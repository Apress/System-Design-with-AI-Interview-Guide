# Chapter 17 Solution Guide

## Exercise 1 Solution: Messaging as a Commitment Engine

A strong answer should explain that messaging is not merely a way to make calls asynchronous. Messaging is a commitment system that carries intent across unreliable boundaries until a consumer performs a side effect.

A producer does not simply “send a message.” It records intent. The broker does not create business truth. It transports the event. The consumer does not merely “process.” It decides whether the system is allowed to act. The side-effect system changes reality. That side effect may be payment capture, entitlement grant, inventory reservation, email send, account update, compliance notification, or warehouse release.

The side-effect boundary is where liability begins. Everything before that boundary can be retried, enriched, validated, delayed, reordered, or replayed. Everything after that boundary must be idempotent, replayable, and stoppable.

“Message processed” is not enough because a message can be processed while the side effect fails, repeats, arrives late, or becomes impossible to prove. “Delivered” is infrastructure. “Safely applied” is architecture.

Actors involved include:

- Producer
- Broker
- Consumer
- Schema owner
- Policy owner
- DLQ owner
- Replay operator
- Side-effect system
- Business capability owner
- Support/audit/compliance stakeholder

Before an irreversible side effect is executed, the system should know:

- What event arrived
- Which business transaction it belongs to
- Which side effect is being attempted
- Whether the side effect already happened
- Which schema version governs the event
- Which policy version governs the decision
- Whether the retry is still safe
- Whether ordering rules are satisfied
- Whether replay coverage is available
- Who owns stop authority

Months later, the system should be able to replay:

- `eventId`
- `businessTxnId`
- `effectId`
- schema version
- policy version
- consumer version
- evidence snapshot
- external/tool calls
- idempotency status
- outcome
- no-op receipt if duplicate
- reversal or compensation path

Senior answer:

> I am not designing async plumbing. I am designing a side-effect commitment engine. The broker moves intent, but the architecture must prove when intent became reality and why that side effect was allowed.

---

## Exercise 2 Solution: eventId vs. businessTxnId vs. effectId

A mature messaging design separates three identities.

`eventId` identifies the message or event. It answers: **What arrived?**

Example:

```text
eventId = EV-9012
```

`businessTxnId` identifies the business story. It answers: **Which business outcome is this part of?**

Example:

```text
businessTxnId = ORDER-771204
```

`effectId` identifies the specific side effect. It answers: **What irreversible action are we about to own?**

Example:

```text
effectId = payment.authorize(ORDER-771204, attempt=1)
effectId = email.send(RECEIPT, ORDER-771204)
effectId = inventory.reserve(ORDER-771204, sku=ABC, qty=1)
```

Idempotency belongs to the side effect, not merely the event, because one event can legitimately trigger multiple effects. An `OrderCreated` event may authorize payment, reserve inventory, send email, update search, emit analytics, and notify support. Dedupe at only the event level can hide the fact that one side effect repeated while another did not run.

Duplicate delivery should behave like this:

1. Consumer receives event.
2. Consumer computes deterministic `effectId`.
3. Consumer checks durable idempotency store.
4. If `effectId` is already `COMMITTED`, skip the external call.
5. Emit a `NO_OP` receipt explaining that the effect already existed.
6. If no record exists, create `IN_PROGRESS`, execute effect, then mark `COMMITTED`.

A duplicate should not be dramatic. It should be boring, detectable, and provable.

No-op receipt fields:

- correlationId
- eventId
- businessTxnId
- effectId
- prior committed timestamp
- current duplicate attempt timestamp
- consumer version
- schema version
- policy version
- reason code: `EFFECT_ALREADY_COMMITTED`
- outcome: `NO_OP`

Senior answer:

> `eventId` proves what arrived. `businessTxnId` proves the business story. `effectId` proves the side effect. Idempotency must be enforced at `effectId`, because side effects are where reality changes.

---

## Exercise 3 Solution: Idempotency Store Design

Broker delivery semantics are not enough because the broker can redeliver after a consumer crash, timeout, rebalance, lost acknowledgment, or replay. Even “exactly once” within a broker boundary does not make an external payment provider, email gateway, entitlement system, or warehouse API exactly-once.

Redis alone is not enough for irreversible side effects because Redis is usually optimized for speed and short-lived dedupe windows. It can be an accelerator, but for money, entitlements, compliance, or customer-visible irreversible effects, the proof must survive restarts, replay, disputes, and audits.

A durable table should be canonical.

Example DDL concept:

```sql
CREATE TABLE processed_effects (
    effect_id              VARCHAR(300) PRIMARY KEY,
    business_txn_id        VARCHAR(200) NOT NULL,
    event_id               VARCHAR(200) NOT NULL,
    capability             VARCHAR(100) NOT NULL,
    status                 VARCHAR(30) NOT NULL,
    schema_version         VARCHAR(100) NOT NULL,
    policy_version         VARCHAR(100) NOT NULL,
    consumer_version       VARCHAR(100) NOT NULL,
    evidence_snapshot_id   VARCHAR(200),
    external_call_id       VARCHAR(200),
    outcome_code           VARCHAR(100),
    error_class            VARCHAR(100),
    replay_card_id         VARCHAR(200),
    first_seen_at          TIMESTAMP NOT NULL,
    last_attempt_at        TIMESTAMP NOT NULL,
    committed_at           TIMESTAMP,
    expires_at             TIMESTAMP
);
```

State behavior:

- `IN_PROGRESS`: the consumer has claimed the side effect attempt.
- `COMMITTED`: the side effect was applied and should not be repeated.
- `FAILED`: the side effect failed safely or was not applied.
- `NO_OP`: duplicate attempt detected; no external side effect performed.
- `UNKNOWN`: only allowed temporarily and must reconcile before retrying irreversible actions.

For money movement, entitlements, and compliance, retention should be long enough to cover disputes, audits, replays, and business policy. Common posture: 30–90 days or longer depending on domain. For reversible user-visible effects, shorter retention may be acceptable. For rebuildable effects, cache-backed dedupe may be acceptable if source facts can regenerate state.

When replay sees an already committed effect, it should not call the provider again. It should emit a no-op replay receipt.

Decision Replay Card should include:

- correlationId / chainId
- eventId
- businessTxnId
- effectId
- capability
- acting principal and mode
- schema version
- policy version
- consumer version
- evidence snapshot
- idempotency status
- external call details
- outcome
- reversal or compensation path

Senior answer:

> Broker semantics help delivery. Durable `effectId` idempotency protects reality.

---

## Exercise 4 Solution: Streams vs. Queues

Using Kafka for everything can work for some systems, but the design is incomplete if the team does not separate what the infrastructure is promising.

Streams are best at remembering. They preserve facts, support replay, enable audit, retain ordered history within partitions, and allow new consumers to rebuild projections.

Queues are best at moving work. They distribute tasks to workers, absorb bursts, isolate backpressure, and support competing consumers.

The short version:

```text
Streams remember.
Queues execute.
```

If a stream is used as the only work queue, teams often reinvent:

- concurrency control,
- task leasing,
- visibility timeouts,
- aggressive backpressure,
- retry isolation,
- per-task TTLs,
- poison-message handling,
- worker-oriented scheduling.

If a queue is used as the system of record, the team may lose:

- durable event history,
- auditability,
- replay,
- ability to rebuild projections,
- ability to prove what the platform believed at a prior time.

A hybrid architecture is often safer:

1. Producer writes business fact to outbox.
2. Relay publishes to stream/event log.
3. Materializer or worker dispatcher creates derived work.
4. Work queue distributes tasks.
5. Consumer performs side effect through idempotency gate.
6. Replay uses stream history but does not automatically execute side effects.

Replay must not accidentally become re-execution. The replay path should have declared modes:

- `simulate`: evaluate what would happen, no side effects.
- `execute`: perform side effects only with approval, idempotency proof, and receipt.

Senior answer:

> Kafka may be part of the design, but the design promise is not “Kafka for everything.” The stream preserves facts; the queue distributes work; the idempotency gate protects side effects.

---

## Exercise 5 Solution: Retry Budget and DLQ Replay

Retries become recursion when they have no count budget and no time budget. A system that keeps retrying may look resilient while repeatedly trying to apply old intent to new reality.

A safer retry policy has two budgets:

- **Count budget:** how many attempts are allowed.
- **Time budget:** how long the intent remains safe to act on.

Retry safety depends on whether the side effect is idempotent and whether the evidence is still admissible. A payment capture, refund, entitlement grant, or compliance notification should not be retried blindly.

Automatic retries are reasonable when:

- failure is transient,
- side effect is idempotent,
- retry budget remains,
- evidence is still fresh,
- schema/policy versions are compatible,
- external provider did not return ambiguous success.

Route to DLQ when:

- retry count is exhausted,
- retry time budget is exhausted,
- schema mismatch occurs,
- poison message is detected,
- side effect is non-idempotent,
- external state is ambiguous,
- policy/evidence is no longer valid.

DLQ message should carry:

- original event payload
- eventId
- businessTxnId
- intended effectId
- schema version
- policy version
- consumer version
- failure class
- retry count
- first failure timestamp
- last attempt timestamp
- evidence snapshot
- replay eligibility
- allowed replay mode
- owner

DLQ replay should support:

```text
simulate
execute
```

`simulate` mode runs validation, schema compatibility, policy checks, idempotency checks, and produces a preview receipt without executing the side effect.

`execute` mode should require explicit approval, fresh policy, idempotency proof, and a replay receipt.

Senior answer:

> DLQ is not a garbage bin. It is a controlled replay lane. Replay must be simulated first and executed only with explicit approval and proof.

---

## Bonus Exercise 6 Solution: Ordering Scope

A senior answer should reject global ordering as the default goal. Ordering is a business promise scoped to the entity that needs sequence.

Ordering examples:

| Business Entity | Ordering Needed? | Scope |
|---|---|---|
| Conversation thread | Yes | Per thread |
| Order | Yes | Per order |
| Account balance | Yes | Per account |
| Notification fanout | Usually no global order | Per user cap/dedupe |
| Analytics events | Usually no strict order | Event-time windows |

For a conversation thread, messages, edits, deletes, and read receipts must be sequenced per thread.

For an order, create, modify, cancel, reserve, ship, and refund must not apply in contradictory order.

For an account balance, money movement must preserve causal order.

For notification fanout, global ordering is less important than idempotency, rate limits, and dedupe.

For analytics, late events can be handled with event-time windows, watermarks, correction paths, and reprocessing.

Implementation controls:

- partition by business key,
- sequence number per entity,
- version checks,
- compare-and-swap updates,
- out-of-order buffer,
- late-event policy,
- replay card showing ordering decision.

Late or out-of-order events should not be blindly applied. They should be checked against current entity state and sequence expectations. If unsafe, route to DLQ, simulate replay, or create compensation.

Senior answer:

> Ordering is not a global virtue. It is a scoped business promise. Pay for order only where the business outcome depends on sequence.

---

## Bonus Exercise 7 Solution: Decision Replay Card for Messaging

A strong replay card is not a log dump. It is a compact proof object.

Example: payment capture replay card.

```json
{
  "correlationId": "corr-123",
  "chainId": "chain-order-771204",
  "eventId": "EV-9012",
  "businessTxnId": "ORDER-771204",
  "effectId": "payment.capture(ORDER-771204,attempt=1)",
  "capability": "payment_capture",
  "actingPrincipal": {
    "type": "workflow",
    "name": "payment-consumer",
    "mode": "autonomous"
  },
  "versions": {
    "schemaVersion": "order-created.v3",
    "policyVersion": "payment-policy-2026-05",
    "consumerVersion": "payment-consumer.2.8.1",
    "featureFlagVersion": "payment-flags.17"
  },
  "evidenceSnapshot": {
    "orderState": "AUTHORIZED",
    "amount": "129.99",
    "currency": "USD",
    "freshnessAgeSeconds": 4,
    "riskDecision": "PASS"
  },
  "externalCalls": [
    {
      "system": "payment-provider",
      "operation": "capture",
      "status": "success",
      "providerTraceId": "pp-555",
      "latencyClass": "normal"
    }
  ],
  "idempotency": {
    "statusBefore": "IN_PROGRESS",
    "statusAfter": "COMMITTED"
  },
  "outcome": {
    "status": "CAPTURED",
    "receiptId": "receipt-888"
  },
  "reversalOrCompensationPath": "payment-reversal-policy-v2"
}
```

Replay card must answer:

- What arrived?
- What business story did it belong to?
- What side effect was attempted?
- Who or what acted?
- Which schema and policy governed it?
- What evidence existed?
- Which external call was made?
- What happened?
- How can the effect be reversed or compensated?

Senior answer:

> Logs tell us what software did. Replay cards prove what the system was allowed to do.

---

## Bonus Exercise 8 Solution: Stop Authority for Messaging Side Effects

A senior answer should say: you do not stop Kafka; you stop the risky side effect.

Capability-scoped stop authority reduces blast radius. The system may freeze payment capture while allowing analytics, indexing, or email to continue.

Stop authority actions:

| Signal | Control Action |
|---|---|
| Replay coverage < 100% for high-risk capability | Freeze side effects for that capability |
| Idempotency store unavailable | Hard stop irreversible side effects |
| DLQ rate spikes | Degrade, triage, simulate-only replay |
| Schema mismatch spikes | Quarantine producer/consumer version |
| Consumer lag + timeout straddling | Reduce concurrency and freeze irreversible effects |
| Operator requests replay | Simulate first, execute only with approval |

Owners:

- capability owner,
- side-effect owner,
- schema owner,
- DLQ owner,
- replay operator,
- platform on-call,
- risk/compliance owner for high-risk effects.

Stop receipt should include:

- signal
- threshold crossed
- affected capability
- affected effect class
- action taken
- scope
- owner
- policy version
- timestamp
- replay status
- re-enable criteria

Re-enable criteria:

- replay coverage restored,
- idempotency store healthy,
- DLQ rate back to baseline,
- schema compatibility restored,
- consumer lag stable,
- ambiguous side effects reconciled,
- owner approval recorded.

Senior answer:

> Stop authority is not shutting down the broker. It is freezing the side effect whose proof boundary is unsafe.

---

## Bonus Exercise 9 Solution: Consumer Lag Looked Like Performance Until Money Doubled

This was not simply a Kafka problem. Kafka redelivery exposed an architecture weakness: the payment side effect did not have durable effect-level idempotency.

Lag is a performance signal. It tells you work is backing up. It does not prove correctness. Scaling consumers may improve throughput while multiplying unsafe side effects.

At-least-once delivery became at-least-twice money because:

1. Payment provider accepted authorization.
2. Consumer restarted before durable idempotency commit.
3. Broker redelivered the message.
4. Consumer recomputed or reused weak identity.
5. Provider accepted another request.
6. No durable `effectId` record stopped the duplicate.

Scaling consumers made it worse because it increased the rate at which unsafe side effects crossed the boundary.

Stop authority should have fired when:

- consumer lag overlapped with payment timeouts,
- idempotency proof was incomplete,
- replay coverage was incomplete,
- provider success could not be reconciled,
- duplicate payment risk rose.

Immediate response:

- freeze payment side effects,
- reduce concurrency,
- reconcile provider traces,
- backfill idempotency records where possible,
- replay in simulate mode,
- execute only with approval and receipts.

Structural fix:

- deterministic effectId,
- durable `processed_effects` table,
- `IN_PROGRESS` before provider call,
- `COMMITTED` after provider success,
- no-op receipt on duplicate,
- replay card for every capture/authorization,
- stop authority for missing idempotency proof.

Senior answer:

> The broker did what at-least-once systems do. The failure was that money movement crossed the side-effect boundary without durable proof.

---

## Bonus Exercise 10 Solution: Senior Architect Messaging Defense

A mature answer should acknowledge that Kafka, partitions, consumer groups, retries, and DLQs are useful, but incomplete.

A senior answer starts here:

> I am not designing async plumbing. I am designing a side-effect commitment engine.

Key defense points:

### Side-effect boundary

The important boundary is not producer → broker → consumer. It is consumer → side-effect system. That is where liability begins.

### Identity chain

Separate:

- `eventId`: what arrived
- `businessTxnId`: what business story it belongs to
- `effectId`: what side effect is owned

### Idempotency

Idempotency belongs to the side effect. Durable idempotency is required for irreversible effects.

### Streams and queues

Streams remember facts. Queues execute work. Hybrid architectures often make replay and backpressure safer.

### Ordering

Ordering is scoped by business entity: order, account, conversation, claim, user—not global.

### Retries

Retries need count and time budgets. Late retries can apply old intent to new reality.

### DLQ replay

DLQ replay must be simulate-first. Execute mode requires approval, idempotency proof, and receipt.

### Stop authority

If replay coverage is missing, idempotency store is unavailable, schema mismatch spikes, or lag overlaps with timeout straddling, freeze the affected side effect.

### Replay evidence

Every consequential side effect should produce a replay card with identity, versions, evidence, calls, outcome, and compensation path.

Senior interview line:

> I would not frame messaging as Kafka topics and consumers. I would frame it as a side-effect commitment engine. I draw the side-effect boundary in ink, mint effectIds for irreversible actions, enforce durable idempotency, scope ordering to business entities, bound retries by count and time, make DLQ replay simulate-first, and emit replay cards so the system can prove why a side effect happened under a pinned schema, policy, event, and evidence snapshot.
