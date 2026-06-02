# Chapter 22 Exercises

## Exercise 1: Storage as a Long-Lived Truth Engine

A candidate says, “A file storage system stores files in buckets, replicates them, indexes metadata, and serves them through APIs or a CDN.”

Why is that incomplete?

Your answer should include:

- Why file storage is a truth system, not only a bucket system
- Why **Stored**, **Discoverable**, **Retained**, **Deleted**, and **Recoverable** are claims, not labels
- Why bytes can exist while truth is still indefensible
- Which actors are involved: user, application owner, metadata service, indexer, security, legal, compliance, lifecycle engine, KMS, restore operator, auditor, and platform owner
- What evidence must exist before the platform claims stored, discoverable, deleted, or recoverable
- Why durability must be graded years later, not only at write time
- What must be replayable later

## Exercise 2: Token Chain and Storage State Boundaries

Design the token chain for a file storage system using `objectId`, `pathId`, `versionId`, `writeReceiptId`, `indexReceiptId`, `legalHoldId`, `retentionHoldId`, `deleteReceiptId`, and `restoreReceiptId`.

Your answer should include:

- What each token proves
- Why `objectId` or `pathId` is not enough to prove durable truth
- Why `versionId` identifies the immutable preserved version
- Why `writeReceiptId` is required before claiming **Stored**
- Why `indexReceiptId` is required before claiming **Discoverable**
- Why `legalHoldId` or `retentionHoldId` blocks deletion
- Why `deleteReceiptId` must describe deletion semantics
- Why `restoreReceiptId` is required before claiming **Recoverable**
- What the Storage Decision Replay Card should contain

## Exercise 3: Stored vs. Discoverable

A user uploads a file. The write succeeds and a `versionId` exists, but search and list APIs cannot find the file for several minutes because the index is delayed.

What should the system claim?

Your answer should include:

- Why **Stored** and **Discoverable** are different state claims
- Why asynchronous indexing is acceptable but ambiguity is not
- What freshness budget should exist for index catch-up
- What the UI/API should say while indexing is behind
- Why “upload complete” can be true while “searchable” is not yet true
- What `writeReceiptId` proves
- What `indexReceiptId` proves
- What happens if index drift exceeds budget
- What stop authority or truth-first mode should do

## Exercise 4: Integrity Proof Chain

A team says, “We use checksums and encryption, so our storage integrity is covered.”

Why is that incomplete?

Your answer should include:

- Why integrity is not checksum theater
- Why content hash/checksum must be bound to `versionId`
- Why encryption key ID and key lineage are part of integrity proof
- Why write receipts, scrub receipts, serve-path verification, and restore drill receipts matter
- Why integrity must survive replication, caching, lifecycle movement, key rotation, and restore
- Why a wrong key can be an integrity failure even if bytes exist
- What evidence must be replayable to prove that served bytes match stored truth

## Exercise 5: Lifecycle and Deletion as Liability Actions

A lifecycle policy wants to hard-delete old files. At the same time, a legal hold may apply, receipt coverage is incomplete, and policy versions are mismatched across workers.

Should the system proceed?

Your answer should include:

- Why lifecycle and deletion are liability actions, not cleanup jobs
- Why legal hold and retention checks must outrank cleanup pressure
- Why hard delete requires pinned policy, hold check, approval, lineage, and destruction proof
- Why incomplete replay coverage should freeze hard delete
- Why policy bundle mismatch should quarantine or roll back the affected version
- What the system should do: refuse, defer, escalate, or freeze
- What `deleteReceiptId` must prove
- What re-enable criteria must be satisfied before destructive actions resume

---

# Bonus GitHub Exercises

## Bonus Exercise 6: Storage Clocks and Admissible Reality

Design a storage clocks policy using write time, index time, lifecycle time, legal time, delete time, and restore time.

## Bonus Exercise 7: Metadata Authority and Derived Systems

A file’s bytes exist, but metadata is stale, ACLs are drifting, the search index disagrees with source metadata, and embeddings show an outdated summary.

Which layer is authoritative?

## Bonus Exercise 8: AI Derivatives and Rebuild Contract

A document storage system creates OCR text, embeddings, summaries, thumbnails, and search indexes from uploaded files.

How should the architecture separate source truth from AI derivatives?

## Bonus Exercise 9: Incident Response — Green Dashboards, Missing Truth

A lifecycle policy change goes live. Writes return 200, latency is normal, and dashboards are green. Later, an auditor asks for a file. The bytes may exist, but the platform cannot prove the correct version, policy, receipt, index state, or deletion history.

Analyze the incident.

## Bonus Exercise 10: Senior Architect File Storage Defense

An interviewer says, “File storage is straightforward: upload files to object storage, replicate them, store metadata in a database, index them for search, and use lifecycle policies for archive and delete.”

Defend a more mature design.
