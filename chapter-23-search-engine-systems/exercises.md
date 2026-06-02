# Chapter 23 Exercises

## Exercise 1: Search as a Governed Visibility Engine

A candidate says, “A search engine indexes documents, retrieves matching results, ranks them, and returns them quickly.”

Why is that incomplete?

Your answer should include:

- Why search is a truth-shaping system, not only a retrieval system
- Why **Searchable**, **Rankable**, **Admissible**, **Citable**, and **Answerable** are claims requiring proof
- Why APIs can return 200 while the system is still wrong
- Which actors are involved: user, source owner, crawler, parser, indexer, ranker, policy engine, AI answer generator, auditor, support, and platform owner
- What evidence must exist before the platform claims a result is searchable, fresh, safe, citable, or answerable
- Why ranking is not neutral
- What must be replayable later

## Exercise 2: Token Chain and Search Commitment Boundaries

Design the search token chain using `crawlReceiptId`, `ingestReceiptId`, `parseReceiptId`, `indexReceiptId`, `rankPolicyId`, `filterReceiptId`, `citationReceiptId`, `answerReceiptId`, `queryId`, and `resultSetHash`.

Your answer should include:

- What each token or receipt proves
- Why crawling or ingesting content is not enough to claim searchability
- Why `indexReceiptId` is the first serious retrieval boundary
- Why `rankPolicyId` and `filterReceiptId` govern visibility shaping
- Why `citationReceiptId` is required before an AI answer can claim grounding
- Why `answerReceiptId` is the highest-liability claim
- Why `queryId` and `resultSetHash` are needed for replay
- What the Search Decision Replay Card should contain

## Exercise 3: Freshness as a Time Policy

A policy document is updated in the source-of-record system. Ingest sees it, but the index still serves the old version for several minutes. A cached AI answer continues to cite the old policy.

What should the system do?

Your answer should include:

- Difference between source update time, ingest time, index time, cache time, ranking-model time, and answer time
- Why freshness is not one generic SLA
- Why governed policy corpora need hard freshness budgets
- Why a cached answer can spread stale truth
- When to mark results stale, bypass cache, force fresh retrieval, or suppress AI answers
- What receipt or trace proves the answer used the current source version
- What stop authority should fire if freshness exceeds budget
- What re-enable criteria must be met

## Exercise 4: Indexing Is Not Storage

A team says, “The documents are in object storage, so search can find them.”

Why is that incomplete?

Your answer should include:

- Why storage preserves content, while indexing commits future retrieval
- Why present in the corpus is not the same as findable in practice
- How parsing, chunking, tokenization, metadata extraction, normalization, redaction, and field selection shape future recall
- Why missing tables, bad chunks, or weak metadata can make correct content invisible
- Why indexing needs parser version, chunking policy, index version, source version, and policy version
- What `indexReceiptId` proves
- What should happen when indexing quality collapses for a source or corpus

## Exercise 5: Ranking as a Decision Surface

A user searches: “red Nike shoes endorsed by Ronaldo under $100.” Retrieval returns official Nike products, stale campaign pages, CR7-branded non-Nike shoes, out-of-stock items, sponsored items, and fuzzy semantic matches.

How should the ranking system decide what appears first?

Your answer should include:

- Why ranking is not presentation polish
- Why ranking decides what becomes visible and believed first
- Why policy beats popularity
- Why authority beats engagement
- Why freshness beats historical clicks in governed domains
- Why structured truth beats free-text implication
- How hard constraints, soft ranking signals, business rules, personalization, and safety should interact
- What ranking evidence must be replayable later

---

# Bonus GitHub Exercises

## Bonus Exercise 6: Retrieval Modes — Lexical, Vectorless, Vector, and Hybrid

An interviewer asks, “Should we use keyword search, vector search, or hybrid search?”

Give a senior answer.

## Bonus Exercise 7: Query Understanding and Routing

A customer asks: “Where is my order?” Another asks: “What is the damaged-delivery refund policy?” Another asks: “Show me red Nike shoes under $100 that can arrive in Boston in two days.”

Should all three queries go to the same search index?

## Bonus Exercise 8: AI Search and Multi-Truth Governance

A system adds AI to search and now creates extracted text, chunks, embeddings, summaries, query rewrites, reranked passages, citations, and generated answers.

How should the architecture govern these layers?

## Bonus Exercise 9: Incident Response — The Old Policy Outranked the Real One

A refund policy was updated in the source-of-record system. Ingest saw the update, but the policy index lagged. The old article had stronger historical engagement and ranked first. The AI layer cited the stale policy and gave a confident answer. Dashboards were green.

Analyze the incident.

## Bonus Exercise 10: Senior Architect Search Defense

An interviewer says, “Search is straightforward: crawl documents, index them in Elasticsearch or OpenSearch, add vector search, rank the results, and let an LLM summarize the top passages.”

Defend a more mature design.
