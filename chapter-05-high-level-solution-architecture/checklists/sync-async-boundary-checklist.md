# Synchronous / Asynchronous Boundary Checklist

Keep synchronous when:

- The customer cannot receive a valid response without it
- The action affects a customer-visible commitment
- The result must be known before confirmation
- Strong consistency is required
- The failure must be shown immediately

Move asynchronous when:

- Work can happen after confirmation
- Work is operational or analytical
- The user does not need immediate completion
- Retries are acceptable
- Eventual consistency is acceptable
- Fan-out would slow the critical path

Always define:

- Timeout
- Retry limit
- Idempotency key
- User-visible state
- Dead-letter handling
- Replay mechanism
