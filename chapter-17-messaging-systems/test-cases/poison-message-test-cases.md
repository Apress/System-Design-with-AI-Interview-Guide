# Poison Message Test Cases

| Case | Failure | Expected Behavior |
|---|---|---|
| Same validation error repeatedly | Poison | DLQ after budget. |
| External transient error | Transient | Retry with budget. |
| Policy block | Policy | DLQ/review. |
| Ambiguous provider state | Unknown | Reconcile, do not retry blindly. |
