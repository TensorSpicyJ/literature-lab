# Daily Search Prompt

Search for today's literature across all active topics from `config/topics.json`.

## Workflow

1. Read `config/topics.json` to get all active topics and their query strings.
2. Read `state/search-log.json` to skip already-searched papers.
3. For each topic, run 1-2 WebSearch queries with `site:arxiv.org` first, then broader.
4. Constrain to papers from the last 3 days. Extend to 7 if results are sparse.
5. For each result, extract: title, authors, year, source status, venue, arXiv ID, link, topic match, one-line relevance.
6. After search, append entries to `state/search-log.json`.

## Query Template

For topic with query string `{query}`:
- `site:arxiv.org {query} 2026` → arxiv recent
- `{query} recent published` → broader for journal papers

## Source Status Assignment

When reading search results, label every paper:
- Has a journal name + volume/page → `published`
- Labeled "accepted" / "in press" → `accepted`
- arxiv.org domain, no journal → `arXiv`
- Other preprint server → `preprint`
- Conference abstract / personal communication → `unpublished`

Output the candidate list for filtering.
