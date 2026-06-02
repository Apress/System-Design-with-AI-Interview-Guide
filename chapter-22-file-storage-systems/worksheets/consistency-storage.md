# Consistency: Storage

| Boundary | Rule | Artifact |
|---|---|---|
| Bytes received | Not stored. | Ingest receipt |
| Version written | Stored. | versionId/writeReceiptId |
| Index updated | Discoverable. | indexReceiptId |
| Hold applied | Delete blocked. | legalHoldId |
| Soft delete | Hidden recoverable. | deleteReceiptId |
| Hard delete | Unrecoverable. | destruction proof |
| Restore demonstrated | Recoverable. | restoreReceiptId |
