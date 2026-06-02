# Schema Mismatch Simulation

## Scenario

Producer publishes v4 events. Consumer expects v3. A required field was renamed without compatibility handling.

## Expected Controls

- Quarantine affected events
- Stop affected consumer path
- Notify schema owner
- Emit schema mismatch receipt
- Replay only after compatibility is restored
