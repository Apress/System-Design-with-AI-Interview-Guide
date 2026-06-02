# Chapter 18 Solution Guide

## Exercise 1 Solution: Auction as a Commitment Engine

A strong answer should explain that an auction is not merely a highest-bid feature. It is an adversarial marketplace commitment engine. The system is not only collecting bids. It is deciding, at a specific boundary in time, which bid is admissible, which bidder won, which price is defensible, and which downstream obligations may begin.

The most important boundary is close. Before close, bids are intent. After close, the platform owns an outcome. That outcome may trigger payment capture, escrow, allocation, fulfillment, title transfer, notifications, disputes, refunds, and compensation. That is why close is not a timer. Close is a liability boundary.

“Bid received” is not the same as “bid admissible.” A bid may exist in logs, arrive from a client, or be visible to a bidder, but still be inadmissible if it missed the ingestion window, violated bid increment policy, failed fraud checks, arrived after the hard cutoff, or was submitted by a quarantined bidder.

“Auction ended” is not the same as “winner committed.” The UI may show time expired, but the platform should not declare a winner until the close decision is computed under pinned policy, admissible bids are selected, fraud pressure is evaluated, tie-breakers are applied, and `closeCommitId` is minted.

Actors affected include:

- Bidders
- Seller
- Marketplace operator
- Fraud/risk system
- Policy owner
- Payment/escrow provider
- Fulfillment or title-transfer partner
- Dispute/support team
- Compliance/legal stakeholders

Evidence before declaring a winner should include:

- `auctionId`
- Complete bid ledger snapshot
- Admissible bid set
- Close policy version
- Close rule: hard close or soft close
- Server close time
- Ingestion timestamps
- Late-window and hard-cutoff decisions
- Clock-skew budget state
- Proxy-bidding policy
- Bid-increment table
- Reserve-price rule
- Fraud-pressure score
- Tie-breaker result
- `closeCommitId`
- Close replay receipt

What must be replayable later:

- Which bids were counted
- Which bids were excluded and why
- Which clock governed close
- Which close rule applied
- How the final price was formed
- Whether reserve was met
- Whether fraud pressure existed
- Why this bidder won
- Why this price was declared
- Whether settlement was allowed to proceed

Senior answer:

> I am not designing a leaderboard. I am designing an adversarial marketplace commitment engine. Close creates liability, so I only declare a winner after admissible bids, pinned policy, price-formation rules, fraud pressure, and replay evidence produce one defensible closeCommitId.

---

## Exercise 2 Solution: Commitment Token Chain

A mature auction design should model the auction lifecycle as a chain of commitment tokens.

| Token | What It Proves | Why It Matters |
|---|---|---|
| `auctionId` | The contest identity. | All bids, rules, close, settlement, and disputes attach to one auction. |
| `bidId` | A bid event was recorded in the append-only bid ledger. | A bid can be audited without automatically being admissible. |
| `closeCommitId` | The auction outcome was committed under pinned close rules. | This is the liability boundary for winner and price. |
| `allocationId` | The item, entitlement, or asset was reserved for the winner. | Winning is not the same as allocation. |
| `settlementIntentId` | The platform intends to move money for the committed outcome. | Separates close decision from payment action. |
| `settlementEffectId` | The exact payment/escrow/capture side effect attempted. | Enables durable idempotency and replay. |
| `fulfillmentId` / `transferId` | Delivery, title, asset, or entitlement transfer began or completed. | Completes the obligation chain. |
| `compensationId` | Refund, credit, reversal, second-chance offer, or re-auction path. | Makes correction explicit and replayable. |

`closeCommitId` is the liability boundary because it freezes the auction outcome. After this token exists, the platform should not recompute the winner casually. It may later compensate, cancel, or dispute the outcome under policy, but the original close decision must remain replayable.

Settlement must not begin before close is committed because settlement moves money based on the outcome. If close is ambiguous, settlement multiplies ambiguity into liability.

Allocation is different from winning because a bidder can win an auction while item allocation fails due to inventory mismatch, entitlement error, or asset-transfer failure. The system must preserve the close outcome while executing a compensating flow.

Settlement intent is different from payment execution. `settlementIntentId` says the platform intends to settle this committed auction. `settlementEffectId` says the exact external action was attempted, such as capture payment for auction A, winner W, amount P, attempt 1.

Idempotency belongs to `settlementEffectId`. If payment capture is retried, replayed, or redelivered, the same effect should not charge the winner twice.

Receipts:

- Close replay receipt for `closeCommitId`
- Allocation receipt for `allocationId`
- Settlement receipt for `settlementIntentId` and `settlementEffectId`
- Compensation receipt if settlement or fulfillment fails

Senior answer:

> `bidId` records intent. `closeCommitId` commits the winner and price. `allocationId` reserves the asset. `settlementIntentId` prepares money movement. `settlementEffectId` protects the external side effect. Without this chain, the system only has a story.

---

## Exercise 3 Solution: Hard Close vs. Soft Close

A timer alone is not enough because auction ending rules are marketplace strategy, not UI behavior. The close rule changes incentives, fairness, dispute patterns, load shape, fraud pressure, and settlement risk.

A hard close ends at a fixed time, such as 8:00 PM. It is easier to reason about and easier to replay because the close boundary is crisp. But it invites sniping. Bidders may wait until the last second to prevent others from responding. This can be legitimate market behavior if the marketplace explicitly chooses hard close.

A soft close extends the auction if a bid arrives near the end. For example, if a bid arrives within the last two minutes, the auction extends by two minutes until a full quiet window occurs. This reduces sniping and improves price discovery, but it introduces new risks:

- Extension storms on hot listings
- More close-time load
- Longer uncertainty for bidders and sellers
- More opportunities for manipulation
- More complex replay
- More disputes if extension rules are unclear

The policy pinned before close should include:

- Close type: hard or soft
- Scheduled close time
- Soft-close extension window
- Maximum extension count or maximum total extension duration
- Late-window rule
- Hard cutoff
- Server-time authority
- Clock-skew budget
- Tie-breaker rule
- Proxy-bid rule
- Bid increment table
- Reserve rule
- Fraud-pressure behavior

The system may mint `closeCommitId` only when:

- Close policy is pinned
- Admissible bid window is closed
- Server-controlled close time has passed
- Late window is drained or hard cutoff reached
- No required extension remains
- Fraud pressure is below freeze threshold or reviewed
- Close computation is singular
- Replay receipt can be emitted

Senior answer:

> Hard close and soft close are not timer settings. They are marketplace strategies. The close engine should mint `closeCommitId` only when the pinned ending policy says the admissible window is complete and the outcome can be replayed.

---

## Exercise 4 Solution: Admissible Time and Late Bid

Client event time cannot be the sole authority because clients and networks are unreliable. A bidder’s device clock may be wrong, the request may be delayed, the network may partition, or the client may be manipulated. The platform must define the authoritative time policy before the auction closes.

| Time Concept | Meaning | Auction Rule |
|---|---|---|
| Event time | When the bidder acted or submitted the bid. | Useful for intent, but not sufficient alone. |
| Ingestion time | When the platform received the bid. | Usually governs whether the bid entered the authoritative system before close. |
| Close time | When the system commits the auction result. | Must be server-controlled and tied to `closeCommitId`. |
| Late window | Bounded drain period for in-flight bids. | Accept only if policy allows and bid arrives within the declared window. |
| Hard cutoff | Absolute latest time a bid can be admitted. | Bids after this must be rejected. |
| Clock-skew budget | Allowed uncertainty in time measurement. | If exceeded, close should delay, tighten, or route to review. |

Bid handling:

- Bid A: submitted and ingested before close. Count it if it also passes amount, increment, bidder authority, fraud, and policy checks.
- Bid B: submitted before close and ingested during the declared late window. Count it only if the pinned close policy allows this late-window behavior.
- Bid C: ingested after the hard cutoff. Reject it, even if the bidder claims they clicked in time.

If ingestion lag or clock skew exceeds the budget, the platform should not confidently mint a winner. It should delay close, extend if policy allows, freeze close for review, tighten posture, or route high-value auctions to manual review.

Replay evidence:

- Bid event time
- Bid ingestion time
- Server close time
- Late-window policy
- Hard cutoff
- Clock-skew measurements
- Ingestion-lag metrics
- Bid admissibility decision
- Reason for counting or excluding each bid
- Close policy version
- `closeCommitId`

Senior answer:

> Fairness is not “who clicked first.” Fairness is the declared clock policy the platform can enforce and replay.

---

## Exercise 5 Solution: Proxy Bidding, Increments, and Reserve Price

A strong answer should explain that auctions are price-formation systems. The final visible price is not always equal to the winner’s maximum bid.

In proxy bidding, a bidder enters the maximum amount they are willing to pay. The platform bids on their behalf only as much as needed to remain in the lead under the increment table.

Example:

- Bidder A proxy max: $500
- Bidder B proxy max: $410
- Increment table around that range: $10
- Reserve price: $400

The system does not necessarily show $500. It may show $420 because A only needs to exceed B’s $410 by the legal increment to remain the winner.

Bid increments determine legal price movement. If the increment is $10, the next valid visible price after $410 may be $420. The system should not invent arbitrary prices. It should follow the pinned increment table.

Reserve price affects whether a sale exists. If the highest admissible price does not meet reserve, the auction may close with no sale, even if a bidder is leading. If reserve is met, the system can declare a winning obligation.

Evidence to preserve:

- Auction ID
- Bid IDs
- Bidder identities, access-controlled
- Proxy max values, protected from inappropriate exposure
- Visible price progression
- Bid increment table version
- Reserve rule and reserve-met status
- Tie-breaker policy
- Close policy version
- Final winner
- Final clearing price
- Explanation reason codes

Support should be able to explain:

> You entered a maximum of $500. Another bidder’s maximum was $410. Under the increment table, the minimum price needed for you to remain in the lead was $420. Your full maximum was not charged because the system only increased the visible price as needed.

Close replay receipt should include price-formation evidence without exposing private proxy maximums to unauthorized users.

Senior answer:

> Proxy max, increments, and reserve are not product details. They are replayable price-formation rules.

---

## Bonus Exercise 6 Solution: Manipulation and Fraud Containment

A strong answer should treat auctions as adversarial by default. Fraud detection must happen before close because after close, manipulation can become settlement liability.

| Pattern | Signal | Containment |
|---|---|---|
| Shill bidding | Related accounts repeatedly lift prices but rarely complete wins. | Graph scoring, bidder/seller review, quarantine. |
| Collusion ring | Coordinated timing across recurring bidder clusters. | Cluster detection, category watch, rate limits, review. |
| Bid shielding | High fake bid scares away competition, then retracts late. | Retraction limits, late-retraction review, close freeze. |
| Last-second spoofing | Burst of low-confidence late bids near close. | Step-up verification, bid-rate throttle, soft-close extension. |
| Account takeover | New device or identity anomaly on high-value bid. | Verification challenge, hold bid, route to review. |

Fraud detection must connect to close authority. If fraud pressure rises near close, the system should not merely log the risk and continue. It should reduce authority:

- throttle bidding,
- quarantine accounts,
- require step-up verification,
- hold suspicious bids,
- freeze close,
- pause settlement,
- route to review.

The goal is not perfect certainty. In an adversarial marketplace, perfect real-time certainty is unrealistic. The goal is containment and proof: prevent manipulation from crossing into irreversible close, settlement, allocation, or fulfillment.

Evidence to capture:

- Fraud-pressure score
- Account graph signals
- Device/session signals
- Bid timing and velocity
- Retraction history
- Seller/bidder relationship indicators
- Verification attempts
- Quarantine decisions
- Policy version
- Owner decision
- Close or settlement action taken

Senior answer:

> Fraud is not a sidebar. Fraud pressure must be allowed to change close and settlement posture before manipulation becomes liability.

---

## Bonus Exercise 7 Solution: Settlement and Fulfillment Side Effects

A strong answer should separate close from settlement. Close determines the winner and price. Settlement changes reality.

After `closeCommitId` exists, the platform may begin allocation, escrow, payment capture, fulfillment, title transfer, or delivery. These are side effects and must be idempotent, replayable, compensatable, and stoppable.

`settlementIntentId` and `settlementEffectId` must be separate:

- `settlementIntentId` says: “We intend to settle this auction outcome.”
- `settlementEffectId` says: “This exact payment or escrow operation was attempted.”

If capture fails:

- retry only within a bounded window,
- check idempotency before retry,
- determine whether payment provider state is ambiguous,
- route to second-chance offer, cancel, re-auction, or review based on pinned policy.

If allocation fails:

- preserve the close record,
- prevent settlement from continuing if possible,
- invalidate or reverse allocation intent,
- notify seller and winner,
- execute compensation if the platform caused harm,
- consider second-chance offer or re-auction if policy allows.

Compensation paths:

- refund,
- credit,
- second-chance offer,
- re-auction,
- cancellation,
- seller/bidder support escalation,
- manual title/asset correction.

Replay evidence:

- `closeCommitId`
- Winner and price
- `allocationId`
- `settlementIntentId`
- `settlementEffectId`
- Payment provider trace
- Fulfillment/transfer trace
- Idempotency record
- Failure reason
- Compensation decision
- Policy version

Senior answer:

> Close commits the auction outcome. Settlement and fulfillment change reality. That means every post-close side effect needs idempotency, receipts, stop conditions, and compensation.

---

## Bonus Exercise 8 Solution: Stop Authority for Auction Close and Settlement

A strong answer should say that stop authority is capability-scoped. You do not stop the entire marketplace unless necessary. You freeze risky close or settlement paths.

| Signal | Control Action |
|---|---|
| Close mismatch rate > 0 | Freeze close commits for affected segment; reconcile with pinned evidence. |
| Replay coverage < 100% for close or settlement | Freeze close/settlement until receipts are complete. |
| Bid ingestion lag exceeds hard window | Delay close, extend if policy allows, or route to review. |
| Clock-skew budget exceeded | Tighten close posture; review high-value closes. |
| Fraud pressure above threshold | Quarantine bidder cohort; freeze close or settlement. |
| Payment/settlement failure spike | Pause captures; route to triage; execute compensation policy. |
| Operator replay requested | Simulate first; execute only with approval and receipt. |

Owners:

- Auction close owner
- Marketplace policy owner
- Fraud/risk owner
- Settlement/payment owner
- Fulfillment owner
- Replay/governance owner
- Incident commander for high-value events

When stop authority fires, emit:

- Signal
- Threshold crossed
- Affected auction/listing/category/cohort
- Action taken
- Policy version
- Owner
- Timestamp
- Replay receipt
- Re-enable criteria

Re-enable criteria:

- Close mismatch reconciled
- Replay coverage restored
- Ingestion lag within budget
- Clock skew within budget
- Fraud pressure reduced or reviewed
- Settlement failures back to baseline
- Compensation/reversal plan approved
- Owner approval recorded
- Policy version updated if needed

Senior answer:

> Stop authority is not panic. It is the system’s ability to become conservative before ambiguity becomes money movement.

---

## Bonus Exercise 9 Solution: Incident Response — The Night Close Created Two Realities

This is not simply a latency or failover problem. It is a truth-boundary failure. A failover at close exposed that the system allowed more than one authoritative close computation for the same auction.

Two `closeCommitId` values for one `auctionId` is a truth defect. The platform created two realities:

- One path admitted the late bid and declared Bidder A.
- Another path excluded the late bid and declared Bidder B.
- Settlement began on one path.

Close mismatch rate above zero is not noise because auctions are liability systems. The only acceptable number of committed outcomes per auction is one.

Settlement must pause immediately because money movement, allocation, title transfer, or fulfillment will multiply the ambiguity. Once settlement begins, the cost of correction rises.

Reconciliation should use pinned evidence:

- bid ledger,
- event time,
- ingestion time,
- close time,
- late-window policy,
- hard cutoff,
- clock-skew state,
- close policy version,
- fraud state,
- tie-breaker policy,
- close computation logs,
- replay receipts.

Durable constraint to prevent recurrence:

- One `auctionId` maps to one `closeCommitId`.
- Close commit should be inserted under a unique constraint.
- Close computation should use a single authoritative close authority or strongly guarded compare-and-set.
- Settlement must require exactly one valid `closeCommitId`.

Platform explanation:

- To bidders: which close rule governed the outcome and whether their bid was admissible.
- To seller: which buyer and price were valid under pinned policy.
- To support: what happened and what compensation/dispute path applies.
- To engineering: which constraint, failover, or replay gap allowed duplicate close.

Senior answer:

> You can live with latency. You cannot live with ambiguity at close.

---

## Bonus Exercise 10 Solution: Senior Architect Auction Defense

A mature answer should acknowledge that bid services, WebSockets, Redis, Kafka, and leaderboards are useful but incomplete. They do not define when the marketplace becomes liable.

A senior answer starts like this:

> I am not designing a leaderboard. I am designing an adversarial marketplace commitment engine.

Key defense points:

### Close is the liability boundary

The platform becomes accountable when it declares a winner and price. Close must be singular, pinned, and replayable.

### Bids are not automatically admissible

A bid may exist but still be excluded due to timing, policy, fraud, increments, reserve, or authority.

### Token chain

Use `auctionId`, `bidId`, `closeCommitId`, `allocationId`, `settlementIntentId`, `settlementEffectId`, and `compensationId`.

### Admissible time

Define event time, ingestion time, close time, late window, hard cutoff, and clock-skew budget. Client time is not enough.

### Hard close and soft close

Hard close favors crispness but invites sniping. Soft close improves price discovery but creates extension load and policy complexity.

### Price formation

Proxy bidding, increment ladders, reserve rules, and tie-breakers must be replayable.

### Manipulation containment

Fraud pressure must be connected to close and settlement authority. The system must throttle, quarantine, verify, freeze, or review when pressure rises.

### Settlement side effects

Payment, allocation, fulfillment, transfer, and compensation are side effects. They require idempotency, receipts, and stop conditions.

### ROCS and stop authority

Reliability means one close outcome. Observability means replayable winner and price. Cost means bounded retries, disputes, fraud review, and compensation. Sustainability means the marketplace becomes conservative when truth drifts.

### Replay evidence

The platform must prove later why this bidder won at this price under this policy version using admissible close-time evidence.

Senior interview line:

> I would not frame this as highest bid in Redis. I would frame it as an adversarial marketplace commitment engine. I define close as the liability boundary, separate bid intent from closeCommitId, define admissible time with server-controlled policy, make proxy bidding and reserve replayable, connect fraud pressure to close and settlement authority, make settlement idempotent, and emit replay receipts so the platform can defend why this bidder won at this price.
