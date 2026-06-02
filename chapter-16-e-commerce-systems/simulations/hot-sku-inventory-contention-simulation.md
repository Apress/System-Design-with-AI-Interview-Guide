# Hot SKU Inventory Contention Simulation

## Scenario

A limited-stock item goes viral. Inventory snapshots lag behind reservation attempts. Browsing shows in stock while checkout allocations fail.

## Expected Controls

- Label browse availability as estimate
- Enforce hard TTL at checkout
- Use inventoryHoldId and reservationId
- Move to pending/backorder/refused when allocation fails
- Emit replay evidence
