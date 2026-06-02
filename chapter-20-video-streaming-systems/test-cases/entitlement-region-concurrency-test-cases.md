# Entitlement / Region / Concurrency Test Cases

| Case | Condition | Expected Behavior |
|---|---|---|
| Allowed tier but restricted region | Region blocked | Refuse: REGION_NOT_ALLOWED. |
| Right region but concurrency exceeded | Too many sessions | Refuse or session replacement by policy. |
| Entitled but DRM fails | Provider unavailable | Retry/remediate/refuse. |
| Parental control blocked | Age restriction | Refuse precisely. |
