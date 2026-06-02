# Chapter 17 Exercises

## Exercise 1: Messaging as a Commitment Engine

A candidate says, “A messaging system is just a way to make work asynchronous between producers and consumers.”

Why is that incomplete?

Your answer should include:

- Why messaging is a commitment system, not just async plumbing
- The difference between producer intent, broker delivery, consumer processing, and side-effect execution
- Why the side-effect boundary is where liability begins
- Why “message processed” is not the same as “side effect safely applied”
- Which actors are involved: producer, broker, consumer, schema owner, DLQ owner, replay operator, side-effect system, and business capability owner
- What must be true before an irreversible side effect is executed
- What must be replayable months later

## Exercise 2: eventId vs. businessTxnId vs. effectId

Design the identity model for a messaging system using `eventId`, `businessTxnId`, and `effectId`.

Your answer should include:

- What `eventId` proves
- What `businessTxnId` proves
- What `effectId` proves
- Why idempotency belongs to the side effect, not just the event
- Why one event may legitimately create multiple side effects
- How duplicate delivery should behave
- What receipt should be emitted when the effect already exists

## Exercise 3: Idempotency Store Design

A payment authorization event is redelivered after a consumer restart. The payment provider may already have accepted the authorization, but the consumer did not durably record the result before restarting.

Design the idempotency strategy.

Your answer should include:

- Why broker delivery semantics are not enough
- Why Redis alone is not enough for irreversible side effects
- What should be stored in a durable `processed_effects` table
- How `IN_PROGRESS`, `COMMITTED`, `FAILED`, and `NO_OP` states should work
- How long idempotency proof should be retained for money, entitlements, compliance, and reversible effects
- How replay should behave when the effect is already committed
- What the Decision Replay Card should contain

## Exercise 4: Streams vs. Queues

A team says, “We can use Kafka for everything: event history, task execution, retries, replay, and worker distribution.”

Analyze this design.

Your answer should include:

- What streams are best at
- What queues are best at
- Why streams remember and queues execute
- What breaks when a stream is used as the only work queue
- What breaks when a queue is used as the system of record
- Why hybrid stream-plus-queue architecture is often safer
- How to prevent replay from accidentally re-executing side effects

## Exercise 5: Retry Budget and DLQ Replay

A consumer keeps failing on a message. The team increases retries and consumer concurrency to clear lag. Later they discover duplicate side effects and unsafe replay behavior.

Design a safer retry and DLQ policy.

Your answer should include:

- Why retries become recursion without count and time budgets
- Why retry safety depends on whether evidence is still admissible
- When to retry automatically
- When to route to DLQ
- What metadata a DLQ message must carry
- Why DLQ replay must support `simulate` and `execute` modes
- Why execute-mode replay requires explicit approval and a receipt

---

# Bonus GitHub Exercises

## Bonus Exercise 6: Ordering Scope

An interviewer asks, “How do you guarantee ordering in your messaging system?”

Give a senior answer.

## Bonus Exercise 7: Decision Replay Card for Messaging

Create a Decision Replay Card for a consequential messaging side effect such as payment capture, entitlement grant, inventory reservation, compliance email, or account update.

## Bonus Exercise 8: Stop Authority for Messaging Side Effects

Design stop authority for messaging side effects.

## Bonus Exercise 9: Incident Response — Consumer Lag Looked Like Performance Until Money Doubled

A payment system experiences consumer lag. The team scales consumers to clear the backlog. Some consumers restart mid-flight after the payment provider accepted authorization but before the platform durably recorded the side effect. Messages are redelivered and some payments are authorized twice.

Analyze the incident.

## Bonus Exercise 10: Senior Architect Messaging Defense

An interviewer says, “Messaging is straightforward: use Kafka, create topics, add partitions, scale consumer groups, and send failed messages to a DLQ.”

Defend a more mature design.
