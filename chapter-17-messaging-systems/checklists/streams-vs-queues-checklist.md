# Streams vs Queues Checklist

Streams are best for:

- Durable facts
- Replay
- Audit
- Projection rebuilds

Queues are best for:

- Work distribution
- Backpressure
- Worker scheduling
- Poison isolation

Hybrid is often safest when you need both history and execution control.
