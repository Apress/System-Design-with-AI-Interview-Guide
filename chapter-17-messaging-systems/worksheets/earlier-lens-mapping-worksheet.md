# Earlier-Lens Mapping Worksheet: Messaging Systems

This worksheet helps you apply the earlier lenses from Part I and Part II to Chapter 17: Messaging Systems.

The purpose is not to memorize a “use Kafka” answer. The purpose is to prove that you can reuse the same system design method when intent crosses asynchronous boundaries and becomes side effects.

Use this worksheet before drawing the final architecture. A senior answer should show that you understand producer intent, business transaction identity, side-effect identity, idempotency proof, ordering scope, retry budgets, DLQ replay modes, stop authority, ROCS loops, failure modes, economics, and replay requirements.

---

## 1. 7-Step Method Mapping

| Step | Messaging Application | Senior Architect Framing | Reader Notes |
|---|---|---|---|
| 1. Clarify the problem | Are we moving facts, work, commands, events, side effects, or all of them? | “I need to know what side effect the system is allowed to perform.” |  |
| 2. Identify actors | Producer, broker, consumer, side-effect system, schema owner, DLQ owner, replay operator, capability owner. | “Messaging actors include owners of meaning, not just components.” |  |
| 3. Map the journey | User action → producer intent → outbox → broker → consumer → idempotency gate → side effect → receipt → replay. | “The journey ends only when the side effect is proved.” |  |
| 4. Define constraints | Duplicate delivery, late retries, reordering, schema drift, lost acknowledgments, poison messages, replay risk. | “Messaging fails by staying up while meaning drifts.” |  |
| 5. Name commitments | eventId, businessTxnId, effectId, idempotency record, DLQ mode, replay card. | “eventId is not enough; effectId owns liability.” |  |
| 6. Choose architecture | Outbox, event log, queue, consumer, idempotency store, DLQ, replay service, schema registry, stop authority. | “I draw the side-effect boundary before choosing topics.” |  |
| 7. Defend trade-offs | Stream vs queue, local ordering vs global ordering, retries vs recursion, replay vs re-execution. | “Replay must not become hidden side-effect execution.” |  |

---

## 2. Customer Journey Mapping

| Journey Moment | Business Believes | System Risk | Architecture Response |
|---|---|---|---|
| User acts | Intent has begun. | Intent may be lost if not durably recorded. | Outbox record in same transaction. |
| Event published | Work can move asynchronously. | Publish may happen without durable intent. | Outbox relay. |
| Consumer receives | Side effect may be attempted. | Duplicate delivery or stale evidence. | Compute effectId and check idempotency. |
| Side effect executes | Reality changed. | Duplicate or unsafe execution. | Durable processed_effects record. |
| Failure occurs | System should recover. | Retries become recursion. | Count/time retry budgets. |
| DLQ receives message | Automatic continuation is unsafe. | DLQ becomes graveyard or replay bomb. | Versioned DLQ with simulate/execute modes. |
| Operator replays | Work may be recovered. | Replay re-executes side effects. | Simulate first, execute with approval. |
| Audit/support asks why | System must prove. | Logs are incomplete. | Decision Replay Card. |

---

## 3. Capability Map

| Capability | Responsibility | Commitment Boundary | Owner |
|---|---|---|---|
| Producer | Record business intent. | Outbox commit. | Producing capability owner |
| Outbox | Preserve producer intent. | Durable intent exists. | Producer/platform owner |
| Broker/Event Log | Transport and retain facts. | Delivery boundary, not side-effect boundary. | Messaging platform owner |
| Work Queue | Distribute derived work. | Task execution boundary. | Worker platform owner |
| Consumer | Interpret event and decide action. | Before side-effect boundary. | Consumer owner |
| Idempotency Store | Prove effect already happened. | Side-effect gate. | Capability owner |
| Side-Effect System | Change reality. | Liability begins. | External/system owner |
| DLQ | Hold unsafe/unresolved work. | Automatic processing stops. | DLQ owner |
| Replay Service | Simulate or execute replay. | Replay mode boundary. | Replay operator |
| Schema Registry | Govern compatibility. | Contract boundary. | Schema owner |
| Replay/Audit | Prove decisions. | Decision receipt. | Governance owner |

---

## 4. ARCHVIEW Mapping

| ARCHVIEW Concern | Messaging View |
|---|---|
| Actors | Producer, broker, consumer, side-effect system, DLQ owner, replay operator, schema owner, capability owner. |
| Responsibilities | Intent recording, delivery, consumption, idempotency, side-effect execution, DLQ, replay, audit. |
| Control surfaces | effectId, idempotency store, retry budgets, ordering scope, DLQ replay mode, schema compatibility, stop authority. |
| Commitment points | Outbox commit, broker publish, consumer decision, side-effect execution, receipt emission. |
| Ownership | Producer owner, consumer owner, schema owner, DLQ owner, replay owner, side-effect owner. |
| Evidence | eventId, businessTxnId, effectId, schema version, policy version, evidence snapshot, external calls. |
| Degradation | Retry, DLQ, quarantine, simulate-only replay, freeze side effect. |
| Stop authority | Capability-scoped freeze for risky side effects. |

---

## 5. AI Primitives Mapping

| AI Primitive | Messaging Application | Artifact |
|---|---|---|
| Authority | Who can execute, replay, quarantine, or freeze side effects? | Stop-authority policy |
| Commitment | eventId, businessTxnId, effectId separate arrival, story, and liability. | Identity-chain schema |
| Time | Retries expire; evidence becomes stale. | Retry count/time budget |
| Degradation | Retry, DLQ, simulate-only, quarantine, freeze. | DLQ replay policy |
| Evidence/Replay | Prove why side effect happened. | Decision Replay Card |
| Ownership | Every DLQ and side effect needs an owner. | Capability ownership map |

---

## 6. ROCS Mapping

| ROCS Dimension | Messaging Pressure | Control |
|---|---|---|
| Reliability | Duplicate delivery, reordering, restarts, redelivery. | Idempotency, ordering scope, retry budgets. |
| Observability | Need proof across async hops. | Correlation chain and replay cards. |
| Cost | Retry storms, DLQ triage, reprocessing, duplicate work. | Budgets, caps, simulate-first replay. |
| Sustainability | Trust must survive replay, schema drift, and operator intervention. | Stop authority and re-enable criteria. |

---

## 7. Scale Mapping

| Scale Pressure | Messaging Failure Shape | Control |
|---|---|---|
| High volume | Consumer lag. | Backpressure and scoped concurrency. |
| Hot partition | Entity-level backlog. | Key design and partition strategy. |
| Fanout pressure | Too many derived tasks. | Stream-plus-queue split. |
| Retry storm | Work multiplies without truth. | Count/time budgets. |
| DLQ spike | Automatic processing unsafe. | Triage and simulate-only replay. |

---

## 8. Consistency Mapping

| Boundary | Trust Rule | Artifact |
|---|---|---|
| Producer intent | Intent exists only after durable commit. | Outbox row |
| Event delivery | Delivered does not mean applied. | eventId |
| Business story | Events must connect to one outcome. | businessTxnId |
| Side effect | Reality changes once. | effectId |
| Idempotency | Already happened must be durable. | processed_effects |
| Replay | Re-execution must be controlled. | Replay mode and receipt |

---

## 9. Latency Mapping

| Latency Type | Messaging Meaning | Control |
|---|---|---|
| Broker lag | Work is delayed. | Monitor lag but do not confuse with correctness. |
| Consumer timeout | Side effect may have succeeded externally. | Reconcile before retry. |
| Late retry | Old intent meets new reality. | Time budget and freshness checks. |
| DLQ delay | Unsafe work awaits triage. | Owner and replay mode. |
| Replay latency | Time to prove or recover. | Replay cards and simulate mode. |

---

## 10. Failure Mapping

| Failure Signal | What It Looks Like | Response |
|---|---|---|
| Duplicate delivery | Same event arrives again. | effectId idempotency and no-op receipt. |
| Lost acknowledgment | External effect succeeded, internal ack lost. | Durable idempotency and reconciliation. |
| Poison message | Same message fails repeatedly. | DLQ with failure class. |
| Schema mismatch | Consumer cannot interpret safely. | Quarantine version. |
| Unsafe replay | DLQ re-executes side effects. | Simulate first, execute with approval. |
| Replay gap | Cannot prove side effect. | Freeze high-risk capability. |

---

## 11. Economics Mapping

| Economic Multiplier | Messaging Example | Control |
|---|---|---|
| Retry storms | Same failing event retried repeatedly. | Count/time budget. |
| Duplicate side effects | Double payment, double email, double entitlement. | Durable effectId idempotency. |
| Manual DLQ triage | Operators inspect unclear messages. | Versioned DLQ metadata and runbook. |
| Reprocessing cost | Rebuilds and replays run broadly. | Stream history with safe replay modes. |
| Over-retention | Storing everything without policy. | Retention based on liability. |

## Final Senior Line

> A messaging system is not async plumbing. It is a side-effect commitment engine. The senior design records producer intent, separates eventId, businessTxnId, and effectId, enforces durable idempotency at the side-effect boundary, scopes ordering to business entities, bounds retries by count and time, makes DLQ replay simulate-first, and emits replay cards so the system can prove why a side effect happened under a pinned schema, policy, and evidence snapshot.
