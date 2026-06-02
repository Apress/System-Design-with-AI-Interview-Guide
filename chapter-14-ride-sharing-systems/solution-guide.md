# Chapter 14 Solution Guide

## Exercise 1 Solution: Ride-Sharing as a Commitment Engine

A strong answer should explain that ride-sharing is not simply a nearest-driver search. It is a real-time marketplace commitment problem.

Candidate exploration is probabilistic. The system can fetch nearby drivers, score candidates, estimate ETA, predict acceptance likelihood, and compare marketplace outcomes. But at that stage, the system has not yet created liability. It is still exploring.

A committed match is different. Once the platform tells the rider, “This is your driver,” and tells the driver, “This is your trip,” obligations begin. The rider expects the ETA to be believable. The driver expects the assignment to be stable. The marketplace expects low churn. The platform must preserve safety, compliance, and replayability.

Hold and commit should be separate because reality moves while the system computes. A `matchHoldId` expresses bounded intent. It says, “This candidate is temporarily being evaluated for commitment.” A `matchId` expresses liability. It says, “The platform has committed this rider-driver pairing.”

Stale GPS can be inadmissible evidence because present data is not always valid data. If the driver’s GPS is older than the hard TTL, the system may still have a location value, but it cannot defend a commitment based on that value. At commitment time, the platform needs admissible evidence, not merely available evidence.

Before issuing a committed match, the system should pass:

- Driver GPS freshness gate
- ETA freshness gate
- Demand/supply freshness gate
- Driver availability gate
- Driver acceptance gate
- Rider eligibility/payment gate
- Safety/fraud gate
- Policy/city-rule gate
- Pricing policy gate
- Fairness guardrail check
- Conflict check across signals

Replay evidence should include:

- Correlation ID
- Rider request ID
- Candidate driver set
- Ranking scores
- Driver GPS timestamp
- ETA evidence
- Demand/supply snapshot
- Pricing policy version
- Fairness pressure indicators
- Hold token
- Driver acceptance
- Commit token
- Gate results
- Reason codes
- Final match outcome

The senior answer: matching is optimization before commitment. Ride-sharing architecture becomes real at the line where the platform turns a probable match into an obligation.

---

## Exercise 2 Solution: Hold Token vs. Commit Token

A strong flow should separate rider intent, candidate exploration, temporary hold, acceptance, admissibility checks, and final commit.

Possible flow:

1. Rider taps **Request Ride**.
2. Request service creates `rideRequestId` and `correlationId`.
3. Marketplace service identifies region, pickup point, ride type, and applicable policy.
4. Candidate service fetches eligible drivers.
5. Freshness filter removes drivers with hard-stale GPS.
6. Ranker scores candidates using ETA, proximity, acceptance likelihood, fairness pressure, driver state, and marketplace health.
7. System creates a shortlist.
8. Dispatch service issues `matchHoldId` with TTL.
9. Driver is offered the ride.
10. Driver accepts within the hold TTL.
11. System rechecks GPS freshness, ETA freshness, demand/supply freshness, pricing state, policy state, fraud/safety state, and fairness guardrails.
12. If gates pass, system issues `matchId`.
13. Rider and driver receive committed match.
14. Replay card is written.

If the hold expires:

- Release hold.
- Do not treat it as a committed match.
- Try another candidate only within the rematch budget.
- If budgets are spent, enter conservative fallback or assisted handling.

If gates fail:

- Do not issue `matchId`.
- Record failure reason.
- Try bounded refresh/re-rank if still pre-commit.
- Move to “finding another driver,” “limited availability,” or “assisted handling” if budget is spent.

Bounded retries and rematches:

- Maximum candidate refetch count
- Maximum redispatch count
- Maximum hold attempts per request
- Maximum compute budget per request
- Maximum time to commit
- Single-flight protection for repeated rider taps
- Idempotency key for request submission

A strong distinction:

- `matchHoldId` = intent under TTL, no marketplace liability yet.
- `matchId` = committed obligation with evidence.

---

## Exercise 3 Solution: Freshness Budget

“The latest data available” is not precise enough because the latest data in the system may already be too old to support a commitment. Ride-sharing requires time-scoped truth. GPS, demand/supply, and ETA are not just data streams; they are admissible or inadmissible evidence at decision time.

A possible freshness budget:

| Signal | Soft TTL | Hard TTL | Commit Rule |
|---|---:|---:|---|
| Driver GPS | <= 5 seconds | <= 10 seconds | Hard-stale GPS cannot justify committed match |
| Demand/Supply | <= 30 seconds | <= 60 seconds | Hard-stale signals cannot justify commitment-level surge or dispatch |
| Traffic/ETA | <= 60 seconds | <= 120 seconds | Hard-stale ETA cannot justify locked ETA promise |

Inside the soft TTL:

- Use signal normally.
- Preserve timestamp.
- Refresh opportunistically if close to soft limit.
- Include uncertainty band if relevant.

Between soft and hard TTL:

- Proceed cautiously.
- Refresh before high-risk commitment.
- Widen ETA confidence band.
- Avoid high-confidence language.
- Consider conservative matching.

After hard TTL:

- Do not commit using that evidence.
- Refresh, defer, re-rank, or enter fallback.
- If refresh fails within budget, refuse or move to assisted handling.

Freshness is admissibility because the system is making a claim about the moving world. A driver location older than the hard TTL may still be a value, but it is not defensible reality.

Replay evidence:

- Signal type
- Signal timestamp
- Decision timestamp
- Signal age
- Soft/hard TTL policy version
- Source system
- Region
- Confidence/uncertainty band
- Refresh attempts
- Gate pass/fail result
- Decision outcome

The senior answer: freshness budgets are not performance tuning. They are policy at the commitment boundary.

---

## Exercise 4 Solution: Bounded Churn and Rematch Storm

A strong answer should describe rematch storms as marketplace failures, not only technical failures.

Services may remain healthy while the marketplace becomes unstable. APIs return 200s, queues drain eventually, and caches work. But riders see drivers change repeatedly. Drivers receive unstable assignments. Cancellations rise. Acceptance drops. Marketplace liquidity drains.

The loop may look like this:

1. Demand spikes in a hot zone.
2. Traffic snapshots drift stale.
3. GPS updates become delayed or jittery.
4. Candidate search fetches drivers with questionable freshness.
5. Holds expire before commit.
6. System reranks and redispatches.
7. Riders lose confidence and cancel.
8. Drivers reject unstable offers.
9. Supply tightens.
10. More rematching occurs.
11. Compute spend and tail latency increase.
12. Marketplace churn becomes contagious.

Unbounded reranking and redispatch are dangerous because the system tries to optimize its way out of uncertainty. Instead of becoming more trustworthy, it becomes more active and less stable.

Controls:

- Rematch budget per request
- Redispatch cap per request
- Candidate cap per search
- ETA recomputation limit
- Pricing recalculation limit
- End-to-end compute budget
- Hold TTL
- Hard GPS TTL
- Backpressure during hot-zone instability
- Conservative mode when churn crosses threshold
- Assisted handling when replay or evidence quality drops

Stop-authority triggers:

- Rematch rate above threshold
- Post-commit cancellation spike
- Driver rejection spike
- Replay coverage below required level
- GPS hard-stale rate above threshold
- Hold-expiry rate above threshold
- P95 wait-time disparity spike
- Compute cost per successful match above threshold
- Surge volatility beyond dampening policy

Replay evidence:

- Region and time window
- Demand/supply snapshot
- GPS freshness distribution
- Candidate sets
- Ranking decisions
- Hold attempts
- Driver acceptance/decline events
- Rematch count
- Redispatch count
- Policy version
- Stop-authority action
- Final outcome

The senior answer: a marketplace can fail while every service is “up.” Churn is the failure signal.

---

## Exercise 5 Solution: Pricing as a Defensible Commitment

A strong pricing design treats a quote as a replayable policy decision. The system should not merely store the fare amount. It should store why the fare was allowed.

Pricing receipt fields:

- `quoteId`
- `correlationId`
- `riderId` or privacy-safe rider reference
- `regionId`
- `pickupLocationBucket`
- `dropoffLocationBucket`
- `rideType`
- `baseFare`
- `surgeMultiplier`
- `finalQuotedPrice`
- `currency`
- `pricingPolicyVersion`
- `cityPolicyVersion`
- `crisisPostureFlag`
- `demandSnapshotId`
- `supplySnapshotId`
- `trafficSnapshotId`
- `signalTimestamps`
- `signalAge`
- `sampleSize`
- `uncertaintyBand`
- `dampeningApplied`
- `hysteresisState`
- `rateOfChangeCap`
- `capsApplied`
- `driverIncentiveComponent`
- `reasonCodes`
- `createdAt`
- `expiresAt`

Plain-language reason codes might include:

- High rider demand
- Low nearby driver supply
- Weather or traffic pressure
- Driver incentive active
- City cap applied
- Crisis dampening applied
- Price-change cap applied

Why pricing must be replayable:

- Riders need support explanations.
- Drivers need confidence that incentives are fair.
- Regulators may ask why prices moved.
- Executives need to defend marketplace behavior.
- Auditors need policy versions and evidence.
- The platform needs to prove volatility was controlled.

A strong quote state model:

- Estimated quote
- Held quote
- Confirmed quote
- Expired quote
- Repriced quote with reason

The senior answer: dynamic pricing is not just optimization. It is policy with receipts.

---

## Bonus Exercise 6 Solution: Fairness as a Control Loop

Fairness in ride-sharing should be treated as an operating control loop, not a value statement.

A strong loop:

1. Sense disparities.
2. Interpret whether disparity is outside guardrails.
3. Decide intervention.
4. Act through dispatch, exploration, incentives, or surge dampening.
5. Prove whether the intervention reduced disparity without destabilizing the marketplace.

Metrics to monitor:

- Rider wait-time p95 by neighborhood
- Rider wait-time p95 disparity between regions
- Post-commit cancellation rate by cohort
- Driver acceptance/rejection rate by segment
- Driver hourly earnings variance
- Driver utilization skew
- Coverage SLO by geography
- ETA error disparity by region
- Surge exposure disparity
- Safety escalation rates by geography/cohort

Possible interventions:

- Dispatch-weight adjustments
- Exploration allocation
- Driver incentives in underserved zones
- Surge dampening
- Supply nudging
- Conservative matching in unstable areas
- Driver repositioning suggestions
- Temporary policy review for anomalous regions

How to prove intervention worked:

- Before/after disparity metrics
- Control-group comparison
- Wait-time reduction
- Cancellation-rate reduction
- Driver earnings variance reduction
- Coverage SLO restoration
- No unacceptable increase in global marketplace churn
- Replay of the dispatch-weight change and policy version

The senior answer: fairness is not a quarterly dashboard. It is a live control loop with thresholds, actions, owners, and evidence.

---

## Bonus Exercise 7 Solution: Inference DAG Budget

A ride-sharing request is not one algorithm call. It is an inference DAG with many places where loops can hide.

DAG surfaces:

- Candidate search
- Driver eligibility filtering
- GPS freshness filtering
- ETA inference
- Demand/supply inference
- Pricing inference
- Driver acceptance prediction
- Ranking
- Fairness/policy gates
- Hold creation
- Commit checks
- Post-commit repair/reassignment

Budgets:

| DAG Surface | Budget / Control | Exit Path |
|---|---|---|
| Candidate search | Candidate cap, retry budget, hard GPS filter | Conservative candidate set or assisted lane |
| ETA inference | ETA TTL, confidence band, recomputation cap | Fallback ETA lane |
| Pricing inference | Dampening, hysteresis, policy cap | Held quote or no quote |
| Ranking | Max-depth, compute budget | Deterministic heuristic |
| Policy/fairness gates | One bounded re-evaluation | Defer/refuse commit |
| Hold | Hold TTL | Release hold and count attempt |
| Redispatch | Redispatch cap | Assisted handling or no match |
| Commit | Strict admissibility gate | Commit only with evidence |

When budgets are exhausted:

- Stop chasing perfect optimization.
- Do not keep reranking indefinitely.
- Switch to conservative mode.
- Show honest rider state.
- Route to assisted handling if needed.
- Refuse commitment if evidence is insufficient.

The senior answer: what you do not budget will recurse.

---

## Bonus Exercise 8 Solution: Phase-Aware Conflict Handling

Conflict handling must depend on commitment phase.

### Pre-commit: probabilistic exploration

Before a match is committed, the system can still optimize. If GPS, ETA, and movement data conflict, it can:

- Refresh data
- Re-rank candidates
- Try a different driver
- Recalculate ETA
- Re-evaluate price
- Redispatch within budget

But it must stay bounded. Pre-commit exploration is allowed; unbounded exploration is marketplace churn.

### Commit boundary: strict admissibility

At the commit boundary, the system is about to create liability. It must not bluff. If GPS, ETA, acceptance, pricing, safety, or policy evidence conflicts and cannot be resolved quickly, the system should:

- Refuse commit
- Defer commit
- Re-enter bounded hold
- Route to conservative fallback
- Preserve reason code

The system should not issue `matchId` if evidence is inadmissible.

### Post-commit: obligation management

After commit, the platform has made a promise. The goal is not endless optimization. The goal is to honor the obligation and minimize harm.

Post-commit behavior:

- Repair first by refreshing GPS/ETA/movement data
- Communicate honest ETA update
- Use controlled reassignment only if repair fails
- Avoid oscillating between drivers
- Compensate rider or driver when platform-side disruption crosses threshold
- Preserve replay evidence

Compensation may apply when:

- Platform-side reassignment causes significant delay
- Driver incurred cost after commitment
- Rider experiences disruption beyond policy threshold
- Price/ETA commitment is materially affected by platform-side conflict

Evidence:

- Phase
- Conflict type
- Signal timestamps
- Driver movement trace
- ETA before/after
- Policy version
- Repair attempt
- Reassignment attempt
- Compensation decision
- Final outcome

The senior answer: before commit, optimize truth. At commit, verify truth. After commit, honor the promise.

---

## Bonus Exercise 9 Solution: Safety and Fraud Hard Stop

Safety and fraud signals are different from ETA uncertainty because they may involve physical harm, unauthorized access, coercion, payment abuse, or emergency response. The system should not try to optimize through these conditions.

Signals requiring hard stop or narrowed automation:

- Identity anomaly
- Account takeover signal
- Impossible travel pattern
- Payment-risk spike
- Suspected coercion
- Emergency escalation
- Driver/rider safety flag
- Vehicle mismatch
- Suspicious device or session
- Regulatory or city-policy block
- Authorization failure

System response:

- Freeze or narrow automation for the capability.
- Do not issue or continue a risky match.
- Do not retry endlessly.
- Route to specialist/human review.
- Preserve evidence packet.
- Use conservative communication.
- Escalate emergency paths immediately when needed.

What the system must refuse:

- Match commitment without identity/safety clearance
- Payment continuation under severe fraud flag
- Automated reassignment that ignores safety context
- AI-generated reassurance without authoritative safety evidence
- Tool calls that escalate risk without human authority

Evidence packet:

- Correlation ID
- Rider/driver account references
- Device/session data
- Location/time signals
- Safety/fraud trigger
- Policy version
- Risk score and threshold
- Tool calls
- Human/specialist owner
- User-visible state
- Decision and timestamp
- Final outcome

Owner:

- Safety operations owner
- Fraud/risk owner
- Marketplace capability owner
- Emergency response workflow owner, when applicable

Replay record should show:

- Which threshold fired
- Why automation stopped
- Who owned the review
- What action was allowed or refused
- What user communication was sent
- How the case was resolved

The senior answer: when safety or fraud thresholds fire, the system stops being clever and becomes conservative.

---

## Bonus Exercise 10 Solution: Senior Architect Ride-Sharing Defense

A mature answer should acknowledge that geohash, Kafka, Redis, and matching services are useful, but incomplete. Those are implementation mechanisms. They do not define the marketplace contract.

A senior design starts with the promise:

> I am designing a real-time marketplace commitment engine where the platform must decide when it is allowed to turn rider intent and driver availability into a committed obligation.

Key points:

### Hold and commit separation

Use `matchHoldId` to represent temporary intent and `matchId` to represent commitment. This prevents the system from creating liability before evidence is admissible.

### Freshness budgets as policy

Driver GPS, demand/supply, and ETA data must have soft and hard TTLs. Hard-stale evidence cannot justify commitment.

### Bounded churn

Rematch, redispatch, candidate search, retry, and compute budgets prevent the system from becoming unstable while trying to optimize.

### Pricing with receipts

Every quote should preserve policy version, demand/supply snapshot, freshness, dampening, crisis posture, caps, and reason codes.

### Fairness as control loop

Monitor wait-time disparity, cancellation disparity, driver earnings variance, utilization skew, and coverage SLO. Trigger dispatch weights, exploration, incentives, or surge dampening.

### Inference DAG budgets

Candidate search, ETA, pricing, ranking, policy gates, hold, and commit checks need budgets and exit paths.

### Phase-aware conflict handling

Pre-commit: explore.  
At commit: verify.  
Post-commit: repair, reassign carefully, compensate if needed.

### Safety/fraud hard stops

Safety, fraud, authorization, or admissibility failures stop optimization and route to owner-led review.

### Replay evidence

Six months later, the platform should be able to prove:

- Why this rider got this driver
- Why this price was shown
- Which evidence was fresh
- Which policy version applied
- Which fairness pressure existed
- Which gates passed
- Which stop conditions did or did not fire

Senior interview line:

> I would not frame ride-sharing as nearest-driver lookup. I would frame it as a real-time marketplace commitment engine. I separate hold from commit, enforce freshness budgets, bound churn, make pricing replayable, treat fairness as a control loop, budget the inference DAG, hard-stop safety and fraud risk, and preserve evidence so we can explain later why this rider got this driver at this price.
