# ABR Control Test Cases

| Case | Signal | Expected Behavior |
|---|---|---|
| Stable throughput | Normal | Normal ABR. |
| Timeout rise | Cohort issue | Conservative ABR. |
| Buffer collapse | Stall risk | Buffer widen/clamp. |
| Recovery | Stable window | Gradual restore. |
