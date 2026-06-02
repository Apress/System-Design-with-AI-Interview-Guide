# Payment Auth Ambiguity Test Cases

| Case | Provider Response | Expected Behavior |
|---|---|---|
| Authorized | Auth ID returned | Continue commit gate. |
| Declined | Decline returned | Refuse/payment failed. |
| Timeout maybe authorized | No final state | Pending payment confirmation. |
| Duplicate retry | Same idempotency | Reconcile, do not double charge. |
