# Earlier-Lens Mapping Worksheet: File Storage Systems

This worksheet helps you apply the earlier lenses from Part I and Part II to Chapter 22: File Storage Systems.

The purpose is not to memorize a “bucket + metadata DB + index + lifecycle policy” answer. The purpose is to prove that you can reuse the same system design method when bytes, metadata, versions, policies, legal holds, deletion, restore, integrity, AI derivatives, and audit collide over time.

Use this worksheet before drawing the final architecture. A senior answer should show that you understand state claims, version identity, receipt boundaries, storage clocks, metadata authority, integrity proof, lifecycle liability, AI derivative rebuilds, stop authority, ROCS loops, failure modes, economics, and replay requirements.

---

## 1. 7-Step Method Mapping

| Step | File Storage Application | Senior Architect Framing | Reader Notes |
|---|---|---|---|
| 1. Clarify the problem | Are we designing upload, versioning, metadata, discovery, retention, legal hold, deletion, restore, or AI derivatives? | “I need to know which state claim the platform is allowed to make.” |  |
| 2. Identify actors | User, application owner, metadata service, indexer, lifecycle engine, legal, compliance, KMS, restore operator, auditor. | “Storage involves more actors than user and file.” |  |
| 3. Map the journey | Upload, validate, write, version, index, serve, retain, hold, delete, restore, audit, derive. | “The journey does not end when bytes land.” |  |
| 4. Define constraints | Index lag, metadata drift, policy mismatch, key rotation, delete attack, restore failure, receipt gaps. | “The system must preserve truth while time changes everything.” |  |
| 5. Name commitments | `versionId`, `writeReceiptId`, `indexReceiptId`, `legalHoldId`, `deleteReceiptId`, `restoreReceiptId`. | “If I cannot mint the receipt, I cannot claim the state.” |  |
| 6. Choose architecture | Object store, metadata authority, index, policy engine, lifecycle worker, KMS, restore system, replay log. | “I draw truth boundaries before drawing buckets.” |  |
| 7. Defend trade-offs | Durability vs cost, async indexing vs honesty, deletion vs retention, derivatives vs source truth. | “A slower honest state is better than a fast false claim.” |  |

---

## 2. Customer Journey Mapping

| Journey Moment | User/System Believes | Platform Risk | Architecture Response |
|---|---|---|---|
| Upload begins | File is being saved. | Bytes received but not durable. | Validate and compute identity. |
| Write completes | File is stored. | Version or receipt missing. | Mint `versionId` and `writeReceiptId`. |
| Search/list begins | File should be discoverable. | Index lag. | Use `indexReceiptId`; label stored-not-discoverable until ready. |
| Legal hold applies | File cannot be deleted. | Hold not enforced in lifecycle path. | Mint `legalHoldId`; block delete. |
| Lifecycle runs | File may move/archive/delete. | Policy mismatch or stale metadata. | Pin policy and require receipts. |
| Delete requested | File should disappear. | Destruction may violate hold/retention. | Hold check, retention check, `deleteReceiptId`. |
| Restore requested | File should recover. | Backup exists but restore fails. | Run drill and mint `restoreReceiptId`. |
| Audit asks why | Platform must prove. | Logs are scattered or incomplete. | Storage Decision Replay Card. |

---

## 3. Capability Map

| Capability | Responsibility | Commitment Boundary | Owner |
|---|---|---|---|
| Ingest | Receive and validate bytes. | Ingest accepted. | Storage API owner |
| Write | Commit bytes. | `writeReceiptId`. | Storage engine owner |
| Version | Preserve immutable content identity. | `versionId`. | Object store owner |
| Metadata | Maintain owner, ACL, classification, retention, lineage. | Metadata receipt. | Metadata owner |
| Index | Make object discoverable. | `indexReceiptId`. | Search/index owner |
| Serve | Return correct version. | Serve verification receipt. | Read-path owner |
| Integrity | Prove bytes/key/version remain valid. | Scrub/verify receipt. | Integrity owner |
| Lifecycle | Tier, archive, expire. | Lifecycle receipt. | Lifecycle owner |
| Legal Hold | Block deletion. | `legalHoldId`. | Legal/compliance owner |
| Delete | Commit soft/hard delete. | `deleteReceiptId`. | Deletion owner |
| Restore | Demonstrate recovery. | `restoreReceiptId`. | Restore owner |
| AI Derivatives | Build OCR, embeddings, summaries, previews. | Derivative receipt. | AI/search owner |
| Replay/Audit | Prove state changes. | Storage Replay Card. | Governance owner |
| Stop Authority | Freeze unsafe action. | Stop event. | Platform operations owner |

---

## 4. ARCHVIEW Mapping

| ARCHVIEW Concern | File Storage View |
|---|---|
| Actors | User, application owner, metadata service, indexer, lifecycle engine, legal, security, KMS, restore operator, auditor. |
| Responsibilities | Ingest, write, version, metadata, index, serve, lifecycle, hold, delete, restore, derive, audit. |
| Control surfaces | Write boundary, index freshness, legal hold, retention, deletion semantics, key lineage, restore certification. |
| Commitment points | `versionId`, `writeReceiptId`, `indexReceiptId`, `legalHoldId`, `deleteReceiptId`, `restoreReceiptId`. |
| Ownership | Storage, metadata, search, lifecycle, legal, security, KMS, restore, AI derivatives, replay owners. |
| Evidence | Integrity hash, key ID, policy version, receipts, metadata authority, restore drill result. |
| Degradation | Stored-not-discoverable, delete-deferred, restore-required, truth-first mode, human review. |
| Stop authority | Freeze deletes, lifecycle moves, retention changes, key destruction, derivative rebuild, or writes by scope. |

---

## 5. AI Primitives Mapping

| AI Primitive | Storage Application | Artifact |
|---|---|---|
| Authority | What may be stored, served, retained, deleted, restored, or derived? | State-claims policy and deletion policy |
| Commitment | State claim becomes real only when receipt exists. | Receipt schemas |
| Time | Write, index, lifecycle, legal, delete, and restore clocks govern different claims. | Storage clocks policy |
| Degradation | Honest intermediate states prevent false claims. | Stored-not-discoverable, pending-restore, delete-deferred |
| Evidence/Replay | Prove object state years later. | Storage Decision Replay Card |
| Ownership | Owners must freeze unsafe irreversible transitions. | Stop-authority matrix |

---

## 6. ROCS Mapping

| ROCS Dimension | Storage Pressure | Control |
|---|---|---|
| Reliability | State claims must survive write, index, lifecycle, delete, restore, and attack pressure. | Verified writes, integrity checks, bounded retries, restore drills. |
| Observability | Platform must replay why object state changed. | Receipts, policy pins, version lineage, audit chain. |
| Cost | Replication, verification, restore, tiering, derivative rebuilds can explode. | Budgets, tiering policy, rebuild queues, lifecycle controls. |
| Sustainability | Storage must preserve trust over years as policies and threats change. | Bounded irreversibility, honest state labels, stop authority. |

---

## 7. Scale Mapping

| Scale Pressure | Storage Failure Shape | Control |
|---|---|---|
| High object volume | Index lag and metadata pressure. | Index budgets and truth-first mode. |
| Lifecycle storms | Mass archive/delete pressure. | Lifecycle throttles and receipt gates. |
| Restore pressure | Recovery bottlenecks. | Restore drills and restore queue priorities. |
| Delete attack | Ransomware-like destructive velocity. | Freeze delete/lifecycle by scope. |
| AI derivative rebuild | Expensive OCR/embedding/summary regeneration. | Rebuild queues, source-version pins, cost budgets. |

---

## 8. Consistency Mapping

| Boundary | Trust Rule | Artifact |
|---|---|---|
| Bytes received | Not yet stored. | Ingest receipt |
| Version written | Stored claim possible. | `versionId` + `writeReceiptId` |
| Index updated | Discoverable claim possible. | `indexReceiptId` |
| Hold applied | Delete blocked. | `legalHoldId` / `retentionHoldId` |
| Soft delete | Hidden but recoverable. | `deleteReceiptId` |
| Hard delete | Irreversible or unrecoverable. | `deleteReceiptId` + destruction proof |
| Restore demonstrated | Recoverable claim possible. | `restoreReceiptId` |
| Derivative rebuilt | Derived artifact current. | Derivative rebuild receipt |

---

## 9. Latency Mapping

| Latency Type | Storage Meaning | Control |
|---|---|---|
| Write latency | Time to commit bytes and version. | Write receipt. |
| Index latency | Time to become searchable. | Index freshness budget. |
| Legal-hold latency | Time until hold is enforced. | Hold propagation proof. |
| Lifecycle latency | Time until tier/archive/delete action completes. | Lifecycle receipt. |
| Restore latency | Time to recover and verify. | Restore receipt and RTO/RPO. |
| Derivative rebuild latency | Time to rebuild OCR, embeddings, summaries, indexes. | Rebuild queue and invalidation policy. |

---

## 10. Failure Mapping

| Failure Signal | What It Looks Like | Response |
|---|---|---|
| Index drift | Stored file missing from search. | Truth-first mode; rebuild index. |
| Receipt gap | Cannot prove write/delete/restore. | Freeze affected claim/action. |
| Integrity failure | Hash/key/version mismatch. | Quarantine and block serve/restore claim. |
| Restore drill failure | Backup exists but recovery fails. | Stop claiming recoverable. |
| Delete velocity spike | Potential ransomware/destructive attack. | Freeze deletes and lifecycle. |
| Policy mismatch | Workers apply different rules. | Quarantine version and rollback. |
| Key lineage mismatch | Cannot prove encryption/access history. | Freeze key operations. |

---

## 11. Economics Mapping

| Economic Multiplier | Storage Example | Control |
|---|---|---|
| Replication cost | Multiple copies and regions. | Tiering and durability policy. |
| Verification cost | Scrubbing and hash checks. | Risk-based verification budget. |
| Restore cost | Drills, recovery compute, archive retrieval. | Restore drill schedule and priority. |
| Index rebuild cost | Large search/index recovery. | Rebuild queues and budgets. |
| AI derivative cost | OCR, embeddings, summaries, thumbnails. | Regenerate derivatives from pinned source. |
| Audit cost | Manual proof reconstruction. | Replay cards and receipts. |

## Final Senior Line

> A file storage system is not where bytes go. It is where truth must survive time. The senior design separates stored from discoverable, retained from deletable, deleted from unrecoverable, and recoverable from assumed backup; binds every state claim to version, policy, receipt, integrity proof, and authority; treats lifecycle and deletion as liability actions; keeps AI derivatives rebuildable; and freezes irreversible actions when proof weakens.
