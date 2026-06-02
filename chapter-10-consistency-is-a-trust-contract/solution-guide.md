# Chapter 10 Solution Guide

## Exercise 1 Solution: Consistency as a Trust Contract

A strong answer should explain that this is not merely a database replication issue. It is a broken trust contract.

The customer believed that “available” meant the item could be purchased and fulfilled. During discovery, “available” may be an advisory hint. At checkout, however, availability becomes actionable. Once the customer submits the order, the system has crossed the actionability cliff.

The system could not defend the promise because it lacked committed evidence: inventory reservation, payment authorization, final price calculation, and durable order state.

A better design would separate:

- **Available** as a discovery hint
- **Held** as a temporary reservation attempt
- **Reserved** as inventory secured for checkout
- **Confirmed** as order committed with payment and inventory evidence

The system should not show “order confirmed” until inventory is reserved and payment is authorized. If evidence is delayed, the customer should see “pending confirmation,” “reservation in progress,” or “review required,” not a false final state.

Required evidence:

- Inventory reservation token
- Payment authorization
- Price/promotion version
- Order state
- Correlation ID
- Timestamp
- Replay record

## Exercise 2 Solution: Actionability Cliff

A strong answer should show how consistency expectations tighten as the user gets closer to action.

On a **browse page**, the value is informational. The system may show approximate price, availability hints, or recommendations. Staleness is acceptable if the UI does not imply commitment.

On a **cart page**, the value becomes provisional. The system may show an estimated total, but it should label the total as subject to recalculation. Inventory may be shown as likely available, but not guaranteed.

On a **checkout confirmation page**, the value is committed. The system must revalidate price, promotion, inventory, payment, fraud, and order state before confirming.

Suggested semantic labels:

- Informational: approximate, estimated, trending, likely available
- Provisional: held, pending, recalculating, subject to confirmation
- Actionable: ready to submit, validated, eligible
- Committed: confirmed, settled, ticketed, final, approved

The key point: stale data is tolerable when the user is exploring. It becomes dangerous when the user can act.

## Exercise 3 Solution: Consistency vs. Availability

A strong answer should defend the pending-state design.

During a partner outage, continuing to accept bookings quickly and calling them “confirmed” is unsafe if partner acknowledgment has not arrived. That design maximizes apparent availability but weakens trust.

The more trustworthy design is to slow down or show a pending state.

“Confirmed” should mean the system has commit evidence:

- Partner acknowledgment
- Inventory/seat/room lock
- Payment authorization or capture
- Booking record
- State transition timestamp
- Correlation ID

Travel semantics should map to real states:

- Searching: no commitment
- Held: temporary availability hold
- Reserved: internal reservation exists
- Confirmed: partner/system commitment exists
- Ticketed: final ticketing authority has committed

If partner acknowledgment is delayed, the system should show “pending partner confirmation” or “held,” not “confirmed.” Compensation paths may include reaccommodation, refund, alternate booking, customer notification, and support escalation.

Replay evidence should include partner request/response, payment state, booking state, policy version, timestamps, and remediation link.

## Exercise 4 Solution: Classic Consistency Models Through a Trust Lens

A strong answer should choose models based on the user journey and consequence of being wrong.

### Product search results

Eventual consistency is usually acceptable. Search is discovery-oriented. Slightly stale results are tolerable if the system revalidates before purchase.

### Recommendation feed

Eventual consistency is acceptable. Recommendations are advisory, not committed truth.

### User profile update

Read-your-writes is important. After a user changes their address, phone number, or preferences, they expect to see their own update immediately.

### Shopping cart update

Read-your-writes and causal consistency matter. If a user adds an item to cart, the cart should not appear empty on the next page or device without explanation.

### Inventory reservation

Strong consistency or a defensible reservation protocol is required. Overselling breaks the checkout promise.

### Payment capture

Strong consistency, idempotency, and often linearizable behavior are needed around capture/settlement boundaries. Duplicate capture is unacceptable.

### Lab result release

Status-gated consistency is required. A value can be visible as preliminary, but it must not trigger final clinical action until readiness conditions are met.

### Flight ticket confirmation

Strong consistency or partner-backed committed evidence is required. “Confirmed” must not appear before the system can defend it.

Trust risk:

- Weak consistency in discovery may be acceptable.
- Weak consistency at commitment creates disputes, reversals, liability, or harm.

## Exercise 5 Solution: AI Consistency and Admissible Evidence

A strong answer should state that AI can sound coherent while relying on inconsistent or inadmissible evidence.

The support article and prior chat history are explanatory sources. They may help the assistant explain policy, but they are not authoritative for whether the order can still be modified.

Authoritative sources include:

- Order system
- Warehouse management system
- Fulfillment status
- Carrier handoff state
- Active order-modification policy
- Partner acknowledgment, if applicable

The admissible evidence gate should check:

- Source authority
- Freshness
- Version pinning
- User authorization
- Conflict detection
- Sensitive-data redaction

If warehouse picking has already started, the assistant should not say, “Yes, your order can still be modified.” A safer answer:

> Your order may no longer be eligible for automatic modification because fulfillment appears to have started. I can escalate this to support or check whether an exception is available.

Replay evidence should include retrieved sources, source timestamps, policy version, warehouse status, assistant output, tool calls, decision mode, and escalation path.

## Bonus Exercise 6 Solution: DreamFinance Balance Semantics

A strong answer should separate balance into multiple semantic types.

Possible balance types:

- Ledger balance: posted transactions
- Available balance: funds currently usable
- Pending authorization: reserved but not settled
- Hold amount: blocked funds
- Projected balance: expected future state after pending items
- Settled balance: final reconciled state

The UI and API should never expose a generic “balance” without semantics. If the user can transfer money, spend, or pay a bill based on a number, the number must represent committed or available truth.

Money movement should use near-zero allowed drift at commitment. If holds or settlement uncertainty exist, the system should block, reduce available amount, or show pending.

Required replay evidence:

- Ledger snapshot
- Pending holds
- Authorization records
- Settlement status
- Reconciliation version
- Policy/rule version
- Customer-visible balance label
- Transaction decision record

## Bonus Exercise 7 Solution: DreamHealthcare Readiness Gate

A strong answer should distinguish correct value from action-ready value.

A lab value may be technically correct but still preliminary. Preliminary data may be visible for awareness, but it should not trigger clinical action unless explicitly allowed.

A readiness gate should check:

- Result status: preliminary, corrected, final
- Result version
- Timestamp
- Patient identity confirmation
- Ordering clinician or workflow context
- Permission to notify or act
- Clinical policy version
- Exception approval, if applicable

Allowed actions for preliminary results:

- Display as preliminary
- Notify internal staff with label
- Hold for review

Blocked actions:

- Patient notification as final
- Clinical decision support triggering final recommendation
- Billing or regulatory action based on finality
- Automated treatment workflow

Exceptions must be approved, timestamped, role-based, and replayable.

## Bonus Exercise 8 Solution: Language as State

A strong answer should explain that language is architecture.

Replacing “held,” “reserved,” “pending,” and “ticketed” with “confirmed” destroys semantic precision. The UI may become simpler, but the business contract becomes false.

Possible meanings:

- Held: temporary hold exists, may expire
- Reserved: internal reservation exists, may still require partner or payment confirmation
- Pending: system is waiting for evidence
- Confirmed: commitment evidence exists
- Ticketed: final ticketing authority has issued ticket

Evidence required:

- Held: hold ID and expiration time
- Reserved: reservation ID and inventory lock
- Pending: pending reason and next action
- Confirmed: payment/partner/inventory evidence
- Ticketed: ticket number and ticketing authority

APIs and UIs should carry semantic state explicitly. Compensation paths may include reversal, reaccommodation, refund, customer notification, and support escalation.

## Bonus Exercise 9 Solution: Consistency Design Review Table

A strong answer should produce a table like this:

| Domain | What the User Believes | System of Record | Allowed Drift | Actionability Rule | Compensation / Proof |
|---|---|---|---|---|---|
| DreamMart Checkout | The order is real and will be fulfilled | Order + payment + inventory | None after confirmation | No confirmation without inventory reservation and payment authorization | Refund/reversal path + replay card |
| DreamFinance Balance | This amount is usable | Ledger + holds + settlement | Near zero when spending/transferring | If user can act, show available/settled semantics or block | Audit trail + ledger snapshot |
| DreamHealthcare Lab | This result is final | Lab system + clinical workflow | Status-gated | Preliminary visible but non-actionable unless approved | Correction workflow + evidence snapshot |
| DreamTravel Booking | My booking is real | Ticketing + partner authority | None after confirmation | No confirmed state without partner ack/payment/inventory lock | Reaccommodation + transition proof |

The table exposes weak assumptions because it forces the team to define user belief, source of truth, allowed drift, actionability, and compensation before production.

## Bonus Exercise 10 Solution: Senior Architect Consistency Defense

A strong answer should reject the simplistic statement that eventual consistency is always fine.

Eventual consistency is fine where the system is informing: search, feeds, recommendations, analytics, and low-risk discovery. It is dangerous where the user can act on the implied truth.

A precise strategy:

- Use fast, possibly stale views for discovery.
- Revalidate before commitment.
- Label state honestly: estimated, pending, held, reserved, confirmed, settled.
- Use strong or defensible consistency at commitment points.
- Use idempotency and reservation semantics for duplicate or concurrent actions.
- Use admissible evidence gates for AI outputs.
- Use conflict detection when authoritative sources disagree.
- Defer, escalate, or block when proof is missing.
- Preserve replay evidence for all high-risk decisions.

The consistency boundary to defend strongly: no customer-visible final commitment without admissible evidence and replayable proof.
