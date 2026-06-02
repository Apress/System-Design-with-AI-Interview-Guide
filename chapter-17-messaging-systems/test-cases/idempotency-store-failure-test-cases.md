# Idempotency Store Failure Test Cases

| Case | Store State | Expected Behavior |
|---|---|---|
| Store unavailable | Cannot prove effect | Hard stop irreversible side effects. |
| Store slow | Timeout near provider call | Degrade/retry before side effect. |
| Store inconsistent | Conflicting records | Freeze capability and reconcile. |
| Cache missing durable present | Redis miss | Check durable table before acting. |
