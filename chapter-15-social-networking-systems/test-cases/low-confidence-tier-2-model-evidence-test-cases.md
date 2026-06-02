# Low-Confidence Tier 2 Model Evidence Test Cases

| Case | Model Signal | Expected Behavior |
|---|---|---|
| Low provenance confidence | Below threshold | Freeze or review before amplification. |
| Coordination likelihood rising | Warning threshold | Throttle or defer. |
| Safety classifier conflict | Conflicting labels | Route to review. |
| Model version missing | Not replayable | Block amplification. |
