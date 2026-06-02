# Chapter 9 Solution Guide

## Exercise 1 Solution: Scale as Truth Serum

A strong answer should explain that scale reveals hidden assumptions rather than creating all problems from scratch.

Scale exposes stale inventory, slow payment dependencies, retry storms, cache staleness, hot partitions, manual cleanup, weak ownership, and AI fan-out/tool-call loops.

Search, recommendations, and discovery can often degrade. Checkout confirmation cannot bluff. Before confirming an order, the system must prove inventory reservation, payment authorization, final price, policy version, and durable order state.

## Exercise 2 Solution: Average Load Is a Lie

A weak answer divides daily traffic evenly across the day.

A stronger answer asks for peak-to-average ratio, burst duration, hot products, read/write mix, downstream fan-out, retry behavior, queue depth, AI inference work, and commitment-critical paths.

Users experience peak pressure, not average load.

## Exercise 3 Solution: Capacity Estimation as a Trust Exercise

A strong answer estimates enough to reveal the bottleneck.

Estimate users, peak traffic, read/write ratio, payload size, fan-out, queue risk, retry behavior, commitment points, AI inference, and evidence/replay needs.

The goal is to identify where capacity pressure can break trust.

## Exercise 4 Solution: Hidden Queues Before the Outage

A strong answer should state that queues appear before outages.

Queues are useful when they absorb bursty non-critical work, but dangerous when they delay customer commitments. In checkout, delayed inventory and payment decisions can create duplicate clicks, abandoned carts, support tickets, and ambiguous order state.

Responses should include priority queues, backpressure, admission control, pending states, retry budgets, honest UX, and support-visible evidence.

## Exercise 5 Solution: Bottleneck Analysis

A bottleneck is not always the slowest component. It is the narrowest point in the system’s ability to keep its promise.

Types:

- Compute: CPU/GPU saturation, worker queue, batch jitter
- Storage: hot partitions, lock contention, index pressure
- Network: fan-out, cross-region calls, egress pressure
- Dependency: payment, inventory, fraud, tax slowdown
- Queue: growing backlog while system stays up
- Policy: approval or human review becomes narrowest path
- AI inference: prompt expansion, RAG fan-out, tool loops, GPU queue

A senior answer maps each bottleneck to the promise it threatens.

## Bonus Exercise 6 Solution: Scaling Patterns and Trade-Offs

A strong answer should explain that scaling patterns are tools with trade-offs.

Examples:

- Horizontal scaling adds stateless capacity but does not fix shared databases.
- Queues absorb bursts but can hide stale work.
- Caching improves reads but may damage trust at commitment.
- Sharding splits data but adds routing and cross-shard complexity.
- Backpressure prevents collapse but requires honest UX.

## Bonus Exercise 7 Solution: Sharding and Partitioning

A strong answer should choose shard keys by access pattern.

Examples:

- Product catalog: product ID, category, or region
- Cart: user ID or session ID
- Orders: customer ID or order ID
- Inventory: SKU + region/warehouse
- Fulfillment: region or warehouse
- Search: category, freshness, or index partition

The key question is which operations must remain local and which cross-shard operations are acceptable.

## Bonus Exercise 8 Solution: Caching, Staleness, and Trust

A strong answer should classify data by trust level.

- Product description: usually cache friendly
- Search results: often cache friendly
- Recommendations: often cache friendly
- Pricing: cache carefully
- Inventory display: cache carefully
- Cart totals: cache carefully
- Order confirmation: do not casually cache
- Refund eligibility: do not casually cache

Advisory values can tolerate staleness. Committed truth requires evidence.

## Bonus Exercise 9 Solution: AI Scale Pressure

A strong answer should explain that AI scale is QPS multiplied by hidden work.

Failure sources include retrieval fan-out, prompt expansion, tool-call loops, model-tier escalation, GPU queue growth, evaluation loops, and retry cascades.

Controls include retrieval budgets, token budgets, tool budgets, model tiering, prompt tracing, queue telemetry, loop caps, and human escalation.

## Bonus Exercise 10 Solution: Senior Architect Scale Defense

A strong answer should defend disciplined scaling.

Start with the promise. Identify what can be approximate and what must be exact. Use caching for discovery, revalidation for commitment, queues for dependency protection, idempotency for duplicate checkout, and pending states for uncertainty. Choose shard keys by access pattern. Add AI budgets for retrieval, tokens, tools, retries, and model tiers. Prove the design with evidence and replay.
