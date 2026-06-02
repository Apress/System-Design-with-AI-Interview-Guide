# Consistency: Messaging

| Boundary | Rule | Artifact |
|---|---|---|
| Intent | Durable only after commit. | Outbox row |
| Delivery | Delivered != applied. | eventId |
| Business story | One outcome chain. | businessTxnId |
| Side effect | Reality changes once. | effectId |
| Idempotency | Must be durable. | processed_effects |
| Replay | Controlled re-execution. | Replay mode |
