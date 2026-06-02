# Live-Defense Runtime Template

## Capability

Capability name:
Runtime owner:
Risk tier:

## Runtime Controls

| Control | Watches | Response |
|---|---|---|
| AI firewall | Prompt injection, jailbreak, leakage, unsafe output | Allow / Block / Redact / Escalate / Rephrase |
| Semantic anomaly detection | Strange topics, repeated attacks, long prompts | Alert / Throttle / Step down autonomy |
| AI observability | Prompt, model, RAG docs, tools, safety metrics | Replay / Rollback / Update guardrails |
| SIEM/SOC integration | Cross-system security signals | Incident playbook / Forensic review |
| Kill switch | Rogue behavior, excessive autonomy | Pause capability / Capture session |

## Signals

- Guardrail hit rate
- Blocked-action count
- Escalation rate
- Reversal count
- Disagreement with system of record
- Evidence-snapshot gaps
- Policy-version drift
- Retrieval anomaly rate
- Tool failure rate
- Cost per successful action

## Response Plan

Block when:
Redact when:
Escalate when:
Rephrase when:
Throttle when:
Kill switch when:
