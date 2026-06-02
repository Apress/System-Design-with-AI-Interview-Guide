# ARCHVIEW: Messaging

| Concern | View |
|---|---|
| Actors | Producer, broker, consumer, side-effect system, DLQ owner, replay operator. |
| Responsibilities | Intent, delivery, consumption, idempotency, effect, DLQ, replay. |
| Controls | effectId, idempotency store, retry budgets, ordering scope, replay mode, stop authority. |
| Commitment Points | Outbox, broker publish, consumer decision, side-effect execution, receipt. |
| Evidence | eventId, businessTxnId, effectId, schema, policy, evidence, calls. |
| Degradation | Retry, DLQ, quarantine, simulate-only, freeze. |
