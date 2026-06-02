# Simulation: Recommendation Mode Leakage

## Scenario

A user selects non-profiling mode. The UI label changes, but the ranker still uses behavior-derived embeddings from a shared feature store.

## Expected Behavior

- Detect mode-boundary leak.
- Hard stop affected ranking path.
- Serve safe non-profiling fallback.
- Emit incident receipt.
- Route to privacy/policy review.
