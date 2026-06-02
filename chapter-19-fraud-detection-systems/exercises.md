# Chapter 19 Exercises

## Exercise 1: Fraud as an Authority Allocation System

A candidate says, “A fraud detection system scores transactions and blocks risky users.”

Why is that incomplete?

Your answer should include:

- Why fraud detection is an authority allocation system, not only an ML pipeline
- Why “high risk” is not the same as “allowed to enforce”
- Difference between advisory scoring and liability action
- Which actors are affected: customer, seller, fraud operations, appeals, compliance, finance, payments, support, and policy owner
- Why false enforcement can be as damaging as fraud loss
- What evidence must exist before denying, holding, or blocking
- What must be replayable later

## Exercise 2: Advisory Risk vs. Enforcement Token

Design the boundary between advisory risk and enforcement using `riskDecisionId`, `stepUpChallengeId`, `enforcementId`, `refundDenyId`, `payoutHoldId`, and `hardBlockId`.

Your answer should include:

- What `riskDecisionId` proves
- Why `riskDecisionId` is not enough for liability action
- What `stepUpChallengeId` proves
- Why step-up is reversible friction
- What `enforcementId` proves
- When to mint `refundDenyId`, `payoutHoldId`, or `hardBlockId`
- What receipt must be emitted before enforcement

## Exercise 3: Fraud Clocks and Label Delay

A fraud model makes a decision today, but the real label arrives two weeks later through a chargeback, appeal, reversal, or investigation.

How should the architecture handle this?

Your answer should include:

- Difference between event time, ingestion time, decision time, and label time
- Why enforcement must be judged using decision-time evidence
- Why label-time evidence cannot retroactively justify past enforcement
- Which signals must be fresh at enforcement time
- How delayed labels should improve future model and policy behavior
- How to preserve evidence snapshots for audit and appeals
- What replay should show months later

## Exercise 4: Reversible Control Ladder

A team wants to reduce fraud losses quickly by increasing hard blocks and refund denials whenever model risk is high.

Analyze this as an architecture failure.

Your answer should include:

- Why fraud systems should become reversibly strict before punitive
- When to use allow + monitor
- When to use step-up only
- When to use soft hold or soft block
- When to freeze liability actions
- When to route to human review
- When hard enforcement is justified
- Why uncertainty should increase friction before punishment

## Exercise 5: Evidence Tiers and Enforcement Admissibility

A refund request has a high fraud score and suspicious device velocity, but Tier 1 payment and identity records show the purchase was authenticated and settled cleanly.

Should the system deny the refund automatically?

Your answer should include:

- Why model evidence cannot outrank system-of-record truth
- Difference between hard constraints, Tier 1 evidence, Tier 2 model evidence, and Tier 3 soft signals
- Why Tier 3 soft signals can trigger step-up or review but not hard enforcement alone
- What to do when Tier 1 conflicts with Tier 2
- When to refresh evidence, step up, defer, or route to review
- What replay evidence must be preserved
- Why conflict at enforcement boundary is a liability problem, not a ranking problem

---

# Bonus GitHub Exercises

## Bonus Exercise 6: Stop Authority for Fraud Enforcement

Design stop authority for refund denial, payout holds, hard blocks, and account restrictions.

## Bonus Exercise 7: ROCS Fraud Control

Apply ROCS to fraud enforcement.

## Bonus Exercise 8: Adversary Adaptation and Drift

Fraud losses decreased for two weeks after a policy update, but then attackers shifted channels, step-up bypass attempts rose, appeal overturns increased, and complaint spikes appeared in one seller cohort.

Analyze this as drift.

## Bonus Exercise 9: Incident Response — Green Dashboards, Red Trust

A policy tweak increases refund denials. Latency is fine, services are healthy, fraud queue metrics look normal, but appeals and support complaints spike. Many denials used stale identity evidence and weak replay coverage.

Analyze the incident.

## Bonus Exercise 10: Senior Architect Fraud Detection Defense

An interviewer says, “Fraud detection is straightforward: collect events, build features, train a model, score transactions, send high-risk cases to review, and block bad actors.”

Defend a more mature design.
