"""Extract paper notes into a thesis literature matrix CSV.

Usage: python extract-matrix.py
Reads from the configured PAPERS_DIR, writes to OUTPUT_CSV.
"""

import csv
import re
import os
import glob

PAPERS_DIR = r"D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\papers"
OUTPUT_CSV = r"D:\BaiduSyncdisk\iop\毕业相关\论文模板\01-文献矩阵.csv"

MATRIX_HEADERS = [
    "序号", "题目", "作者", "年份", "来源",
    "研究问题", "方法", "数据集/样本", "关键结论",
    "与你课题的关系", "可引用章节", "引用优先级(A/B/C)", "DOI/链接", "笔记"
]

def parse_frontmatter(text):
    """Simple YAML frontmatter parser (no PyYAML dependency)."""
    if not text.startswith("---"):
        return {}
    end = text.find("---", 3)
    if end == -1:
        return {}
    fm_text = text[3:end].strip()
    result = {}
    multiline_key = None
    multiline_value = []
    for line in fm_text.split("\n"):
        if line.strip() == "":
            continue
        if line.startswith("  - ") or line.startswith("  "):
            if multiline_key:
                multiline_value.append(line.strip().lstrip("- "))
            continue
        if multiline_key:
            result[multiline_key] = ", ".join(multiline_value)
            multiline_key = None
            multiline_value = []
        if ":" in line:
            key, val = line.split(":", 1)
            key = key.strip()
            val = val.strip()
            if val == "" or val == "[]":
                multiline_key = key
                multiline_value = []
            elif val.startswith("[") and val.endswith("]"):
                result[key] = val[1:-1]
            else:
                result[key] = val
    if multiline_key:
        result[multiline_key] = ", ".join(multiline_value)
    return result

def extract_section(md_body, section_name):
    """Extract content under a markdown heading."""
    pattern = rf"##\s+{re.escape(section_name)}\s*\n(.*?)(?=\n##\s|\Z)"
    match = re.search(pattern, md_body, re.DOTALL)
    if not match:
        return ""
    content = match.group(1).strip()
    items = re.findall(r"^\s*-\s*(.*)", content, re.MULTILINE)
    if items:
        return "; ".join(item.strip() for item in items)
    lines = [l.strip() for l in content.split("\n") if l.strip()]
    return " ".join(lines[:3])

def extract_title(md_body):
    match = re.search(r"^#\s+(.*)", md_body, re.MULTILINE)
    return match.group(1).strip() if match else ""

def extract_authors(md_body):
    pattern = r"-\s*Authors:\s*(.*)"
    match = re.search(pattern, md_body, re.MULTILINE)
    return match.group(1).strip() if match else ""

def process_paper(filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        text = f.read()

    fm = parse_frontmatter(text)
    title = extract_title(text)
    authors = extract_authors(text)
    if not authors and "authors" in fm:
        authors = fm["authors"]

    year = fm.get("year", "")
    if not year:
        match = re.search(r"-\s*Year:\s*(.*)", text)
        year = match.group(1).strip() if match else ""

    venue = fm.get("venue", "")
    doi = fm.get("doi", "")
    link = fm.get("link", "")
    doi_link = doi if doi else link
    if doi and link:
        doi_link = f"{doi} | {link}"

    core_question = extract_section(text, "核心问题")
    methods = extract_section(text, "方法 / 表征 / 理论工具")
    conclusions = extract_section(text, "主要结论")
    relation_to_ts = extract_section(text, "与 TS 课题的关系")
    notes = extract_section(text, "我的备注")
    worth_reading = extract_section(text, "为什么值得读")
    suitable_ref = extract_section(text, "是否适合作为正式参考文献")

    combined_notes = notes
    if worth_reading:
        combined_notes = f"值得读: {worth_reading}" + (f" | 备注: {notes}" if notes else "")

    # Citation priority
    frontmatter_priority = fm.get("ref_priority", "").strip()
    if frontmatter_priority in ("A", "B", "C"):
        priority = frontmatter_priority
    else:
        priority = "B"
        if "是" in suitable_ref and ("否" not in suitable_ref[:10]):
            if any(kw in relation_to_ts for kw in ["核心", "直接", "主线", "主证据"]):
                priority = "A"
            elif any(kw in relation_to_ts for kw in ["邻", "背景", "outlook", "方法"]):
                priority = "B"
            else:
                priority = "B"
        else:
            priority = "C"

    # Citation chapter
    chapter = fm.get("citation_chapter", "").strip()
    if not chapter:
        combined = f"{title} {relation_to_ts}"
        if "LSCO" in combined or "lsco" in combined.lower():
            chapter = "Chap_Intro / Chap_LSCO"
        elif "diode" in combined.lower() or "Josephson" in combined or "tunnel" in combined.lower():
            chapter = "Chap_Diode"
        elif "magnetic" in combined.lower() or "manganite" in combined.lower():
            chapter = "Chap_Magnetic"

    return {
        "题目": title,
        "作者": authors,
        "年份": str(year),
        "来源": venue,
        "研究问题": core_question,
        "方法": methods,
        "数据集/样本": "",
        "关键结论": conclusions,
        "与你课题的关系": relation_to_ts,
        "可引用章节": chapter,
        "引用优先级(A/B/C)": priority,
        "DOI/链接": doi_link,
        "笔记": combined_notes,
    }

def main():
    paper_files = sorted(glob.glob(os.path.join(PAPERS_DIR, "*.md")))
    paper_files = [f for f in paper_files if "template" not in os.path.basename(f)]

    papers = []
    for filepath in paper_files:
        try:
            papers.append(process_paper(filepath))
        except Exception as e:
            print(f"Error processing {os.path.basename(filepath)}: {e}")

    def sort_key(p):
        prio_order = {"A": 0, "B": 1, "C": 2}
        try:
            yr = int(p["年份"])
        except (ValueError, TypeError):
            yr = 0
        return (prio_order.get(p["引用优先级(A/B/C)"], 2), -yr, p["题目"])

    papers.sort(key=sort_key)

    for i, p in enumerate(papers):
        p["序号"] = str(i + 1)

    with open(OUTPUT_CSV, "w", newline="", encoding="utf-8-sig") as f:
        writer = csv.DictWriter(f, fieldnames=MATRIX_HEADERS)
        writer.writeheader()
        for p in papers:
            row = {k: p.get(k, "") for k in MATRIX_HEADERS}
            writer.writerow(row)

    print(f"Processed {len(papers)} papers → {OUTPUT_CSV}")
    for p in papers:
        print(f"  [{p['引用优先级(A/B/C)']}] {p['年份']} | {p['题目'][:80]}")

if __name__ == "__main__":
    main()
