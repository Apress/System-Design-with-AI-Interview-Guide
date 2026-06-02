# Chapter 19 Solution Guide

## Exercise 1 Solution: Fraud as an Authority Allocation System

A strong answer should explain that fraud detection is not simply event collection, feature engineering, model scoring, and blocking. Fraud detection is an authority allocation system. The platform is deciding what it is allowed to permit, challenge, delay, deny, hold, restrict, or block under uncertainty.

A model score is advisory. It says, “This looks risky.” It does not automatically mean the platform has authority to deny a refund, hold a payout, hard-block an account, or restrict capability. Those actions create liability. They affect money, access, reputation, seller operations, customer trust, compliance posture, and support workload.

A senior design separates:

- **Advisory risk**: model score, rules, reason codes, soft signals, graph anomalies.
- **Reversible friction**: step-up challenge, MFA, KYC refresh, 3DS, document proof, temporary review.
- **Liability action**: refund denial, payout hold, account hard block, account restriction, capability freeze.
- **Appeal and reversal**: review, restore, compensate, retrain, policy update.

Actors include:

- Customer
- Seller
- Fraud operations
- Appeals reviewer
- Compliance and risk
- Finance and payment operations
- Customer support
- Identity provider
- Payment system
- Policy owner
- Platform governance owner

False enforcement can be as damaging as fraud loss because it denies legitimate customers, holds legitimate seller money, increases support load, creates appeal spikes, causes churn, and may create regulatory or reputational exposure.

Before enforcement, the system must have:

- Pinned policy version
- Evidence snapshot
- Evidence freshness proof
- Evidence tier result
- Reason codes
- Authority token
- Reversibility classification
- Appeal path
- Decision Replay Card
- Stop posture

The system must later replay why it denied, held, blocked, stepped up, restored, or compensated under the policy and evidence available at decision time.

Senior answer:

> I am not designing a fraud score. I am designing an authority allocation system. A score advises, but a token enforces. Liability actions require pinned policy, admissible evidence, reversibility thinking, stop authority, and replay proof.

---

## Exercise 2 Solution: Advisory Risk vs. Enforcement Token

A mature design uses explicit tokens to mark authority boundaries.

| Token | Meaning | Authority Level |
|---|---|---|
| `riskDecisionId` | Advisory fraud assessment was produced. | Advisory only. |
| `stepUpChallengeId` | Reversible proof-gathering challenge was issued. | Friction, not punishment. |
| `enforcementId` | The platform crossed into liability action. | Enforcement boundary. |
| `refundDenyId` | Refund denial was committed. | Liability action. |
| `payoutHoldId` | Payout was held under policy. | Liability action, often reversible/time-bound. |
| `hardBlockId` | Account or capability was hard-blocked. | Highest liability action. |

`riskDecisionId` proves that a risk assessment happened. It should include model version, score, uncertainty, reason codes, evidence snapshot ID, and policy context. But it is not enough for liability because a score does not prove authority.

`stepUpChallengeId` proves the system chose reversible friction. This is the safe degradation path. It says, “We are not confident enough to enforce, but not naive enough to proceed.” Step-up can gather admissible proof without yet denying, holding, or blocking.

`enforcementId` proves the platform crossed the enforcement boundary. It should only be minted when:

- policy is pinned,
- evidence is admissible,
- evidence is fresh enough,
- conflicts are resolved or reviewed,
- replay receipt is ready,
- appeal path exists,
- stop authority has not frozen the capability.

`refundDenyId`, `payoutHoldId`, and `hardBlockId` are specific liability tokens. They should never be side effects of scoring alone.

Receipt before enforcement should include:

- `chainId`
- `riskDecisionId`
- `stepUpChallengeId`, if used
- `enforcementId`
- liability token ID
- policy bundle version
- evidence snapshot ID
- evidence tier decision
- freshness state
- model version
- uncertainty
- reason codes
- actor mode: automated, assisted, human
- appeal path
- reversal path
- owner
- timestamp

Senior answer:

> `riskDecisionId` is an opinion. `stepUpChallengeId` is reversible proof gathering. `enforcementId` is liability. I do not mint refundDenyId, payoutHoldId, or hardBlockId unless policy, evidence, replay, and appeal are ready.

---

## Exercise 3 Solution: Fraud Clocks and Label Delay

Fraud systems operate across multiple clocks.

| Clock | Meaning | Design Rule |
|---|---|---|
| Event time | When the transaction, refund, payout, login, or account action occurred. | Useful for reconstruction, not sufficient alone for enforcement. |
| Ingestion time | When telemetry or evidence reached the platform. | Determines what the platform actually knew before action. |
| Decision time | When the platform scored, stepped up, held, denied, or blocked. | Enforcement must use evidence and policy admissible at this moment. |
| Label time | When chargeback, appeal, reversal, investigation, or confirmation arrives. | Used for learning, not retroactive justification. |

The key rule: fraud is judged at decision time but learned at label time.

If a chargeback arrives two weeks later, that label can improve future training, thresholds, policy, and review routing. It cannot retroactively justify a past enforcement decision if the evidence was not available or admissible when the platform acted.

Signals that must be fresh at enforcement time include:

- identity verification state,
- device continuity,
- session integrity,
- authentication posture,
- account status,
- velocity counters,
- payment instrument state,
- settlement state,
- active policy bundle,
- prior enforcement state.

Architecture should preserve:

- event timestamp,
- ingestion timestamp,
- decision timestamp,
- label timestamp,
- evidence snapshot,
- model version,
- policy version,
- freshness ages,
- reason codes,
- action taken,
- later label linked back to the original decision.

Delayed labels should feed:

- model retraining,
- calibration,
- policy review,
- threshold tuning,
- appeal-pattern analysis,
- cohort fairness review,
- stop-authority triggers.

Replay months later should show:

> At decision time, the platform knew X, did not yet know Y, used policy version P, score/model version M, evidence snapshot E, and chose STEP_UP / HOLD / DENY / BLOCK for these reason codes. Later label L arrived and was used for learning, not for rewriting the original justification.

Senior answer:

> Labels improve the future. They do not rewrite the past.

---

## Exercise 4 Solution: Reversible Control Ladder

Increasing hard blocks and refund denials whenever model risk is high is an architecture failure because it lets advisory risk jump directly into punishment. Fraud systems should become reversibly strict before punitive.

A good control ladder:

| Mode | Use When | Reversibility |
|---|---|---|
| Allow + monitor | Low risk, clean evidence, normal behavior. | Fully reversible through normal workflow. |
| Step-up only | Conflicting signals, weak identity, elevated uncertainty. | Highly reversible. |
| Soft hold / soft block | Money, payout, or account action needs time-boxed containment. | Reversible with proof or review. |
| Freeze liability actions | Replay gaps, appeal spikes, policy mismatch, high uncertainty. | Reversible after evidence/policy recovery. |
| Human review only | Severe uncertainty, high-risk cohort, regulatory exposure. | Depends on action taken. |
| Hard enforcement | Strong admissible evidence, pinned policy, replay receipt. | Least reversible; must be appealable. |

The mature move is not “deny more.” The mature move is “increase friction before punishment.”

Hard enforcement is justified only when:

- hard constraints or Tier 1 evidence support it,
- Tier 2 model evidence aligns rather than conflicts,
- Tier 3 soft signals are not the sole basis,
- evidence is fresh enough,
- policy is pinned,
- replay is complete,
- appeal path exists,
- stop authority has not frozen the capability.

When uncertainty rises, the system should:

- step up,
- refresh evidence,
- defer,
- soft hold,
- route to review,
- freeze liability action,
- avoid irreversible punishment.

Senior answer:

> Fraud systems do not win by being aggressive. They win by being reversibly strict.

---

## Exercise 5 Solution: Evidence Tiers and Enforcement Admissibility

The system should not automatically deny the refund.

A high fraud score and suspicious device velocity are important signals, but they do not outrank Tier 1 system-of-record truth. If payment and identity records show the purchase was authenticated and settled cleanly, the system has a conflict at the enforcement boundary.

Evidence hierarchy:

| Tier | Examples | Allowed Use |
|---|---|---|
| Hard constraints | Sanctions, jurisdiction, regulatory restrictions, privacy/consent, product policy. | Can block or route to compliance regardless of score. |
| Tier 1 — System of record | Identity verification, payment confirmation, account status, enforcement history, active policy bundle. | Required for liability actions. |
| Tier 2 — Model evidence | Fraud score, calibrated risk, reason codes, uncertainty bands, model version. | Supports decision; cannot override conflicting Tier 1. |
| Tier 3 — Soft signals | Velocity, device fingerprint, graph proximity, behavioral anomaly. | Can trigger step-up or review; cannot justify hard enforcement alone. |

When Tier 1 conflicts with Tier 2, do not average truth. This is not a ranking problem. It is a liability problem.

Correct behavior:

- Do not auto-deny.
- Refresh identity and payment evidence.
- Trigger step-up if identity uncertainty remains.
- Defer decision or time-box soft hold if money movement risk exists.
- Route to case review if risk remains high.
- Preserve evidence snapshot and conflict reason.
- Emit replay receipt for step-up, hold, or review path.

Replay evidence should include:

- refund request ID,
- riskDecisionId,
- Tier 1 evidence state,
- Tier 2 score/model state,
- Tier 3 soft signals,
- evidence freshness,
- policy version,
- conflict reason code,
- chosen control mode,
- stepUpChallengeId or review case ID,
- liability token if eventually enforced,
- appeal and reversal path.

Senior answer:

> Model evidence can raise suspicion. It cannot outrank system-of-record truth. Conflict at enforcement time should move to step-up, refresh, defer, or review—not automatic denial.

---

## Bonus Exercise 6 Solution: Stop Authority for Fraud Enforcement

A strong design should use capability-scoped stop authority. You do not “stop fraud.” You freeze the unsafe enforcement path.

| Signal | Control Action |
|---|---|
| Appeal overturn spike | Freeze refund denial; route to step-up + case review. |
| Payout-hold reversal spike | Shift payout risk to step-up only; keep holds time-bounded. |
| Replay coverage < 100% for liability actions | Freeze liability tokens until receipts are complete. |
| Policy/schema mismatch spike | Quarantine bundle or schema version; roll back to last known good. |
| Uncertainty spike + evidence conflicts | Shift to step-up only; do not deny more. |
| Identity provider degraded | Cap step-up rate; use fallback proof; avoid hard enforcement for missing identity. |
| Manual review backlog exceeds threshold | Narrow autonomy or freeze high-risk enforcement paths. |

Owners:

- fraud policy owner,
- enforcement capability owner,
- appeals owner,
- compliance/risk owner,
- identity provider owner,
- payments/finance owner,
- replay/governance owner,
- incident commander for major events.

Stop receipt should include:

- signal,
- threshold crossed,
- affected capability,
- affected cohort,
- action taken,
- policy version,
- owner,
- timestamp,
- replay coverage,
- re-enable criteria.

Re-enable criteria:

- replay coverage restored,
- appeal overturns back within bounds,
- payout reversals back within bounds,
- policy/schema reconciled,
- identity/step-up providers healthy,
- manual review backlog under threshold,
- new or confirmed policy bundle version recorded,
- owner approval captured.

Senior answer:

> Stop authority is not a meeting. It is the system’s ability to freeze liability actions when proof weakens.

---

## Bonus Exercise 7 Solution: ROCS Fraud Control

ROCS turns fraud operations into runtime governance.

### Reliability

Fraud reliability is not merely scoring uptime. It asks whether enforcement remains bounded under attack, drift, dependency failure, and evidence conflict.

Controls:

- idempotent enforcement,
- bounded retries,
- control ladder,
- step-up fallback,
- capability-scoped freeze,
- provider degradation policy.

Metrics:

- duplicate holds,
- repeated denials,
- enforcement error rate,
- dependency health,
- evidence conflict rate.

### Observability

Observability asks whether the platform can replay why it denied, held, blocked, stepped up, or restored.

Controls:

- Decision Replay Card,
- policy pin,
- evidence snapshot,
- evidence freshness,
- reason codes,
- appeal/reversal linkage.

Metrics:

- replay coverage,
- missing evidence rate,
- missing policy version rate,
- support reconstruction time.

### Cost

Fraud controls create costs: step-up provider calls, identity checks, manual review, appeals, support, churn, chargebacks, compliance exposure.

Controls:

- budgets,
- provider rate caps,
- review prioritization,
- risk-based routing,
- false-enforcement caps.

Metrics:

- cost per step-up,
- manual review backlog,
- appeal rate,
- support contact rate,
- false-positive cost,
- chargeback cost.

### Sustainability

Sustainability asks whether trust can survive as attackers adapt.

Controls:

- harm-latency limits,
- false-enforcement limits,
- policy audits,
- drift monitoring,
- re-enable criteria,
- cohort monitoring.

Metrics:

- appeal overturn rate,
- payout reversal rate,
- complaint spike,
- cohort disparity,
- churn,
- policy exception rate.

Senior answer:

> ROCS keeps fraud enforcement bounded, provable, cost-aware, and trust-preserving while adversaries adapt.

---

## Bonus Exercise 8 Solution: Adversary Adaptation and Drift

This scenario includes all three fraud drift types.

| Drift Type | What Changed | Signal | Control |
|---|---|---|---|
| Model drift | Fraud patterns changed. | Calibration decay, precision/recall shift, score distribution shift. | Recalibrate, retrain, shadow evaluate. |
| Policy drift | Rules/thresholds changed behavior. | Denial increase, complaint spike, cohort disparity, appeal overturn rise. | Policy versioning, rollback, quarantine, stop authority. |
| Attacker adaptation | Adversaries changed strategy. | Channel shift, step-up bypass, identity laundering, synthetic activity. | Graph detection, step-up redesign, containment. |

Monitoring model accuracy alone is insufficient because the model may still appear stable while:

- policy thresholds over-enforce,
- attackers move channels,
- step-up providers are bypassed,
- good users are denied,
- appeal reversals spike,
- support complaints concentrate in one cohort.

Signals of attacker adaptation:

- channel migration,
- step-up bypass attempts,
- synthetic identity clusters,
- device/session anomalies,
- graph proximity changes,
- coordinated activity.

Signals of policy drift:

- sudden increase in refund denials,
- payout holds,
- hard blocks,
- complaint spikes,
- cohort disparities,
- manual review surge.

Signals of false-enforcement drift:

- appeal overturns,
- reversals,
- customer complaints,
- support contacts,
- churn,
- social/reputation signal,
- legitimate-seller payout complaints.

Controls:

- shadow evaluate new model/policy,
- roll back policy bundle,
- quarantine policy version,
- freeze affected enforcement,
- shift to step-up only,
- retrain/recalibrate,
- redesign step-up,
- review affected cohort.

Senior answer:

> Fraud drift is not only model drift. It is model drift, policy drift, and attacker adaptation moving at the same time.

---

## Bonus Exercise 9 Solution: Green Dashboards, Red Trust

This is not an uptime incident. It is a defensibility incident.

Services are healthy. Latency is normal. Queues are moving. But the platform is minting false liability at scale. Refund denials increased because policy changed the meaning of suspicious faster than evidence could defend.

Why dashboards hide it:

- API success does not mean enforcement was justified.
- Fraud queue health does not mean false enforcement is bounded.
- Low latency can accelerate wrong decisions.
- Model score availability does not prove admissible evidence.
- RefundDenyId creation can look “successful” while harming users.

Correct response:

1. Freeze refund denial for the affected cohort.
2. Shift to step-up only plus case review.
3. Stop minting liability tokens where replay is weak.
4. Preserve replay receipts for all affected decisions.
5. Identify stale evidence and policy version involved.
6. Link appeals and reversals back to original decisions.
7. Correct policy under a new version.
8. Restore only after re-enable criteria are met.

Replay receipts reconstruct:

- which users were denied,
- which evidence was used,
- how stale it was,
- which policy version applied,
- which model version scored,
- which reason codes fired,
- which appeals overturned,
- which cohorts were affected,
- which actions were restored or compensated.

Re-enable criteria:

- replay coverage restored,
- policy version corrected,
- appeal overturns back within bounds,
- affected users remediated,
- evidence freshness fixed,
- identity dependency healthy,
- stop owner approval recorded.

Senior answer:

> The system did not go down. It stayed up and became confidently wrong. That is a fraud-platform outage.

---

## Bonus Exercise 10 Solution: Senior Architect Fraud Detection Defense

A mature answer should acknowledge models, features, rules, case queues, and review tools, but explain that they do not define enforcement authority.

A senior answer starts like this:

> I am not designing only a fraud model. I am designing an authority allocation system.

Key defense points:

### Advisory versus enforcement

`riskDecisionId` is advisory. It does not deny, hold, or block. Enforcement requires separate tokens.

### Tokenized liability

Use `stepUpChallengeId` for reversible proof gathering, `enforcementId` for crossing liability, and specific liability tokens such as `refundDenyId`, `payoutHoldId`, and `hardBlockId`.

### Evidence tiers

Hard constraints and Tier 1 evidence govern liability. Tier 2 model evidence supports. Tier 3 soft signals raise suspicion.

### Label delay

Decisions are made now. Truth often arrives later. Labels improve future models and policy; they do not rewrite history.

### Reversibility

Fraud systems should climb from allow to step-up to soft hold to review before hard enforcement.

### Stop authority

When appeal overturns, reversals, replay gaps, policy mismatch, identity degradation, or uncertainty spikes occur, freeze the affected enforcement capability.

### ROCS

Reliability bounds enforcement. Observability proves decisions. Cost bounds step-up/review/appeal/support burden. Sustainability protects trust while attackers adapt.

### Replay

The system must prove why it denied a refund, held a payout, hard-blocked an account, restored a user, or compensated a seller under a pinned policy and decision-time evidence.

Senior interview line:

> I would not frame fraud detection as collect events, score risk, and block users. I would frame it as an authority allocation system. A score advises; a token enforces. I separate riskDecisionId from enforcementId, use step-up as reversible friction, require evidence tiers and policy pins before liability actions, preserve decision-time evidence despite label delay, operate a reversible control ladder, and freeze enforcement when proof weakens. Months later, I can replay why a refund was denied, payout was held, or account was blocked.
