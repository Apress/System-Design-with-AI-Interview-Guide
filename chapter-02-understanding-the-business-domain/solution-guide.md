# Chapter 2 Solution Guide: Understanding the Business Domain

This guide provides sample answer direction for the Chapter 2 exercises. Use it after attempting the questions yourself.

## 1. Domain Understanding Warm-Up — Sample Direction

A strong answer starts with domain discovery, not infrastructure.

### Primary actors

- Shopper: searches, compares, adds to cart, checks out, tracks delivery, requests support.
- Seller or marketplace partner: manages catalog, pricing, inventory, fulfillment rules, promotions.
- Warehouse or fulfillment operator: picks, packs, ships, handles substitutions and returns.
- Delivery partner: receives delivery assignments, updates delivery state, resolves exceptions.
- Support agent: helps with payment failures, missing items, returns, refunds, and order issues.
- Fraud or risk analyst: investigates suspicious behavior, chargebacks, abuse, and account risk.
- Internal business teams: monitor conversion, revenue, margin, retention, inventory health, and service quality.

### Core entities

Common domain entities include customer, account, product, SKU, catalog, seller, price, promotion, cart, order, payment authorization, payment capture, inventory reservation, shipment, delivery, return, refund, support case, recommendation, and fraud signal.

### Important journeys

- Browse and search products.
- Add items to cart.
- Validate price, promotion, inventory, delivery promise, and payment.
- Place order.
- Track fulfillment and delivery.
- Handle returns, refunds, and support.

### Business success metrics

- Conversion rate
- Cart abandonment rate
- Revenue and gross merchandise value
- Payment authorization success rate
- Inventory accuracy
- On-time delivery rate
- Support contact rate
- Refund and return rate
- Fraud loss rate
- Recommendation click-through and conversion impact

### Technical quality attributes

- Low-latency search and product detail pages
- Correct checkout and payment behavior
- Reliable inventory reservation
- High availability during peak traffic
- Strong auditability for financial and user-impacting decisions
- Graceful degradation when dependencies fail

### AI opportunity areas

- Product recommendations
- Search ranking and semantic search
- Customer support summarization and next-best action
- Fraud/risk scoring
- Delivery ETA prediction
- Seller coaching and catalog quality improvement

A senior answer explains that domain understanding prevents generic architecture. It reveals what must be fast, what must be correct, what can be eventually consistent, where user trust is at risk, and where AI can help without overstepping authority.

## 2. Actor and Journey Analysis — Sample Direction

### Shopper journey: buy a product

- Goal: find a product, understand price and delivery promise, place a trusted order.
- Capabilities: search, recommendations, product catalog, pricing, promotions, cart, checkout, payment, inventory, order management.
- Trust moment: the confirmation page must reflect a real order backed by valid payment authorization and inventory reservation.
- What could go wrong: stale price, out-of-stock item, duplicate order, payment timeout, wrong delivery promise.
- Architecture protection: idempotent checkout, inventory reservation, payment authorization state machine, order confirmation only after required commitments, clear degradation messages.

### Seller journey: manage catalog and inventory

- Goal: list products, maintain accurate inventory, update prices, fulfill orders.
- Capabilities: seller management, catalog ingestion, pricing, inventory, fulfillment, analytics.
- Trust moment: seller updates should become visible accurately and should not create invalid catalog or inventory state.
- What could go wrong: malformed product data, incorrect stock count, conflicting price update, delayed catalog propagation.
- Architecture protection: validation pipelines, ownership boundaries, event-driven updates, reconciliation jobs, versioned catalog records.

### Support agent journey: resolve order issue

- Goal: understand customer issue and take appropriate action.
- Capabilities: customer profile, order history, payment status, fulfillment status, return/refund policy, support case management, AI summarization.
- Trust moment: the agent must not issue a refund or promise replacement without policy and state validation.
- What could go wrong: AI summarizes incorrectly, stale order state, unauthorized refund, missing evidence.
- Architecture protection: read-only AI summaries, tool authorization, policy checks, evidence trails, human approval for sensitive actions.

## 3. Business Capability Mapping — Sample Direction

A capability map should group the business into stable areas instead of mirroring implementation services too early.

| Capability | Type | Why it matters |
| --- | --- | --- |
| Product discovery | Customer-facing | Shapes first impression and conversion. |
| Search and recommendations | Customer-facing / AI-driven | Drives relevance, personalization, and engagement. |
| Cart and checkout | Customer-facing / financial | Converts intent into committed order. |
| Payment | Financial / governance | Requires correctness, audit, compliance, and idempotency. |
| Inventory | Operational | Prevents oversell and false promises. |
| Fulfillment | Operational | Turns orders into shipped packages. |
| Delivery tracking | Customer-facing / operational | Maintains trust after purchase. |
| Customer support | Customer-facing / operational | Recovers trust when something goes wrong. |
| Fraud and risk | Governance / AI-driven | Protects platform, sellers, and customers. |
| Seller management | Operational | Enables marketplace scale. |
| Analytics and personalization | Intelligence/AI-driven | Improves decisioning and customer experience. |

Three high-attention capabilities:

1. Checkout and payment, because mistakes create financial, legal, and trust damage.
2. Inventory and fulfillment, because the platform must not promise what it cannot deliver.
3. Search/recommendations, because discovery drives conversion and user satisfaction, especially at scale.

## 4. AI Opportunity and Boundary Analysis — Sample Direction

### Product recommendations

- Business problem: increase product discovery, conversion, and basket size.
- Data needed: browsing history, product metadata, purchase history, similarity signals, popularity, availability, price, delivery constraints.
- Decision influenced: ranking and suggested products.
- Authority: AI should suggest and rank; it should not override inventory, pricing, or compliance rules.
- Evidence/audit: model version, features used, ranking explanation category, experiment ID.
- Fallback: use trending, category bestsellers, or rules-based recommendations if personalization is unavailable.

### Fraud detection

- Business problem: reduce payment fraud, account abuse, promo abuse, and chargebacks.
- Data needed: account history, device signals, payment patterns, velocity, shipping address risk, order value, prior disputes.
- Decision influenced: allow, challenge, review, or block.
- Authority: AI may score and recommend; final policy should be enforced by deterministic risk rules or a decisioning service.
- Evidence/audit: risk factors, score, policy version, model version, reviewer actions.
- Fallback: conservative policy, step-up verification, manual review queues.

### Customer support assistant

- Business problem: reduce resolution time and improve answer quality.
- Data needed: order state, customer history, support policy, shipment events, payment/refund status, prior case notes.
- Decision influenced: suggested response, next-best action, summarization.
- Authority: AI can summarize and suggest; it should not refund, cancel, or modify orders without tool permissions and policy validation.
- Evidence/audit: source records, policy references, tool calls, agent approval.
- Fallback: escalate to human, provide transparent uncertainty, avoid unsupported claims.

## 5. Senior Architect Domain-to-Architecture Question — Sample Direction

A strong answer translates business concerns into system qualities and design priorities.

### Business concerns to architecture priorities

| Stakeholder concern | Architecture priority |
| --- | --- |
| CEO wants revenue growth | High conversion, low-latency discovery, checkout throughput, personalized offers. |
| Operations wants inventory accuracy | Reservation model, reconciliation, inventory ownership, anti-oversell controls. |
| Finance wants payment correctness | Idempotency, payment state machine, audit trail, PCI-aware boundaries. |
| Support wants fewer complaints | Clear order state, reliable tracking, evidence-rich support tools, graceful degradation. |
| AI team wants personalization | Feature pipelines, experiment governance, model monitoring, AI authority boundaries. |

### Critical quality attributes

- Availability during Black Friday
- Checkout correctness
- Payment idempotency
- Inventory reservation integrity
- Search/recommendation latency
- Observability and replay
- Safe AI behavior under uncertainty

### Data ownership concerns

- Payment service owns payment state.
- Inventory service owns reservation and stock truth.
- Order service owns order lifecycle.
- Catalog service owns product truth.
- AI systems may read and recommend but should not own core transactional truth.

### AI risk boundaries

The AI assistant may help users discover products, explain order status, and recommend next steps. It must not claim an order is confirmed unless the order system has committed the order. It must not promise delivery dates, refunds, or inventory unless those facts are backed by authoritative systems.

### Metrics proving the design works

- Checkout success rate
- Payment duplicate rate
- Payment timeout rate
- Inventory oversell rate
- Order confirmation accuracy
- Search p95 latency
- Support contact rate after checkout
- AI unsupported-claim rate
- Recommendation conversion lift
- Black Friday error budget burn

### Executive trade-off

A senior architect should explain that maximizing conversion cannot come at the expense of false promises. During peak load, the system should degrade discovery or personalization before compromising payment correctness, inventory accuracy, or order confirmation integrity.

