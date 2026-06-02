# LLM-SHIELD Design Review Template

## Capability

Capability name:
Business outcome:
Primary users:
Risk level:

## 1. Scope

What must never happen?
What guarantees must hold?
What attack surfaces exist?
What evidence is admissible?
Where is human review mandatory?

## 2. Harden

Which prompts are versioned?
Which policies are versioned?
Which guardrails are tested?
Which golden conversations exist?
What rollback path exists?

## 3. Isolate

What data can be retrieved?
What data is forbidden?
What memory is allowed?
What tools are allowed?
What trust zones exist?

## 4. Empower

Autonomy level:
Allowed actions:
Actions requiring approval:
Actions forbidden:
Confidence gates:
Rate limits:
Rollback path:

## 5. Live-Defend

Runtime policies:
AI firewall checks:
Anomaly signals:
Replay coverage:
Kill switch:
SIEM/SOC integration:

## 6. Demonstrate

Security scorecard:
Red-team/blue-team cadence:
Threat coverage:
Governance evidence:
Improvement evidence:

## Final Review

Most dangerous attack path:
Most important isolation boundary:
Most important autonomy control:
Most important runtime signal:
Most important evidence artifact:
