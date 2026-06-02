# ROCS Cost Budget Template

## Capability

Capability name:
Traffic profile:
Peak scenario:

## Budget Table

| Surface | Budget | Why It Exists | When Exceeded | Owner |
|---|---|---|---|---|
| Retries | <= N attempts or <= T seconds | Prevent retry storms | Defer + escalate | Reliability owner |
| Tool calls | <= N per request | Cap probabilistic authority and cost | Hard stop + human review | Capability owner |
| Retrieval fan-out | <= K sources / documents | Avoid multiple truths and cost blowups | Admissibility filter + conflict route | Data/RAG owner |
| Latency at commit | p99 <= target | Protect trust at commitment | Switch to pending | Product + platform |
| Evidence coverage | 100% for high-risk actions | Enable auditability | Block high-risk actions | Governance owner |
| Token budget | Max prompt + completion | Stop prompt expansion | Compress, tier model, or defer | AI platform owner |

## Cost Multipliers

- Token drift:
- Retrieval fan-out:
- Agent loops:
- Retry cascades:
- Tool-call bursts:
- GPU queue buildup:
- Manual cleanup:

## Cost Response

Compress:
Tier model:
Cache:
Defer:
Escalate:
Stop:
