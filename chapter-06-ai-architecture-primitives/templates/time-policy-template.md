# Time Policy Template

## Capability

Capability name:
Decision being made:

## Relevant Clocks

| Clock | Definition | Source |
|---|---|---|
| Event Time | When the original event happened |  |
| Ingestion Time | When the system received the event |  |
| Decision Time | When the system made the decision |  |
| Partner Time | External system timestamp |  |

## Governing Clock

Which clock governs automation?
Which clock governs fairness review?
Which clock governs audit?

## Cutoff Rule

Policy:
Cutoff time:
Timezone:
Weekend/holiday behavior:
Late-arrival behavior:

## Clock Disagreement

If event time and decision time disagree:
If partner time is missing:
If timezone is unknown:
If ingestion is delayed:

## Logging and Replay

Record event time?
Record ingestion time?
Record decision time?
Record policy version?
Record timezone?
