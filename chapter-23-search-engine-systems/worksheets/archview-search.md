# ARCHVIEW: Search

| Concern | View |
|---|---|
| Actors | User, source owner, crawler, parser, indexer, ranker, policy engine, AI, support, auditor. |
| Responsibilities | Crawl, ingest, parse, index, retrieve, rank, filter, cite, answer, observe, replay. |
| Controls | Freshness, ranking precedence, policy filters, citation proof, answer admissibility. |
| Commit Points | indexReceiptId, rankPolicyId, filterReceiptId, citationReceiptId, answerReceiptId. |
| Evidence | Source version, parser, index, rank model, policy, citations, result-set hash. |
| Degradation | Mark stale, sources only, bypass cache, suppress answer. |
