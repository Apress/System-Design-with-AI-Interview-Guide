# Customer Journey: Storage

| Moment | Belief | Risk | Response |
|---|---|---|---|
| Upload begins | File saving. | Bytes not durable. | Validate. |
| Write completes | Stored. | Receipt missing. | versionId + writeReceiptId. |
| Search begins | Discoverable. | Index lag. | indexReceiptId. |
| Hold applies | Cannot delete. | Hold not enforced. | legalHoldId. |
| Delete requested | File gone. | Violates hold. | deleteReceiptId. |
| Restore requested | Recoverable. | Restore fails. | restoreReceiptId. |
