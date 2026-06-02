# Chapter 12 Exercises

## Exercise 1: Failure as a Path

DreamMart remains technically available during a promotion, but inventory checks are delayed, cached availability is stale, customers keep submitting orders, and some orders are later canceled.

Explain why this is a failure path, not a single outage event.

Your answer should include:

- Where uncertainty entered the journey
- How latency and stale data changed behavior
- How retries and repeated user actions amplified the failure
- Why the system staying “up” did not mean the capability was healthy
- Which commitment point was violated
- What state the system should have used instead of continuing to commit
- What evidence should be preserved for replay

## Exercise 2: Blast Radius

DreamMart can respond to uncertain inventory in two ways:

1. Move one order into **Pending Verification** until authoritative evidence arrives
2. Keep accepting confirmed orders based on projected inventory and reconcile later

Which design has the smaller blast radius?

Your answer should include:

- Why blast radius is an architectural decision
- How reservation semantics reduce harm
- How idempotency and bounded retries limit duplicate work
- Why “reconcile later” can become global harm
- When to use pending, deferred, escalated, or hard-stop states
- What evidence and ownership are required for recovery

## Exercise 3: Latency-Consistency Failure Loop

In DreamFinance, a fraud signal is delayed, an enrichment job lags, and the approval workflow still forces a binary approve-or-deny decision.

Analyze the failure loop.

Your answer should include:

- How latency creates uncertainty
- How uncertainty creates inconsistent decisions
- Why forcing a binary decision can be dangerous
- Why **Pending**, **Deferred**, or **Under Review** should be first-class outcomes
- How retry budgets, idempotency, and clear commit messages break the loop
- What data version, policy version, and evidence snapshot must be captured

## Exercise 4: AI Confident Wrongness

DreamMart’s AI assistant receives conflicting evidence about whether an order can be modified. The support article says modification is usually allowed, but the warehouse system shows fulfillment has already started. The assistant still replies confidently that the order can be changed.

Analyze this AI failure.

Your answer should include:

- Why AI failure often continues with confidence instead of stopping loudly
- Which evidence is authoritative
- Why support articles and prior conversations may be explanatory but not admissible for action
- How an admissible-evidence gate should work
- What the assistant should do when evidence conflicts
- When to defer, escalate, or hard-stop
- What replay evidence is required

## Exercise 5: Degradation Ladder

Design a failure-state ladder for a high-risk capability such as order modification, financial approval, clinical decision support, or digital-twin automation.

Your answer should include:

- Normal state
- Degraded state
- Pending state
- Escalated state
- Hard-stop state
- Recovery state

For each state, explain:

- What it means
- What the system is allowed to do
- What the system must refuse
- What the user or operator sees
- What evidence is preserved
- Who owns re-entry to normal operation

---

# Bonus GitHub Exercises

## Bonus Exercise 6: Escalation as an Architectural Contract

A team says, “If the system cannot decide, we will open a ticket for support.”

Why is this incomplete?

Design an escalation contract.

Your answer should include:

- Who owns the outcome
- What authority the owner has
- What evidence must be attached
- What reason code is used
- What SLA or service expectation applies
- What the system refuses to do while escalation is pending
- How the escalation decision is replayed later

## Bonus Exercise 7: Stop Conditions Contract

Create a Stop Conditions Contract for an AI-enabled refund approval or order modification capability.

Your answer should include:

- When retries stop
- When automation narrows scope
- When the system moves to pending
- When human approval is required
- When the system hard-stops
- What evidence is preserved
- Who owns re-entry to normal operation
- What criteria must be met before automation resumes

## Bonus Exercise 8: Failure-as-Behavior Design Review Table

Create a failure-as-behavior design-review table for one capability, such as DreamMart inventory/order modification, DreamManufacturing digital twin, or DreamFinance approval workflow.

Your table should include:

- Signal under stress
- Observed system behavior
- Hidden assumption
- Business or human harm
- Architectural fix

Then explain how the table exposes weak assumptions before they become incidents.

## Bonus Exercise 9: Success-Only Design

A team has designed the happy path beautifully: services, queues, caches, dashboards, and alerts. But they have not defined pending states, hard stops, escalation ownership, or replay artifacts.

What breaks later?

Your answer should include:

- How success-only design outsources architecture to operations
- How manual overrides become default behavior
- How retries become amplification
- How AI makes improvisation sound intentional
- Why monitoring alone is not enough
- What failure states, refusal lines, and replay artifacts must be added

## Bonus Exercise 10: Senior Architect Failure Defense

An interviewer says:

“Failure handling is straightforward: add retries, circuit breakers, fallbacks, and alerts.”

Defend a more mature failure strategy.

Your answer should include:

- Why failure is behavior, not an event
- How to trace uncertainty through the journey
- Why blast radius must be designed
- Where retries are safe versus dangerous
- How pending, degraded, escalated, and hard-stop states protect trust
- How AI changes the failure shape
- Why escalation must be a contract
- What evidence proves the system acted responsibly under pressure
- One failure boundary you would defend strongly in production
