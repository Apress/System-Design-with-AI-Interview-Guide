# Close Mismatch Simulation

## Scenario

Two close computations run during failover for the same auction. One includes a late bid; one excludes it. Both attempt to write a close result.

## Expected Controls

- Unique auctionId -> closeCommitId constraint
- Single close authority or guarded compare-and-set
- Freeze settlement immediately
- Reconcile with pinned evidence
- Emit close mismatch incident receipt
