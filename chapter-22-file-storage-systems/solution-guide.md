# Chapter 22 Solution Guide

## Exercise 1 Solution: Storage as a Long-Lived Truth Engine

A strong answer should explain that file storage is not merely a place where bytes are uploaded and replicated. A serious storage system is a long-lived truth engine. It must preserve not only content, but also version identity, metadata meaning, policy authority, integrity proof, legal hold state, lifecycle decisions, deletion semantics, restore evidence, and audit history.

The states **Stored**, **Discoverable**, **Retained**, **Deleted**, and **Recoverable** are not UI labels. They are claims. Each claim requires proof.

A file can physically exist while the system is still indefensible. Examples:

- Bytes exist, but no `writeReceiptId` proves the committed version.
- A version exists, but the index has not caught up.
- A file is listed, but metadata or ACL state is stale.
- A deletion completed, but no policy pin proves it was lawful.
- Backups exist, but no restore drill proves the object can be recovered and decrypted.
- An embedding or summary exists, but it was produced from an outdated source version.

Actors include:

- user,
- application owner,
- storage service,
- metadata service,
- indexer,
- lifecycle engine,
- key-management system,
- security team,
- legal team,
- compliance team,
- restore operator,
- auditor,
- platform owner.

Before claiming **Stored**, the platform needs:

- `objectId` or `pathId`,
- `versionId`,
- content hash,
- encryption key ID,
- policy version,
- `writeReceiptId`.

Before claiming **Discoverable**, it also needs:

- source metadata committed,
- index freshness inside budget,
- `indexReceiptId`.

Before claiming **Deleted**, it needs:

- deletion intent,
- policy pin,
- legal hold check,
- retention check,
- delete semantics: soft delete, hard delete, expiration delete, or key destruction,
- `deleteReceiptId`,
- recovery-window statement.

Before claiming **Recoverable**, it needs:

- restore drill evidence,
- checksum verification,
- decrypt proof,
- metadata rebuild proof,
- `restoreReceiptId`.

What must be replayable later:

- who or what changed state,
- which object and version changed,
- which policy governed it,
- which integrity proof existed,
- whether legal hold or retention applied,
- what index state existed,
- what deletion semantics applied,
- whether restore was demonstrated,
- what stop authority fired or should have fired.

Senior answer:

> I am not designing buckets and replication. I am designing a long-lived truth engine. Stored, discoverable, retained, deleted, and recoverable are claims. Each claim requires version identity, receipts, policy pins, integrity evidence, authority trail, stop authority, and replay proof.

---

## Exercise 2 Solution: Token Chain and Storage State Boundaries

A mature storage design uses tokens to separate logical identity, immutable content, state claims, policy constraints, destructive transitions, and recovery proof.

| Token | What It Proves | Why It Matters |
|---|---|---|
| `objectId` | Logical object identity. | Names the object independent of path changes. |
| `pathId` | Logical path or namespace location. | Useful for user-facing location, rename, and move. |
| `versionId` | Immutable stored version. | Identifies the exact preserved content. |
| `writeReceiptId` | Stored claim was earned. | Proves bytes were committed under policy. |
| `indexReceiptId` | Discoverable claim was earned. | Proves search/list/metadata discovery caught up. |
| `legalHoldId` | Legal deletion block exists. | Deletion must refuse regardless of cleanup pressure. |
| `retentionHoldId` | Retention policy applies. | Lifecycle cannot outrun retention obligation. |
| `deleteReceiptId` | Deletion semantics were applied. | Proves soft/hard/expiry/delete behavior. |
| `restoreReceiptId` | Recoverability was demonstrated. | Proves restore worked end to end. |

`objectId` or `pathId` is not enough because identity does not prove committed bytes. A path can move, be renamed, or point to different versions. `versionId` is the immutable unit of truth.

`writeReceiptId` is required before claiming **Stored** because the platform must prove the write was completed, integrity was sealed, policy was pinned, and the object version became durable.

`indexReceiptId` is required before claiming **Discoverable** because search and list are derived convenience layers. They may lag. The system may claim **Stored** before it claims **Discoverable**, but it must label that state honestly.

`legalHoldId` and `retentionHoldId` are authority tokens. They transform delete from a product action into a blocked or governed legal action.

`deleteReceiptId` must prove:

- who or what requested deletion,
- which policy version applied,
- whether legal hold/retention checks passed,
- whether delete was soft, hard, lifecycle expiry, or key destruction,
- whether recovery remains possible,
- what integrity or lineage evidence was preserved.

`restoreReceiptId` is required before claiming **Recoverable** because recoverability is not belief. It is demonstrated recovery: fetch, decrypt, verify, rebuild metadata, and prove serve-readiness.

Storage Decision Replay Card should contain:

- `correlationId`,
- `objectLineageId`,
- `objectId`,
- `pathId`,
- `versionId`,
- content hash,
- encryption key ID,
- key lineage ID,
- policy version,
- `writeReceiptId`,
- `indexReceiptId`,
- `legalHoldId` / `retentionHoldId`,
- `deleteReceiptId`,
- `restoreReceiptId`,
- actor/authority,
- state claim,
- outcome,
- stop-authority state,
- compensation or rebuild path.

Senior answer:

> `objectId` names the thing. `versionId` identifies the preserved truth. Receipts prove the platform earned each state claim. Without the receipt, the system does not get to say stored, discoverable, deleted, or recoverable.

---

## Exercise 3 Solution: Stored vs. Discoverable

The system should claim:

```text
Stored, not yet discoverable.
```

This is a correct and honest state if the write has succeeded and the index is still catching up.

**Stored** and **Discoverable** are different claims.

- **Stored** means the bytes are committed, a `versionId` exists, integrity is sealed, and a `writeReceiptId` exists.
- **Discoverable** means search/list/metadata discovery can find the object within the declared freshness budget, and an `indexReceiptId` exists.

Asynchronous indexing is acceptable. Ambiguous claims are not. The platform may say:

```text
Upload complete. This file is safely stored and will appear in search shortly.
```

But it should not say:

```text
Upload complete and searchable.
```

unless the index receipt exists.

A freshness budget should define:

- expected index catch-up time,
- maximum allowed lag,
- cohort or tenant scope,
- what UI/API state appears during lag,
- what happens if the budget is missed.

Example:

```yaml
indexFreshnessBudget:
  normalCatchupSeconds: 30
  maxAllowedLagSeconds: 180
  onLagExceeded:
    - label_stored_not_discoverable
    - enter_truth_first_mode
    - prioritize_index_rebuild
    - freeze_lifecycle_delete_for_affected_scope
```

If index drift exceeds budget, the system should enter truth-first mode:

- do not let search/index state override source metadata,
- label affected objects as stored but not discoverable,
- prioritize index rebuild,
- emit index drift incident receipt,
- freeze lifecycle or deletion transitions if they depend on stale index state,
- alert index owner and storage platform owner.

`writeReceiptId` proves that durable storage was earned.

`indexReceiptId` proves that the discovery layer caught up and can be trusted for that claim.

Senior answer:

> Eventual indexing is fine. Eventual truth is not. I separate Stored from Discoverable and expose the honest intermediate state until the index receipt exists.

---

## Exercise 4 Solution: Integrity Proof Chain

The answer “we use checksums and encryption” is incomplete because integrity is not a static feature. It is a replayable proof chain across content, version, key, policy, verification, serve path, lifecycle movement, and restore.

A checksum alone proves only byte identity at one point in time. It does not prove:

- which immutable version the checksum belongs to,
- which key protected the object,
- whether key rotation preserved access,
- whether the serve path returned the correct version,
- whether lifecycle movement preserved integrity,
- whether restore can reconstruct and decrypt the object,
- whether verification actually happened over time.

A strong integrity proof chain includes:

| Proof | Purpose |
|---|---|
| Content hash/checksum | Proves byte identity. |
| `versionId` binding | Connects hash to immutable object version. |
| Encryption key ID | Proves which key protected the object. |
| Key lineage | Shows key rotation, re-encryption, and access history. |
| `writeReceiptId` | Proves the object was written under policy. |
| Scrub/verify receipt | Proves periodic integrity verification. |
| Serve-path verification | Proves served version matches stored truth. |
| `restoreReceiptId` | Proves recoverability through restore and decrypt. |

A wrong key is an integrity failure even if bytes exist. If the platform cannot decrypt the correct version under the correct policy and key lineage, the content is not recoverable in the way the platform claimed.

Integrity must survive:

- replication,
- cache serving,
- CDN serving,
- lifecycle tiering,
- archive transitions,
- key rotation,
- re-encryption,
- metadata migration,
- restore,
- AI derivative rebuilds.

To prove served bytes match stored truth, replay must show:

- requested `objectId`,
- requested `versionId`,
- stored content hash,
- served content hash,
- encryption key ID,
- key lineage,
- policy version,
- serve-path verification receipt,
- integrity verification timestamp,
- cache/CDN validation if applicable.

Senior answer:

> Checksums are necessary, but not sufficient. Integrity is a replayable chain: content hash, version binding, key lineage, policy pin, write receipt, verification receipt, serve-path proof, and restore proof.

---

## Exercise 5 Solution: Lifecycle and Deletion as Liability Actions

The system should not proceed with hard delete.

Lifecycle and deletion are not cleanup jobs. They are liability actions because they can destroy, hide, retain, or make unrecoverable data that may be legally, operationally, or commercially important.

Legal hold and retention checks must outrank cleanup pressure. If legal time says hold, lifecycle time cannot delete.

Hard delete requires:

- delete intent,
- pinned policy version,
- retention check,
- legal hold check,
- object lineage,
- version lineage,
- approval if required,
- integrity and receipt evidence,
- destruction proof,
- recovery-impossibility statement,
- `deleteReceiptId`.

If replay coverage is incomplete, hard delete should freeze. Destructive actions require full proof because missing proof after destruction cannot always be recovered.

If policy versions are mismatched across workers, the system should:

- quarantine affected policy bundle,
- roll back to last known-good policy version,
- freeze hard delete and lifecycle transitions for affected scope,
- continue safe reads if possible,
- route questionable actions to manual review,
- emit stop-authority receipt.

The system should use this posture:

| Condition | Correct Behavior |
|---|---|
| Legal hold active | Refuse delete. |
| Legal hold unknown | Defer or escalate. |
| Retention state stale | Defer delete. |
| Policy mismatch | Freeze lifecycle/delete. |
| Replay coverage incomplete | Freeze hard delete. |
| Destruction proof unavailable | Do not claim hard deleted. |

`deleteReceiptId` must prove:

- which object/version was deleted,
- deletion mode,
- governing policy,
- legal hold status,
- retention status,
- actor/authority,
- approval,
- timestamp,
- recovery window,
- destruction proof if hard delete,
- replay card ID.

Re-enable criteria:

- replay coverage restored,
- policy/schema versions reconciled,
- legal hold and retention state current,
- integrity verification passes,
- delete receipt path restored,
- affected scope audited,
- owner approval recorded,
- re-enable receipt emitted.

Senior answer:

> Hard delete is not cleanup. It is a destruction boundary. If hold status, policy version, or replay proof is unclear, the system must refuse, defer, escalate, or freeze—not convert ambiguity into irreversible loss.

---

## Bonus Exercise 6 Solution: Storage Clocks and Admissible Reality

Storage truth is governed by multiple clocks. Each clock controls a different claim.

| Clock | Meaning | Governs Claim |
|---|---|---|
| Write time | When bytes are committed and `versionId` exists. | Stored. |
| Index time | When search/list/metadata discovery catches up. | Discoverable. |
| Lifecycle time | When tiering, archival, expiration, or transition executes. | Archived, expired, tiered. |
| Legal time | When legal hold or retention becomes enforceable. | Retained, deletion blocked. |
| Delete time | When soft or hard delete commits. | Deleted, unrecoverable, recoverable window. |
| Restore time | When recovery is demonstrated end to end. | Recoverable. |

Write time is required before claiming **Stored** because until committed bytes and `versionId` exist, the system has only received or attempted a write.

Index time is required before claiming **Discoverable** because discovery is a separate derived state.

Legal time must block deletion even if lifecycle time is ready because compliance authority outranks cleanup automation.

Delete time must preserve semantics:

- soft delete: hidden but recoverable within window,
- hard delete: destruction or unrecoverable state,
- retention-expiry delete: deletion after retention satisfied,
- key destruction: data may exist but access is permanently removed.

Restore time is required before claiming **Recoverable** because backups, replicas, or archive tiers are not enough. The platform must demonstrate retrieve, decrypt, verify, rebuild metadata, and serve or export.

The system may be asynchronous:

```text
Stored now.
Discoverable within 60 seconds.
Retained immediately after legal hold enforcement.
Deleted only after hold and retention checks.
Recoverable only after restore certification.
```

But it must not be ambiguous:

```text
“Should be searchable” is not a state.
“Probably deleted” is not a state.
“Backups exist” is not recoverability.
```

Senior answer:

> Storage may be asynchronous, but every state claim must be tied to the clock and receipt that makes it admissible.

---

## Bonus Exercise 7 Solution: Metadata Authority and Derived Systems

The authoritative layer depends on the question.

| Layer | Examples | Authority |
|---|---|---|
| Source bytes | Blob/object content, versioned payload. | Authoritative for content. |
| Source metadata | Owner, ACL, classification, retention, legal hold, lineage. | Authoritative for meaning and policy. |
| Derived indexes | Search, list views, embeddings, OCR, thumbnails, summaries. | Rebuildable, non-authoritative. |
| Caches/CDN | Served copies, stale views, edge metadata. | Performance layer only. |
| Audit/receipts | Write, index, policy, delete, restore receipts. | Authoritative proof trail. |

Metadata is the real storage system because metadata determines who can find, serve, retain, delete, move, classify, audit, or restore content. Bytes without meaning are not governable.

If source metadata conflicts with search, embeddings, or cache, source metadata wins. The derived layer should be invalidated and rebuilt.

Examples:

- Search says file is public; source ACL says private → source ACL wins.
- Embedding summary reflects version 4; source object is version 6 → embedding is stale and must be invalidated.
- Thumbnail exists for deleted version → thumbnail must be removed or marked stale.
- Cache serves old policy state → cache purge or revalidation required.

Receipt-bearing metadata changes should include:

- ACL update receipt,
- classification receipt,
- retention change receipt,
- legal hold receipt,
- rename/move receipt,
- reclassification receipt,
- ownership change receipt,
- metadata rebuild receipt.

Rebuild derived artifacts by pinning:

- source `versionId`,
- source metadata version,
- policy version,
- extractor/model/renderer version,
- transformation configuration,
- invalidation event,
- rebuild receipt.

Senior answer:

> Bytes preserve content. Metadata preserves meaning. Indexes, embeddings, thumbnails, and caches are accelerators, not authority. When they disagree with source metadata and receipts, the derived layer loses and must rebuild.

---

## Bonus Exercise 8 Solution: AI Derivatives and Rebuild Contract

AI makes storage a multi-truth system unless the architecture clearly separates source-of-record truth from regeneratable derivatives.

Non-regeneratable source-of-record truth:

- original object version,
- immutable version history,
- legal hold receipt,
- retention receipt,
- key lineage,
- write receipt,
- delete receipt,
- restore receipt,
- audit chain,
- policy decision evidence.

Regeneratable derivatives:

- OCR text,
- embedding vector,
- summary,
- thumbnail,
- preview,
- extracted tags,
- search index,
- semantic index,
- transcript if generated from source media.

Derivative artifacts need a rebuild contract:

| Field | Why It Matters |
|---|---|
| Source `versionId` | Identifies input truth. |
| Source content hash | Proves input bytes. |
| Extractor/model version | Explains output generation. |
| Policy version | Shows governing rules. |
| Prompt/config version | Required for AI summaries or extraction. |
| Generated timestamp | Shows derivative age. |
| Invalidation reason | Explains why derivative is stale. |
| Rebuild receipt | Proves derivative was regenerated. |

When a new source version arrives:

1. Mint new `versionId`.
2. Preserve old version and receipts.
3. Invalidate derivatives tied to the old version if they no longer apply.
4. Queue rebuild for OCR, embeddings, summaries, thumbnails, search.
5. Pin model/extractor versions.
6. Emit derivative rebuild receipts.
7. Expose honest state: source stored, derivatives rebuilding.

Cost control:

- do not preserve expensive derivatives forever if they are reproducible,
- prioritize rebuild by access frequency and compliance need,
- use tiered derivative storage,
- rebuild lazily when safe,
- never delete non-regeneratable truth to save derivative cost,
- do not treat derivative absence as source loss.

Senior answer:

> Preserve truth, regenerate derivatives, and never let the fast layer impersonate the real layer.

---

## Bonus Exercise 9 Solution: Green Dashboards, Missing Truth

This is not a basic availability incident. It is a defensibility incident.

The platform stayed up. Writes returned 200. Latency was fine. But the system lost the ability to prove which state was real.

This incident is dangerous because:

- bytes may exist but cannot be proven,
- index entries may not match source versions,
- lifecycle transitions may lack pinned policy,
- delete receipts may be missing,
- audit cannot reconstruct authority,
- legal hold and retention history may be uncertain.

“It should be there” is a failed storage answer because storage systems are graded by proof, not optimism.

Immediate response:

1. Freeze destructive transitions for affected scope.
2. Freeze lifecycle moves that depend on questionable policy or receipt state.
3. Enter truth-first mode.
4. Use source-of-record metadata and receipts as authority.
5. Quarantine affected policy bundle or worker version.
6. Rebuild index from source version receipts.
7. Run integrity verification.
8. Run restore drill for affected scope.
9. Backfill or annotate missing receipts where possible.
10. Emit incident replay card.

Receipt coverage below 100 percent should freeze destructive transitions because deletion without proof is irreversible harm.

Index drift beyond budget should trigger truth-first mode:

- do not trust search/list as authority,
- label files as stored but not discoverable where appropriate,
- rebuild from source metadata,
- prevent lifecycle/delete decisions based on stale derived state.

Re-enable criteria:

- replay coverage restored,
- policy/schema versions reconciled,
- index freshness inside budget,
- integrity verification passed,
- restore proof current,
- affected scope audited,
- receipt path fixed,
- re-enable event recorded under confirmed control version.

Senior answer:

> The system did not go down. It stayed up and lost truth. In storage, that is an outage.

---

## Bonus Exercise 10 Solution: Senior Architect File Storage Defense

A mature answer should acknowledge object storage, replication, metadata databases, search indexes, backup, and lifecycle policies, but explain that they are not the design center. The design center is truth over time.

A senior answer starts like this:

> I am not designing only buckets and search. I am designing a long-lived truth engine.

Key defense points:

### State claims require evidence

Stored, Discoverable, Retained, Deleted, and Recoverable are not labels. They are claims backed by receipts.

### Tokenized truth

Use:

- `objectId`,
- `pathId`,
- `versionId`,
- `writeReceiptId`,
- `indexReceiptId`,
- `legalHoldId`,
- `retentionHoldId`,
- `deleteReceiptId`,
- `restoreReceiptId`.

### Stored is not Discoverable

Write time and index time are different. A file can be safely stored but not yet searchable.

### Deleted is not always Unrecoverable

Soft delete, hard delete, retention expiry, lifecycle delete, and key destruction have different semantics.

### Recoverable must be demonstrated

Replication is not restore proof. Backups are not recoverability. `restoreReceiptId` proves restore worked.

### Integrity is a proof chain

Content hash, `versionId`, key ID, key lineage, policy pin, write receipt, scrub receipt, serve-path verification, and restore receipt must be replayable.

### Metadata is authority

Source bytes prove content. Source metadata proves meaning and policy. Search indexes and AI derivatives are rebuildable convenience layers.

### AI derivatives are non-authoritative

OCR, embeddings, summaries, thumbnails, and search indexes must be rebuildable from pinned source versions and model/extractor versions.

### Lifecycle and deletion require stop authority

If legal hold, retention, policy, receipt coverage, key lineage, or restore proof is unclear, freeze destructive actions.

### Replay is the final test

The platform must prove years later why an object was written, indexed, held, retained, deleted, restored, served, or derived under the policy and evidence that existed at the time.

Senior interview line:

> I would not frame file storage as upload to object storage, replicate, index, and lifecycle delete. I would frame it as preserving truth over time. I treat the preserved unit as a versioned object, separate stored from discoverable, bind integrity proof to version and key lineage, govern metadata as authority, keep AI derivatives rebuildable, treat lifecycle and deletion as liability actions, and emit replay cards so the platform can prove years later why this object was stored, held, deleted, restored, or derived.
