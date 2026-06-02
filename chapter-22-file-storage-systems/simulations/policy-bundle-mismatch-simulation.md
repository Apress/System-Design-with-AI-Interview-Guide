# Policy Bundle Mismatch Simulation

## Scenario

Some lifecycle workers run deletion policy v3 while others run v4.

## Expected Controls

- Quarantine policy bundle
- Roll back to last known-good
- Freeze lifecycle/delete
- Audit affected scope
- Re-enable after policy/schema reconciliation
