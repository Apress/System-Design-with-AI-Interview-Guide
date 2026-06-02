# Out-of-Order Event Test Cases

| Case | Entity | Expected Behavior |
|---|---|---|
| Order shipped before reserved | order | Route to DLQ/reconcile. |
| Message edit before create | thread | Buffer or reject until create arrives. |
| Balance debit after later credit | account | Sequence check. |
| Analytics late event | analytics | Handle with watermark/correction. |
