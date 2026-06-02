# Chapter 21 Solution Guide

## Exercise 1 Solution: Payments as a Liability Commitment Engine

A strong answer explains that payments are not merely money movement. They are promises made under uncertainty. The platform is deciding when an attempted action becomes a liability claim that must be defended later. Authorization is permission to try; capture crosses the side-effect boundary where money movement may occur.

A senior design separates intent, authorization, side effect, liability token, ledger truth, settlement truth, dispute truth, and compensation. Actors include customer, merchant, processor, acquirer, card network, issuer, fraud engine, ledger, finance, reconciliation, support, dispute operations, and platform operators.

Before the platform claims captured, refunded, denied, held, or reconciled, it needs payment intent, auth reference, effectId, liability token, policy/schema version, provider references, ledger pre/post state, idempotency state, ambiguity classification, reconciliation result, and replay card.

Senior answer: I am not designing a payment gateway integration. I am designing a liability commitment engine. Authorization is permission to try. Capture, refund, refund denial, and payout hold are liability actions. Each one needs a token, durable idempotency, policy pin, ledger proof, reconciliation path, stop authority, and replay evidence.

## Exercise 2 Solution: Token Chain and Side-Effect Boundary

| Token | Meaning | Liability Role |
|---|---|---|
| paymentIntentId | Customer or merchant intends to pay. | Pre-liability. |
| authId | Processor or issuer gave provisional authorization. | Permission to try. |
| effectId | Exact side effect identity. | Idempotency anchor. |
| captureId | Platform claims capture occurred. | Liability token. |
| refundId | Platform claims refund occurred. | Liability token. |
| refundDenyId | Platform denied refund request. | Customer-trust liability token. |
| payoutHoldId | Platform held seller funds. | Seller-liability token. |
| disputeId | External challenge or chargeback identity. | Delayed-truth linkage. |
| responseId | Platform response to dispute. | Audit/legal response token. |

The effectId belongs to the side effect, not the message. A message can redeliver many times; the side effect must happen once. Durable idempotency is required because money truth must survive restarts, cache eviction, DLQ replay, provider timeouts, and lost acknowledgments.

Payment Decision Replay Card should contain correlation ID, order ID, payment intent, auth ID, effectId, liability token, policy/schema version, evidence snapshot, idempotency state, ledger pre/post state, provider request/response, ambiguity classification, reconciliation result, compensation pointer, and stop-authority state.

## Exercise 3 Solution: Idempotency versus Exactly-Once

Exactly-once messaging does not make an external payment side effect exactly once. Processors, card networks, banks, webhooks, settlement files, and disputes exist outside the broker transaction boundary. Duplicates still happen through retries, restarts, lost acknowledgments, webhook redelivery, DLQ replay, operator replay, and ledger failures after provider success.

Safe flow: compute deterministic effectId, check durable idempotency, return existing result if COMMITTED, do not execute if IN_PROGRESS, write IN_PROGRESS before provider call, execute provider side effect, write COMMITTED with provider reference, liability token, ledger state, and replay receipt. If result is unknown, mark PENDING_RECONCILE.

Redis-only dedupe is unsafe for money truth. Duplicate capture should become a no-op returning the original captureId and provider reference, not a second charge.

## Exercise 4 Solution: Ambiguous Capture Timeout

Timeout after sending capture is ambiguity, not failure. The processor may have captured funds, but the platform lacks proof. Blind retry can duplicate capture.

Correct behavior: keep the same effectId, mark CAPTURE_PENDING_RECONCILE, suppress blind retry, query the processor, wait for webhook, compare settlement files, compare provider truth with ledger state, then commit, fail, or escalate. Customer status should be honest: payment is pending confirmation, not failed.

Replay receipt should include payment intent, auth ID, effectId, attempted timestamp, timeout timestamp, ambiguity class, idempotency state, retry suppression reason, reconciliation references, final provider truth, ledger update, final capture or failure, customer communication, and compensation pointer.

## Exercise 5 Solution: Ledger Truth and Delayed Truth

Payment truth arrives across event time, processor time, ledger time, settlement time, and dispute time. The ledger is courtroom memory because it records what the platform committed at the liability boundary. Settlement and dispute events should not overwrite original truth. They should attach new evidence and drive reconciliation, adjustment, reversal, compensation, or dispute response.

Fields to preserve include event time, processor time, ledger time, settlement time, dispute time, payment intent, auth ID, effectId, liability token, provider reference, ledger entry, settlement file reference, dispute ID, policy/schema version, evidence snapshot, reconciliation result, adjustment entry, compensation pointer, and replay card ID.

## Bonus Exercise 6 Solution: Liability Action Matrix

| Action | Liability Level | Tokens | effectId | Retry Budget | Stop Posture |
|---|---|---|---|---|---|
| Authorize | Low, reversible, expires | paymentIntentId, authId | authorize(paymentIntentId, attempt) | 3 attempts / 2 min | alternate payment, defer |
| Capture | High money movement | paymentIntentId, authId, captureId | capture(orderId, amount, currency) | 2 attempts then park | freeze capture, pending capture |
| Void | Medium, time-sensitive | authId, voidId | void(authId) | within auth window | review on conflict |
| Refund | High money movement | captureId, refundId | refund(captureId, amount) | 2 attempts then case | freeze refunds |
| Refund denial | High customer-trust | refundRequestId, refundDenyId | denyRefund(refundRequestId) | no looping | step-up, review, freeze denials |
| Payout hold | High seller-liability | payoutId, payoutHoldId | holdPayout(payoutId, reason) | immediate then case | freeze holds |
| Chargeback response | Audit/legal | disputeId, responseId | respondToChargeback(disputeId) | SLA window | human review |

Each action needs its own operational contract because risk, reversibility, evidence, retry safety, and stop posture differ.

## Bonus Exercise 7 Solution: Scoped Ordering

Payments rarely need global ordering. They need causal ordering per orderId, paymentIntentId, refundRequestId, and sometimes merchantId or payout batch. Scoped ordering reduces latency, cost, and availability risk while preserving business truth. Analytics and reporting usually tolerate late correction through windows and adjustments.

## Bonus Exercise 8 Solution: DLQ Replay and Controlled Recovery

DLQ is a quarantine lane, not a hidden retry path. Replay must support simulate mode before execute mode. It must pin original schema version, original policy version, current policy version, original effectId, evidence snapshot, provider references, and ledger state. Execute mode requires approvals, idempotency checks, and replay receipts. Outcomes include NO_OP_ALREADY_COMMITTED, PARKED_PENDING_RECONCILE, EXECUTED_COMMITTED, REJECTED_POLICY_MISMATCH, COMPENSATED, and HUMAN_REVIEW_REQUIRED.

## Bonus Exercise 9 Solution: Green Dashboards, Duplicate Money

This is a liability correctness incident, not uptime. API success rates can be green while duplicate captures happen. Timeout straddles around capture are dangerous because provider success may occur after the platform times out. Immediate response is to freeze capture for affected cohort, stop blind retries, park ambiguous captures, reduce processor concurrency, audit replay coverage, reconcile provider/ledger/settlement truth, refund duplicates, notify support and finance, and re-enable only after proof is restored.

## Bonus Exercise 10 Solution: Senior Architect Payment Defense

A mature answer starts: I am not designing a gateway integration; I am designing a payment liability commitment engine. Intent, authorization, capture, settlement, refund, refund denial, payout hold, and dispute are distinct states. External side effects need durable idempotency keyed by effectId. Ambiguous outcomes must be parked and reconciled, not blindly retried. The ledger is courtroom memory. Reconciliation is correctness recovery. Stop authority freezes unsafe liability actions. Replay proves why money was captured, refunded, denied, held, parked, reconciled, compensated, or disputed.
