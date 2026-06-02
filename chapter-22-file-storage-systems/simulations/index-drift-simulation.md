# Index Drift Simulation

## Scenario

Writes succeed and `writeReceiptId` exists, but search/list cannot find objects for longer than the freshness budget.

## Expected Controls

- Claim Stored, not Discoverable
- Enter truth-first mode
- Rebuild index from source metadata
- Prevent lifecycle/delete based on stale index
- Emit index drift receipt
