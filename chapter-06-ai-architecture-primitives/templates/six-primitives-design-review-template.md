# Six-Primitives Design Review Template

## Capability

Capability name:
Business outcome:
Primary users:
Risk level:

## 1. Authority

Who is allowed to act?
Which role is represented?
What actions are allowed?
What actions are forbidden?
What tool allowlist applies?

## 2. Commitment

When does output become consequence?
Which states are provisional?
Which states are committed?
What proof is required before commitment?

## 3. Time

Which clocks exist?
- Event time:
- Ingestion time:
- Decision time:

Which clock governs the decision?
Where is the rule written?

## 4. Degradation

What happens when certainty drops?
What moves from automated to assistive?
What moves to pending review?
What must hard stop?

## 5. Evidence and Replay

What evidence must be captured?
What policy and guardrail versions must be recorded?
What tool calls must be logged?
What commit token proves the outcome?

## 6. Ownership

Who owns the capability?
Who can pause, degrade, or stop automation?
What thresholds trigger action?
What are the re-enable criteria?

## Final Review

Most dangerous hidden authority:
Most important commitment point:
Most important refusal line:
Most important replay requirement:
