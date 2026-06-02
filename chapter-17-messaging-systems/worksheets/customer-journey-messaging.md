# Customer Journey: Messaging

| Moment | Business Believes | Risk | Response |
|---|---|---|---|
| User acts | Intent started. | Lost intent. | Outbox. |
| Event published | Work moves. | No durable intent. | Outbox relay. |
| Consumer receives | Side effect possible. | Duplicate/stale. | effectId idempotency. |
| Side effect executes | Reality changed. | Duplicate/unsafe execution. | processed_effects. |
| DLQ | Unsafe work stopped. | Replay bomb. | simulate/execute modes. |
| Audit | Must prove. | Logs insufficient. | Replay card. |
