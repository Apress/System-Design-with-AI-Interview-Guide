# Low-Latency Drift Simulation

## Scenario

Glass-to-glass latency exceeds budget and partial segment failures rise.

## Expected Controls

- Fall back to standard latency
- Prevent oscillation with cooldown
- Preserve clock evidence
- Re-enable only after stable window
