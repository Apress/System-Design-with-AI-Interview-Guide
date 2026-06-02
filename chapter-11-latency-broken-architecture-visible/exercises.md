# Chapter 11 Exercises

## Exercise 1: Latency as Trust Pressure

DreamMart checkout remains technically available during a flash sale, but users experience long delays after clicking **Place Order**. Some users refresh, some click again, some abandon the cart, and some contact support.

Explain why this is not just a performance problem.

Your answer should include:

- Why latency is experienced differently across the customer journey
- Why checkout latency is more dangerous than browse latency
- How delay creates uncertainty at commitment points
- How user retries create duplicated work
- What state the user should see while waiting
- What evidence must be preserved if the order eventually succeeds, fails, or remains pending

## Exercise 2: Journey-Weighted Latency

A team defines one latency target for the whole DreamMart platform: “All APIs should respond within 300 ms.”

Why is this incomplete?

Create a journey-weighted latency model for:

- Browse
- Add to cart
- Checkout
- Payment confirmation
- Post-purchase support

For each journey moment, explain:

- User expectation
- Latency pain level
- Trust risk
- Architecture response
- Whether the system should cache, degrade, revalidate, move to pending, or preserve replay evidence

## Exercise 3: Tail Latency Behavior Loop

DreamEntertainment streams a major live event. Average latency looks good, but a small percentage of viewers experience stalls and rebuffering. Those users refresh, restart the app, switch devices, open support chats, and complain publicly.

Analyze the tail-latency behavior loop.

Your answer should include:

- Why average latency hides the real failure
- How tail latency creates user doubt
- How doubt creates retries, refreshes, and duplicate work
- How duplicate work worsens the tail
- How idempotency, bounded retries, rate limits, backpressure, and commit clarity break the loop
- What observability is required to detect this before it becomes a public incident

## Exercise 4: Moment of Commitment

In DreamBank, a customer initiates a funds transfer. The fraud service is slow, payment authorization is delayed, and the UI keeps showing a spinner.

What should the system do?

Your answer should include:

- Why this is a commitment moment
- Why optimistic UI is dangerous here
- Whether the system should confirm, fail, pending, or review-required
- How idempotency prevents duplicate transfers
- How backpressure protects downstream systems
- What the user should see while waiting
- What replay evidence should be captured

## Exercise 5: Latency Myths

A product team says:

“We can hide latency with better UX, and if that is not enough, we can always add capacity.”

Why are both statements incomplete?

Your answer should include:

- Where UX smoothing helps
- Where UX smoothing becomes dishonest
- What capacity can improve
- What capacity cannot fix
- Why hop count, queue depth, dependency lag, retry amplification, idempotency gaps, and weak boundaries matter
- What a more honest latency strategy looks like

---

# Bonus GitHub Exercises

## Bonus Exercise 6: Latency Budget Design

Create a latency budget for a DreamMart checkout journey.

Your answer should include budgets and failure behavior for:

- UI/API gateway
- Pricing and inventory
- Fraud and payment
- AI assistant/RAG
- Confirmation

For each segment, explain:

- Why the budget matters
- What happens if the budget is exceeded
- Whether to show progress, pending, failed, degraded, or escalated state
- What evidence should be preserved

## Bonus Exercise 7: AI Latency DAG

DreamMart’s AI assistant answers customer questions about delivery, inventory, refunds, and order changes. One user request may trigger planning, retrieval, vector search, reranking, prompt construction, model inference, tool calls, evaluator loops, memory writes, and logging.

Design a latency strategy for this AI DAG.

Your answer should include:

- Retrieval fan-out controls
- Token and prompt budgets
- GPU queue telemetry
- Tool-call budgets
- Evaluator loop caps
- Model-tier routing
- Streaming or progressive response
- When to compress, degrade, defer, or escalate

## Bonus Exercise 8: Boundary Collapse Under Latency

DreamMart allows customers to modify orders after checkout. Under normal traffic, the flow works. Under heavy traffic, partner lag, policy checks, fraud changes, warehouse cutoff rules, and tool retries make order modification slow and ambiguous.

Analyze this as a boundary problem.

Your answer should include:

- Why latency exposes weak boundaries
- Which capability owns the order-modification promise
- Which actions should be allowed, blocked, deferred, or escalated
- How policy, jurisdiction, fraud, payment settlement, fulfillment cutoff, and partner constraints should be enforced
- Why manual overrides become dangerous at scale
- What state and evidence the user and support team should see

## Bonus Exercise 9: Latency Evidence and Replay

Six months after a delayed checkout incident, leadership asks:

“Why did the customer see pending for eight minutes, and why did the system later confirm the order?”

Design the evidence package needed to answer.

Your answer should include:

- Correlation ID
- Capability
- User context
- Decision and timestamp
- Policy version
- Evidence sources
- Queue depth or latency signals
- Tool calls
- Human approval, if any
- Final outcome
- Reversal or remediation link

Explain why screenshots and dashboards are not enough.

## Bonus Exercise 10: Senior Architect Latency Defense

An interviewer says:

“Latency is easy. Use CDN, caching, async processing, and autoscaling.”

Defend a more mature latency strategy.

Your answer should include:

- Why latency must be budgeted by journey moment
- Where latency changes user behavior
- Where commitment points require honest state
- Why retries need idempotency and budgets
- Where backpressure and priority queues are needed
- How UX smoothing differs from hiding uncertainty
- How AI DAG latency changes the design
- What safe degraded modes should exist
- What evidence proves the system behaved correctly while slow
