# AI Derivative Staleness Simulation

## Scenario

Embeddings and summaries point to source version 4 while current source is version 6.

## Expected Controls

- Mark derivatives stale
- Prevent authoritative use
- Enqueue rebuild
- Preserve old derivative lineage
- Emit invalidation receipt
