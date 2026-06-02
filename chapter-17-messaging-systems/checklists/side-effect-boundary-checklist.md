# Side-Effect Boundary Checklist

Before executing a side effect, verify:

- Deterministic effectId
- Idempotency check
- Schema version
- Policy version
- Evidence snapshot
- Retry budget remaining
- Ordering check, if required
- External state not ambiguous
- Replay card can be emitted
