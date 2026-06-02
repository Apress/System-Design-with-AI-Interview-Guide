# Chapter 9 Exercises

## Exercise 1: Scale as Truth Serum

DreamMart runs normally at modest traffic. During a promotion, traffic increases 10x, many users target the same products, payment slows down, inventory checks queue, and customers begin clicking checkout multiple times.

Explain why scale did not “create” the architecture problem but revealed it.

## Exercise 2: Average Load Is a Lie

A candidate estimates DreamMart capacity by saying:

“We expect 10 million daily requests. That is about 116 requests per second on average, so 500 QPS should be enough.”

Why is this answer weak? Improve the estimation approach.

## Exercise 3: Capacity Estimation as a Trust Exercise

DreamMart wants to estimate capacity for Black Friday checkout.

What dimensions would you estimate before choosing scaling patterns?

## Exercise 4: Hidden Queues Before the Outage

During a promo spike, DreamMart remains technically available, but inventory checks and payment authorization begin to queue. Customers see delayed confirmation, retry checkout, abandon carts, or contact support.

Analyze this failure.

## Exercise 5: Bottleneck Analysis

A team says, “The bottleneck is the slowest component, so we just need to find which service has the highest latency.”

Why is this incomplete? Analyze bottlenecks by type.

---

# Bonus GitHub Exercises

## Bonus Exercise 6: Scaling Patterns and Trade-Offs

Choose five scaling patterns and explain what each solves, what it does not solve, and what trade-off it introduces.

## Bonus Exercise 7: Sharding and Partitioning

DreamMart needs to shard product catalog, cart, orders, inventory, fulfillment, and search.

Propose possible shard keys and explain the trade-offs.

## Bonus Exercise 8: Caching, Staleness, and Trust

Classify product descriptions, search results, recommendations, pricing, inventory display, cart totals, order confirmation, and refund eligibility as cache friendly, cache carefully, or do not casually cache.

## Bonus Exercise 9: AI Scale Pressure

DreamMart’s AI assistant receives only 20 percent more traffic during a promotion, but latency and cost increase 5x.

Diagnose the AI scale failure.

## Bonus Exercise 10: Senior Architect Scale Defense

Defend a disciplined scale strategy when an interviewer says:

“Why not just add Redis, Kafka, autoscaling, and database sharding?”
