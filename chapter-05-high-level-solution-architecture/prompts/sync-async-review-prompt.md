# Synchronous / Asynchronous Review Prompt

Review my architecture and identify which operations should be synchronous and which should be asynchronous.

For each operation, classify it as:

- Must be synchronous
- Should be asynchronous
- Can be eventually consistent
- Requires compensation
- Requires human escalation

Also identify:
- Critical path
- Timeout risks
- Retry risks
- Idempotency needs
- User-visible state
- Events to emit
- Dead-letter and replay requirements
