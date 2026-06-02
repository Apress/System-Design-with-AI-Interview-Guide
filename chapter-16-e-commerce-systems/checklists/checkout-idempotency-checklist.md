# Checkout Idempotency Checklist

Check:

- Idempotency key tied to checkout intent
- Cart snapshot included
- Payment attempt scoped
- Duplicate clicks return same state
- Retries do not create duplicate orders
- Payment ambiguity moves to pending/reconcile
- Replay captures retry count
