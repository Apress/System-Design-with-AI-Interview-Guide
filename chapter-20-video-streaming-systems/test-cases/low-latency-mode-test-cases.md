# Low-Latency Mode Test Cases

| Case | Evidence | Expected Behavior |
|---|---|---|
| Partial stable, latency budget met | Good | Low latency allowed. |
| Partial failures rise | Bad | Standard latency fallback. |
| Manifest staleness high | Bad | Disable low latency. |
| Mode oscillation | Too many switches | Cooldown. |
