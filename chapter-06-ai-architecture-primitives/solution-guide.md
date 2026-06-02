# Chapter 6 Solution Guide

## Exercise 1 Solution: Six-Primitives Warm-Up

A strong answer should define:

- Authority: the assistant acts only within the represented user or support role.
- Commitment: the system distinguishes suggestion, pending action, and committed outcome.
- Time: cutoff, eligibility, and policy decisions use declared clocks.
- Degradation: low confidence or missing evidence reduces system power.
- Evidence/Replay: every high-risk action has a replayable decision record.
- Ownership: a named capability owner can pause, degrade, or stop automation.

## Exercise 2 Solution: Authority Boundary

A strong answer should prevent the AI agent from becoming a superuser.

The agent should:

- Operate under a represented role, such as Support Rep.
- Use a bounded execution identity.
- Read only authorized customer, order, policy, and support data.
- Suggest high-risk actions instead of directly committing them.
- Invoke only allowlisted tools.
- Require evidence gates before state-changing actions.
- Record who or what acted in the audit trail.

## Exercise 3 Solution: Commitment Point

A strong answer should distinguish provisional truth from committed truth.

The system should not say “modified” until:

- ERP acknowledgment exists.
- Warehouse label invalidation is confirmed when needed.
- Carrier handoff has not already occurred.
- Policy version and cutoff rules are known.
- The modification has a durable commit token.

Before that, the customer-visible state should be “pending modification” or “under review.”

## Exercise 4 Solution: Time Policy

A strong answer should define:

- Event time: when the customer or system event originally occurred.
- Ingestion time: when the workflow received the event.
- Decision time: when the system made or attempted the decision.

For automation, decision time may govern operational safety. Event time should be preserved for fairness review and dispute handling. The rule must be written into the architecture, not left to service-level interpretation.

## Exercise 5 Solution: Degradation and Refusal Lines

A strong answer should reduce system power as certainty drops.

Possible degradation ladder:

1. Normal automated approval for low-risk, fully evidenced cases.
2. Assistive recommendation when some non-critical context is missing.
3. Pending review when policy, payment, or customer history is incomplete.
4. Hard stop for high-value refunds, stale policy, disputed accounts, or payment uncertainty.

The system should prefer safe refusal or pending review over confident unsupported action.

## Exercise 6 Solution: Decision Replay Card

A minimum replay card should include:

- Correlation ID
- Capability name
- Decision and mode
- Acting principal and represented role
- Authority envelope version
- Policy and guardrail versions
- Evidence sources
- Tool calls
- Commit token
- Customer-visible outcome
- Reversal or remediation link

Logs and transcripts alone are not enough because they may show what happened without proving why the system was allowed to act.

## Exercise 7 Solution: Ownership and Stop Authority

A strong Stop Authority SOP should define:

- Named capability owner
- Signals monitored
- Numeric thresholds
- Scoped response actions
- Blast-radius controls
- Re-enable criteria

Example response:

- Replay coverage below 100% for high-risk actions: hard stop automation.
- ERP failures above budget: degrade to pending review.
- Disputes above threshold: switch from automated mode to assistive mode for affected region or cohort.

## Exercise 8 Solution: Senior Architect Design Review

A strong review should ask:

- What role envelope does the agent operate under?
- What exact proof is required before saying “modified”?
- Which clock governs fulfillment cutoff?
- What happens when ERP, WMS, or carrier systems are slow?
- What replay card proves the decision?
- Who can stop the behavior if disputes spike?

The strongest decision to defend is usually: no high-risk AI-involved commitment without authority envelope, evidence gate, replay card, and stop authority.
