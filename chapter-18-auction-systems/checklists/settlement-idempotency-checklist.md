# Settlement Idempotency Checklist

Settlement requires:

- Valid closeCommitId
- settlementIntentId
- deterministic settlementEffectId
- idempotency key
- provider trace ID
- effect status
- retry budget
- no-op behavior on duplicate
- pause/reconcile on unknown provider state
