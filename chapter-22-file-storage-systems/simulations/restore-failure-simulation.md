# Restore Failure Simulation

## Scenario

Backups exist, but restore drill fails because key lineage is broken.

## Expected Controls

- Stop claiming Recoverable
- Quarantine affected scope
- Repair key lineage/restore path
- Run restore certification before re-enable
