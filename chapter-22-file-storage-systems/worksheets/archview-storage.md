# ARCHVIEW: Storage

| Concern | View |
|---|---|
| Actors | User, app owner, metadata, indexer, lifecycle, legal, KMS, restore, auditor. |
| Responsibilities | Ingest, write, version, metadata, index, serve, lifecycle, hold, delete, restore. |
| Controls | Write boundary, index freshness, legal hold, deletion semantics, key lineage. |
| Commit Points | versionId, writeReceiptId, indexReceiptId, legalHoldId, deleteReceiptId, restoreReceiptId. |
| Evidence | Hash, key ID, policy version, receipts, metadata authority, restore drill. |
| Degradation | Stored-not-discoverable, delete-deferred, truth-first, human review. |
