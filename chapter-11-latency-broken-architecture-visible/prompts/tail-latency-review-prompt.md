# Tail Latency Review Prompt

Review my system design for tail-latency behavior loops.

Look for:

- User doubt
- Refreshes
- Duplicate submissions
- Retry amplification
- Queue growth
- Repeated tool calls
- Support escalation

Then propose controls:
- Idempotency
- Bounded retries
- Rate limits
- Backpressure
- Priority queues
- Honest state
- Replay evidence
