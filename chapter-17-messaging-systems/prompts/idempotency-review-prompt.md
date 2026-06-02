# Idempotency Review Prompt

Review my idempotency strategy.

Check:

- eventId vs effectId dedupe
- durable processed_effects table
- Redis/cache limitations
- IN_PROGRESS/COMMITTED/FAILED/NO_OP/UNKNOWN states
- provider timeout behavior
- retention policy
- replay behavior

Then identify duplicate side-effect risk.
