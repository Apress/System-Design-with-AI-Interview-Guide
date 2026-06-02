# Replay Gap Freeze Simulation

## Scenario

Replay coverage for automated refund denials drops below 100% for 30 minutes.

## Expected Controls

- Freeze refundDenyId minting
- Route to step-up/review
- Restore receipt path
- Backfill or annotate affected actions
- Require owner approval before re-enable
