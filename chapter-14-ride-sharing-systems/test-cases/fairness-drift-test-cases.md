# Fairness Drift Test Cases

| Case | Signal | Expected Behavior |
|---|---|---|
| Wait disparity by region | p95 ratio exceeds threshold | Dispatch-weight adjustment. |
| High cancellation cohort | Cancellation disparity exceeds threshold | Conservative matching review. |
| Driver earnings variance | Variance exceeds threshold | Incentive adjustment. |
| Coverage SLO breach | Region below SLO | Supply nudging or surge dampening. |
