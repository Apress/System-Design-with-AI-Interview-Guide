# Scale: E-Commerce

| Pressure | Failure Shape | Control |
|---|---|---|
| Hot SKU | Inventory contention. | Holds/reservations. |
| Promotion | Checkout retries. | Idempotency/backpressure. |
| Payment queue | Ambiguous auth. | Reconciliation. |
| Warehouse cutoff | Unsafe modification. | Cutoff gates. |
| Support spike | No explanation. | Replay cards. |
