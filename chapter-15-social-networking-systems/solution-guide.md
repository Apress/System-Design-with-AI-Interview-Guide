# Chapter 15 Solution Guide

## Exercise 1 Solution: Social Feed as an Influence Engine

A strong answer should explain that a social feed is not merely a ranked read model. It is an influence engine. It decides what becomes visible, what becomes loud, what becomes viral, and what must be stopped before reach becomes harm.

A ranked list sounds neutral. An influence engine is not neutral. It affects viewers, creators, moderators, advertisers, regulators, and the platform itself. When the platform chooses to distribute content beyond the expected audience, it creates obligations. It must be able to answer why the content was shown, why it was boosted, why it was frozen, why it was suppressed, or why it was allowed to keep spreading after evidence changed.

The key distinction is visibility versus amplification.

- **Visibility** means scoped exposure. For example, a creator’s followers may see a post because they chose to follow the creator.
- **Amplification** means the platform accelerates reach beyond the expected audience: For You, Trending, recommendations, notifications, or cross-surface promotion.

The phrase “engagement is up” can be dangerous because engagement may rise while trust falls. A post may be highly engaging because it is misleading, coordinated, polarizing, emotionally manipulative, or harmful in context. Engagement can rank within an admissible lane, but it cannot create admissibility by itself.

Before the platform accelerates reach, it needs admissible evidence:

- Pinned policy version
- Surface authority
- User or creator eligibility
- Consent and mode state
- Regional restrictions
- Integrity and coordination signals
- Safety/moderation labels
- Provenance confidence
- Model version and input snapshot
- Replay coverage
- Budget availability for ranking, promotion, notification, and fanout

Replay must preserve:

- Content ID
- Surface
- Token minted
- Policy version
- Evidence snapshot
- Model and feature versions
- Gate results
- Reason codes
- Amplification budget state
- Stop-authority state
- Final outcome

The senior answer: a feed is not just serving content. It is governing influence.

---

## Exercise 2 Solution: Push vs. Pull as a Power Boundary

A strong answer should explain that push versus pull is not only a performance trade-off. It is also a control and recallability trade-off.

Push, or fanout-on-write, works well where continuity is expected. The Following feed is the classic case. A creator publishes, and the post can be pushed into follower timeline stores. Reads become fast because the work happened earlier.

But push has a recall problem. Once content lands in timeline stores, caches, notification queues, inboxes, and client-side stores, the platform cannot truly un-send everything. It can delete, filter, suppress, or recall what it still controls, but the content may already have spread. A wrong push decision creates recall lag.

Pull, or fanout-on-read, gives more control because the system can requalify at read time. This is valuable for For You, Trending, Search, and other high-blast-radius surfaces. If evidence changes, the platform can check policy, safety, mode, freshness, and surface rules before serving or amplifying.

But pull can become a compute furnace. If every read performs candidate retrieval, embedding lookup, ranking, safety classification, fairness adjustment, policy checks, and model inference, cost and latency can explode. Pull must be bounded with budgets, caching, staged requalification, and fallback modes.

Different surfaces need different strategies:

- Following: push is often acceptable because the user asked for continuity.
- For You/Home: pull or near-pull is safer because the platform is choosing on behalf of the user.
- Trending/Top: stricter pull/requalification is needed because blast radius is high.
- Search/Topics: intent and correctness should dominate surprise.
- Notifications: interruption must be capped and governed.

A hybrid strategy reduces both latency and blast radius:

- Push low-risk, expected visibility.
- Pull or requalify high-reach amplification.
- Use grants for scoped exposure.
- Require tokens and receipts for amplification.
- Recall or freeze expansion when evidence changes.

The senior answer: push is fast but harder to recall; pull is controllable but must be budgeted.

---

## Exercise 3 Solution: Visibility Grant vs. Amplification Token

A strong answer should design visibility and amplification as separate states.

A `visibilityGrantId` means the platform has allowed scoped exposure. The content may be visible in an expected lane, such as a follower feed, creator profile, or limited surface. A grant is reversible when possible and containable when full recall is impossible.

An `amplificationToken` means the platform has authorized reach expansion. This is a stronger decision. It may allow content to enter For You, Trending, broad recommendations, notification fanout, or cross-surface distribution. Amplification creates platform liability because the platform is not merely honoring an existing relationship; it is accelerating reach.

A possible state model:

1. Created
2. Eligibility checked
3. Visibility granted
4. Discovery candidate
5. Amplification gate
6. Amplification token issued
7. Expanded distribution
8. Throttle / freeze / review / suppress / appeal

Before amplification, gates should check:

- Tier 1 authoritative evidence
- Tier 2 model evidence with replayable versions
- Surface authority
- Recommendation mode
- Regional policy
- Safety/moderation posture
- Integrity and coordination signals
- Fairness guardrails
- Replay coverage
- Distribution budget
- Notification budget
- Promotion-stage cap

Budgets should include:

- Candidate retrieval budget
- Rerank attempt budget
- Promotion-stage budget
- Notification fanout budget
- Compute budget per decision path
- Requalification budget
- Harm velocity threshold

When evidence conflicts, the system should not average the conflict away. It should contain blast radius first:

- Throttle
- Freeze amplification
- Defer expansion
- Route to review
- Grant-only mode
- Suppress or enforce if policy confirms violation

Receipt should include:

- `visibilityGrantId`
- `amplificationToken`
- `contentId`
- `surface`
- `policyVersion`
- `evidenceSnapshot`
- `modelVersion`
- `gateResults`
- `budgetState`
- `reasonCodes`
- `createdAt`
- `expiresAt`
- `stopAuthorityState`

The senior answer: “can be seen” is not the same as “should be amplified.”

---

## Exercise 4 Solution: Recommendation Mode Boundary

A strong answer should identify this as a broken architecture boundary.

If the user selects a non-profiling mode, the system must not quietly continue using behavioral features through a shared feature store, shared model path, or hidden ranking fallback. A UI preference is not enough. The mode must change the actual data path.

Profiling mode may use approved behavioral features, subject to consent, retention, feature admissibility, regional policy, and replay requirements. Examples may include:

- Prior engagement
- Watch history
- Click patterns
- Dwell time
- Similarity from behavior-derived embeddings
- Interaction graph features

Non-profiling mode should use a different evidence posture. It may rely on:

- Explicit follows
- Explicit topic subscriptions
- User mutes and blocks
- Language
- Region, when allowed
- Recency
- Freshness
- Content-level safety and eligibility
- Surface policy
- Source precedence

It should not rely on:

- Behavioral profiling features
- Watch history
- Dwell-time-derived preferences
- Behavioral embeddings
- Lookalike profiles
- Hidden personalization from shared model paths

Replay fields should prove:

- Active recommendation mode
- Policy bundle version
- Allowed signal classes
- Disallowed signal classes
- Feature store path used
- Model path used
- Surface
- Ranking inputs
- Reason codes
- Mode-boundary check result

Failure behavior when mode leakage occurs:

- Hard stop or downgrade affected ranking path
- Serve safe non-profiling fallback
- Emit incident receipt
- Invalidate affected cache path
- Route to policy/privacy review
- Preserve replay for audit
- Notify support/moderation if user-facing impact exists

The senior answer: a recommendation mode is real only if the data path changes.

---

## Exercise 5 Solution: Admissible Evidence for Amplification

A strong answer should say that the system should not amplify the post based only on high engagement. Engagement is useful, but it is Tier 3 evidence. It can rank within an admissible lane. It cannot create admissibility on its own.

The platform should evaluate three tiers.

### Tier 1: Authoritative evidence

Mandatory before amplification:

- Pinned policy version
- Consent and mode state
- Creator/account eligibility
- Enforcement history
- Regional restrictions
- Known safety restrictions
- Graph integrity signals
- Surface authority
- Replay coverage

If Tier 1 is missing or violated, amplification should be blocked.

### Tier 2: Model evidence

Useful but must be replayable:

- Safety label
- Topic classification
- Provenance confidence
- Coordination likelihood
- Manipulation risk
- Spam or abuse likelihood
- Model version
- Input snapshot
- Confidence threshold

If Tier 2 confidence is low or conflicting, the system should contain reach.

### Tier 3: Engagement evidence

Useful for ranking:

- Likes
- Comments
- Shares
- Dwell time
- Follows
- Reactions

But engagement cannot override missing Tier 1 evidence or conflicting Tier 2 evidence.

In this scenario, provenance confidence is low, coordination signals are rising, and reports are increasing. That means uncertainty is rising while reach may accelerate. The correct response is:

- Do not mint amplification token yet
- Freeze or throttle discovery expansion
- Clamp resharing or notification fanout if needed
- Route to review
- Continue limited visibility if policy allows
- Preserve replay evidence

Replay evidence should include:

- Content ID
- Surface
- Tier 1 gate results
- Tier 2 model outputs and versions
- Tier 3 engagement metrics
- Evidence conflict summary
- Reports and timestamps
- Coordination signal version
- Policy version
- Token decision
- Stop action
- Final outcome

The senior answer: high engagement is not permission to amplify. Engagement must stay inside an admissible lane.

---

## Bonus Exercise 6 Solution: Surface Authority Matrix

A strong answer should treat surfaces as authority envelopes, not UI locations.

| Surface | Allowed Token | Replay Required | Evidence Required | Default Stop Posture |
|---|---|---|---|---|
| Following Feed | Exposure / visibility token | Only for eligibility or filtering actions | Follower relationship, mute/block, eligibility, policy | User downgrade or local filter |
| For You / Home | Amplification token after gates | Always | Mode, policy, Tier 1/Tier 2 evidence, replay, budget | Throttle, freeze, review |
| Trending / Top | Promotion token through promotion pipeline | Always | Strict policy, provenance, integrity, HVI, replay coverage | Freeze first, ask later |
| Search + Topic Feeds | Answer / intent token | When visibility or order is affected | Query intent, freshness, source precedence, policy | Corrective ordering or discovery off |
| Notifications | Notify token only | For sensitive triggers | Opt-in, frequency cap, safety, policy, sensitivity | Hard caps or quiet mode |

Following is an expectation surface. For You is an influence surface. Trending is a blast-radius surface. Search is an intent surface. Notifications are an attention surface.

The mistake to avoid is allowing a low-authority surface to behave like a high-authority surface. For example, Following should not casually mint amplification tokens. Notifications should not become hidden amplification. Trending must require stricter evidence because its blast radius is larger.

The senior answer: each surface must define what token it can mint, what evidence it requires, when replay is mandatory, and how it stops.

---

## Bonus Exercise 7 Solution: Harm Velocity Index Stop Authority

A strong answer should design stop authority as a runtime mechanism, not a meeting.

A useful formula:

```text
HVI = Severity x Velocity x (1 + Uncertainty)
```

Where:

- Severity = policy/harm class, usually 1–5
- Velocity = shares or reach acceleration per minute per 1,000 impressions
- Uncertainty = replay gaps, conflicting evidence, low provenance confidence, low model confidence, or weak source confidence

Example thresholds:

- HVI >= 8 for 5 minutes: throttle distribution
- HVI >= 12 for 2 minutes: freeze amplification
- HVI >= 16: hard stop
- Replay coverage below 100 percent on amplification: hard stop affected amplification path

Why this matters:

High reach with weak proof is dangerous because distribution outruns governance. Humans arrive late to exponential curves. The system must become conservative before the platform is forced to explain a blast radius.

Stop owner may vary by surface:

- Marketplace/platform integrity owner
- Trust and safety owner
- Policy owner
- Regional escalation owner
- On-call governance owner

Receipts emitted when stop authority fires:

- Content ID
- Surface
- HVI components
- Threshold crossed
- Policy version
- Evidence snapshot
- Stop action
- Scope
- Owner
- Timestamp
- Re-enable criteria
- Review outcome

Re-enable should require:

- Evidence stabilized
- Replay coverage restored
- Policy review completed
- HVI below threshold for a defined period
- Owner approval
- Re-enable receipt

The senior answer: governance that cannot stop the system is narration after the fact.

---

## Bonus Exercise 8 Solution: Distribution DAG Budget

A strong answer should show that ranking is not a single function call. It is a DAG with hidden loops.

DAG surfaces:

- Candidate retrieval
- Embedding lookup
- Ranking
- Safety classification
- Integrity check
- Fairness adjustment
- Eligibility filtering
- Visibility grant
- Amplification gate
- Fanout
- Notification decision
- Feedback ingestion
- Requalification

Budgets:

| DAG Surface | Budget / Cap | Exit Path |
|---|---|---|
| Candidate retrieval | Max candidates per surface | Smaller candidate set |
| Embedding lookup | Cache and timeout budget | Simpler ranking |
| Reranking | Max rerank attempts per post/window | Freeze or grant-only |
| Safety recheck | Max recheck count before review | Review or suppress |
| Fairness adjustment | Bounded reweighting attempts | Conservative ranking |
| Promotion stages | Max promotion stages | Stop expansion |
| Notification fanout | Frequency and audience cap | Quiet mode |
| Feedback ingestion | Rate cap and delay tolerance | Batch mode |
| Requalification | Required at every stage | Freeze if evidence missing |
| Compute path | Cost/latency budget | Downgrade to safer heuristic |

When budgets are exhausted, the system should not keep trying to optimize. It should become conservative:

- Freeze promotion
- Defer review
- Grant-only mode
- Suppress expansion
- Limit notifications
- Reduce autonomy
- Route to moderation or policy review

Every loop needs a counter because social systems fail by continuing to reconsider, re-rank, recheck, and re-promote while appearing healthy.

The senior answer: what you do not budget will recurse.

---

## Bonus Exercise 9 Solution: Incident Response — Trending Stayed Green While Trust Went Red

A strong answer should explain that this is a social-system failure even though the platform is technically up.

The feed loads. Latency is fine. Engagement is high. Ranking appears to work. But reports are spiking, provenance becomes unclear, coordination risk rises, and replay coverage drops. That means influence is moving faster than evidence can defend.

Engagement and latency are insufficient because they measure product motion, not trust. A harmful or coordinated topic can be engaging. A fast system can spread bad decisions quickly.

The system should freeze amplification before human review completes when:

- HVI crosses threshold
- Provenance confidence drops
- Coordination risk rises
- Replay coverage drops
- Reports spike
- Policy evidence conflicts

Controls:

- Freeze Trending promotion
- Throttle resharing
- Disable notification fanout
- Clamp cross-surface promotion
- Route to review
- Preserve receipts
- Require requalification before re-enable

Replay coverage must be mandatory because amplification without proof is indefensible. If a platform cannot replay why a topic entered Trending, it should not continue expanding reach.

After the incident, the platform should explain:

- Why the topic entered Trending
- What evidence existed at the time
- Which policy version applied
- Which model version was used
- When reports spiked
- When provenance confidence changed
- When coordination risk changed
- Which stop threshold fired
- What action was taken
- Why the topic was frozen, suppressed, or restored

The senior answer: the incident is not downtime. The incident is confident amplification after evidence became less defensible.

---

## Bonus Exercise 10 Solution: Senior Architect Social Networking Defense

A mature answer should acknowledge that Kafka, Redis, graph databases, caches, and ranking services are useful but incomplete. Those are implementation mechanisms. They do not define the platform’s influence contract.

A senior answer starts like this:

> I am designing a governed influence engine, not only a feed service.

Key defense points:

### Feed as influence engine

The platform controls visibility, reach, amplification, notification, search ordering, trending, and suppression.

### Push versus pull as power boundary

Push is fast but harder to recall. Pull is controllable but must be budgeted. The design should be hybrid by surface.

### Visibility grant versus amplification token

Visibility is scoped exposure. Amplification is platform liability. The architecture should use explicit tokens and receipts.

### Recommendation mode boundary

Profiling and non-profiling modes must have different data paths, policy bundles, replay fields, and failure behavior.

### Admissible evidence

Tier 1 authoritative evidence is mandatory. Tier 2 model evidence must be replayable. Tier 3 engagement can rank but cannot create admissibility.

### Surface authority

Following, For You, Trending, Search, and Notifications carry different power. Each surface must define allowed token, replay requirement, evidence requirement, and stop posture.

### Stop authority

Use HVI, replay coverage, evidence conflicts, and policy thresholds to throttle, freeze, or hard-stop reach before harm compounds.

### ROCS loop

Sense pressure, decide with pinned policy, act with scoped controls, prove with receipts, and stabilize reach, harm, fairness, cost, and policy posture.

### Replay evidence

Six months later, the platform should prove:

- Why this post was shown
- Why it was boosted
- Why it was frozen
- Why it was suppressed
- Which policy version applied
- Which evidence existed
- Which mode was active
- Which surface minted which token
- Which stop conditions did or did not fire

Senior interview line:

> I would not frame this as a feed service. I would frame it as a governed influence engine. I separate visibility grants from amplification tokens, enforce recommendation mode as a real data-path boundary, define admissible evidence for reach-changing decisions, scope authority by surface, cap distribution DAG loops, use Harm Velocity Index for stop authority, and preserve replay receipts so the platform can defend why content was shown, boosted, frozen, or suppressed.
