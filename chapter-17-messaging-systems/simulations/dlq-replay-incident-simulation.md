# DLQ Replay Incident Simulation

## Scenario

Operator replays DLQ messages directly in execute mode. Some messages execute side effects that had already been applied manually.

## Expected Controls

- Simulate first
- Check idempotency
- Require approval
- Execute with receipt
- Emit replay card and no-op for already committed effects
