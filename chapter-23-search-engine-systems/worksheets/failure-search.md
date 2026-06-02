# Failure: Search

| Signal | Looks Like | Response |
|---|---|---|
| Index lag | Current doc missing. | Mark stale/rebuild. |
| Citation missing | No provenance. | Suppress answer. |
| Ranking drift | Wrong top result. | Revert ranker. |
| Policy mismatch | Filters disagree. | Fail closed. |
| Cache stale | Old answer appears. | Bypass/invalidate. |
| Vector wrong | Semantic but unauthorized. | Structured filter. |
