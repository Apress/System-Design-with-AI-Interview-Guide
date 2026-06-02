# Consumer Lag and Timeout Straddling Simulation

## Scenario

Consumer lag grows. External payment calls time out. Scaling consumers increases throughput but also increases ambiguous side-effect attempts.

## Expected Controls

- Treat lag as performance, not correctness
- Reduce concurrency for risky effects
- Freeze irreversible side effects if idempotency proof is incomplete
- Reconcile provider traces
- Replay simulate-first
