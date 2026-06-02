# Duplicate Delivery Test Cases

| Case | Condition | Expected Behavior |
|---|---|---|
| Same event delivered twice | effect already COMMITTED | Emit NO_OP receipt. |
| Same event, different side effect | New effectId | Execute only if allowed. |
| Redelivery after IN_PROGRESS | stale in-progress | Reconcile before retry. |
| Redelivery after FAILED | failure safe | Retry only if budget/evidence allow. |
