# Settlement Idempotency Test Cases

| Case | Condition | Expected Behavior |
|---|---|---|
| Duplicate capture attempt | Same settlementEffectId committed | NO_OP receipt. |
| Provider timeout | Unknown state | Pause/reconcile. |
| Capture before close | Missing closeCommitId | Block. |
| Allocation failed | Post-close failure | Compensation/second chance/re-auction. |
