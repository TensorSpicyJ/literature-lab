# Search Strategy

## Sources

Search across these sources in order:

1. **arxiv.org** — Use WebSearch with `site:arxiv.org`. Primary source for preprints and recent submissions.
2. **Google Scholar** — Use WebSearch. Best for published papers and citation tracking.
3. **Nature/Science/PRL feeds** — Use WebSearch with `site:nature.com`, `site:science.org`, `site:journals.aps.org`. For high-signal formal publications.

## Query Construction

1. Read `config/topics.json` for active topics and their query strings.
2. For each topic, run 1-2 WebSearch queries.
3. Append date constraint: prioritize last 3 days, extend to 7 days if sparse.
4. For arxiv, use `new` listing: search `site:arxiv.org <keywords>` and check dates.

## Dedup

Before adding a paper to the candidate list:

1. Check `state/search-log.json` — skip if already logged.
2. Check `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\papers\` — skip if a note already exists for this paper.
3. Check `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\12-每日文献知识库\daily\` — skip if featured in a recent daily radar.

## Source Status Labeling

Every paper must carry an explicit source status:

| Label | Meaning | Thesis-eligible? |
|-------|---------|------------------|
| `published` | Formally published in peer-reviewed journal | Yes |
| `accepted` | Accepted but not yet published | Yes |
| `arXiv` | Preprint only, not formally published | No (background only) |
| `preprint` | Non-arxiv preprint | No |
| `unpublished` | Conference talk, private communication, etc. | No |

## Candidate List Output

For each paper found, record:

```
- Title:
- Authors:
- Year:
- Source status: [published/accepted/arXiv/preprint/unpublished]
- Venue:
- arXiv ID: (if any)
- Link:
- Topic match: (which topic from topics.json)
- One-line relevance: (why it matched)
```

After search, update `state/search-log.json` with the date, topic, query used, and papers found.
