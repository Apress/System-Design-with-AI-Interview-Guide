# Chapter 1 Solution Guide

Use this guide after attempting the exercises. These are not the only correct answers. They show the level of reasoning expected from a strong senior system design candidate.

## How to use this guide

For each exercise, compare your response against three signals:

1. Did you clarify the promise before designing the machinery?
2. Did you connect architecture choices to users, capabilities, and failure behavior?
3. Did you explain trade-offs instead of listing technologies?

---

## 1. The Seven-Step Warm-Up Question

### Strong answer shape

A strong answer does not begin with “we need microservices.” It begins by framing the system promise.

### Sample answer

For an online food delivery system, I would first clarify the core promise: a customer should be able to discover restaurants, place an order, pay safely, track delivery, and receive food within an expected time window.

**Step 1: Requirements and constraints**  
I would clarify whether we are designing the full platform or only the ordering and delivery flow. I would ask about target geography, peak orders per second, restaurant count, driver count, delivery latency expectations, payment methods, and whether real-time tracking is required.

**Step 2: Domain and users**  
The key actors are customers, restaurants, drivers, support agents, and internal operations teams. The main entities include restaurant, menu, cart, order, payment, driver assignment, delivery route, and delivery status.

**Step 3: Customer journey**  
The critical journey is browse restaurant → select items → place order → authorize payment → restaurant accepts → driver assigned → food picked up → delivery completed. The trust moments are order confirmation, restaurant acceptance, delivery tracking, and refund handling.

**Step 4: Business capabilities**  
The core capabilities are restaurant discovery, menu management, cart and checkout, order orchestration, payment processing, driver matching, delivery tracking, notifications, and support/refunds.

**Step 5: High-level architecture**  
I would propose separate capabilities for restaurant/menu, ordering, payment, dispatch, tracking, notification, and support. Synchronous APIs would handle browsing and checkout. Asynchronous events would handle order state changes, driver assignment, notifications, and analytics.

**Step 6: Critical deep dive**  
The riskiest part is order orchestration because it coordinates payment, restaurant acceptance, driver matching, and customer status. I would deep dive into state transitions, idempotency, timeout behavior, retries, and compensation.

**Step 7: Validate and stress-test**  
I would test peak meal-time traffic, restaurant unavailability, payment timeout, driver shortage, duplicate order submissions, stale menus, delayed notifications, and regional outages.

### Senior-level signal

The strongest answers show that the candidate understands the system is not just a marketplace. It is a chain of commitments across time: customer payment, restaurant acceptance, driver availability, and delivery completion.

---

## 2. Requirements and Constraints Question

### Strong clarifying questions

1. **What exact flow are we designing: rider request, driver matching, trip tracking, payments, or the full platform?**  
   This prevents the answer from becoming too broad and unfocused.

2. **What scale should we assume: city-level launch, regional service, or global platform?**  
   Scale changes geospatial partitioning, caching, replication, and operational complexity.

3. **What matters most: fastest match, lowest cost, fairness to drivers, or marketplace liquidity?**  
   The optimization goal affects matching algorithms and ranking logic.

4. **What is the expected location update frequency from drivers and riders?**  
   Update frequency changes write load, stream processing needs, and storage choices.

5. **Do we require real-time price changes, surge pricing, or upfront pricing guarantees?**  
   Pricing commitment changes consistency and audit requirements.

6. **How should the system behave when no driver is available?**  
   This defines degradation, retry, waitlist, and user communication behavior.

7. **Are payments, safety, fraud, and support in scope?**  
   These determine whether the answer needs ledger design, trust workflows, and support tooling.

### Senior-level signal

A senior candidate shows discipline by saying: “Before choosing Kafka, Redis, or geohashing, I need to understand the promise the platform makes to riders and drivers.”

---

## 3. Customer Journey and Trust Question

### Strong answer shape

The trust moment in checkout is not “the user clicked Place Order.” It is the moment the platform claims: “Your order is real.”

### Sample answer

For DreamMart checkout, the most important trust moment is the order confirmation page. Before showing confirmation, the system must prove that the order has crossed the minimum safe commitment boundary.

At minimum, the system should know:

- The cart was priced using a valid price version.
- The inventory reservation succeeded or a safe backorder/substitution policy applies.
- Payment authorization succeeded or the chosen payment method was accepted under a defined policy.
- The order record was durably created with a unique idempotency key.
- The user can later retrieve the order and its state.

If payment authorization succeeds but inventory reservation times out, the system should not show a normal confirmation that implies everything is complete. It should either:

1. hold the payment authorization and show a pending confirmation state,
2. release or reverse the authorization if inventory cannot be secured, or
3. confirm only the items that have been safely reserved if partial fulfillment is allowed.

The key is that the UI, backend state, and customer promise must match. The system should not let the customer believe the order is guaranteed if inventory is still unknown.

### Senior-level signal

A senior architect separates technical success from customer trust. “Payment authorized” is not the same as “order confirmed.” The confirmation page is a business commitment, not a UI screen.

---

## 4. AI Authority and Boundaries Question

### Strong answer shape

The AI assistant should not become an invisible owner of business commitments. It can recommend, explain, and prepare actions, but the system of record must validate commitments.

### Suggested authority model

| AI action type | Allowed behavior | Required control |
|---|---|---|
| Product recommendation | Allowed | Ground recommendations in catalog, availability, and user context. |
| Coupon suggestion | Allowed with validation | Coupon service must validate eligibility before display or application. |
| Delivery question | Allowed with evidence | Must use current order and logistics state, not guess. |
| Order modification | Suggest or prepare | Final modification requires order-service validation. |
| Refund or cancellation | Limited authority | Must follow policy and escalation rules. |
| Order confirmation | Not directly allowed | Only order service can confirm durable commitment. |
| Payment action | Not directly allowed | Payment service must authorize or reject. |

### Evidence required

Before the assistant makes a claim, it should have evidence from the relevant system of record:

- Catalog service for product facts
- Inventory service for availability
- Pricing or promotion service for coupon eligibility
- Order service for order state
- Payment service for payment state
- Delivery/logistics service for shipment state

### Fallback behavior

If the assistant cannot retrieve evidence, it should degrade honestly:

- “I cannot confirm that yet.”
- “The order is still being processed.”
- “I can connect you to support.”
- “Please review this before I submit the change.”

### Replay and audit needs

Every consequential AI-assisted action should record:

- user request
- tool calls
- evidence snapshot
- policy version
- action attempted
- system decision
- final user-visible message

### Senior-level signal

The strongest answer says: AI can assist the journey, but it must not invent commitments. Authority belongs to validated services and explicit policies.

---

## 5. Senior Architect Stress-Test Question

### Strong answer shape

The stress test should reveal whether the architecture protects the customer promise under pressure.

### Sample stress-test response

For Black Friday checkout, I would test the architecture against load, duplicate actions, slow dependencies, partial failures, and AI overclaiming.

**Duplicate requests**  
Every Place Order request should carry an idempotency key. The order service should return the same durable result for duplicate submissions instead of creating multiple orders.

**Payment timeout behavior**  
A slow payment provider should not cause uncontrolled retries from the user interface or backend workers. The system should use timeout budgets, retry limits, circuit breakers, and pending states. The customer should see an honest status instead of a false confirmation.

**Inventory oversell prevention**  
Inventory reservation should be explicit. The system should avoid confirming an order until inventory is reserved or a defined substitution/backorder policy is applied. For high-demand items, reservation expiry and atomic decrement semantics matter.

**User-visible degradation**  
The checkout experience may degrade to queueing, pending confirmation, reduced recommendation calls, simplified shipping options, or delayed email confirmation. It should not degrade into lying.

**AI response control**  
The AI assistant should be prevented from saying “your order is confirmed” unless the order service reports a confirmed state. During degraded periods, the assistant should use approved language such as “your order is processing” or “I cannot confirm this yet.”

**Observability and replay**  
The system should capture correlation IDs across cart, order, payment, inventory, AI assistant, and notification services. A replay record should show what the user attempted, what each dependency returned, what the assistant said, and why the final state was chosen.

**Design decision to defend**  
The design decision I would defend most strongly is idempotent checkout with an explicit order state machine. Without that, Black Friday failures become duplicate charges, oversold inventory, false confirmations, and impossible support investigations.

### Senior-level signal

A principal-level answer does not say only “scale horizontally.” It identifies the commitment boundary and protects it with idempotency, explicit state, controlled retries, degradation, and replay.

---

## Quick scoring rubric

| Score | What the answer usually shows |
|---|---|
| 1–3 | Jumps directly to technologies without requirements, users, or failure behavior. |
| 4–5 | Covers basic architecture but misses trust moments, constraints, or trade-offs. |
| 6–7 | Uses the seven-step method and identifies major components and risks. |
| 8–9 | Connects requirements, journey, capabilities, architecture, failure behavior, and AI boundaries. |
| 10 | Shows senior judgment: commitment boundaries, degradation, evidence, replay, ownership, and defendable trade-offs. |
