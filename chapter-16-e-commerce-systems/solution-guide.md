# Chapter 16 Solution Guide

## Exercise 1 Solution: E-Commerce as a Commitment Engine

A strong answer should explain that e-commerce is not simply a collection of services. It is a chain of business commitments. DreamMart is not judged only by whether catalog, cart, checkout, payment, and fulfillment APIs remain available. It is judged by whether customer-visible promises are true, defensible, and replayable.

Browsing is exploratory. The system may show approximate availability, cached prices, recommendations, or estimated delivery windows. Cart is intent. The customer has expressed interest, but the business has not necessarily reserved inventory or accepted payment liability. Checkout is the commitment boundary. Once the UI says **Confirmed**, DreamMart must be able to prove that inventory was reserved or allocated, payment was authorized, policy was pinned, and fulfillment was still inside a valid window.

“In stock” is not the same as “reserved.” “In stock” may be a cached or approximate hint. “Reserved” means the system has an inventory proof object, such as `inventoryHoldId`, `reservationId`, or `inventoryCommitId`.

“Order created” is not the same as “order confirmed.” An order record may exist for workflow tracking, but confirmation means the business has accepted liability. Confirmation requires the token chain.

Actors affected include:

- Customer
- Catalog and pricing systems
- Inventory systems
- Payment processor
- Fraud/risk system
- Order management
- Warehouse/fulfillment
- Carrier
- Support
- Policy owner
- Legal/risk/audit

Evidence before showing **Confirmed** should include:

- Checkout intent ID
- Idempotency key
- Inventory freshness snapshot
- `inventoryHoldId`
- `reservationId` or inventory allocation acknowledgment
- `paymentAuthId`
- Fraud/policy decision
- Fulfillment cutoff check
- Pinned policy version
- `orderCommitId`
- Replay card emitted

Replay should preserve who acted, what evidence existed, which policy applied, which tools ran, which tokens were minted, what was shown to the customer, and what reversal or compensation path exists.

The senior answer: DreamMart is not an online store. It is a commitment engine, and **Confirmed** is not a UI label; it is a liability state backed by evidence.

---

## Exercise 2 Solution: Hold Token vs. Commit Token

A strong checkout flow should separate customer intent, inventory hold, payment authorization, reservation acknowledgment, and final order commitment.

Suggested flow:

1. Customer presses **Place Order**.
2. Checkout service creates `checkoutIntentId`, `correlationId`, and an idempotency key tied to the cart snapshot and customer.
3. Pricing and checkout policy bundle are pinned.
4. Inventory snapshot freshness is checked.
5. Fulfillment cutoff is checked for the selected fulfillment node, shipping promise, and warehouse state.
6. Fraud/risk posture is evaluated.
7. Inventory service creates `inventoryHoldId`.
8. Payment provider returns `paymentAuthId`.
9. Inventory hold is promoted to `reservationId` or allocation acknowledgment.
10. Commit gate verifies:
    - inventory is reserved,
    - payment is authorized,
    - fraud/policy passed,
    - fulfillment is still eligible,
    - replay can be emitted.
11. System mints `orderCommitId`.
12. UI shows **Confirmed**.
13. Decision Replay Card is written.

Token meanings:

- `checkoutIntentId`: customer action intent.
- `inventoryHoldId`: short-lived inventory intent, not final truth.
- `reservationId`: inventory allocated or reserved.
- `paymentAuthId`: payment authorization evidence.
- `orderCommitId`: umbrella proof that the order crossed the liability boundary.

Failure behavior:

- Inventory unavailable: show unavailable, backorder, or pending allocation.
- Inventory hard-stale: refresh, defer, or pending.
- Payment ambiguity: do not show confirmed; reconcile or show pending payment.
- Fraud review required: show requires review.
- Fulfillment cutoff crossed: refuse automatic path or escalate.
- Policy unavailable: defer high-risk action.

Idempotency is essential. The idempotency key should be tied to checkout intent, cart snapshot, customer, and payment attempt. Repeated clicks should return the same state, not create new orders, new authorizations, or duplicate reservations. A retry should ask, “What happened to my previous intent?” not “Please create a new liability.”

The senior answer: `inventoryHoldId` is intent; `orderCommitId` is liability. The UI can show **Confirmed** only after the proof chain exists.

---

## Exercise 3 Solution: Freshness Budgets as Admissible Reality

“The latest data available” is not precise enough because the latest data in the system may already be too stale to support a customer-visible commitment. Freshness is not only a performance issue. It is an admissibility rule.

Suggested freshness budget:

| Signal | Soft TTL | Hard TTL | Commit Rule |
|---|---:|---:|---|
| Inventory snapshot | <= 30 seconds | <= 120 seconds | Hard-stale inventory cannot justify confirmed order or allocation. |
| Fulfillment state | <= 5 seconds | <= 20 seconds | Hard-stale fulfillment cannot justify modification, cancellation, or release. |
| Payment authorization | <= 10 seconds | <= 60 seconds | Hard-stale payment cannot justify confirmation, refund, or capture. |
| Policy bundle | <= 5 minutes | <= 30 minutes | Policy may be cached, but exact version must be pinned at decision time. |

Inside soft TTL:

- Use normally.
- Preserve timestamp.
- Include snapshot version.
- Refresh opportunistically if near boundary.

Between soft and hard TTL:

- Proceed cautiously.
- Refresh before high-risk commit.
- Use pending state if proof is incomplete.
- Avoid final customer-visible commitment if confidence is weak.

After hard TTL:

- Do not commit.
- Refresh, defer, move to pending, route to review, or hard-stop depending on risk.

Stale evidence may support exploration. Browsing can show “limited stock,” “estimated delivery,” or “price subject to confirmation.” But stale evidence cannot support liability. Checkout, payment capture, fulfillment release, refund, or modification requires decision-time evidence fresh enough to defend.

Replay record should include:

- Signal source
- Event time
- Ingestion time
- Decision time
- Signal age
- Soft/hard TTL policy version
- Snapshot version
- Refresh attempts
- Gate result
- Outcome

The senior answer: freshness is admissible reality. If the evidence is too stale, DreamMart must not pretend it knows.

---

## Exercise 4 Solution: Checkout Latency and Duplicate Commitment

A strong answer should explain that checkout latency is more dangerous than browsing latency because checkout is where customer intent becomes business liability.

During browsing, delay is annoying. During checkout, delay creates doubt: “Did my order go through?” Customers refresh, resubmit, retry payment, or contact support. If the system does not bind retries to one checkout intent, the result can be duplicate orders, duplicate payment authorizations, duplicate inventory reservations, and later reversals.

This is a commitment-boundary failure because the system allowed uncertainty at the commit point to spread.

Controls:

- Idempotency key tied to checkout intent
- Single-flight checkout processing
- Explicit checkout state machine
- Payment authorization reconciliation
- Inventory hold TTL
- Reservation confirmation before UI confirmation
- Pending state for ambiguous commits
- Retry budgets
- Compensation budgets
- Replay card before confirmation

Payment ambiguity should not become confirmation. If a payment provider timeout occurs after an authorization may have succeeded, DreamMart should move to **Pending Payment Confirmation** or **Pending Confirmation**, reconcile asynchronously, and avoid issuing a new payment attempt unless idempotency confirms safety.

When to show states:

- **Pending**: evidence may arrive soon.
- **Backorder**: inventory is unavailable but policy allows later fulfillment.
- **Requires review**: fraud, policy, or high-risk ambiguity exists.
- **Refused**: policy, safety, inventory, payment, or fulfillment proof blocks action.
- **Confirmed**: token chain exists.

Replay evidence:

- Checkout intent ID
- Idempotency key
- Cart snapshot
- Inventory evidence
- Payment attempt and auth status
- Retry count
- Tool call statuses
- Policy version
- Commit token
- Customer-visible state
- Reversal or compensation path

The senior answer: at checkout, latency turns into repeated intent. Repeated intent must be collapsed into one defensible commitment.

---

## Exercise 5 Solution: Order Modification After Fulfillment Cutoff

A strong answer should say DreamMart should not automatically allow the modification if warehouse evidence says picking has started.

Order modification is phase-aware. Before fulfillment acts, address change may be a simple update. After payment, fraud, fulfillment, warehouse release, or carrier handoff enters the chain, modification becomes a commitment-risk decision.

Fulfillment state must be authoritative at the modification boundary because warehouse execution can make the change irreversible. CRM may be useful for customer service workflow, but it is not sufficient to prove warehouse modifiability.

Conflicting evidence should not be smoothed into a confident answer. If CRM says modifiable and warehouse says picking started, the system should treat that as a conflict at a commitment boundary.

Behavior:

- Refresh fulfillment state if within budget.
- If conflict remains, do not commit automated modification.
- If picking has started, hard-stop or escalate.
- If carrier handoff has occurred, hard-stop automatic address change.
- If policy allows exception, route to human/specialist review.
- If customer harm occurs after post-commit divergence, communicate and compensate according to policy.

Replay evidence:

- Order ID
- Modification request
- Customer actor
- Current fulfillment state
- CRM state
- Warehouse state
- Payment/settlement state
- Fraud/risk state
- Policy version
- Conflict reason
- Decision mode: modified, pending, escalated, refused
- Customer communication
- Compensation decision

The senior answer: after fulfillment begins, convenience cannot outrank enforceability. If DreamMart cannot keep the address-change promise, it must not make it.

---

## Bonus Exercise 6 Solution: Defensible Refund

A defensible refund workflow should treat refund approval as a financial and policy commitment, not a support gesture.

Required evidence:

- Order ID and customer ID
- Delivery status
- Carrier acceptance or delivery proof
- Return merchandise authorization, if applicable
- Return received/inspected state, if applicable
- Payment authorization or settlement status
- Refund method eligibility
- Fraud/risk score
- Customer account age and history
- Return-policy version
- Refund threshold
- Prior refund/chargeback history

Suggested flow:

1. Customer requests refund.
2. System creates `refundRequestId` and `correlationId`.
3. Policy bundle is pinned.
4. Delivery and return state are checked.
5. Payment state is checked.
6. Fraud/risk posture is checked.
7. Refund amount is classified by threshold.
8. Low-risk refund may be automated if evidence passes.
9. High-value, new-account, unclear-payment, or policy-change cases go to review.
10. Approved refund mints `refundDecisionId`.
11. Replay card is emitted.

Decision states:

- **Approved**: all evidence passes and policy allows.
- **Deferred**: waiting for payment/return/delivery evidence.
- **Requires review**: high value, new account, fraud risk, policy conflict.
- **Refused**: policy or evidence blocks refund.
- **Compensated**: goodwill or exception path approved by owner.

`refundDecisionId` receipt should contain:

- Refund request ID
- Correlation ID
- Order ID
- Payment state
- Delivery/return evidence
- Policy version
- Fraud/risk score
- Refund threshold classification
- Human approval, if any
- Outcome
- Reversal/appeal path

The senior answer: a refund is money movement. It needs policy, evidence, authority, and replay.

---

## Bonus Exercise 7 Solution: Stop Authority for Commerce Commitments

Stop authority should be a runtime mechanism that can narrow or stop commerce paths when evidence quality, tool reliability, or customer trust degrades.

Useful triggers:

| Signal | Example Threshold | Action |
|---|---:|---|
| Replay coverage for high-risk commits | < 100% | Hard-stop affected commit path |
| Payment tool failure | sustained threshold breach | Move to pending or payment review |
| Inventory conflict rate | rising above baseline | Tighten commit gates |
| Fulfillment conflict rate | rising above baseline | Stop automated modifications |
| Refund reversal rate | above threshold | Require review for affected refund type |
| Dispute/chargeback rate | above threshold | Freeze risky automation |
| Retry storm | budget exceeded | Enforce backpressure and pending states |

Owners:

- Checkout owner
- Inventory owner
- Payment owner
- Fulfillment owner
- Refund/policy owner
- Trust/risk owner
- Commerce operations owner

When stop authority fires, emit:

- Signal
- Threshold crossed
- Affected capability
- Scope
- Owner
- Policy version
- Action taken
- Customer-visible state
- Re-enable criteria
- Replay link

Re-enable criteria:

- Replay coverage restored
- Tool failures below threshold
- Conflict rate normal
- Disputes/reversals return to baseline
- Policy or authority-envelope version bumped
- Owner approves re-enable

The senior answer: ownership is not a name on a slide. It is the authority to change system behavior before weak evidence becomes customer harm.

---

## Bonus Exercise 8 Solution: ROCS Commerce Control

A strong answer should apply ROCS as operating control, not as four dashboards.

### Reliability

Reliability means commitments hold under load and partial failure.

Controls:

- Idempotency
- Inventory holds
- Payment authorization handling
- Pending states
- Fulfillment cutoffs
- Bounded retries
- Phase-aware refusal lines

Metrics:

- Duplicate order rate
- Confirmation reversal rate
- Payment ambiguity rate
- Inventory conflict rate
- Modification failure rate

### Observability

Observability means the system can prove why it committed, modified, shipped, or refunded.

Controls:

- Decision Replay Cards
- Correlation ID across async hops
- Pinned policy version
- Evidence snapshots
- Tool traces
- Token chain

Metrics:

- Replay coverage
- Missing token rate
- Correlation break rate
- Support reconstruction time

### Cost

Cost means repeated work is bounded.

Controls:

- Retry budgets
- Tool-call caps
- Compensation budgets
- Reprocessing caps
- Early escalation
- Duplicate collapse

Metrics:

- Retry cost per order
- Manual review rate
- Compensation cost
- Support contacts per order
- Reprocessing rate

### Sustainability

Sustainability means the system can continue operating without trust, cost, or operational drift.

Controls:

- Refusal lines
- Stop authority
- Fair outcomes
- Re-enable criteria
- Policy learning from receipts

Metrics:

- Dispute rate
- Reversal rate
- Customer trust signals
- Policy exception rate
- Manual override rate

Posture changes should trigger when replay coverage drops, tool failures rise, conflict rates spike, reversals increase, disputes rise, or retry budgets are exhausted.

The senior answer: ROCS keeps DreamMart stable, provable, cost-bounded, and sustainable under commercial pressure.

---

## Bonus Exercise 9 Solution: Decision Replay Card Design

Example: order confirmation replay card.

```json
{
  "correlationId": "corr-123",
  "actionType": "ORDER_CONFIRMATION",
  "actor": {
    "type": "CUSTOMER",
    "id": "cust-789"
  },
  "orderContext": {
    "checkoutIntentId": "chk-456",
    "cartSnapshotId": "cart-snap-222",
    "orderId": "ord-1001"
  },
  "policy": {
    "policyVersion": "checkout-policy-2026-05",
    "authorityEnvelope": "standard-checkout"
  },
  "evidence": {
    "inventorySnapshotId": "inv-snap-999",
    "inventoryAgeSeconds": 18,
    "fulfillmentStateId": "fulfill-state-321",
    "fulfillmentAgeSeconds": 4,
    "paymentAuthStatus": "AUTHORIZED",
    "paymentAuthId": "pay-auth-555",
    "fraudDecisionId": "fraud-pass-101"
  },
  "toolCalls": [
    {
      "tool": "inventory.reserve",
      "status": "success",
      "token": "reservation-abc"
    },
    {
      "tool": "payment.authorize",
      "status": "success",
      "token": "pay-auth-555"
    }
  ],
  "tokensMinted": {
    "inventoryHoldId": "hold-111",
    "reservationId": "reservation-abc",
    "paymentAuthId": "pay-auth-555",
    "orderCommitId": "order-commit-777"
  },
  "customerVisibleOutcome": "CONFIRMED",
  "reversalOrCompensationPath": "standard-order-support-policy"
}
```

A strong replay card should answer:

- Who acted?
- What was requested?
- Which policy applied?
- What evidence existed?
- Was the evidence fresh?
- Which tools ran?
- Which tokens were minted?
- What did the customer see?
- How can the decision be reversed, appealed, or compensated?

The senior answer: logging says what ran. Replay says why the system was allowed to act.

---

## Bonus Exercise 10 Solution: Senior Architect E-Commerce Defense

A mature answer should acknowledge that catalog, cart, checkout, payment, inventory, fulfillment, and notifications are necessary, but incomplete. Those are components. They do not define when the business becomes liable.

A senior answer starts like this:

> I am not designing only an online store. I am designing a commerce commitment engine.

Key defense points:

### Hold and commit separation

Cart is intent. `inventoryHoldId` is temporary reservation intent. `reservationId` and `paymentAuthId` provide proof. `orderCommitId` is the umbrella commitment.

### Freshness as admissibility

Inventory, fulfillment, payment, and policy evidence must be fresh enough at decision time. Hard-stale evidence cannot justify confirmation, modification, refund, capture, or fulfillment release.

### Token chain

Confirmed requires a defensible proof chain: inventory hold, reservation/allocation, payment authorization, policy pin, fulfillment eligibility, and replay card.

### Refusal lines

Automatic workflows must stop for modification after picking, address change after settlement or carrier handoff, refund above threshold for risky accounts, missing commit token, or conflicting evidence.

### Bounded churn

Retries, rechecks, refunds, compensation, and tool loops need budgets. When budgets are exhausted, the system moves to pending, escalates, or hard-stops.

### Stop authority

Replay gaps, tool failure spikes, conflict rates, reversals, and disputes must be able to narrow or stop automation without waiting for a crisis meeting.

### ROCS

Reliability keeps commitments intact. Observability proves them. Cost bounds retries and cleanup. Sustainability protects trust and operating health.

### Replay

Six months later, DreamMart should prove why an order was confirmed, modified, refunded, shipped, or refused under a pinned policy version.

Senior interview line:

> I would not frame DreamMart as catalog, cart, and checkout services. I would frame it as a commitment engine. I separate hold from commit, treat freshness as admissibility, require a token chain before showing Confirmed, define refusal lines for high-risk actions, bound retries and compensation loops, make stop authority runnable, and emit replay cards so the platform can defend every confirmed, modified, refunded, shipped, or refused state.
