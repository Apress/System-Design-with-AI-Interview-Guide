# Liability Boundary Map

| Domain | Attempt State | Commitment Boundary | Required Evidence | Receipt | Owner | Reversible? | Compensation Path |
|---|---|---|---|---|---|---|---|
| Checkout | Cart submitted | Order confirmed | Inventory + payment + policy | orderCommitReceipt | Checkout owner | Partial | Cancel/refund |
| Payment | Capture requested | Capture committed | Auth + idempotency + provider proof | captureReceipt | Payment owner | Sometimes | Refund/reversal |
| Search | Evidence retrieved | AI answer generated | Current citations + policy | answerReceipt | AI answer owner | Yes | Correction/source-only |
| Storage | Delete requested | Hard delete committed | Retention clear + legal hold clear | deleteReceipt | Storage owner | No | Restore if possible |
