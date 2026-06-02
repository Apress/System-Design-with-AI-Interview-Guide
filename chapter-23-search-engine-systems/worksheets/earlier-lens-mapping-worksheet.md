# Earlier-Lens Mapping Worksheet: Search Engine Systems

This worksheet helps you apply the earlier lenses from Part I and Part II to Chapter 23: Search Engine Systems.

The purpose is not to memorize an “Elasticsearch + vector database + LLM” answer. The purpose is to prove that you can reuse the same system design method when indexing, ranking, filtering, freshness, policy, AI retrieval, citations, and answer generation decide what becomes visible and believable.

Use this worksheet before drawing the final architecture. A senior answer should show that you understand search as a governed visibility engine, not a convenience layer.

---

## 1. 7-Step Method Mapping

| Step | Search Application | Senior Architect Framing | Reader Notes |
|---|---|---|---|
| 1. Clarify the problem | Are we designing product search, policy search, support search, operational search, or AI answer search? | “I need to know what visibility promise the system is allowed to make.” |  |
| 2. Identify actors | User, source owner, crawler, parser, indexer, ranker, policy engine, AI answer generator, support, auditor. | “Search involves more actors than user and index.” |  |
| 3. Map the journey | Query, understand intent, route, retrieve, rank, filter, cite, answer, observe, replay. | “The journey does not end when results return.” |  |
| 4. Define constraints | Index lag, stale cache, ranking drift, policy mismatch, weak citations, vector retrieval errors. | “The system can be fast and still make the wrong truth visible.” |  |
| 5. Name commitments | `indexReceiptId`, `rankPolicyId`, `filterReceiptId`, `citationReceiptId`, `answerReceiptId`. | “If I cannot mint the receipt, I cannot claim searchability or answerability.” |  |
| 6. Choose architecture | Crawl, parse, normalize, index, retrieve, rank, filter, cite, answer, serve, replay. | “I draw commitment boundaries before choosing Elasticsearch or vector search.” |  |
| 7. Defend trade-offs | Speed vs freshness, recall vs authority, semantic discovery vs governed truth, AI fluency vs proof. | “A slower honest result is better than a fast stale answer.” |  |

---

## 2. Customer Journey Mapping

| Journey Moment | User Believes | Platform Risk | Architecture Response |
|---|---|---|---|
| User enters query | System understands intent. | Query routed to wrong truth source. | Intent detection and query routing. |
| Results appear | Results are relevant and allowed. | Stale, unauthorized, or suppressed content appears. | Ranking and filter receipts. |
| Top result appears | Top result is best. | Engagement outranks authority. | Ranking precedence policy. |
| AI answer appears | Answer is grounded and safe. | Citation is stale or insufficient. | Citation and answer receipts. |
| User asks why | Platform can explain. | No replay trace exists. | Search Decision Replay Card. |
| Corpus changes | Search updates. | Cache/index lag spreads stale truth. | Freshness budgets and cache invalidation. |

---

## 3. Capability Map

| Capability | Responsibility | Commitment Boundary | Owner |
|---|---|---|---|
| Crawl/Ingest | Observe source and admit to processing. | `crawlReceiptId` / `ingestReceiptId`. | Ingest owner |
| Parse/Normalize | Extract usable content. | `parseReceiptId`. | Parser owner |
| Index | Make content searchable. | `indexReceiptId`. | Index owner |
| Query Understanding | Detect intent, entities, constraints. | Query trace. | Search API owner |
| Routing | Select source of truth and retrieval mode. | Routing receipt. | Search platform owner |
| Retrieval | Fetch candidate evidence. | Retrieval trace. | Retrieval owner |
| Ranking | Order candidates. | `rankPolicyId` / rank receipt. | Ranking owner |
| Filtering | Enforce ACL, policy, safety, legal constraints. | `filterReceiptId`. | Policy owner |
| Citation | Prove source support. | `citationReceiptId`. | RAG/evidence owner |
| Answer Generation | Convert evidence into visible claim. | `answerReceiptId`. | AI answer owner |
| Replay/Audit | Reconstruct decision later. | Search Decision Replay Card. | Governance owner |
| Stop Authority | Freeze unsafe visibility. | Stop receipt. | Platform operations owner |

---

## 4. ARCHVIEW Mapping

| ARCHVIEW Concern | Search View |
|---|---|
| Actors | User, source owner, crawler, parser, indexer, ranker, policy engine, AI answer generator, support, auditor. |
| Responsibilities | Crawl, ingest, parse, normalize, index, retrieve, rank, filter, cite, answer, serve, observe, replay. |
| Control surfaces | Freshness budget, ranking precedence, policy filters, citation proof, answer admissibility, cache invalidation. |
| Commitment points | `indexReceiptId`, `rankPolicyId`, `filterReceiptId`, `citationReceiptId`, `answerReceiptId`. |
| Ownership | Ingest, parser, index, rank, policy, cache, RAG, AI answer, replay, operations owners. |
| Evidence | Source version, parser version, index version, rank model, policy version, citations, result-set hash. |
| Degradation | Mark stale, show sources only, bypass cache, narrow retrieval, suppress answer, human review. |
| Stop authority | Freeze indexing, ranking rollout, cache serving, semantic expansion, AI answer generation, or governed retrieval path. |

---

## 5. AI Primitives Mapping

| AI Primitive | Search Application | Artifact |
|---|---|---|
| Authority | What is allowed to be visible, ranked, cited, or answered? | Ranking and admissibility policy |
| Commitment | Searchability and answerability begin only after receipts. | Index and answer receipts |
| Time | Source, ingest, index, cache, ranking, and answer clocks govern freshness. | Freshness-budget policy |
| Degradation | When proof weakens, show sources, narrow scope, or refuse. | Stop-authority policy |
| Evidence/Replay | Prove why something appeared, outranked, was cited, or was suppressed. | Search Decision Replay Card |
| Ownership | Named owners must freeze unsafe visibility. | Capability-scoped stop matrix |

---

## 6. ROCS Mapping

| ROCS Dimension | Search Pressure | Control |
|---|---|---|
| Reliability | Search must not expose stale, unauthorized, or weakly proven truth. | Freshness budgets, policy filters, ranking guardrails. |
| Observability | The system must replay why results appeared or answers were generated. | Query traces, receipts, model versions, result-set hashes. |
| Cost | Embeddings, reranking, fan-out, cache bypass, and index rebuilds can explode. | Retrieval budgets, routing controls, cache rules, tiered reranking. |
| Sustainability | Trust must survive corpus changes, model changes, and policy drift. | Honest degradation, source display, stop authority, re-enable criteria. |

---

## 7. Scale Mapping

| Scale Pressure | Search Failure Shape | Control |
|---|---|---|
| Large corpus | Index lag and partial coverage. | Freshness budgets and index receipts. |
| Query spikes | Cache pressure and stale answer reuse. | Cache invalidation and governed bypass. |
| Ranking rollout | Wrong result class surfaces. | Rank rollout gates and rollback. |
| Vector expansion | High fan-out and policy-wrong candidates. | Structured filters and retrieval budgets. |
| AI answer volume | Weak citations become public claims. | Citation-required policy and answer suppression. |

---

## 8. Consistency Mapping

| Boundary | Trust Rule | Artifact |
|---|---|---|
| Source observed | Not yet searchable. | `crawlReceiptId` / `ingestReceiptId` |
| Parsed | Usable content extracted. | `parseReceiptId` |
| Indexed | Searchability claim possible. | `indexReceiptId` |
| Ranked | Visibility ordering claim possible. | `rankPolicyId` / rank receipt |
| Filtered | Admissibility claim possible. | `filterReceiptId` |
| Cited | Grounding claim possible. | `citationReceiptId` |
| Answered | Visible AI claim possible. | `answerReceiptId` |
| Served | Public result set exists. | `queryId` + `resultSetHash` |

---

## 9. Latency Mapping

| Latency Type | Search Meaning | Control |
|---|---|---|
| Crawl/ingest latency | Delay from source change to observed change. | Source freshness monitoring. |
| Index latency | Delay until searchable. | Index freshness budget. |
| Cache latency | Cached result reuse window. | TTL and invalidation receipts. |
| Ranking latency | Time to score/rerank. | Rerank budget and fallback. |
| AI answer latency | Time to retrieve, cite, and answer. | Answer budget and source-only fallback. |
| Replay latency | Time to reconstruct decision. | Replay-card completeness. |

---

## 10. Failure Mapping

| Failure Signal | What It Looks Like | Response |
|---|---|---|
| Index lag | Current document missing. | Mark stale, narrow to certified sources, rebuild index. |
| Citation missing | AI answer lacks provenance. | Suppress answer; show sources only. |
| Ranking drift | Wrong class outranks authority. | Revert ranker. |
| Policy mismatch | Filters disagree across services. | Fail closed or narrow visible set. |
| Cache staleness | Old answer continues to appear. | Bypass cache and invalidate keys. |
| Vector policy-wrong retrieval | Semantically close but unauthorized result. | Constrain vector behind structured filters. |

---

## 11. Economics Mapping

| Economic Multiplier | Search Example | Control |
|---|---|---|
| Index cost | Reindexing large corpora. | Incremental indexing and validation diff. |
| Embedding cost | Rebuilding vectors after source change. | Source-version pins and rebuild priority. |
| Reranking cost | Expensive reranker on too many candidates. | Candidate caps and tiered ranking. |
| Fan-out cost | Query hits too many sources/tools. | Routing budget and stop rules. |
| Cache bypass cost | Fresh retrieval for governed content. | Policy-specific cache rules. |
| Support/audit cost | Manual explanation of wrong result. | Replay cards and receipts. |

## Final Senior Line

> A search system is not just how users find content. It is how the platform decides what becomes visible, believable, and actionable. The senior design separates observed from searchable, searchable from rankable, rankable from admissible, citable from answerable, and grounded from authoritative; binds every visibility-changing action to receipts, freshness budgets, policy pins, and replay; and freezes unsafe visibility when proof weakens.
