# Messaging Readiness Checklist

Before launching a messaging capability, confirm:

- Producer intent is durably recorded
- eventId, businessTxnId, and effectId are separate
- Side-effect boundary is explicit
- Durable idempotency exists for irreversible effects
- Retry count/time budgets exist
- DLQ has owner and replay modes
- Replay execute requires approval
- Ordering scope is business-keyed
- Schema compatibility policy exists
- Stop authority can freeze risky side effects
- Replay cards are emitted
