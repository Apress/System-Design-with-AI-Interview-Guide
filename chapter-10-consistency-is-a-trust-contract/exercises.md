# Chapter 10 Exercises

## Exercise 1: Consistency as a Trust Contract

DreamMart shows a product as “available,” allows the customer to check out, and then later cancels the order because inventory was not actually reserved.

Explain why this is not only a data consistency problem.

Your answer should include:

- What the customer believed
- What the system could actually defend
- Where the actionability cliff occurred
- Why “available” can be advisory during discovery but dangerous during checkout
- What state should have been shown instead
- What evidence is required before the system can confirm the order

## Exercise 2: Actionability Cliff

A system shows the same value in three places: a browse page, a cart page, and a checkout confirmation page.

How should consistency expectations change across those three moments?

Your answer should address:

- Informational state
- Advisory state
- Actionable state
- Irreversible or committed state
- Where stale data is acceptable
- Where stale data becomes dangerous
- How the UI/API should label provisional, pending, held, confirmed, settled, or final states

## Exercise 3: Consistency vs. Availability

During a partner outage, DreamTravel can either keep accepting bookings quickly with delayed partner acknowledgment or slow down and show customers a pending state.

Which design is more trustworthy?

Your answer should include:

- Why availability alone is not the right goal at commitment points
- What “confirmed” should mean
- Why held, reserved, confirmed, and ticketed must map to real state transitions
- How to degrade honestly
- What compensation or recovery path is needed
- What evidence must be captured for replay

## Exercise 4: Classic Consistency Models Through a Trust Lens

Choose the right consistency model for each scenario and explain why:

- Product search results
- Recommendation feed
- User profile update
- Shopping cart update
- Inventory reservation
- Payment capture
- Lab result release
- Flight ticket confirmation

Your answer should compare:

- Strong consistency
- Eventual consistency
- Read-your-writes
- Monotonic reads
- Causal consistency
- Linearizability

Explain the trust risk if the wrong consistency model is used.

## Exercise 5: AI Consistency and Admissible Evidence

DreamMart’s AI assistant answers: “Yes, your order can still be modified,” based on a support article and prior chat history. However, the warehouse system shows fulfillment picking has already started.

Analyze this consistency failure.

Your answer should include:

- Why AI can sound consistent while using inconsistent evidence
- Which sources are authoritative
- Which sources are explanatory but not admissible for action
- How an admissible evidence gate should work
- What the assistant should say when evidence conflicts
- When to defer, escalate, or route to deterministic review
- What replay evidence should be captured

---

# Bonus GitHub Exercises

## Bonus Exercise 6: DreamFinance Balance Semantics

A customer sees a balance, transfers money, and later discovers that pending holds and settlement delays changed the available amount.

Design a consistency model for balance display and money movement.

Your answer should include:

- Ledger balance
- Available balance
- Pending authorizations
- Holds
- Settlement timing
- Reconciliation
- What the user is allowed to do based on each balance type
- What semantics the UI/API must expose
- What audit or replay evidence is required

## Bonus Exercise 7: DreamHealthcare Readiness Gate

A lab result is technically correct but still marked preliminary. A downstream workflow treats it as final and triggers a clinical action.

Design a readiness gate.

Your answer should include:

- Why correct value is not the same as action-ready value
- Required status, version, timing, and permission checks
- Which actions preliminary results may support
- Which actions must be blocked
- How exceptions should be approved and recorded
- What evidence snapshot should be preserved

## Bonus Exercise 8: Language as State

A product manager wants to simplify the UI by replacing “held,” “reserved,” “pending,” and “ticketed” with one word: “confirmed.”

Explain why this is dangerous.

Your answer should include:

- Why language is architecture
- What each state should mean
- What evidence is required for each state
- How misleading language creates business liability
- How APIs and UIs should carry semantic state
- What compensation path is needed when state transitions fail

## Bonus Exercise 9: Consistency Design Review Table

Create a consistency design-review table for one capability, such as DreamMart checkout, DreamFinance balance, DreamHealthcare lab results, or DreamTravel booking.

Your table should include:

- Domain
- What the user believes
- System of record
- Allowed drift
- Actionability rule
- Compensation or proof

Then explain how the table exposes weak assumptions before production failure.

## Bonus Exercise 10: Senior Architect Consistency Defense

An interviewer says:

“Eventual consistency is fine. We just need the system to be available and fast.”

Defend a more precise consistency strategy.

Your answer should include:

- Why consistency is a trust contract
- Why users experience promises, not replication models
- Where eventual consistency is safe
- Where defensible consistency is required
- How to separate fast views from authoritative actions
- How to label provisional versus committed truth
- How AI should handle inadmissible or conflicting evidence
- What replay evidence proves the system was allowed to act
- One consistency boundary you would defend strongly in production
