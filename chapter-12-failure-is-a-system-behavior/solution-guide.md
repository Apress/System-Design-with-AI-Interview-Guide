# Chapter 12 Solution Guide

## Exercise 1 Solution: Failure as a Path

A strong answer should explain that this is not a single outage because no one component necessarily failed. The system stayed available, but the capability stopped behaving responsibly.

The failure path begins when inventory truth becomes uncertain. Inventory checks are delayed, cached availability becomes stale, and the system continues accepting orders as if inventory were authoritative. Customers interpret confirmation as a business promise. If orders are later canceled, the failure is not just stale data. It is a broken commitment.

The path looks like this:

1. Promotion increases demand.
2. Inventory checks slow down.
3. Cached availability remains visible.
4. Customers submit orders.
5. Some customers retry or refresh.
6. Duplicate attempts increase backend work.
7. Orders are accepted without defensible inventory evidence.
8. Reconciliation later discovers mismatch.
9. Orders are canceled, credited, or manually remediated.

The system staying “up” is not enough. A healthy capability should know when it no longer has enough evidence to commit.

A better design would use:

- **Pending Verification** when authoritative inventory is delayed
- **Inventory reservation token** before order confirmation
- **Idempotency key** to prevent duplicate orders from repeated clicks
- **Bounded retries** for inventory calls
- **Backpressure** when inventory verification queues grow
- **Clear user state** such as “checking availability” or “pending confirmation”
- **Support-visible evidence** so recovery does not depend on memory

Replay evidence should include:

- Correlation ID
- Customer/session/cart ID
- Product/SKU
- Inventory source used
- Cache version and timestamp
- Reservation attempt
- Payment authorization status
- User-visible state
- Retry count
- Final order outcome
- Remediation link

The senior answer: failure began before cancellation. It began when the system kept committing after it stopped knowing.

---

## Exercise 2 Solution: Blast Radius

The first design has the smaller blast radius: moving one uncertain order into **Pending Verification** until authoritative evidence arrives.

Blast radius is an architectural decision because the system chooses whether uncertainty stays local or spreads. If one order is pending, one customer waits with honest state. If the platform keeps confirming based on projected inventory, thousands of customers may receive promises the business cannot honor.

Reservation semantics reduce harm by separating possible inventory from committed inventory:

- **Available**: discovery hint
- **Held**: short-lived attempt to reserve
- **Reserved**: authoritative inventory secured for checkout
- **Confirmed**: inventory plus payment plus order state committed

Idempotency prevents repeated customer actions from creating duplicate commitments. Bounded retries prevent the system from hammering inventory, ERP, manufacturer, or supplier systems when they are already slow.

“Reconcile later” becomes global harm when:

- Many orders are confirmed from projections
- Reversals become mass cancellations
- Support queues spike
- Refunds/credits become manual work
- Customer trust is damaged
- Finance and operations inherit the cleanup

Use states intentionally:

- **Pending** when evidence may arrive soon
- **Deferred** when action is accepted but not yet eligible
- **Escalated** when human or specialist judgment is required
- **Hard stop** when safety, authorization, inventory, or payment evidence is insufficient

Evidence and ownership required:

- Inventory snapshot
- Reservation token
- Supplier/ERP response
- Policy version
- Correlation ID
- Order owner
- Recovery owner
- Customer communication record
- Re-entry criteria for normal automation

The senior answer: containment is not a recovery tactic. It is a design choice made before the spike.

---

## Exercise 3 Solution: Latency-Consistency Failure Loop

A strong answer should show that latency creates uncertainty, and uncertainty becomes a consistency problem when the system still forces a final decision.

In DreamFinance, the workflow depends on fraud signals and enrichment jobs. When those are delayed, the system no longer has complete evidence. If it still forces approve or deny, it may approve against incomplete data or deny a valid customer unfairly.

The loop:

1. Fraud signal is delayed.
2. Enrichment job lags.
3. Decision engine lacks complete evidence.
4. Workflow still demands approve/deny.
5. Approval is granted or denied based on stale or partial truth.
6. Late evidence arrives and contradicts the decision.
7. Reversal, dispute, compliance review, or manual remediation follows.

The better architecture introduces a third outcome:

- **Pending**
- **Deferred**
- **Under Review**

These states are not weakness. They are truthful system behavior when correctness and timeliness cannot both be satisfied.

Controls:

- Retry budget for delayed signals
- Timeout policy for enrichment
- Idempotency key for approval requests
- Data freshness check
- Policy-version binding
- Confidence threshold
- Human review route
- Clear customer/operator message
- Replay evidence

Captured evidence should include:

- Applicant/account ID
- Decision timestamp
- Data versions used
- Fraud signal status and timestamp
- Enrichment job version
- Policy/risk version
- Missing evidence list
- Decision mode: approved, denied, pending, deferred, under review
- Human approval if applicable
- Final outcome

The senior answer: when evidence is delayed, forcing binary decisions is a failure behavior. Pending is the architecture choosing honesty.

---

## Exercise 4 Solution: AI Confident Wrongness

A strong answer should explain that AI failure often looks successful because the model returns a fluent answer instead of stopping with an error.

In this case, the support article says modifications are usually allowed. That is explanatory evidence. It can help explain policy, but it is not authoritative for the current order. Prior conversation is also not authoritative. The warehouse system is authoritative for fulfillment status.

Authoritative evidence:

- Order system
- Warehouse management system
- Fulfillment status
- Carrier handoff status
- Active order-modification policy
- Payment/settlement state
- Jurisdiction or fraud rules, if relevant

Explanatory but not admissible for action:

- Support articles
- FAQs
- Prior chats
- Customer statements
- Model memory
- General policy summaries

The admissible-evidence gate should check:

- Source authority
- Freshness
- Version pinning
- Customer authorization
- Conflict detection
- Sensitive-data redaction
- Required evidence for action

Because the warehouse says fulfillment has started, the assistant should not say the order can be changed. It should respond with bounded honesty:

> This order may no longer be eligible for automatic modification because fulfillment appears to have started. I can escalate the request or check whether an approved exception path is available.

When evidence conflicts:

- Do not average the sources.
- Do not let the model decide based on language confidence.
- Defer to authoritative system state.
- Escalate if policy allows exceptions.
- Hard-stop if fulfillment/carrier handoff makes modification invalid.

Replay evidence:

- User request
- Retrieved sources
- Source authority labels
- Warehouse status
- Policy version
- Tool calls
- Model output
- Decision mode
- Escalation or refusal reason
- Correlation ID

The senior answer: the AI did not fail by crashing. It failed by continuing confidently with inadmissible evidence.

---

## Exercise 5 Solution: Degradation Ladder

A strong answer should define failure states before production pressure forces improvisation.

Example capability: DreamMart order modification.

| Failure State | What It Means | System Behavior | User/Operator View | Evidence |
|---|---|---|---|---|
| Normal | Evidence sufficient and dependencies healthy | Modify order if within rules | “Order modified” only after proof | Standard trace, policy version, order state |
| Degraded | Non-critical dependencies slow or partial | Reduce autonomy, allow low-risk changes only | “Some options may be limited” | Dependency health, tool status |
| Pending | Commitment cannot be defended yet | Hold action, prevent duplicate modification | “Modification pending verification” | Request snapshot, idempotency key, current state |
| Escalated | Human/specialist decision required | Route with evidence and reason code | “Support is reviewing this request” | Evidence package, owner, SLA |
| Hard Stop | Safety, policy, authorization, or evidence insufficient | Refuse action and block automation | “This order can no longer be modified automatically” | Refusal reason, policy, system state |
| Recovery | Trust must be restored | Reconcile, explain, compensate, prevent recurrence | “Resolution completed” | Remediation record, replay link |

What the system must refuse:

- Modification after carrier handoff
- Modification without authoritative order state
- Modification when payment settlement prevents safe change
- AI-generated commitment without evidence
- Duplicate modification from repeated clicks

Who owns re-entry:

- Capability owner
- Support/escalation owner
- Platform/reliability owner if dependency health caused degradation
- Governance owner for high-risk automation

Re-entry criteria:

- Replay evidence complete
- Dependency health restored
- Policy version consistent
- Dispute/reversal rate back below threshold
- Tool failures within budget

The senior answer: degradation is not collapse. It is the system preserving trust while reducing power.

---

## Bonus Exercise 6 Solution: Escalation as an Architectural Contract

“Open a ticket for support” is incomplete because it does not define authority, evidence, urgency, ownership, or what the system must stop doing while humans decide.

A real escalation contract defines:

| Contract Element | Design Answer |
|---|---|
| Trigger | Missing evidence, conflicting evidence, high-risk action, policy exception, dependency timeout |
| Owner | Named capability owner or specialist team |
| Authority | Approve, deny, defer, override, compensate, hard-stop |
| Evidence package | Correlation ID, state snapshot, policy version, tool traces, reason code |
| SLA | Expected review time based on risk |
| User state | Pending, under review, or blocked |
| System refusal | No automatic commit while escalation is open |
| Replay | Escalation decision and outcome stored with replay link |

For DreamMart order modification, escalation should include:

- Order state
- Fulfillment status
- Cutoff time
- Payment status
- Policy version
- Customer request
- Tool calls attempted
- Conflict reason
- Owner
- SLA
- Allowed actions

Escalation is not a ticket. It is the capability’s designed behavior when it cannot keep its promise safely.

---

## Bonus Exercise 7 Solution: Stop Conditions Contract

Example: AI-enabled order modification.

A strong Stop Conditions Contract should include:

### Retries stop when

- Tool timeout budget is exceeded
- Partner API fails above threshold
- Same request has already been submitted with same idempotency key
- Queue age exceeds commitment budget

### Automation narrows scope when

- Fulfillment status is delayed
- Fraud posture changes
- Payment settlement state is uncertain
- Policy source is stale
- Replay coverage is incomplete

### Move to pending when

- Required evidence may arrive soon
- Partner acknowledgment is delayed
- Inventory or warehouse status is not authoritative yet
- Human review is not immediately required but commitment is unsafe

### Human approval required when

- High-value order
- Jurisdiction exception
- Fraud-sensitive change
- Address change after fulfillment progress
- Customer dispute history exists
- AI confidence is low or evidence conflicts

### Hard stop when

- Carrier handoff confirmed
- Safety/authorization/evidence insufficient
- Customer is not authorized
- Policy explicitly forbids modification
- Replay card cannot be created for high-risk action

### Evidence preserved

- Correlation ID
- Idempotency key
- Customer/order state
- Evidence sources
- Policy version
- Tool calls
- Reason code
- User-visible state
- Final decision
- Reversal/remediation link

### Re-entry owner

- Capability owner
- Product owner for customer-facing behavior
- Reliability owner for dependency health
- Governance owner for automation policy

Automation resumes only when thresholds recover, replay coverage is restored, policy/tool versions are valid, and the owner approves re-entry.

---

## Bonus Exercise 8 Solution: Failure-as-Behavior Design Review Table

Example: DreamMart order modification.

| Signal Under Stress | Observed System Behavior | Hidden Assumption | Business / Human Harm | Architectural Fix |
|---|---|---|---|---|
| Inventory lag between ERP and warehouse | Order modification accepted, later reversed | Inventory will converge fast enough | Customer acts on revoked promise | Use authoritative inventory at commit; pending until verified |
| Partner acknowledgment delay | Modification shown as complete before partner confirms | Partner SLA equals commitment | Customer believes change is done | No committed state without partner ack |
| Fulfillment cutoff uncertainty | System allows change after picking starts | Cutoff can be checked later | Shipment errors, cancellations | Hard stop after cutoff; escalation for exceptions |
| Retry storm during tool delay | Duplicate modification attempts | Retries are harmless | Duplicate work, inconsistent state | Idempotency, retry budget, single-flight |
| AI conflicting evidence | Assistant says change is allowed | Model will hedge | False authority, disputes | Admissible evidence gate; conflict means defer/escalate |
| Green dashboards, rising disputes | System remains up but users harmed | Uptime equals health | Executive surprise, reputation damage | Add trust SLOs: reversals, disputes, pending duration |
| Missing replay evidence | Postmortem becomes debate | We can reconstruct later | Accountability collapse | Require replay card before high-risk commit |

The table exposes weak assumptions because it forces the team to name the signal, the behavior, the assumption, the harm, and the fix. “Monitor better” is not enough. The architectural fix must change what the system does.

---

## Bonus Exercise 9 Solution: Success-Only Design

A success-only design looks mature until uncertainty arrives. It has services, queues, caches, dashboards, and alerts, but it does not define what the system does when it cannot safely continue.

What breaks later:

### Operations becomes the architecture

If pending states, escalation contracts, and hard stops are missing, humans invent the failure path during incidents. Manual overrides become normal.

### Retries amplify harm

Without retry budgets and idempotency, a slow dependency becomes duplicate work, duplicate writes, duplicate payments, duplicate approvals, or repeated tool calls.

### The system bluffs

If evidence is thin and no deferred state exists, the system commits and later reverses. That creates customer harm and support load.

### AI makes improvisation sound intentional

AI agents can produce fluent explanations while crossing boundaries. A temporary bypass becomes a policy. A one-off exception becomes a default.

### Monitoring arrives too late

Dashboards may show uptime while users experience broken promises. Alerts identify symptoms, not necessarily the pressure path.

Missing artifacts to add:

- Failure-state ladder
- Pending/deferred/review-required states
- Stop Conditions Contract
- Escalation Contract
- Authority boundary
- Refusal lines
- Retry/idempotency strategy
- Trust-based SLOs
- Decision Replay Card

The senior answer: success-only design outsources failure behavior to tired humans during the worst possible moment.

---

## Bonus Exercise 10 Solution: Senior Architect Failure Defense

A mature answer should acknowledge that retries, circuit breakers, fallbacks, and alerts are useful but incomplete.

Failure is behavior, not an event. The question is not only whether a component failed. The question is what the system continues to do after uncertainty enters.

A senior failure strategy includes:

### Trace uncertainty through the journey

Identify where uncertainty enters: latency, stale reads, partial writes, partner lag, missing evidence, human override, AI conflicting evidence.

### Design blast radius

Keep uncertainty local with pending states, reservation semantics, idempotency, bounded retries, scoped automation, and hard stops.

### Separate safe retries from dangerous retries

Retries are safe for idempotent reads or bounded operations. They are dangerous for payments, commits, refunds, tool actions, and anything that changes state unless idempotency and replay exist.

### Define failure states

- Normal
- Degraded
- Pending
- Escalated
- Hard stop
- Recovery

### Treat AI failure differently

AI may continue with confidence. Use admissible evidence gates, confidence thresholds, tool budgets, authority envelopes, and human approval for high-consequence action.

### Make escalation a contract

Escalation needs owner, authority, reason code, evidence, SLA, user-visible state, and replay link.

### Prove behavior

Capture decision replay: correlation ID, state snapshot, policy version, evidence sources, tool trace, decision mode, approval, outcome, and remediation.

One failure boundary to defend strongly:

> No high-risk commitment should proceed when required evidence is missing, stale, conflicting, unauthorized, or not replayable.

The senior line:

> I do not treat failure as a single outage. I trace where uncertainty enters the journey, how it propagates through retries, stale reads, queues, partial writes, human overrides, and AI outputs. Then I define whether the system proceeds, degrades, moves to pending, escalates, or hard-stops, and I preserve replay evidence for every high-risk decision.
