# Chapter 23 Solution Guide

## Exercise 1 Solution: Search as a Governed Visibility Engine

A strong answer should explain that search is not simply a fast retrieval stack. A search system shapes what becomes visible, believable, and actionable. It decides which content is searchable, which version is current, which candidates are admissible, which result ranks first, which source may be cited, and whether an AI-generated answer is allowed to leave the system.

The states **Searchable**, **Rankable**, **Admissible**, **Citable**, and **Answerable** are not labels. They are claims. Each claim requires proof.

A search API can return HTTP 200 while the system is still wrong. For example:

- The freshest policy document is missing.
- The old version outranks the current source-of-record version.
- A suppressed or unauthorized result leaks back into the visible set.
- A semantic retrieval result is plausible but not authoritative.
- An AI answer cites a real document that is stale, superseded, or out of scope.
- Ranking favors engagement over authority in a governed domain.

Actors include:

- user,
- source owner,
- crawler,
- parser,
- indexer,
- metadata service,
- ranking model owner,
- policy engine,
- filter/suppression system,
- AI answer generator,
- auditor,
- support,
- platform owner.

Before the platform claims **Searchable**, it needs:

- `crawlReceiptId` or `ingestReceiptId`,
- `parseReceiptId`,
- `indexReceiptId`,
- source version,
- index version,
- freshness window,
- policy version.

Before claiming **Rankable**, it needs:

- rank policy,
- ranking model version,
- feature schema,
- admissibility proof,
- result-set candidate trace.

Before claiming **Admissible**, it needs:

- ACL checks,
- safety policy,
- legal constraints,
- suppression rules,
- `filterReceiptId`.

Before claiming **Citable**, it needs:

- source version,
- chunk ID,
- citation provenance,
- current-version proof,
- `citationReceiptId`.

Before claiming **Answerable**, it needs:

- retrieval trace,
- citation coverage,
- model version,
- prompt version,
- grounding/admissibility checks,
- `answerReceiptId`.

What must be replayable later:

- why the result appeared,
- why another result did not appear,
- why one result outranked another,
- which freshness clock governed the decision,
- which retrieval mode was used,
- which policy version applied,
- which citations supported an answer,
- why the system answered, showed sources only, suppressed, or refused.

Senior answer:

> I am not designing only a retrieval stack. I am designing a governed visibility engine. Searchability, ranking, admissibility, citation, and answerability are commitments. Each one needs receipts, policy pins, freshness proof, authority rules, stop authority, and replay evidence.

---

## Exercise 2 Solution: Token Chain and Search Commitment Boundaries

A mature search system uses tokens and receipts to separate private processing from public visibility.

| Token / Receipt | What It Proves | Why It Matters |
|---|---|---|
| `crawlReceiptId` | The source was observed by the crawler. | Observation is not searchability. |
| `ingestReceiptId` | The platform admitted the source into processing. | Proves the source entered the pipeline. |
| `parseReceiptId` | Content was extracted under a parser and policy version. | Bad parsing can erase future retrieval. |
| `indexReceiptId` | Content became searchable in a specific index and freshness contract. | This is the first serious retrieval boundary. |
| `rankPolicyId` | Ranking rules or model policy governed ordering. | Ranking decides what becomes visible first. |
| `filterReceiptId` | ACL, legal, safety, suppression, or policy filters shaped visibility. | Proves why something was included or excluded. |
| `citationReceiptId` | A source or chunk supports a claim. | Required before AI can claim grounding. |
| `answerReceiptId` | The system decided evidence was sufficient to answer. | Highest-liability search claim. |
| `queryId` | Identifies the query execution. | Needed for replay and debugging. |
| `resultSetHash` | Identifies the returned result set. | Proves exactly what was shown. |

Crawling or ingesting content is not enough to claim searchability. The document may be observed but not parsed, parsed but not indexed, indexed but stale, indexed but filtered, or retrieved but not citable.

`indexReceiptId` is the first serious retrieval boundary because it changes the platform’s claim from “we are processing this source” to “this content is searchable.”

`rankPolicyId` and `filterReceiptId` govern visibility shaping. They prove why the system allowed, suppressed, boosted, demoted, or excluded specific candidates.

`citationReceiptId` is required before an AI answer can claim grounding because citation is the bridge between retrieved evidence and a visible answer.

`answerReceiptId` is the highest-liability claim because the system is no longer merely showing results. It is turning evidence into a natural-language claim.

A Search Decision Replay Card should contain:

- `queryId`,
- user or session context,
- query text and normalized form,
- intent classification,
- routing decision,
- retrieval mode,
- corpus snapshot,
- source versions,
- parser version,
- chunking policy,
- embedding model version if used,
- lexical parameters if used,
- structured filters,
- rank policy ID,
- ranking model version,
- feature snapshot,
- filter receipt,
- citation receipt,
- answer receipt,
- result-set hash,
- model and prompt versions,
- freshness clocks,
- stop-authority state,
- final customer-visible response.

Senior answer:

> Before the receipt, the system is processing. After the receipt, the system is accountable. Index receipts make content searchable; answer receipts make the system liable for a visible claim.

---

## Exercise 3 Solution: Freshness as a Time Policy

The system should not continue serving the old policy or cached AI answer as if it were current. This is a governed freshness failure.

Freshness is not one SLA. Search has several clocks:

| Clock | Meaning | Governed Claim |
|---|---|---|
| Source update time | When the source-of-record changed. | Current truth. |
| Ingest time | When the search pipeline observed the change. | Processing awareness. |
| Index time | When the changed content became searchable. | Searchable freshness. |
| Cache time | When a prior result or answer was stored. | Reuse safety. |
| Ranking-model time | When scoring logic changed. | Ranking behavior. |
| Answer time | When the final response was generated. | Answer validity. |

A policy corpus is governed content. It needs hard freshness budgets because stale policies can produce customer, legal, or operational harm. A cached answer can spread stale truth faster than fresh retrieval because it bypasses the current source/version check.

Correct behavior:

1. Detect source update time.
2. Compare ingest, index, cache, ranking, and answer clocks.
3. If the old version remains indexed past the freshness budget, mark affected results stale.
4. Bypass cache for governed queries.
5. Force fresh retrieval against current policy source or last-certified index.
6. Suppress AI answers if citation freshness is uncertain.
7. Show retrieved sources only or route to human review when proof is incomplete.
8. Emit stop-authority receipt.
9. Re-enable only when index catches up and validation diff passes.

The answer path must prove:

- current source version,
- citation source version,
- policy version,
- index version,
- answer timestamp,
- cache status,
- freshness age,
- citation receipt,
- answer receipt.

Stop authority should fire when:

- policy index freshness exceeds budget,
- cache is serving stale governed results,
- citation current-version proof is missing,
- ranking still favors stale versions,
- answer generation cannot prove current authority.

Re-enable criteria:

- source and index versions reconciled,
- stale cache invalidated,
- affected result keys cleared,
- ranking precedence validated,
- citation freshness restored,
- replay tests pass,
- owner approval or automated policy approval recorded.

Senior answer:

> Freshness is not one number. For governed search, freshness is a policy boundary. If the index or cache crosses that boundary, the system must stop claiming current truth and suppress AI answers until citation freshness is defensible.

---

## Exercise 4 Solution: Indexing Is Not Storage

The statement “documents are in object storage, so search can find them” is incomplete. Storage preserves bytes. Indexing commits future retrieval.

A document can exist and still be effectively invisible. Indexing decides what future search can know by choosing:

- parser,
- extraction rules,
- chunking strategy,
- tokenization,
- normalization,
- metadata extraction,
- redaction,
- field selection,
- language handling,
- policy filters,
- inclusion/exclusion rules.

If the parser drops a table, the table cannot be found. If chunks cut across a policy clause, semantic retrieval can lose the meaning. If metadata misses jurisdiction, product line, or effective date, filtering and ranking may fail. If field selection omits important attributes, ranking cannot use them later.

Present in the corpus is not the same as findable in practice.

A defensible index receipt should include:

- source ID,
- source version,
- source timestamp,
- parser version,
- extraction summary,
- chunking policy,
- tokenization policy,
- metadata version,
- redaction/suppression policy,
- index name/version,
- freshness window,
- policy version,
- validation result.

When indexing quality collapses for a source or corpus, the system should:

- stop claiming searchability for affected scope,
- freeze promotion of new index version,
- fall back to last-known-good index if safe,
- mark affected corpus as stale or indexing-degraded,
- rebuild with corrected parser/chunking policy,
- run validation diff,
- emit indexing incident receipt.

Senior answer:

> Storage keeps the file. Indexing decides what future retrieval can find. Bad indexing can make true content invisible while every storage dashboard remains green.

---

## Exercise 5 Solution: Ranking as a Decision Surface

Ranking is not presentation polish. Ranking decides what becomes visible first, and in practice, visible first often means believed first.

For the query “red Nike shoes endorsed by Ronaldo under $100,” the system must distinguish:

- official Nike products,
- red color constraint,
- shoe category,
- price ceiling under $100,
- endorsement entity Ronaldo,
- current inventory,
- shipping availability,
- stale campaign pages,
- CR7-branded non-Nike items,
- sponsored items,
- fuzzy semantic matches.

A senior ranking design separates hard constraints from soft ranking signals.

Hard constraints:

- brand = Nike,
- color = red,
- product type = shoes,
- price < $100,
- in stock if required,
- delivery promise if required,
- safety/legal/ad policy,
- user eligibility,
- trusted endorsement metadata.

Soft signals:

- textual relevance,
- semantic similarity,
- popularity,
- reviews,
- personalization,
- recency,
- business promotion,
- seller quality.

Precedence rules:

- Policy beats popularity.
- Authority beats engagement.
- Freshness beats historical clicks in governed domains.
- Structured truth beats free-text implication.
- Personalization refines results but does not override hard constraints.
- Sponsored placement must remain inside admissible candidate sets.

A stale campaign page should not outrank a current official product. A CR7-branded non-Nike shoe should not satisfy a Nike query. A sponsored product should not bypass hard user constraints. A fuzzy semantic match should not override structured product data.

Ranking evidence to replay:

- query ID,
- extracted constraints,
- candidate set,
- filtered-out candidates and reasons,
- rank policy ID,
- ranking model version,
- feature values,
- hard-constraint proof,
- authority score,
- freshness score,
- business rule application,
- personalization context,
- final result-set hash.

Senior answer:

> Ranking is where search stops being neutral. I define what is allowed to outrank what before optimizing clicks. In governed or constrained search, authority and policy must control the candidate set before popularity or personalization tunes ordering.

---

## Bonus Exercise 6 Solution: Retrieval Modes

A senior answer should not ask, “Which retrieval method is best?” It should ask:

> What kind of truth does this query need, and what retrieval method can we defend later?

Retrieval modes make different truth promises.

| Retrieval Mode | Truth Promise | Strongest Use | Main Risk |
|---|---|---|---|
| Lexical | Exact term evidence. | Product codes, IDs, legal clauses, error strings, brand names. | Brittle when wording differs. |
| Vectorless | Governed path to known truth. | APIs, SQL, graph traversal, metadata filters, policy repositories. | Rigid if structure is weak. |
| Vector | Semantic proximity. | Fuzzy discovery, paraphrase, exploratory search. | Plausible but operationally wrong retrieval. |
| Hybrid | Discovery plus control. | Real-world mixed queries. | Cost, complexity, tuning drift. |

Lexical retrieval is strongest when exact wording matters. BM25 and inverted indexes work well for codes, SKUs, clauses, names, and exact phrases.

Vectorless retrieval is strongest when the truth already lives in structured systems: order APIs, policy repositories, graph relationships, SQL, metadata filters, inventory services, and entitlement systems.

Vector retrieval is strongest when the user’s language and document language differ, or the query is exploratory. Its weakness is that semantically close content can be stale, unauthorized, wrong jurisdiction, wrong product line, or not authoritative.

Hybrid retrieval is often the adult answer because real queries mix exact constraints and fuzzy language. For example:

- structured filters for brand, price, region, inventory,
- lexical search for exact campaign or clause terms,
- semantic retrieval for paraphrase,
- ranking and policy filters for authority and safety.

What each mode can defend:

- Lexical can defend exact term matches.
- Vectorless can defend governed path and structured source.
- Vector can defend similarity under pinned embedding model and corpus snapshot.
- Hybrid can defend controlled discovery if each stage is traced and bounded.

Senior answer:

> I choose retrieval mode based on the truth burden. Exact terms need lexical. Governed facts need vectorless. Fuzzy meaning may need vector. Most production systems need hybrid, but hybrid must be traceable, policy-bounded, and replayable.

---

## Bonus Exercise 7 Solution: Query Understanding and Routing

All three queries should not go to the same search index.

Query understanding is an architectural decision point because the first decision is not “what matches?” The first decision is “where should the system go for truth?”

Example 1:

```text
Where is my order?
```

This should use system-of-record APIs or tools: order service, shipment tracking, carrier updates, warehouse events. It is not a document search problem.

Example 2:

```text
What is the damaged-delivery refund policy?
```

This should route to a versioned policy repository, support knowledge base, claims rules, and possibly order-state APIs. It requires policy-grounded retrieval and citations from current authoritative sources.

Example 3:

```text
Show me red Nike shoes under $100 that can arrive in Boston in two days.
```

This requires catalog, inventory, pricing, delivery promise, trusted brand/product metadata, and ranking. Semantic search may help, but structured catalog and inventory constraints should dominate.

Routing pipeline:

1. Intent detection.
2. Spelling correction.
3. Entity extraction.
4. Constraint detection.
5. Source-of-truth selection.
6. Retrieval-mode selection.
7. Policy and authority checks.
8. Response mode: results, sources, answer, tool/API output, or refusal.

Routing evidence to capture:

- original query,
- normalized query,
- detected intent,
- extracted entities,
- extracted constraints,
- routing decision,
- selected source of truth,
- retrieval mode,
- policy version,
- fallback path,
- query trace ID.

Senior answer:

> Search quality is not only ranking better. It is routing better. The right answer depends on whether truth lives in a catalog, policy repository, graph, API, source document, or human workflow.

---

## Bonus Exercise 8 Solution: AI Search and Multi-Truth Governance

Adding AI turns search into a multi-truth system. The original source may remain canonical, but the system now creates many derivatives:

- extracted text,
- chunks,
- embeddings,
- summaries,
- query rewrites,
- reranked passages,
- citations,
- generated answers.

Canonical truth includes:

- original versioned documents,
- structured records,
- source-of-record metadata,
- policy-controlled source versions,
- receipts proving authority.

AI derivatives are useful but not authoritative. They are regeneratable artifacts. They must never impersonate the source of record.

Every derivative needs lineage:

| Derivative | Required Lineage |
|---|---|
| Extracted text | source version, parser version, extraction policy. |
| Chunk | source version, chunking policy, boundaries. |
| Embedding | source version, chunk ID, embedding model version. |
| Summary | source version, model version, prompt version. |
| Query rewrite | original query, rewrite model, prompt/config version. |
| Reranked passage | candidate set, reranker version, ranking policy. |
| Generated answer | citations, model version, prompt version, policy version. |

When the source version changes:

1. Preserve old canonical source and lineage.
2. Mark derivatives tied to old source version as stale.
3. Invalidate affected chunks, embeddings, summaries, search entries, and cached answers.
4. Rebuild derivatives under pinned parser/model/prompt/policy versions.
5. Prevent stale derivatives from being used as authoritative evidence.
6. Emit derivative invalidation and rebuild receipts.

Answer generation needs stronger proof than retrieval because retrieval only proposes evidence. Answer generation turns that evidence into a visible claim.

The replay card must show:

- source versions,
- derivative versions,
- parser and chunking policy,
- embedding model version,
- retrieval parameters,
- reranker version,
- citation receipts,
- answer receipt,
- prompt and model version,
- policy bundle,
- freshness state.

Senior answer:

> AI enriches search by creating more representations. Governance keeps those representations from impersonating truth. Preserve canonical truth, regenerate derivatives, and require answer receipts before turning evidence into a claim.

---

## Bonus Exercise 9 Solution: Old Policy Outranked the Real One

This is not an uptime incident. It is a truth and visibility incident.

The system was available. Query latency was healthy. The AI answer was grounded in a real document. But the cited document was stale and superseded. That means the system made the wrong truth visible first.

A grounded answer can still be wrong if:

- the cited source is stale,
- the cited source is superseded,
- the cited source is unauthorized,
- the cited source is from the wrong jurisdiction,
- the citation lacks current-version proof,
- ranking allows historical engagement to outrank authority.

Citation is not proof unless the cited source is admissible, current, authoritative, and policy-valid for the query.

Root causes:

- Freshness for governed policy corpora was treated as quality, not admissibility.
- Current-version precedence was missing.
- Historical engagement overpowered authority.
- AI answer generation allowed plausible evidence without citation freshness proof.
- Cache or index lag spread stale truth.

Correct response:

1. Suppress AI answers for affected governed policy corpus.
2. Show retrieved sources only or route to human review.
3. Mark old policy as stale/superseded.
4. Bypass cache for policy queries.
5. Rebuild or catch up policy index.
6. Add current-version ranking override.
7. Require citation freshness before answer receipt.
8. Emit incident replay card.
9. Notify support and correct affected guidance if customer harm occurred.

Capability-scoped stops:

- stop AI answer generation for affected corpus,
- bypass stale cache,
- freeze ranking rollout if it contributed,
- stop current-policy freshness claims,
- narrow retrieval to last-certified current sources.

Re-enable criteria:

- policy index freshness inside budget,
- source/index version reconciled,
- cache invalidation receipts complete,
- current-version ranking precedence validated,
- citation coverage restored,
- replay tests pass,
- sampled review clears.

Senior answer:

> The AI did not hallucinate. It cited the wrong authority. In governed search, a stale citation is not grounding; it is a confident path to harm.

---

## Bonus Exercise 10 Solution: Senior Architect Search Defense

A mature answer should acknowledge Elasticsearch/OpenSearch, BM25, vector databases, shards, ranking, and LLM summarization, but explain that they are not the design center. The design center is governed visibility.

A senior answer starts like this:

> I am not designing only a retrieval stack. I am designing a governed visibility system.

Key defense points:

### State claims require receipts

Searchable, fresh, admissible, rankable, citable, and answerable must be backed by receipts.

### Commitment boundaries

Indexing mints the searchability commitment. Ranking shapes visibility. Filtering governs admissibility. Citation supports grounding. AI answer generation creates the highest-liability claim.

### Freshness clocks

Source update, ingest, index, cache, ranking, and answer clocks govern different claims. Freshness is a policy, not one generic number.

### Retrieval mode by truth need

Use lexical for exact evidence, vectorless for governed structured truth, vector for semantic discovery, and hybrid when discovery and control are both required.

### Ranking precedence

Policy beats popularity. Authority beats engagement. Freshness beats historical clicks in governed domains. Structured truth beats free-text implication.

### AI derivatives

Extracted text, chunks, embeddings, summaries, rewrites, reranked passages, and generated answers are derivatives. They need lineage and invalidation rules.

### Degradation

When proof is incomplete, degrade honestly: show sources only, mark stale, narrow retrieval, bypass cache, suppress AI answers, or route to human review.

### Stop authority

Stop unsafe visibility by capability: freeze indexing, revert ranker, suppress AI answers, bypass stale cache, narrow semantic retrieval, or fail closed for governed paths.

### Replay

Months later, the platform should prove:

- why a result appeared,
- why another result was suppressed,
- why a result outranked another,
- which source version was cited,
- which model and prompt generated the answer,
- which policy version governed it,
- why the system answered or refused.

Senior interview line:

> I would not frame search as crawl, index, vectorize, rank, and summarize. I would frame it as a governed visibility system. I would define what searchable, admissible, citable, and answerable mean; require receipts for indexing, ranking, filtering, citations, and answers; choose retrieval modes based on the truth burden; enforce freshness, authority, and policy precedence; treat AI outputs as derivatives; and use stop authority so stale or weakly proven visibility freezes before it becomes wrong in public.
