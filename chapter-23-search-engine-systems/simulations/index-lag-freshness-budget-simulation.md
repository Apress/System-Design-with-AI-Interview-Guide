# Index Lag Freshness Budget Simulation

## Scenario

Source update is ingested but not indexed within freshness budget.

## Expected Controls

- Mark results stale
- Narrow to last-certified sources
- Suppress AI answers for governed queries
- Alert index owner
- Re-enable after validation diff passes
