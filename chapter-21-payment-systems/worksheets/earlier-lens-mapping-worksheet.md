# Earlier-Lens Mapping Worksheet: Payment Systems

This worksheet applies the book method to payment systems: 7-Step Method, customer journey, capability map, ARCHVIEW, AI primitives, ROCS, scale, consistency, latency, failure, and economics.

## 1. 7-Step Method Mapping

| Step | Payment Application | Senior Architect Framing |
|---|---|---|
| Clarify | Authorization, capture, refund, refund denial, payout hold, dispute, full lifecycle. | Which liability action is allowed? |
| Identify actors | Customer, merchant, processor, acquirer, issuer, network, fraud, ledger, finance, support. | Payments involve more actors than customer and merchant. |
| Map journey | Intent, authorization, capture, ledger, settlement, refund, dispute, reconciliation. | The journey does not end when provider responds. |
| Constraints | Timeout, duplicate delivery, settlement delay, chargeback, replay gap. | The system acts before all truth arrives. |
| Commitments | paymentIntentId, authId, effectId, captureId, refundId, payoutHoldId. | Authorization is permission; capture is liability. |
| Architecture | Gateway, durable idempotency, ledger, reconciliation, DLQ, replay, stop authority. | Draw side-effect boundary before provider calls. |
| Trade-offs | Speed vs proof, retry vs duplicate, availability vs correctness. | Fast duplicate charge is worse than pending honest answer. |

## 2. Customer Journey Mapping

| Moment | Belief | Risk | Response |
|---|---|---|---|
| Order placed | Payment attempted. | Intent confused with money. | Mint paymentIntentId. |
| Authorization succeeds | Payment approved. | Approval treated as capture. | Preserve authId only. |
| Capture attempted | Money may move. | Timeout ambiguity. | Compute effectId; write IN_PROGRESS. |
| Capture times out | Payment failed. | First capture may have succeeded. | Park pending reconcile. |
| Ledger updated | Platform owns claim. | Mismatch later. | Preserve pre/post state. |
| Settlement arrives | External truth confirms/conflicts. | Original truth overwritten. | Reconcile and adjust. |
| Dispute arrives | Past decision challenged. | Evidence missing. | Replay card and evidence pack. |

## 3. Capability Map

| Capability | Responsibility | Boundary | Owner |
|---|---|---|---|
| Intent | Create intent to pay. | paymentIntentId | Checkout/payment |
| Authorization | Permission to try. | authId | Processor owner |
| Side-effect identity | Name exact money-changing action. | effectId | Payment platform |
| Capture | Move funds / claim capture. | captureId | Payment liability |
| Refund | Return funds. | refundId | Refund owner |
| Refund denial | Deny customer refund request. | refundDenyId | Policy/support |
| Payout hold | Hold seller funds. | payoutHoldId | Risk/merchant |
| Ledger | Courtroom memory. | ledgerEntryId | Finance platform |
| Reconciliation | Confirm/correct delayed truth. | recon result | Finance/recon |
| Replay/Audit | Prove what happened. | replay card | Governance |
| Stop Authority | Freeze unsafe action. | stop event | Payment ops |

## 4. ARCHVIEW Mapping

Actors: customer, merchant, processor, acquirer, issuer, network, fraud, ledger, finance, reconciliation, support, and dispute ops. Responsibilities: intent, authorization, capture, refund, denial, payout hold, ledger, reconciliation, DLQ, dispute, replay. Control surfaces: side-effect boundary, effectId, idempotency store, retry budget, DLQ replay, stop authority.

## 5. AI Primitives Mapping

| Primitive | Payment Application | Artifact |
|---|---|---|
| Authority | What can platform capture, refund, deny, hold, or dispute? | Liability action policy |
| Commitment | Attempt becomes liability at side-effect boundary. | Token chain schemas |
| Time | Processor, ledger, settlement, dispute clocks differ. | Time-lane policy |
| Degradation | Park ambiguity before retrying. | Ambiguity policy |
| Evidence/Replay | Prove why money moved or not. | Payment Replay Card |
| Ownership | Each liability action needs stop owner. | Stop matrix |

## 6. ROCS Mapping

Reliability: durable idempotency, scoped ordering, ambiguity parking. Observability: replay cards, provider refs, ledger state. Cost: retry budgets, DLQ quarantine, scoped freezes. Sustainability: trust through false-enforcement limits, stop authority, and re-enable criteria.

## 7. Scale Mapping

High checkout volume creates retry pressure. Processor slowness creates timeout straddles. Webhook backlog delays external truth. DLQ growth tempts unsafe replay. Duplicate attempt spikes reveal idempotency leaks.

## 8. Consistency Mapping

Intent is not authorization. Authorization is not capture. Capture is not settlement. Settlement is not dispute closure. The design must preserve causal truth per order, payment intent, refund request, and payout batch.

## 9. Latency Mapping

Provider latency, acknowledgment latency, webhook latency, settlement latency, and dispute latency all create different truth gaps. The system should park ambiguity instead of inventing certainty.

## 10. Failure Mapping

Timeout after capture request -> park and reconcile. Duplicate attempt spike -> freeze and audit effectId. Ledger/provider mismatch -> reconcile and adjust. Replay gap -> freeze affected action. Policy/schema mismatch -> quarantine or roll back.

## 11. Economics Mapping

Duplicate captures, refund errors, chargebacks, manual reconciliation, support tickets, and DLQ cleanup are economic multipliers. Control them with effectId, durable idempotency, replay cards, and stop authority.
