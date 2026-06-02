# Storage 7-Step Method Map

| Step | Storage Application | Notes |
|---|---|---|
| Clarify | Upload, versioning, discovery, retention, hold, delete, restore, derivatives. |  |
| Actors | User, app owner, metadata, indexer, lifecycle, legal, KMS, restore, auditor. |  |
| Journey | Upload, write, version, index, serve, retain, hold, delete, restore, derive. |  |
| Constraints | Index lag, policy mismatch, key rotation, delete attack, restore failure. |  |
| Commitments | versionId, writeReceiptId, indexReceiptId, legalHoldId, deleteReceiptId. |  |
| Architecture | Object store, metadata, index, policy engine, KMS, restore, replay. |  |
| Trade-offs | Durability vs cost, async indexing vs honesty, deletion vs retention. |  |
