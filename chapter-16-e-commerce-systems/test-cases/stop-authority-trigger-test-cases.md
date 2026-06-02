# Stop Authority Trigger Test Cases

| Trigger | Condition | Expected Action |
|---|---|---|
| Replay gap | High-risk replay < 100% | Hard stop path. |
| Payment failure | Sustained failure | Pending payment confirmation. |
| Inventory conflict | Above baseline | Tighten commit gate. |
| Fulfillment conflict | Above baseline | Stop automated modifications. |
| Refund reversal | Spike | Require review. |
