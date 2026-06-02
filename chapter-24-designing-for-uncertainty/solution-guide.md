# Chapter 24 Solution Guide

## 1. Commitment Boundary — Detailed Answer

A commitment boundary is where the system stops attempting and starts owing. Before the boundary, the platform can gather evidence, prepare a recommendation, retrieve sources, rank candidates, reserve tentatively, or draft an action. After the boundary, it has made a claim that users, operators, finance, auditors, regulators, or support may expect it to defend later.

A senior answer begins with the promise, not the stack.

| Domain | Commitment Boundary |
|---|---|
| E-commerce checkout | Order confirmed, inventory reserved, payment authorized/captured. |
| Ride sharing | Rider-driver match committed with price and pickup promise. |
| Payments | Capture committed, refund issued, refund denied, payout held. |
| Fraud | Account blocked, transaction denied, case escalated. |
| File storage | File stored, deleted, retained, restored. |
| Search | Result ranked, source cited, AI answer generated. |
| AI agent | Tool action executed rather than merely recommended. |

The boundary must answer: What may the system attempt? What may it claim? What evidence is required? Which policy version governs it? Who has authority? What receipt is emitted? What happens when proof is incomplete?

Weak answer: “I would use microservices, Kafka, Redis, Postgres, and S3.” That names components but not responsibility.

Senior answer:

> I would design this as a commitment engine, not just a workflow. The key question is not only which services exist, but when the platform is allowed to make a claim. For checkout, that boundary may be order confirmation. For payments, it may be capture. For search, it may be answer generation. At that point, the system needs valid evidence, the correct policy version, authority to commit, bounded retries, and a receipt that can be replayed later.

## 2. Admissible Reality and Freshness — Detailed Answer

Production truth is not simply true or false. It is true according to a clock, within a freshness window, under a policy version, and with evidence available at decision time.

| Clock | Meaning | Design Question |
|---|---|---|
| Event time | When the thing happened in the world. | Which real-world moment are we representing? |
| Ingest time | When the platform saw the signal. | How late can evidence arrive and still be admissible? |
| Decision time | When the platform acted. | What evidence and policy were valid then? |
| Label time | When later truth arrived. | How do we learn, reconcile, or correct? |
| Restore time | When recoverability is proven. | Can we demonstrate recovery? |
| Answer time | When a user receives generated or ranked output. | Is the evidence fresh enough for the claim? |

The architecture should define admissible reality: source versions, freshness windows, policy versions, authority, clock values, and missing-evidence behavior. Later truth should not silently rewrite history; it should attach through reconciliation, correction, compensation, appeal, or model feedback.

| Evidence Condition | Safer Posture |
|---|---|
| Slightly stale and low risk | Conservative mode or mark stale. |
| Missing required evidence | Defer or return pending. |
| Conflicting sources | Reconcile or choose source of record. |
| High-stakes uncertainty | Freeze liability action or human review. |
| Later contradiction | Reconcile, compensate, or appeal. |

Senior answer:

> I would define admissible reality for the decision. That means naming the clocks, freshness windows, policy version, and evidence allowed at decision time. If evidence is stale or missing, the system should defer, narrow, escalate, or refuse rather than bluff certainty. If later truth arrives, we reconcile or compensate without rewriting what the system knew when it acted.

## 3. Stop Authority — Detailed Answer

A service being up does not mean behavior is safe. The platform may return 200 responses while acting with confidence it has not earned.

Stop authority should be capability-scoped: stop the unsafe commitment while allowing safe reads, drafts, intent capture, or source display to continue.

| Mode | Meaning | Example |
|---|---|---|
| Normal | Evidence fresh, receipts complete, budgets healthy. | Commit normally. |
| Conservative | Signals drifting but not unsafe. | Tighten thresholds, reduce autonomy. |
| Defer | Evidence incomplete or clocks disagree. | Pending, wait, reconcile. |
| Freeze Liability Actions | High-risk action could harm users. | Freeze capture, hard delete, final AI answer. |
| Human Review | Automation reached trust boundary. | Escalate with evidence package. |
| Re-enable with New Version | Proof restored and safeguards changed. | Resume with policy/version bump. |

Scoped stops include freezing capture after ambiguous payment timeouts, suppressing AI answers when citations are missing, reverting ranking rollout, freezing hard delete when legal-hold proof is incomplete, or routing refund denial to review.

Re-enable requires receipts restored, policy versions reconciled, drift resolved, budgets stable, replay tests passed, validation succeeded, owner approval recorded, and a new version or re-enable receipt.

Senior answer:

> I would not treat green status as permission to continue unsafe behavior. I would stop the specific commitment that is no longer defensible. Safe reads can continue, but liability actions should defer, freeze, or route to review until proof is restored. Ownership means the ability to make the system more conservative before harm occurs.

## 4. ROCS Loop — Detailed Answer

ROCS is a control loop, not four dashboard categories.

Reliability asks whether behavior is still correct enough under uncertainty. Controls include retry budgets, idempotency, pending states, reconciliation, fallback modes, stop authority, freshness gates, and admission controls.

Observability asks whether the system can prove the commitment. Controls include receipts, correlation IDs, evidence snapshots, policy pins, model/prompt versions, tool-call lineage, result-set hashes, and replay cards.

Cost asks whether work is bounded under pressure. Controls include retry, fan-out, token, model-call, tool-call, reindex/rebuild, and manual-review budgets.

Sustainability asks whether trust and operability survive. Controls include harm-latency limits, stale-answer limits, false-enforcement limits, honest degradation, and re-enable criteria.

ROCS loop:

```text
Signals -> Policy -> Actions -> Outcomes -> Feedback
```

Signals include replay gaps, drift, conflict rates, stale evidence, retry storms, cost spikes, manual-review growth, and cohort harm. Actions include defer, clamp, freeze, reroute, quarantine, suppress, reconcile, or compensate.

Senior answer:

> I would apply ROCS as a control loop, not a dashboard. Reliability asks whether behavior is still correct enough. Observability asks whether we can prove it. Cost asks whether work is bounded under pressure. Sustainability asks whether trust and operability survive. If signals show drift, the system should change posture, not merely alert.

## 5. Senior Interview Framing — Detailed Answer

A senior architect starts with the promise, not the diagram.

Opening structure:

1. Identify the user promise.
2. Identify actors and journey.
3. Name the commitment boundary.
4. Define admissible evidence.
5. Define freshness clocks.
6. Set churn budgets.
7. Define stop authority.
8. Define replay receipts.
9. Then discuss components.

Senior opening:

> I would design this as a commitment engine, not just a workflow. First, I want to define where the system stops attempting and starts owing. Then I define what evidence, freshness, policy version, authority, and receipt are required before it may commit. I also set budgets for retries, time, fan-out, tools, tokens, and cost so the system cannot loop under uncertainty. Finally, I define stop authority so the platform becomes more conservative when proof weakens. Once that is clear, I can choose the right services, databases, queues, caches, indexes, APIs, models, and orchestration patterns.

## 6. Green Dashboards, Red Obligations — Detailed Answer

This is a behavioral correctness incident, not a basic uptime incident. The platform is alive, but its claims are not defensible.

| Symptom | Likely Boundary Failure |
|---|---|
| Duplicate charges | Capture retried across ambiguous timeout. |
| Stale answers | Freshness boundary crossed. |
| Incorrect denials | Workflow committed on weak evidence. |
| Missing proof | Receipt not emitted at commit time. |
| Wrong recommendation | Ranking/personalization outranked authority. |

Recovery pattern: freeze the affected high-risk commitment, continue safe reads, preserve evidence and cohorts, reconstruct decisions, reconcile with source-of-truth systems, compensate users, fix receipt/policy/freshness/budget gaps, and re-enable with proof.

Senior answer:

> This is an outage even if the service is up. The system crossed a commitment boundary without defensible proof. I would freeze the affected liability action, preserve safe reads, reconstruct decisions from receipts, reconcile with source-of-truth systems, compensate affected users, and re-enable only after the missing proof path and stop triggers are fixed.

## 7. Bounded Churn — Detailed Answer

More retries, more fan-out, more model calls, more sources, and more fallback logic can amplify uncertainty instead of resolving it.

Risks: duplicate side effects, higher latency, larger failure surface, runaway tool loops, stale evidence, cost explosion, hidden failure states, and manual review becoming the default operating model.

| Budget | Example |
|---|---|
| Retry budget | Maximum attempts before park/reconcile. |
| Time budget | Maximum decision latency before defer. |
| Fan-out budget | Maximum downstream calls or retrieval sources. |
| Token budget | Maximum prompt/context growth. |
| Tool-call budget | Maximum agent actions. |
| Cost budget | Maximum cost per successful outcome. |
| Replay budget | Required coverage before automation continues. |

When budgets are exhausted, the system should move to pending, defer, review, reconcile, suppress answer, narrow sources, freeze liability action, and emit a budget-exhausted receipt.

Senior answer:

> More retries are not always resilience. They can become harm amplification. I would bound attempts, time, fan-out, tokens, tool calls, and cost. When budgets are exhausted, the system should stop guessing and move to a safer mode.

## 8. Decision Replay Card — Detailed Answer

A Decision Replay Card is the receipt emitted at commitment time. It is not a log line. It lets the platform reconstruct why it acted, what it knew, what policy applied, and what happened next.

Required fields:

```yaml
decisionReplayCard:
  replayCardId:
  correlationId:
  domain:
  commitmentType:
  actor:
    actorType:
    actorId:
    authority:
  boundary:
    attemptedAction:
    committedAction:
    liabilityLevel:
  evidence:
    evidenceSnapshotId:
    sourceVersions:
    freshnessWindow:
    confidence:
    missingEvidence:
  policy:
    policyVersion:
    policyBundle:
    admissibilityRule:
  clocks:
    eventTime:
    ingestTime:
    decisionTime:
    labelTime:
    restoreTime:
    answerTime:
  churn:
    retryAttempts:
    fanoutCount:
    tokenBudgetUsed:
    toolCalls:
    costEstimate:
  technicalLineage:
    modelVersion:
    promptVersion:
    rankingVersion:
    toolVersion:
    schemaVersion:
  outcome:
    status:
    reasonCode:
    customerVisibleState:
  reversal:
    reversible:
    compensationPath:
    appealPath:
  replay:
    replayMethod:
    requiredInputs:
    replayable:
```

Senior answer:

> A replay card is not a log line. It is the commitment receipt. It captures the actor, authority, evidence, policy version, clocks, churn budget, technical lineage, outcome, and reversal path at the moment the system crosses the boundary.

## 9. 30-Day Practice Plan — Detailed Answer

The 30-day plan improves one critical commitment rather than redesigning everything.

Week 1: Liability Boundary Map. Deliver a one-page map showing where the system stops attempting and starts owing. Include actors, journey, commitment points, authority owner, reversibility, business harm, and missing proof.

Week 2: Admissibility and Freshness Contract. Define evidence sources, freshness windows, policy versions, authority checks, stale/missing behavior, conflict rules, and late-truth reconciliation.

Week 3: Churn Budget Spec and Stop Authority Mode Ladder. Define retry, time, fan-out, token, tool, and cost budgets. Define Normal, Conservative, Defer, Freeze, Human Review, and Re-enable modes.

Week 4: Decision Replay Cards. Emit replay-ready proof for one critical workflow. Include actor, evidence, policy, timestamps, correlation ID, outcome, compensation path, replay method, and validation examples.

Senior answer:

> In 30 days, I would not redesign the whole system. I would make one critical commitment defensible. I would map the boundary, define admissible evidence, cap churn, add stop authority, and emit replay cards. That changes both design reviews and incident response.

## 10. Final Synthesis — Detailed Answer

The shift is from structure-only architecture to authority-aware architecture.

| From | To |
|---|---|
| Structure | Authority |
| Uptime | Defensible behavior |
| Retry | Bounded churn |
| Logs | Replayable proof |
| Confidence | Admissible reality |
| On-call ownership | Stop authority |
| Tool-first design | Commitment-first design |
| Generic diagrams | Boundary, proof, and stop |

Senior final answer:

> The shift is from designing systems that merely run to designing systems that can act, stop, explain, and be trusted under uncertainty. Designing for uncertainty is the job now; designing for proof is how we do it.
