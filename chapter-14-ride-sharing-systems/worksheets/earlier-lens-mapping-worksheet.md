# Earlier-Lens Mapping Worksheet: Ride-Sharing Systems

This worksheet helps you apply the earlier lenses from Part I and Part II to Chapter 14: Ride-Sharing Systems.

The purpose is not to memorize a ride-sharing architecture. The purpose is to prove that you can reuse the same system design method under real-time marketplace pressure.

Use this worksheet before drawing the final architecture. A senior answer should show that you understand the promise, actors, journey, commitment boundaries, admissible evidence, failure modes, economic pressure, and replay requirements.

---

## How to Use This Worksheet

For each lens:

1. Read the **Senior Architect Framing**.
2. Fill in the **Ride-Sharing Mapping Table**.
3. Answer the **Interview Defense Questions**.
4. Identify the **Artifact You Would Produce**.
5. Use the **Common Weak Answer** section to avoid shallow interview responses.

The goal is to move from:

> “I will use Kafka, Redis, geohash, and a matching service.”

to:

> “I am designing a real-time marketplace commitment engine. I separate hold from commit, enforce freshness budgets, bound rematching, make pricing replayable, treat fairness as an operating control loop, and preserve evidence so the platform can explain why this rider got this driver at this price.”

---

# 1. 7-Step Method Mapping

## Senior Architect Framing

The 7-Step Method prevents you from jumping directly into components. In ride-sharing, this matters because the obvious system — “find nearest driver” — is not the real system. The real system is a moving marketplace where the platform turns rider intent and driver availability into a committed obligation.

Before drawing services, clarify what promise the system is making and when the platform becomes liable.

## Ride-Sharing Mapping Table

| 7-Step Method Step | Ride-Sharing Application | What a Senior Architect Should Say | Reader Notes |
|---|---|---|---|
| 1. Clarify the problem | Are we designing only matching, or the full ride lifecycle: request, quote, hold, commit, pickup, cancellation, payment, support, safety, and replay? | “I need to know whether the interview scope is nearest-driver matching or a full marketplace commitment engine.” |  |
| 2. Identify actors | Rider, driver, marketplace operator, pricing owner, safety/fraud owner, payments owner, support, regulator. | “Riders and drivers experience the same decision differently. The platform must protect both sides of the marketplace.” |  |
| 3. Map the journey | Request, quote, candidate search, hold, driver acceptance, commit, pickup, trip, cancellation, payment, support. | “Each journey moment carries a different trust expectation.” |  |
| 4. Define constraints | Real-time movement, GPS freshness, traffic drift, city policies, pricing volatility, fairness, safety, fraud, payment risk. | “The system commits while reality is still moving, so evidence freshness matters.” |  |
| 5. Name commitments | Price quote, match hold, committed match, pickup ETA, cancellation policy, compensation, payment. | “Hold is intent. Commit is liability.” |  |
| 6. Choose architecture | Location ingestion, candidate search, ranking, dispatch, pricing, ETA, commit gate, fairness guardrails, safety, replay. | “I will draw services only after the responsibility boundaries and control surfaces are clear.” |  |
| 7. Defend trade-offs | Speed vs. admissibility, optimal matching vs. churn, dynamic pricing vs. trust, autonomy vs. safety, fairness vs. marketplace liquidity. | “A fast wrong commitment is worse than a slightly slower defensible one.” |  |

## Interview Defense Questions

- What exactly is the platform allowed to promise when the rider taps **Request Ride**?
- What is still exploration, and what creates liability?
- Which actors are harmed if the system rematches too often?
- Which decision must be replayable later?
- What trade-off would you defend if the interviewer pushes you toward “just find the nearest driver”?

## Artifact to Produce

`worksheets/ride-sharing-7-step-method-map.md`

## Common Weak Answer

> “I will use geohash to find nearby drivers, rank by distance, and dispatch the closest driver.”

## Stronger Answer

> “I will start by defining the ride-sharing platform as a real-time marketplace commitment engine. Candidate search is exploratory, but match commit creates liability. I will separate hold from commit, define freshness budgets for GPS and ETA evidence, and preserve a replay record for every high-risk marketplace decision.”

---

# 2. Customer Journey Mapping

## Senior Architect Framing

Ride-sharing trust changes by journey phase. A stale estimate during browsing is annoying. A stale estimate after commitment can damage trust. A driver change before commitment is normal. A driver change after commitment is a disruption that may require repair, reassignment, or compensation.

The architecture should therefore be journey-aware.

## Customer Journey Table

| Journey Moment | Rider Believes | Driver Believes | Marketplace Risk | Architecture Response | Evidence to Preserve |
|---|---|---|---|---|---|
| Open app / browse | Cars shown are plausible. | Availability is not yet binding. | Map may imply supply that is not real. | Show approximate availability; do not imply commitment. | Region, supply snapshot timestamp. |
| Price quote | Price is explainable and time-bound. | Earnings/incentive is governed. | Pricing may feel arbitrary. | Pricing receipt with policy version, demand/supply snapshot, reason codes. | Quote ID, policy version, signal freshness, caps applied. |
| Request ride | Platform is searching seriously. | Potential trip may be offered. | Slow search causes cancellation or repeated taps. | Create rideRequestId and correlationId; idempotency for duplicate taps. | Request timestamp, rider region, request state. |
| Candidate search | Nearby drivers are being evaluated. | Driver may be considered but not committed. | Stale GPS may produce bad candidate. | Filter by GPS freshness and eligibility. | Candidate set, GPS age, filters applied. |
| Match hold | A driver may become assigned soon. | Offer is temporary. | Hold may expire and trigger churn. | matchHoldId with TTL; bounded attempts. | Hold ID, TTL, candidate driver, created/expires timestamps. |
| Driver accepts | The driver is probably mine. | The trip is becoming real. | Acceptance may be based on stale state. | Recheck freshness, conflict, pricing, fairness, safety. | Acceptance timestamp, gate results. |
| Match commit | “This is my driver.” | “This is my trip.” | Liability begins. | Issue matchId only after admissibility gates pass. | matchId, policy version, gate evidence. |
| Pickup | ETA should remain believable. | Rider should be reachable. | ETA drift creates anxiety and support contacts. | ETA confidence band, honest updates, repair first. | ETA versions, movement evidence. |
| Post-commit conflict | Disruption should be fair. | Lost time should be recognized. | Casual rematch damages both sides. | Repair, controlled reassignment, compensation if threshold crossed. | Conflict reason, repair attempt, reassignment branch, compensation. |
| Payment / support | Fare and outcome should be explainable. | Earnings should be defensible. | Dispute without proof. | Pricing receipt and ride decision replay card. | Full decision replay record. |

## Interview Defense Questions

- At which journey moment does the system become liable?
- What does the rider believe at quote time versus commit time?
- What does the driver believe after accepting?
- What should the system show when evidence is delayed?
- How does support explain the decision later?

## Artifact to Produce

`worksheets/customer-journey-ride-sharing.md`

## Common Weak Answer

> “The user requests a ride, the matching service finds a driver, and the trip starts.”

## Stronger Answer

> “The journey moves through different trust states. Request is intent, hold is bounded exploration, driver acceptance is necessary but not sufficient, and commit creates marketplace liability. Each phase needs different evidence and different user-visible language.”

---

# 3. Capability Map

## Senior Architect Framing

A capability map separates responsibilities. It prevents one generic “matching service” from owning everything: location freshness, pricing, fairness, safety, payment, and replay.

In ride-sharing, the most important capability is not matching alone. It is the **commit gate** that decides when the platform is allowed to create liability.

## Capability Map Table

| Capability | Responsibility | Commitment Boundary | Key Inputs | Key Outputs | Owner |
|---|---|---|---|---|---|
| Rider Request | Accept and normalize rider intent. | No commitment yet. | Rider ID, pickup, drop-off, ride type. | rideRequestId, correlationId. | Rider experience owner |
| Location Ingestion | Capture and timestamp driver/rider location. | Location is admissible only within TTL. | GPS events, device state, ingestion time. | Location snapshot with age. | Location platform owner |
| Candidate Search | Find eligible drivers in region. | Candidate is possible, not promised. | Pickup region, driver locations, eligibility. | Candidate set. | Marketplace matching owner |
| Ranking | Score drivers by ETA, acceptance likelihood, fairness pressure, and marketplace health. | Ranking is exploration. | Candidate set, ETA, acceptance model, fairness signal. | Ranked shortlist. | Ranking owner |
| Dispatch | Offer ride to selected driver. | matchHoldId creates temporary intent. | Shortlist, driver availability, offer policy. | Offer event, matchHoldId. | Dispatch owner |
| Commit Gate | Decide whether hold can become match. | matchId creates liability. | Driver acceptance, freshness, conflicts, policy, safety, pricing. | matchId, deferred, refused, escalated. | Marketplace commitment owner |
| ETA | Estimate pickup and trip time. | Locked ETA requires fresh evidence and confidence band. | GPS, traffic, historical model, route. | ETA estimate, confidence band. | ETA owner |
| Pricing | Produce quote and driver incentive. | Quote must be replayable and time-bound. | Demand, supply, policy, region, traffic. | Pricing receipt. | Pricing owner |
| Fairness Guardrails | Detect and correct marketplace disparities. | Optimization must stay inside guardrails. | Wait times, cancellations, earnings, coverage. | Intervention decision. | Marketplace governance owner |
| Safety/Fraud | Hard-stop unsafe or suspicious automation. | Safety/fraud can override matching. | Identity, device, payment, emergency signals. | Allow, review, hard stop. | Safety/fraud owner |
| Payment | Authorize and capture fare. | Payment commitment after ride/payment gates. | Fare, rider payment, trip completion. | Auth/capture result. | Payments owner |
| Support/Replay | Explain decisions later. | Replay proves what happened and why. | Decision records, receipts, policies. | Replay card, support explanation. | Support/governance owner |

## Interview Defense Questions

- Which capability owns the transition from hold to commit?
- Which capability owns pricing defensibility?
- Which capability can hard-stop automation?
- Which capability owns fairness interventions?
- Which capability owns replay evidence?

## Artifact to Produce

`worksheets/capability-map-ride-sharing.md`

## Common Weak Answer

> “We need services for users, drivers, matching, pricing, payment, and notifications.”

## Stronger Answer

> “I would map capabilities around responsibility and commitment: request, location, candidate search, ranking, dispatch, commit gate, pricing, fairness, safety, payment, and replay. The commit gate is central because it controls when the platform turns exploration into liability.”

---

# 4. ARCHVIEW Mapping

## Senior Architect Framing

ARCHVIEW should make responsibility visible. For ride-sharing, that means the architecture view must show actors, capabilities, control surfaces, commitment points, ownership, evidence, degradation, and stop authority.

A diagram that only shows services and databases is not enough.

## ARCHVIEW Table

| ARCHVIEW Concern | Ride-Sharing View | What Must Be Visible |
|---|---|---|
| Actors | Rider, driver, marketplace, platform, safety/fraud, support, regulator. | Who is affected by each decision. |
| Responsibilities | Request, location, matching, dispatch, ETA, pricing, safety, fairness, payment, replay. | Which capability owns which promise. |
| Control surfaces | Freshness TTLs, rematch budgets, redispatch caps, pricing caps, fairness thresholds, safety hard stops. | What changes runtime behavior. |
| Commitment points | Quote, hold, driver acceptance, match commit, pickup, cancellation, payment. | Where liability begins. |
| Ownership | Capability owners with stop authority. | Who can pause, narrow, or hard-stop behavior. |
| Evidence | Pricing receipt, match replay card, freshness snapshots, policy versions. | What proves the system was allowed to act. |
| Degradation | Conservative mode, assisted handling, defer/refuse commit, repair/reassign/compensate. | How the system behaves under uncertainty. |
| Stop authority | Marketplace ops, safety/fraud, pricing, fairness, dispatch owners. | Who acts when thresholds are breached. |

## Interview Defense Questions

- Does your architecture show the commitment boundary?
- Does your diagram show who can stop automation?
- Does your design show what happens when GPS is hard-stale?
- Does pricing have a receipt?
- Can support replay why this match happened?

## Artifact to Produce

`worksheets/archview-ride-sharing.md`

## Common Weak Answer

> “Here is the high-level architecture: mobile app, API gateway, matching service, Kafka, Redis, PostgreSQL, and notification service.”

## Stronger Answer

> “My architecture view will show the commitment boundary. Candidate search and ranking are exploratory. Dispatch creates a hold. Commit gate creates liability. Pricing, fairness, safety, and replay are control surfaces, not afterthoughts.”

---

# 5. AI Primitives Mapping

## Senior Architect Framing

The AI architecture primitives become concrete in ride-sharing. Commitment becomes hold and commit tokens. Time becomes freshness TTLs. Evidence becomes replay cards and pricing receipts. Degradation becomes conservative mode and assisted handling. Ownership becomes stop authority.

## AI Primitives Table

| AI Primitive | Ride-Sharing Application | Artifact | Example |
|---|---|---|---|
| Authority | Who can commit a match, change a price, reassign a driver, compensate, or stop automation? | Stop-authority matrix. | Safety owner can hard-stop automation on fraud signal. |
| Commitment | Hold is intent; commit is liability. | matchHoldId and matchId schemas. | Driver offer creates hold; gate pass creates matchId. |
| Time | GPS, traffic, ETA, demand, and supply expire. | Freshness-budget policy. | Hard-stale GPS cannot justify committed match. |
| Degradation | System becomes conservative under uncertainty. | Degradation policy. | Reduce redispatch, enter assisted handling, refuse commit. |
| Evidence/Replay | Explain why rider got driver at price. | Replay card and pricing receipt. | Store policy version, signal snapshot, gate results. |
| Ownership | Every control has a responsible owner. | Ownership map. | Pricing owner owns quote policy; marketplace owner owns rematch storm response. |

## Interview Defense Questions

- What is the authority boundary for match commit?
- What is the commitment artifact?
- What expires, and what happens when it expires?
- What does the system do when evidence is missing?
- What evidence survives six months later?
- Who can stop the system from continuing?

## Artifact to Produce

`worksheets/ai-primitives-ride-sharing.md`

## Common Weak Answer

> “AI helps with ETA, matching, pricing, and recommendations.”

## Stronger Answer

> “AI is allowed to assist ranking and prediction, but commitment requires admissible evidence. The architecture uses hold tokens, freshness TTLs, policy gates, degradation states, stop authority, and replay evidence to control AI-assisted decisions.”

---

# 6. ROCS Mapping

## Senior Architect Framing

ROCS turns ride-sharing from an algorithm into an operating system. Reliability, observability, cost, and sustainability interact directly. A rematch storm is not only reliability risk. It is also observability risk, cost risk, sustainability risk, and marketplace trust risk.

## ROCS Table

| ROCS Dimension | Ride-Sharing Pressure | Control | Evidence |
|---|---|---|---|
| Reliability | Match must remain stable enough to trust. | Hold/commit separation, commit gates, bounded rematch, hard TTLs. | Match stability, rematch count, cancellation rate. |
| Observability | Platform must prove why match, price, or reassignment happened. | Replay card, pricing receipt, correlation ID, gate results. | Replay coverage, policy version, evidence snapshots. |
| Cost | Redispatch, recomputation, retries, incentives, and support can multiply. | Compute budgets, redispatch caps, inference DAG budgets, incentive controls. | Cost per successful match, compute per request. |
| Sustainability | Replanning and inefficient routing create compute and real-world waste. | Route churn reduction, conservative mode, fewer recomputations, efficient batching where possible. | Energy/carbon per ride decision, route churn, idle miles. |

## ROCS Loop for Ride-Sharing

| Loop Step | Ride-Sharing Example |
|---|---|
| Sense | Detect rising rematch rate, stale GPS, cancellation spike, pricing oscillation, fairness disparity. |
| Interpret | Identify whether the issue is freshness, demand spike, driver scarcity, pricing volatility, or policy conflict. |
| Decide | Marketplace owner, pricing owner, or safety owner chooses posture change. |
| Act | Enforce TTLs, cap redispatch, dampen surge, enter conservative mode, route to assisted handling. |
| Prove | Show replay cards, before/after metrics, and restored marketplace stability. |

## Interview Defense Questions

- Which ROCS signal tells you the marketplace is unstable?
- Which cost multiplier appears during rematch storms?
- Which observability artifact proves the system acted responsibly?
- Which sustainability metric matters beyond cloud cost?
- Who decides to change posture?

## Artifact to Produce

`worksheets/rocs-ride-sharing.md`

## Common Weak Answer

> “We will monitor latency, errors, and throughput.”

## Stronger Answer

> “I will monitor marketplace trust signals: rematch rate, cancellation rate, acceptance rate, replay coverage, GPS hard-stale rate, pricing volatility, fairness disparity, and cost per successful match. ROCS controls how the system changes behavior under pressure.”

---

# 7. Scale Mapping

## Senior Architect Framing

Scale in ride-sharing is not just more requests. It is hot zones, driver scarcity, supply/demand imbalance, location update pressure, pricing volatility, rematch churn, and support spikes.

Scale reveals weak marketplace assumptions before services go down.

## Scale Mapping Table

| Scale Pressure | Ride-Sharing Failure Shape | Control | Evidence |
|---|---|---|---|
| Hot zones | Too many riders, not enough drivers. | Regional supply strategy, incentives, admission control. | Demand/supply snapshot, wait time by region. |
| Demand spikes | Surge volatility and candidate churn. | Surge dampening, pricing caps, freshness gates. | Pricing receipt, reason codes. |
| Driver GPS load | Stale or jittery telemetry. | GPS TTL, hard-stale refusal, location confidence. | GPS age distribution. |
| High rematch rate | Marketplace thrashing. | Rematch budget, redispatch cap, conservative mode. | Rematch count, hold expiry count. |
| Support spike | Users lose trust or need explanations. | Replay evidence and clear states. | Replay card, support reason code. |
| Driver scarcity | Longer waits and lower acceptance. | Dispatch weighting, incentives, expectation setting. | Acceptance rate, coverage SLO. |
| Pricing pressure | Prices feel arbitrary. | Hysteresis, caps, crisis posture, reason codes. | Quote receipt. |

## Interview Defense Questions

- What fails first under a stadium event or airport rush?
- Which signals show marketplace instability before service health goes red?
- How do you prevent one hot zone from causing global churn?
- How do you cap rematching?
- How do you keep pricing explainable under demand spikes?

## Artifact to Produce

`worksheets/scale-ride-sharing.md`

## Common Weak Answer

> “We will scale matching horizontally and use Kafka for driver updates.”

## Stronger Answer

> “At scale, the marketplace pressure appears as hot zones, stale GPS, hold expiry, pricing volatility, rematch churn, and fairness drift. Horizontal scaling helps throughput, but it does not solve commitment instability. I need budgets, TTLs, caps, and posture changes.”

---

# 8. Consistency Mapping

## Senior Architect Framing

Consistency in ride-sharing is a trust contract. The system must clearly distinguish possible, held, committed, repaired, reassigned, canceled, and compensated states.

The user experiences these as promises, not replication models.

## Consistency Mapping Table

| Consistency Boundary | Trust Rule | Artifact | Risk If Wrong |
|---|---|---|---|
| Candidate | Candidate is possible, not promised. | Candidate list with freshness metadata. | Rider sees driver that was never truly available. |
| Hold | Intent is temporary and expires. | matchHoldId with TTL. | Hold becomes mistaken for commitment. |
| Driver acceptance | Acceptance is necessary but not sufficient. | Acceptance event with timestamp. | System commits despite stale GPS or policy conflict. |
| Commit | Match becomes liability only after gates pass. | matchId. | Rider/driver trust breaks if rematched casually. |
| Price | Quote must be tied to policy and evidence. | Pricing quote receipt. | Price feels arbitrary or unfair. |
| ETA | High-confidence ETA requires fresh traffic/GPS. | ETA evidence snapshot. | Countdown becomes unbelievable. |
| Post-commit conflict | Promise must be repaired, not casually replaced. | Repair/reassign/compensate policy. | Marketplace feels unstable. |

## State Language

| State | Meaning |
|---|---|
| Searching | No driver promise exists. |
| Holding | Candidate temporarily reserved for evaluation. |
| Offered | Driver has received offer. |
| Accepted | Driver accepted, but commit gates may still be pending. |
| Committed | matchId issued; platform has created obligation. |
| Repairing | Post-commit evidence diverged; platform is trying to preserve promise. |
| Reassigned | Controlled replacement after repair failed. |
| Escalated | Human/specialist review required. |
| Canceled | Ride ended before completion. |
| Compensated | Policy-based remediation applied. |

## Interview Defense Questions

- Why is driver acceptance not the same as match commitment?
- Which state is temporary?
- Which state creates liability?
- What does the system do when evidence conflicts at commit?
- What must be replayed after reassignment?

## Artifact to Produce

`worksheets/consistency-ride-sharing.md`

## Common Weak Answer

> “We will eventually update the rider and driver with the match.”

## Stronger Answer

> “The state model must protect the trust contract. Candidate is not promised. Hold is intent. Driver acceptance is not sufficient. Commit requires admissible evidence. After commit, the system repairs first, reassigns carefully, and compensates when policy thresholds are crossed.”

---

# 9. Latency Mapping

## Senior Architect Framing

Latency in ride-sharing becomes marketplace behavior. Waiting causes riders to cancel, drivers to reject, and liquidity to drain. The same delay has different consequences depending on journey phase.

## Latency Mapping Table

| Latency Moment | User/Marketplace Behavior | Control | Replay Evidence |
|---|---|---|---|
| Request delay | Rider may cancel or tap again. | Honest search state, idempotency. | Request timestamp, duplicate tap handling. |
| Candidate search delay | Candidate data becomes stale while computing. | Freshness filter and compute budget. | Candidate fetch time, GPS age. |
| Driver offer delay | Driver may ignore or reject. | Offer TTL and bounded dispatch. | Offer timestamp, response time. |
| Commit delay | Rider/driver uncertainty rises. | Hold TTL, commit budget, clear state. | Hold age, gate timing. |
| ETA jitter | Rider loses confidence. | ETA confidence band and update policy. | ETA versions, traffic timestamp. |
| Pricing delay | Quote may expire or become stale. | Quote TTL and repricing reason. | Quote receipt, policy version. |
| Post-commit repair delay | Trust damage and support contact. | Repair window, controlled reassignment. | Repair attempt, reassignment branch. |

## Interview Defense Questions

- Where does latency cause user behavior change?
- Where does latency turn into churn?
- Which latency needs a budget?
- Which delay should show pending state?
- Which delay should block commitment?

## Artifact to Produce

`worksheets/latency-ride-sharing.md`

## Common Weak Answer

> “We need low-latency APIs and p99 monitoring.”

## Stronger Answer

> “Latency should be weighted by journey moment. Delay before browsing is tolerable. Delay at commit creates uncertainty. Delay after commit becomes obligation management. I will use hold TTLs, commit budgets, idempotency, clear states, and replay evidence.”

---

# 10. Failure Mapping

## Senior Architect Framing

Ride-sharing often fails as marketplace instability before service outage. Requests return 200s, but rematches rise, drivers reject more, riders cancel, replay coverage drops, and prices oscillate.

Failure is the behavior the system follows under uncertainty.

## Failure Mapping Table

| Failure Signal | What It Looks Like | Response | Evidence |
|---|---|---|---|
| GPS hard-stale rate rises | Location exists but cannot support commitment. | Enforce hard TTL and refuse/defer commit. | GPS age, TTL policy, gate result. |
| Rematch rate spikes | Riders see drivers change repeatedly. | Cap redispatch, enter conservative mode. | Rematch count, redispatch count. |
| Hold expiry increases | Holds expire before commit. | Shorten path, reduce candidate churn, assisted handling. | Hold TTL, expiration reason. |
| Replay coverage drops | Decisions cannot be defended. | Lower autonomy and restore logging path. | Replay gap, affected paths. |
| Pricing oscillates | Riders feel pricing is arbitrary. | Apply hysteresis and caps. | Pricing receipt, dampening reason. |
| Fairness disparity grows | Some regions/cohorts wait longer or earn less. | Dispatch weights, incentives, surge dampening. | Before/after disparity. |
| Safety/fraud signal fires | Optimization becomes unsafe. | Hard stop and specialist review. | Risk trigger, policy version, owner. |

## Interview Defense Questions

- How can the platform fail while all services are technically healthy?
- What are the marketplace health signals?
- What is the correct response to replay coverage dropping?
- Why is rematch rate a failure signal?
- Which failures require hard stop?

## Artifact to Produce

`worksheets/failure-ride-sharing.md`

## Common Weak Answer

> “We will use retries, circuit breakers, and fallback services.”

## Stronger Answer

> “Those are useful, but ride-sharing failure often appears as churn and instability. I need to monitor rematch rate, cancellation rate, acceptance rate, GPS hard-stale rate, hold expiry, replay coverage, pricing oscillation, and fairness drift. The system must change posture before services go down.”

---

# 11. Economics Mapping

## Senior Architect Framing

Economics in ride-sharing is shaped by repeated behavior: redispatch, ETA recomputation, pricing recalculation, incentives, support rework, and real-world inefficiency.

Cost is not only cloud spend. It includes compute, incentives, driver time, rider trust, support load, and route waste.

## Economics Mapping Table

| Economic Multiplier | Ride-Sharing Example | Control | Metric |
|---|---|---|---|
| Redispatch loops | Repeated driver reassignment. | Redispatch cap. | Redispatches per successful ride. |
| Inference recomputation | ETA/pricing/ranking recalculated repeatedly. | Inference DAG budget. | Compute cost per match. |
| Pricing volatility | Frequent quote changes. | Dampening and hysteresis. | Quote changes per session. |
| Incentive churn | More incentives used to repair instability. | Incentive budget and reason codes. | Incentive cost per completed ride. |
| Support rework | Users ask why driver/price changed. | Replay card and pricing receipt. | Support contacts per ride. |
| Real-world waste | Drivers reposition or drive inefficiently. | Route stability and churn controls. | Idle miles, deadhead miles. |
| Human operations | Manual intervention becomes normal. | Assisted lane with clear triggers. | Manual reviews per ride request. |
| Safety/fraud review | High-risk cases need specialist handling. | Hard-stop rules and evidence packet. | Review cost per flagged ride. |

## Interview Defense Questions

- Where does cost multiply during a rematch storm?
- What is the unit of value?
- What is the unit cost?
- What budget would you enforce per ride request?
- How do you reduce real-world waste, not just compute cost?
- Who can stop economically unsafe behavior?

## Artifact to Produce

`worksheets/economics-ride-sharing.md`

## Common Weak Answer

> “We will optimize infrastructure cost and cache more.”

## Stronger Answer

> “Ride-sharing economics are marketplace behavior under pressure. Redispatch, ETA recomputation, pricing volatility, incentives, support contacts, and driver deadhead miles all become cost. I would measure cost per successful match and cap the behaviors that multiply cost without improving marketplace value.”

---

# 12. Final Integrated Design Review

## Purpose

This final section combines all lenses into one senior-architect review.

## Integrated Review Table

| Lens | Most Important Ride-Sharing Question | Artifact |
|---|---|---|
| 7-Step Method | What is the real problem: matching or marketplace commitment? | 7-step map |
| Customer Journey | What does rider/driver believe at each phase? | Journey map |
| Capability Map | Which capability owns each promise? | Capability map |
| ARCHVIEW | Where are responsibility, control, and stop authority visible? | ARCHVIEW worksheet |
| AI Primitives | What are the tokens, TTLs, receipts, owners, and replay records? | Primitive mapping |
| ROCS | How do reliability, observability, cost, and sustainability interact? | ROCS worksheet |
| Scale | What happens in hot zones and demand spikes? | Scale worksheet |
| Consistency | When does intent become liability? | State and commit model |
| Latency | Where does waiting change behavior? | Latency map |
| Failure | How does the marketplace fail while services stay up? | Failure map |
| Economics | Where does cost multiply under uncertainty? | Economics worksheet |

## Final Interview Practice Prompt

Use this prompt to test your design:

> Design a ride-sharing platform for a dense city during peak demand. Your answer must explain hold versus commit, freshness budgets, bounded churn, pricing receipts, fairness guardrails, inference-DAG budgets, phase-aware conflict handling, safety hard stops, and replay evidence. Do not start with implementation technologies. Start with the marketplace promise and commitment boundary.

## Senior Answer Structure

1. Start with the system identity:
   - “This is a real-time marketplace commitment engine.”

2. Name actors:
   - Rider, driver, marketplace, platform, safety/fraud, support, regulator.

3. Name commitments:
   - Quote, hold, commit, pickup ETA, payment, cancellation, compensation.

4. Define hold versus commit:
   - `matchHoldId` is temporary intent.
   - `matchId` is liability.

5. Define admissible evidence:
   - GPS, ETA, demand/supply, acceptance, pricing, safety, fairness.

6. Define control surfaces:
   - TTLs, budgets, caps, hysteresis, fairness thresholds, hard stops.

7. Define failure response:
   - Conservative mode, assisted handling, repair, reassign, compensate, refuse.

8. Define replay:
   - “We can explain why this rider got this driver at this price.”

## Final Senior Line

> A ride-sharing system is not a nearest-driver lookup. It is a real-time marketplace commitment engine. The senior design separates hold from commit, treats freshness as admissibility, bounds rematching, makes pricing replayable, operates fairness as a control loop, budgets the inference DAG, hard-stops safety and fraud risk, and preserves evidence so the platform can prove why this rider got this driver at this price.
