# Settlement Duplicate Capture Simulation

## Scenario

Payment capture times out after provider success. Settlement replay attempts capture again.

## Expected Controls

- deterministic settlementEffectId
- idempotency key
- provider trace reconciliation
- no-op receipt on duplicate
- pause/reconcile on unknown state
