# ROCS Design Review Template

## Capability

Capability name:
Business outcome:
Primary users:
Risk level:

## Promise at Commitment

What does the system promise when it commits?

## ROCS Review

| ROCS Dimension | Design Question | Answer |
|---|---|---|
| Reliability | Which promise must still hold under uncertainty? |  |
| Observability | Can we prove why the system acted? |  |
| Cost | What behavior multiplies under volume? |  |
| Sustainability | Can the system stay governable as models, teams, policies, and regions change? |  |

## Drift Analysis

What can drift?

- Policy:
- Model:
- Data:
- Retrieval:
- Tool behavior:
- External dependency:
- Team ownership:
- Regional requirement:

## Signals

Which signals show the promise is under pressure?

- 
- 
- 

## Containment Decision

What happens when signals cross threshold?

- Defer:
- Degrade:
- Throttle:
- Hard stop:
- Roll back:
- Escalate:

## Evidence Required

What evidence must exist?

- Correlation ID:
- Policy version:
- Evidence snapshot:
- Tool calls:
- Decision owner:
- Replay record:

## Owner

Decision owner:
Backup owner:
Re-enable criteria:
