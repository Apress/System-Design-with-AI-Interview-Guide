# Messaging 7-Step Method Map

| Step | Messaging Application | Notes |
|---|---|---|
| Clarify | Facts, work, commands, events, side effects, or all? |  |
| Actors | Producer, broker, consumer, schema owner, DLQ owner, replay operator, side-effect owner. |  |
| Journey | Intent → outbox → broker → consumer → idempotency → side effect → receipt. |  |
| Constraints | Duplicate delivery, retry, reordering, schema drift, poison messages, unsafe replay. |  |
| Commitments | eventId, businessTxnId, effectId, idempotency record, replay card. |  |
| Architecture | Outbox, stream, queue, consumer, idempotency store, DLQ, replay, stop authority. |  |
| Trade-offs | Stream vs queue, local vs global order, retry vs recursion, replay vs re-execution. |  |
