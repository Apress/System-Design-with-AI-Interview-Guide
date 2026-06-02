# Earlier-Lens Mapping Worksheet: Fraud Detection Systems

This worksheet helps you apply the earlier lenses from Part I and Part II to Chapter 19: Fraud Detection Systems.

The purpose is not to memorize a “fraud ML pipeline” answer. The purpose is to prove that you can reuse the same system design method when uncertainty, authority, harm, money, evidence, appeals, and customer trust collide at the enforcement boundary.

Use this worksheet before drawing the final architecture. A senior answer should show that you understand advisory risk, enforcement authority, evidence tiers, fraud clocks, label delay, reversible controls, stop authority, ROCS loops, failure modes, economics, and replay requirements.

---

## 1. 7-Step Method Mapping

| Step | Fraud Detection Application | Senior Architect Framing | Reader Notes |
|---|---|---|---|
| 1. Clarify the problem | Are we evaluating transactions, refunds, payouts, account access, seller risk, or full enforcement lifecycle? | “I need to know which enforcement action the platform is allowed to take.” |  |
| 2. Identify actors | Customer, seller, fraud ops, appeals, compliance, finance, payments, identity provider, support, policy owner. | “Fraud affects money, access, reputation, and trust.” |  |
| 3. Map the journey | Event occurs, telemetry arrives, score is produced, evidence is checked, step-up or enforcement happens, appeal and labels arrive later. | “The journey does not end at model score.” |  |
| 4. Define constraints | Label delay, stale evidence, false enforcement, fraud bursts, provider degradation, appeal spikes, replay gaps. | “The platform must act before it knows the full truth.” |  |
| 5. Name commitments | `riskDecisionId`, `stepUpChallengeId`, `enforcementId`, `refundDenyId`, `payoutHoldId`, `hardBlockId`. | “A score advises. A token enforces.” |  |
| 6. Choose architecture | Intake, normalization, scoring, evidence gate, step-up, enforcement, appeal, feedback, replay, stop authority. | “I draw the enforcement boundary before drawing model services.” |  |
| 7. Defend trade-offs | Fraud loss vs false enforcement, automation vs review, friction vs trust, speed vs proof, model score vs admissible evidence. | “When uncertainty rises, friction should rise before punishment.” |  |

---

## 2. Customer Journey Mapping

| Journey Moment | User/Seller Believes | Platform Risk | Architecture Response |
|---|---|---|---|
| User acts | Transaction, refund, login, or payout should proceed normally. | Action may be fraudulent or legitimate. | Intake and normalize event. |
| Event is scored | Platform is evaluating risk. | Model score may be overconfident. | Mint `riskDecisionId`, advisory only. |
| Evidence checked | Platform should use real facts. | Evidence may be stale, missing, or conflicting. | Evidence-tier gate and freshness policy. |
| Step-up issued | User can prove identity or legitimacy. | Friction may become excessive. | Mint `stepUpChallengeId`, time-box challenge. |
| Enforcement happens | Refund denied, payout held, account restricted. | False enforcement causes harm. | Mint `enforcementId` and liability token only with proof. |
| Appeal begins | Decision can be challenged. | No replay means no defensibility. | Appeal review linked to replay card. |
| Label arrives | Chargeback, reversal, appeal outcome, investigation result. | Future learning may rewrite past truth incorrectly. | Attach label to original decision; do not retro-justify. |

---

## 3. Capability Map

| Capability | Responsibility | Commitment Boundary | Owner |
|---|---|---|---|
| Event Intake | Receive transaction/refund/payout/account events. | Raw event accepted. | Platform ingestion owner |
| Normalization | Create consistent event schema. | Usable risk event. | Data platform owner |
| Scoring | Produce advisory risk. | `riskDecisionId`. | Model owner |
| Evidence Gate | Determine admissible evidence. | Evidence snapshot. | Fraud policy owner |
| Step-up | Gather reversible proof. | `stepUpChallengeId`. | Identity/auth owner |
| Enforcement | Deny, hold, block, restrict, freeze. | `enforcementId` and liability token. | Enforcement owner |
| Case Review | Human review and override. | Review decision. | Fraud operations owner |
| Appeals | Challenge and reverse decisions. | Appeal result. | Appeals owner |
| Feedback/Labels | Join delayed outcomes. | Label link. | ML/data owner |
| Replay/Audit | Prove why action happened. | Decision Replay Card. | Governance owner |
| Stop Authority | Freeze unsafe enforcement. | Capability stop event. | Risk/policy owner |

---

## 4. ARCHVIEW Mapping

| ARCHVIEW Concern | Fraud Detection View |
|---|---|
| Actors | Customer, seller, fraud ops, appeals, compliance, finance, payments, identity, support, policy owner. |
| Responsibilities | Intake, scoring, evidence gate, step-up, enforcement, appeal, feedback, replay. |
| Control surfaces | Advisory-to-enforcement boundary, evidence tiers, freshness policy, control ladder, stop authority. |
| Commitment points | `riskDecisionId`, `stepUpChallengeId`, `enforcementId`, `refundDenyId`, `payoutHoldId`, `hardBlockId`. |
| Ownership | Model owner, policy owner, enforcement owner, appeal owner, identity owner, replay owner. |
| Evidence | Hard constraints, Tier 1 system of record, Tier 2 model evidence, Tier 3 soft signals. |
| Degradation | Allow, step-up, soft hold, freeze, human review, hard enforcement. |
| Stop authority | Freeze refund denial, payout holds, hard blocks, or account restrictions by capability. |

---

## 5. AI Primitives Mapping

| AI Primitive | Fraud Application | Artifact |
|---|---|---|
| Authority | What can the platform deny, hold, block, challenge, or restore? | Enforcement policy and stop authority |
| Commitment | Score becomes liability only when tokenized. | `riskDecisionId` / `enforcementId` schemas |
| Time | Decision time and label time differ. | Freshness and label-delay policy |
| Degradation | Step-up and soft hold before hard enforcement. | Reversible control ladder |
| Evidence/Replay | Prove why enforcement occurred. | Fraud Decision Replay Card |
| Ownership | Each enforcement capability needs an owner who can stop it. | Stop-authority matrix |

---

## 6. ROCS Mapping

| ROCS Dimension | Fraud Pressure | Control |
|---|---|---|
| Reliability | Enforcement must stay bounded under attacks, drift, and dependency failures. | Idempotent enforcement, mode ladder, capability freeze. |
| Observability | Platform must prove why it denied, held, blocked, restored, or stepped up. | Decision Replay Card, evidence snapshot, policy pin. |
| Cost | Step-up, review, appeals, chargebacks, support, and false positives multiply. | Budgets, rate caps, prioritization, review routing. |
| Sustainability | Trust must survive fraud adaptation. | False-enforcement caps, harm-latency limits, re-enable criteria. |

---

## 7. Scale Mapping

| Scale Pressure | Fraud Failure Shape | Control |
|---|---|---|
| Fraud burst | Scoring and step-up pressure spikes. | Rate caps, prioritization, friction ladder. |
| Review backlog | Human queue exceeds capacity. | Narrow autonomy and freeze risky paths. |
| Step-up saturation | Provider unavailable or expensive. | Fallback proof paths and caps. |
| Payout pressure | Holds/reversals spike. | Time-boxed holds and reversal monitoring. |
| Appeal surge | Denials overturned at scale. | Freeze enforcement and shift to step-up/review. |

---

## 8. Consistency Mapping

| Boundary | Trust Rule | Artifact |
|---|---|---|
| Scored | Risk was assessed. | `riskDecisionId` |
| Challenged | Reversible proof requested. | `stepUpChallengeId` |
| Enforced | Liability action was taken. | `enforcementId` |
| Refund denied | Specific refund denial. | `refundDenyId` |
| Payout held | Specific seller payout hold. | `payoutHoldId` |
| Account blocked | Specific hard block. | `hardBlockId` |
| Appealed | Decision challenged. | Appeal review record |
| Restored | Enforcement reversed. | Restoration/compensation receipt |

---

## 9. Latency Mapping

| Latency Type | Fraud Meaning | Control |
|---|---|---|
| Scoring latency | Delay before advisory risk. | Fast scoring but no liability shortcut. |
| Evidence latency | Delay before proof arrives. | Step-up, defer, or review. |
| Harm latency | Time fraud continues before containment. | Mode ladder and freeze rules. |
| False-enforcement latency | Time legitimate users remain harmed. | Appeal monitoring and reversal path. |
| Label latency | Time until truth arrives. | Label linkage without retro-justification. |

---

## 10. Failure Mapping

| Failure Signal | What It Looks Like | Response |
|---|---|---|
| Appeal overturn spike | Many denials reversed. | Freeze affected enforcement. |
| Replay gap | Cannot prove why user was denied/held/blocked. | Freeze liability tokens. |
| Tier conflict | Model high risk but Tier 1 clean. | Step-up, refresh, defer, review. |
| Stale identity | Old identity state used for hard block. | Stop hard enforcement and refresh evidence. |
| Provider degradation | Identity/step-up unavailable. | Cap step-up, fallback proof, avoid hard enforcement. |
| Policy drift | Rule change increases false denials. | Quarantine/rollback policy version. |

---

## 11. Economics Mapping

| Economic Multiplier | Fraud Example | Control |
|---|---|---|
| False denials | Refunds denied incorrectly. | Appeal caps and replay. |
| Step-up cost | Identity checks and MFA provider calls. | Budgets and routing. |
| Manual review | Case queues grow. | Prioritization and autonomy narrowing. |
| Chargebacks | Missed fraud loss. | Harm-latency control. |
| Support load | Users challenge decisions. | Replay cards and clear reason codes. |
| Compliance exposure | Unjustified enforcement. | Evidence tiers and policy pins. |

## Final Senior Line

> Fraud detection is not a scoring pipeline. It is an authority allocation system. The senior design separates advisory risk from enforcement, uses explicit tokens for liability actions, treats evidence freshness and label delay as first-class, climbs a reversible control ladder before hard punishment, freezes enforcement when proof weakens, and emits replay cards so the platform can defend why it denied, held, blocked, stepped up, restored, or compensated.
