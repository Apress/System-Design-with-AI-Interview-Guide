# Hold-to-Commit Flow Template

## Request

rideRequestId:
correlationId:
riderId:
regionId:

## Candidate Search

Candidate cap:
GPS freshness filter:
Eligibility rules:

## Hold

matchHoldId:
candidateDriverId:
holdTtl:
createdAt:
expiresAt:

## Commit Gates

| Gate | Pass / Fail | Evidence |
|---|---|---|
| Driver acceptance |  |  |
| GPS freshness |  |  |
| ETA freshness |  |  |
| Pricing policy |  |  |
| Fairness guardrail |  |  |
| Safety/fraud |  |  |
| Conflict check |  |  |

## Outcome

Committed matchId:
Deferred:
Refused:
Escalated:

## Replay Link

Decision replay card:
