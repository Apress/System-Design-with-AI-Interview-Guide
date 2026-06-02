# Capability Map: Storage

| Capability | Responsibility | Boundary | Owner |
|---|---|---|---|
| Ingest | Validate bytes. | Ingest accepted | API owner |
| Write | Commit bytes. | writeReceiptId | Storage owner |
| Version | Immutable identity. | versionId | Object store |
| Metadata | Meaning/policy. | metadata receipt | Metadata owner |
| Index | Discoverability. | indexReceiptId | Search owner |
| Integrity | Verify truth. | scrub receipt | Integrity owner |
| Hold | Block deletion. | legalHoldId | Legal |
| Delete | Soft/hard delete. | deleteReceiptId | Deletion owner |
| Restore | Demonstrate recovery. | restoreReceiptId | Restore owner |
| Derivatives | OCR/embedding/summary. | derivative receipt | AI owner |
