# Late Bid Test Cases

| Case | Condition | Expected Behavior |
|---|---|---|
| Within late window | Policy enabled | Admit if valid. |
| Late window disabled | Any post-close ingest | Reject. |
| After hard cutoff | Ingested too late | Reject. |
| Lag exceeds budget | System uncertainty | Freeze/delay close. |
