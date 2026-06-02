# Earlier-Lens Mapping Worksheet: E-Commerce Systems

This worksheet helps you apply the earlier lenses from Part I and Part II to Chapter 16: E-Commerce Systems.

The purpose is not to memorize a “design Amazon” answer. The purpose is to prove that you can reuse the same system design method under checkout, payment, inventory, fulfillment, returns, refunds, and support pressure.

Use this worksheet before drawing the final architecture. A senior answer should show that you understand the promise, actors, journey, capability boundaries, commitment tokens, admissible evidence, refusal lines, stop authority, ROCS loops, failure modes, economics, and replay requirements.

---

## 1. 7-Step Method Mapping

| Step | E-Commerce Application | Senior Architect Framing | Reader Notes |
|---|---|---|---|
| 1. Clarify the problem | Are we designing catalog browsing, cart, checkout, fulfillment, returns/refunds, or full commerce lifecycle? | “I need to know whether the interview scope is store infrastructure or commitment engine.” |  |
| 2. Identify actors | Customer, catalog, pricing, inventory, payment, fraud, warehouse, carrier, support, policy owner. | “The customer sees one order; the platform coordinates many systems that disagree.” |  |
| 3. Map the journey | Browse, cart, checkout, payment, fulfillment, delivery, modification, return, refund, support. | “Each journey moment carries a different trust expectation.” |  |
| 4. Define constraints | Hot SKUs, stale inventory, payment ambiguity, fulfillment cutoff, regional policy, fraud, refunds. | “Reality moves while checkout is trying to commit.” |  |
| 5. Name commitments | Inventory hold, reservation, payment authorization, order commit, fulfillment release, shipment acceptance, refund approval. | “Hold is intent. Commit is liability.” |  |
| 6. Choose architecture | Catalog, cart, checkout, inventory, payment, fraud, OMS, fulfillment, shipping, support, replay. | “I draw token mints and stop authority, not just services.” |  |
| 7. Defend trade-offs | Speed vs proof, availability vs defensible confirmation, convenience vs cutoff, automation vs review. | “A fast false confirmation is worse than a slower pending state.” |  |

## 2. Customer Journey Mapping

| Journey Moment | Customer Believes | Platform Risk | Architecture Response |
|---|---|---|---|
| Browse | Availability and price are useful hints. | Stale hints may look like promises. | Label estimates and avoid commitment language. |
| Cart | Items and totals are remembered. | Cart may imply reservation. | Preserve intent but do not promise inventory. |
| Checkout | “If I click Place Order, I bought it.” | Duplicate clicks, stale inventory, payment ambiguity. | Idempotent checkout and admissible commit gate. |
| Confirmed | “DreamMart owes me this order.” | False confirmation creates liability. | Require token chain and replay card. |
| Fulfillment | Order is being prepared. | Modification windows narrow. | Fulfillment cutoff and release tokens. |
| Delivery | Carrier has custody. | Responsibility shifts. | Shipment/carrier acceptance evidence. |
| Return/Refund | I should get money or explanation. | Refund without evidence creates financial risk. | Refund policy pin and refund replay card. |
| Support | DreamMart can explain what happened. | Missing replay causes debate. | Decision Replay Card. |

## 3. Capability Map

| Capability | Responsibility | Commitment Boundary | Owner |
|---|---|---|---|
| Catalog | Product discovery. | No commitment. | Catalog owner |
| Pricing | Price hints and final quote. | Price must be pinned at checkout. | Pricing owner |
| Cart | Customer intent. | No inventory reservation unless token exists. | Cart owner |
| Inventory | Hold, reserve, allocate. | `inventoryHoldId`, `reservationId`. | Inventory owner |
| Checkout | Commit orchestration. | `orderCommitId`. | Checkout owner |
| Payment | Authorize, capture, refund. | `paymentAuthId`, refund decision. | Payments owner |
| Fraud/Risk | Approve, review, block. | Risk gate. | Risk owner |
| Fulfillment | Pick, pack, release. | `fulfillmentReleaseId`. | Fulfillment owner |
| Shipping | Carrier handoff. | `shipmentId` / `carrierAcceptanceId`. | Shipping owner |
| Returns/Refunds | Return eligibility and money movement. | `refundDecisionId`. | Returns/refunds owner |
| Replay/Audit | Explain decisions. | Replay card. | Governance owner |

## 4. ARCHVIEW Mapping

| ARCHVIEW Concern | E-Commerce View |
|---|---|
| Actors | Customer, inventory, payment, fraud, warehouse, carrier, support, policy owner, platform. |
| Responsibilities | Browse, cart, checkout, commit, fulfillment, shipping, returns, refunds, replay. |
| Control surfaces | Freshness budgets, idempotency, hold/commit tokens, refusal lines, stop authority. |
| Commitment points | Inventory hold, reservation, payment auth, order commit, fulfillment release, shipment acceptance, refund approval. |
| Ownership | Checkout, payment, inventory, fulfillment, refund, risk, replay owners. |
| Evidence | Policy version, freshness snapshot, tool calls, tokens, customer-visible state. |
| Degradation | Pending, backorder, requires review, refused, compensated. |
| Stop authority | Replay gaps, tool failures, conflict spikes, reversal spikes, disputes. |

## 5. AI Primitives Mapping

| AI Primitive | E-Commerce Application | Artifact |
|---|---|---|
| Authority | Who can confirm, modify, refund, release, compensate, or stop automation? | Stop-authority matrix |
| Commitment | Cart is intent; confirmation is liability. | Hold/commit schemas |
| Time | Inventory, payment, fulfillment, and policy evidence expire. | Freshness-budget policy |
| Degradation | Pending, backorder, requires review, hard stop. | Degradation ladder |
| Evidence/Replay | Explain why order was confirmed, modified, refunded, shipped, or refused. | Decision Replay Card |
| Ownership | Each high-risk path needs a named owner. | Ownership map |

## 6. ROCS Mapping

| ROCS Dimension | Commerce Pressure | Control |
|---|---|---|
| Reliability | Commitments must hold under load and partial failure. | Idempotency, token chain, cutoffs, pending states. |
| Observability | Decisions must be replayable. | Replay cards, correlation IDs, policy pins. |
| Cost | Retries, reprocessing, refunds, support, and compensation multiply. | Retry budgets, tool caps, early escalation. |
| Sustainability | Trust and operating health must not drift. | Stop authority, refusal lines, re-enable criteria. |

## 7. Scale Mapping

| Scale Pressure | Commerce Failure Shape | Control |
|---|---|---|
| Hot SKU | Inventory contention. | Holds, reservations, allocation rules. |
| Promotion spike | Checkout latency and retries. | Idempotency, pending states, backpressure. |
| Payment queue | Ambiguous authorization. | Reconciliation and no false confirmation. |
| Warehouse cutoff | Modification becomes unsafe. | Fulfillment cutoff gates. |
| Support spike | Customers ask what happened. | Replay cards and clear states. |

## 8. Consistency Mapping

| Boundary | Trust Rule | Artifact |
|---|---|---|
| Browse | Estimate, not promise. | Availability label |
| Cart | Intent, not reservation. | Cart snapshot |
| Hold | Temporary inventory intent. | `inventoryHoldId` |
| Reserve | Inventory allocated. | `reservationId` |
| Authorize | Payment admissible. | `paymentAuthId` |
| Commit | Business liability begins. | `orderCommitId` |
| Release | Warehouse begins fulfillment. | `fulfillmentReleaseId` |
| Refund | Money movement approved. | `refundDecisionId` |

## 9. Latency Mapping

| Latency Type | Commerce Meaning | Control |
|---|---|---|
| Browse latency | Annoyance. | Cache, partial results. |
| Cart latency | Intent confusion. | Read-your-writes, clear state. |
| Checkout latency | Duplicate commitment risk. | Idempotency and pending state. |
| Payment latency | Ambiguous financial state. | Reconcile before confirmation. |
| Fulfillment latency | Modification window may close. | Fresh cutoff check. |
| Refund latency | Trust and support pressure. | Clear status and replay. |

## 10. Failure Mapping

| Failure Signal | What It Looks Like | Response |
|---|---|---|
| Inventory hard-stale | Confirming without proof. | Refresh, pending, or refuse. |
| Payment ambiguity | Authorization unclear. | Pending payment confirmation. |
| Fulfillment conflict | CRM says modifiable, warehouse says picking. | Hard stop or escalate. |
| Replay gap | No proof for high-risk commit. | Stop affected path. |
| Refund reversal spike | Money movement not defensible. | Require review. |

## 11. Economics Mapping

| Economic Multiplier | Commerce Example | Control |
|---|---|---|
| Retry storms | Repeated checkout/payment attempts. | Retry budgets and idempotency. |
| Reprocessing loops | Reconcile same order repeatedly. | Loop caps and owner escalation. |
| Compensation | Credits for broken promises. | Compensation budget and policy. |
| Manual cleanup | Support reconstructs decisions. | Replay cards. |
| Tool loops | Rechecking inventory/payment/fulfillment. | Tool-call budgets. |

## Final Senior Line

> An e-commerce system is not just catalog, cart, checkout, payment, and fulfillment. It is a commitment engine. The senior design separates intent from liability, treats freshness as admissibility, requires a token chain before confirmation, defines refusal lines for modifications and refunds, bounds retry and compensation loops, makes stop authority runnable, and preserves replay cards so the platform can defend why an order was confirmed, modified, refunded, shipped, or refused.
