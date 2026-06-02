# Duplicate Place Order Test Cases

| Case | Condition | Expected Behavior |
|---|---|---|
| Double click | Same checkout intent | Return same order state. |
| Refresh after timeout | Same idempotency key | Show pending/confirmed based on existing state. |
| New cart snapshot | Different intent | Create new checkout intent. |
| Payment timeout | Unknown auth | Pending payment confirmation, reconcile. |
