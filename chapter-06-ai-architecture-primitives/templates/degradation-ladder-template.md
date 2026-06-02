# Degradation Ladder Template

## Capability

Capability name:
Normal behavior:

## Degradation Signals

- Missing evidence
- Low confidence
- Tool timeout
- Policy stale
- External dependency slow
- Replay coverage gap
- Dispute rate increase
- Cost or latency budget exceeded

## Ladder

| Level | Mode | System Behavior | Customer Message | Evidence Required |
|---|---|---|---|---|
| 0 | Normal | Automated action allowed |  |  |
| 1 | Degraded | Assistive recommendation only |  |  |
| 2 | Safe Default | Conservative default or limited action |  |  |
| 3 | Pending Review | Human review required |  |  |
| 4 | Hard Stop | No action allowed |  |  |

## Refusal Lines

The system must refuse when:

- 
- 
- 

## Escalation

Escalate to:
Evidence package:
SLA:
