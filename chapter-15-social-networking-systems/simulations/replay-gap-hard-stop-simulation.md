# Simulation: Replay Gap Hard Stop

## Scenario

Amplification replay coverage drops from 100% to 99.2% during a viral event.

## Expected Behavior

- Block new amplification tokens on affected paths.
- Freeze high-risk promotions.
- Emit replay-gap incident receipt.
- Restore replay path before re-enable.
- Backfill or annotate missing evidence.
