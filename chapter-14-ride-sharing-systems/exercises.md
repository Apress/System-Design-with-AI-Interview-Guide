# Chapter 14 Exercises

## Exercise 1: Ride-Sharing as a Commitment Engine

A rider taps **Request Ride** during a busy evening. The system finds several nearby drivers, but GPS updates are slightly stale, traffic is changing, demand is rising, and drivers are moving while the system computes.

Explain why ride-sharing is not simply a matching problem.

Your answer should include:

- The difference between candidate exploration and committed match
- Why hold and commit should be separate states
- What obligations begin after commitment
- Why stale GPS can be inadmissible evidence
- What gates must pass before issuing a committed match
- What the rider, driver, marketplace, and platform each expect
- What replay evidence should be preserved

## Exercise 2: Hold Token vs. Commit Token

Design the request flow for a ride-sharing match using **matchHoldId** and **matchId**.

Your answer should include:

- Rider request creation
- Candidate driver fetch
- Ranking and shortlist
- Hold token creation with TTL
- Driver acceptance
- Freshness checks
- Conflict checks
- Policy/fairness checks
- Commit token issuance
- What happens if the hold expires or gates fail
- How retries and rematches are bounded

## Exercise 3: Freshness Budget

A candidate says, “We can use the latest GPS, demand/supply, and ETA data available in the system.”

Why is that not precise enough?

Define freshness budgets for:

- Driver GPS
- Demand/supply signals
- Traffic/ETA signals

For each signal, explain:

- Soft TTL
- Hard TTL
- What can happen inside the soft TTL
- What must happen after the hard TTL
- Why freshness is an admissibility rule, not a tuning parameter
- What evidence must be included in the replay record

## Exercise 4: Bounded Churn and Rematch Storm

During a city event, rematches rise above normal. Riders see drivers change repeatedly, drivers reject more often, cancellations increase, and services remain technically healthy.

Analyze this as a marketplace failure.

Your answer should include:

- Why green service dashboards can hide marketplace instability
- How GPS staleness, traffic jitter, demand spikes, and hold expiry create rematch loops
- Why unbounded reranking and redispatch are dangerous
- What rematch budgets, redispatch caps, and compute budgets should exist
- When to switch to conservative mode or assisted handling
- What signals should trigger stop authority
- What replay evidence proves the response was justified

## Exercise 5: Pricing as a Defensible Commitment

A rider sees a surge price during peak demand and later complains that the price felt arbitrary or unfair.

Design a pricing receipt model.

Your answer should include:

- Pricing policy version
- Demand/supply snapshot
- Signal freshness
- Region and sample size
- Uncertainty band
- Dampening or hysteresis state
- Crisis posture flag
- Caps applied
- Plain-language reason codes
- Why pricing must be replayable for support, regulators, and executives

---

# Bonus GitHub Exercises

## Bonus Exercise 6: Fairness as a Control Loop

Ride-sharing latency and dispatch behavior begin to create disparities: one neighborhood has longer p95 wait time, one rider cohort experiences more post-commit cancellations, and one driver segment sees lower hourly earnings.

Design fairness as an operating control loop.

## Bonus Exercise 7: Inference DAG Budget

A ride request triggers candidate search, ETA inference, pricing inference, ranking, policy gates, hold creation, driver acceptance prediction, and commit checks. Under pressure, the system keeps recomputing and redispatching.

Design budgets for the inference DAG.

## Bonus Exercise 8: Phase-Aware Conflict Handling

A driver accepts a ride, but GPS, ETA, and movement data conflict. The system sees different signals before commit, at commit, and after commit.

How should conflict handling differ by phase?

## Bonus Exercise 9: Safety and Fraud Hard Stop

A ride request triggers identity anomaly signals, impossible travel patterns, suspected account takeover, payment-risk spike, or emergency escalation.

Explain why optimization must stop.

## Bonus Exercise 10: Senior Architect Ride-Sharing Defense

An interviewer says:

“Ride-sharing is straightforward: store driver locations, find nearest drivers with geohash, use Kafka for events, Redis for cache, and a matching service.”

Defend a more mature design.
