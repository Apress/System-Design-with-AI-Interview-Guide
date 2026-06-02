# Chapter 18 Exercises

## Exercise 1: Auction as a Commitment Engine

A candidate says, “An auction system is simple: users place bids, the highest bid wins, and we notify the winner.”

Why is that incomplete?

Your answer should include:

- Why an auction is a commitment engine, not a highest-bid feature
- Why close is the central liability boundary
- Why “bid received” is not the same as “bid admissible”
- Why “auction ended” is not the same as “winner committed”
- Which actors are affected: bidder, seller, marketplace operator, fraud system, payment provider, fulfillment partner, dispute team, and policy owner
- What evidence must exist before declaring a winner
- What must be replayable later

## Exercise 2: Commitment Token Chain

Design the token chain for an auction using `auctionId`, `bidId`, `closeCommitId`, `allocationId`, `settlementIntentId`, and `settlementEffectId`.

Your answer should include:

- What each token proves
- Why `closeCommitId` is the liability boundary
- Why settlement must not begin before close is committed
- Why allocation is different from winning
- Why settlement intent is different from payment execution
- How idempotency applies to settlement side effects
- What receipt should be emitted after close and settlement

## Exercise 3: Hard Close vs. Soft Close

A marketplace team says, “We can use a timer and close the auction at exactly 8:00 PM.”

Analyze this design.

Your answer should include:

- Why auction ending rules are marketplace strategy, not UI behavior
- How hard close changes bidder incentives
- Why hard close invites sniping
- How soft close changes fairness and price discovery
- Why soft close creates extension-storm and load risks
- What policy must be pinned before close
- How the system decides when it is allowed to mint `closeCommitId`

## Exercise 4: Admissible Time and Late Bid

A bidder submits a bid before close time, but the platform ingests it after the close timestamp. Another bid arrives during a declared late window. A third bid arrives after the hard cutoff.

Which bids should count?

Your answer should include:

- Why client event time cannot be the sole authority
- Difference between event time, ingestion time, close time, late window, and hard cutoff
- Why close must be anchored to server-controlled time
- When a late bid may still be admissible
- When a bid must be rejected even if the bidder claims they acted in time
- What happens if ingestion lag or clock skew exceeds the budget
- What replay evidence must be preserved

## Exercise 5: Proxy Bidding, Increments, and Reserve Price

A bidder complains: “I bid $500, but the winning price is only $420. Another bidder says they bid $410. How did the system decide the final price?”

Design a replayable price-formation model.

Your answer should include:

- How proxy bidding works
- Why visible price is not always the winner’s maximum bid
- How bid increments determine legal price movement
- How reserve price affects whether a sale exists
- What evidence must be preserved without exposing private proxy maximums incorrectly
- How support can explain the final clearing price
- What should appear in the close replay receipt

---

# Bonus GitHub Exercises

## Bonus Exercise 6: Manipulation and Fraud Containment

Auction systems are adversarial. Design a fraud-pressure control loop for shill bidding, collusion, bid shielding, last-second spoofing, and account takeover.

## Bonus Exercise 7: Settlement and Fulfillment Side Effects

An auction closes and declares a winner. Payment capture begins, allocation fails, and fulfillment cannot proceed.

Analyze this as a side-effect commitment problem.

## Bonus Exercise 8: Stop Authority for Auction Close and Settlement

Design stop authority for auction systems.

## Bonus Exercise 9: Incident Response — The Night Close Created Two Realities

A hot listing closes during a failover. Two close computations succeed. One includes a late bid and declares Bidder A. Another excludes it and declares Bidder B. Settlement begins on one path.

Analyze the incident.

## Bonus Exercise 10: Senior Architect Auction Defense

An interviewer says, “Designing an auction system is straightforward: accept bids, keep the highest bid in Redis, close at the scheduled time, charge the winner, and notify the seller.”

Defend a more mature design.
