# Late Retry Test Cases

| Case | Retry Age | Expected Behavior |
|---|---:|---|
| Within time budget | 30s | Retry if idempotent and evidence valid. |
| Beyond budget | 2h | DLQ or review. |
| Policy changed | any | Re-evaluate with pinned policy. |
| Entity state changed | any | Do not apply old intent blindly. |
