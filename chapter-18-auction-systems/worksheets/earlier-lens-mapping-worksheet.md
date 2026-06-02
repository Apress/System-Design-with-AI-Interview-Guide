# Earlier-Lens Mapping Worksheet: Auction Systems

This worksheet helps you apply the earlier lenses from Part I and Part II to Chapter 18: Auction Systems.

The purpose is not to memorize a “design eBay auction” answer. The purpose is to prove that you can reuse the same system design method when time, fairness, money, and adversarial incentives collide at the close boundary.

Use this worksheet before drawing the final architecture. A senior answer should show that you understand bid intent, close liability, admissible time, price formation, fraud pressure, settlement side effects, stop authority, ROCS loops, failure modes, economics, and replay requirements.

---

## 1. 7-Step Method Mapping

| Step | Auction Application | Senior Architect Framing | Reader Notes |
|---|---|---|---|
| 1. Clarify the problem | Are we designing English auction, proxy bidding, reserve auction, hard close, soft close, settlement, or full auction lifecycle? | “I need to know which close rule governs liability.” |  |
| 2. Identify actors | Bidder, seller, marketplace, fraud/risk, policy owner, payment provider, fulfillment, dispute/support. | “The auction affects more than bidders. Settlement, fraud, and disputes are part of the system.” |  |
| 3. Map the journey | Create auction, accept bids, approach close, commit winner, settle, fulfill, dispute/refund. | “Each stage carries a different trust expectation.” |  |
| 4. Define constraints | Late bids, clock skew, bid storms, proxy rules, reserve, fraud pressure, settlement failures. | “Close happens while incentives actively attack the boundary.” |  |
| 5. Name commitments | `bidId`, `closeCommitId`, `allocationId`, `settlementIntentId`, `settlementEffectId`, `compensationId`. | “Bid is intent. Close is liability. Settlement is side effect.” |  |
| 6. Choose architecture | Bid ledger, close authority, policy engine, fraud scoring, replay, settlement idempotency, stop authority. | “I draw the close boundary before drawing services.” |  |
| 7. Defend trade-offs | Hard close vs soft close, fairness vs load, speed vs proof, automation vs review, settlement vs reversibility. | “A fast winner is worse than an indefensible winner.” |  |

---

## 2. Customer Journey Mapping

| Journey Moment | Participant Believes | Platform Risk | Architecture Response |
|---|---|---|---|
| Seller creates auction | Rules are fixed. | Rules drift later. | Pin auction policy bundle. |
| Bidder places bid | Bid may count. | Bid received may not be admissible. | Append-only bid ledger with timestamps. |
| Auction approaches close | Fairness depends on time. | Clock skew, ingestion lag, sniping, bid storms. | Server-controlled close policy and late window. |
| Auction closes | Winner and price are final. | Two realities if close is not singular. | Mint exactly one `closeCommitId`. |
| Winner announced | Platform owes explanation. | Dispute if price/winner unclear. | Close replay receipt. |
| Settlement starts | Money may move. | Duplicate capture or ambiguous payment. | `settlementIntentId` and `settlementEffectId`. |
| Fulfillment starts | Asset or item moves. | Allocation or transfer fails. | Allocation and fulfillment receipts. |
| Dispute begins | Platform must prove outcome. | Missing replay becomes liability. | Replay bundle with policy/evidence. |

---

## 3. Capability Map

| Capability | Responsibility | Commitment Boundary | Owner |
|---|---|---|---|
| Auction Creation | Define listing and rules. | Auction policy pinned. | Seller/marketplace owner |
| Bid Acceptance | Record bid intent. | `bidId`. | Bidding owner |
| Bid Ledger | Preserve append-only history. | Source of bid evidence. | Data/platform owner |
| Policy Engine | Enforce close, increment, reserve, tie-breaker rules. | Pinned policy version. | Policy owner |
| Close Engine | Commit winner and price. | `closeCommitId`. | Auction close owner |
| Fraud/Risk | Detect manipulation pressure. | Freeze/review authority. | Risk owner |
| Replay/Audit | Prove outcome. | Close replay receipt. | Governance owner |
| Settlement | Prepare and move money. | `settlementIntentId`, `settlementEffectId`. | Payments owner |
| Allocation/Fulfillment | Reserve and deliver item/asset. | `allocationId`, `fulfillmentId`. | Fulfillment owner |
| Dispute/Compensation | Correct or compensate. | `compensationId`. | Support/policy owner |

---

## 4. ARCHVIEW Mapping

| ARCHVIEW Concern | Auction View |
|---|---|
| Actors | Bidder, seller, marketplace, fraud, payment, fulfillment, dispute, policy owner. |
| Responsibilities | Auction creation, bid acceptance, close, settlement, fulfillment, dispute, replay. |
| Control surfaces | Close policy, admissible time, fraud pressure, stop authority, settlement idempotency. |
| Commitment points | `bidId`, `closeCommitId`, `allocationId`, `settlementIntentId`, `settlementEffectId`. |
| Ownership | Close owner, policy owner, fraud owner, settlement owner, replay owner. |
| Evidence | Bid ledger, timestamps, close policy, proxy/increment/reserve rules, fraud signals. |
| Degradation | Extend, delay, freeze, route to review, pause settlement, compensate. |
| Stop authority | Freeze close, pause settlement, quarantine bidders, simulate replay. |

---

## 5. AI Primitives Mapping

| AI Primitive | Auction Application | Artifact |
|---|---|---|
| Authority | Who can close, freeze, settle, replay, or compensate? | Stop-authority policy |
| Commitment | Bid intent becomes close liability. | Token chain schemas |
| Time | Event time, ingestion time, close time, late window, hard cutoff. | Admissible-time policy |
| Degradation | Delay close, extend, freeze, review, pause settlement. | Degradation ladder |
| Evidence/Replay | Prove why bidder won at price. | Close replay receipt |
| Ownership | Every close, fraud, settlement, and replay path needs an owner. | Ownership map |

---

## 6. ROCS Mapping

| ROCS Dimension | Auction Pressure | Control |
|---|---|---|
| Reliability | One auction must produce one committed outcome. | Single close authority, unique `closeCommitId`. |
| Observability | Winner and price must be replayable. | Replay receipts and policy pins. |
| Cost | Fraud review, disputes, retries, compensation, settlement errors. | Budgets, stop authority, idempotency. |
| Sustainability | Trust must survive adversarial behavior and close pressure. | Fraud containment and conservative posture. |

---

## 7. Scale Mapping

| Scale Pressure | Auction Failure Shape | Control |
|---|---|---|
| Hot listing | Bid storm near close. | Close partitioning, write buffering, backpressure. |
| Soft-close storm | Repeated extensions. | Extension caps and quiet-window policy. |
| Fraud burst | Low-confidence late bids. | Step-up verification and freeze. |
| Fanout pressure | Many watchers need updates. | Fanout queues and read models. |
| Settlement burst | Many closes trigger payment. | Settlement queue and idempotency. |

---

## 8. Consistency Mapping

| Boundary | Trust Rule | Artifact |
|---|---|---|
| Bid received | Bid exists as intent. | `bidId` |
| Bid admissible | Bid counts under close policy. | Admissibility decision |
| Auction ended | Timer or window ended. | Close policy state |
| Winner committed | Platform owns outcome. | `closeCommitId` |
| Item allocated | Asset reserved for winner. | `allocationId` |
| Settlement executed | Money movement attempted. | `settlementEffectId` |
| Compensation applied | Correction path executed. | `compensationId` |

---

## 9. Latency Mapping

| Latency Type | Auction Meaning | Control |
|---|---|---|
| Bid ingestion latency | May decide whether bid counts. | Admissible-time policy. |
| Close computation latency | May create ambiguity. | Single close authority and commit constraint. |
| Clock skew | May distort fairness. | Server time and skew budget. |
| Fanout latency | Watchers see stale leader. | UI must distinguish visible leader from committed winner. |
| Settlement latency | Money movement may be ambiguous. | Idempotency and replay. |

---

## 10. Failure Mapping

| Failure Signal | What It Looks Like | Response |
|---|---|---|
| Close mismatch | Two winners or prices. | Freeze close and settlement. |
| Replay gap | Cannot prove winner or price. | Stop close/settlement. |
| Late-bid ambiguity | Bid exists but timing unclear. | Apply pinned admissible-time policy. |
| Fraud pressure spike | Manipulation likely. | Quarantine/freeze/review. |
| Settlement duplicate | Payment captured twice. | Idempotency and compensation. |

---

## 11. Economics Mapping

| Economic Multiplier | Auction Example | Control |
|---|---|---|
| Disputes | Winner or price challenged. | Replay receipts. |
| Fraud review | Manipulation investigation. | Fraud-pressure scoring and thresholds. |
| Settlement retry | Payment ambiguity. | Idempotency and bounded retries. |
| Compensation | Wrong close or failed fulfillment. | Compensation policy. |
| Extension storms | Soft close keeps extending. | Extension caps and budgets. |

## Final Senior Line

> An auction system is not a highest-bid feature. It is an adversarial marketplace commitment engine. The senior design separates bid intent from close liability, defines admissible time under server-controlled policy, makes proxy bidding and reserve price replayable, connects fraud pressure to close and settlement authority, treats settlement as an idempotent side effect, and emits replay receipts so the platform can defend why this bidder won at this price.
