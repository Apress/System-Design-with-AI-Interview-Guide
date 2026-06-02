# Stale GPS Test Cases

| Case | GPS Age | Expected Behavior |
|---|---:|---|
| Fresh GPS | 3s | Candidate can be used. |
| Soft-stale GPS | 7s | Refresh or proceed cautiously before commit. |
| Hard-stale GPS | 12s | Do not commit; refresh, defer, or refuse. |
| Post-commit stale GPS | 15s | Repair first; update ETA; controlled reassignment if needed. |
