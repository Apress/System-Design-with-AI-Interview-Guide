# Earlier-Lens Mapping Worksheet: Social Networking Systems

This worksheet helps you apply the earlier lenses from Part I and Part II to Chapter 15: Social Networking Systems.

The purpose is not to memorize a “design Twitter” or “design Instagram” answer. The purpose is to prove that you can reuse the same system design method under influence, amplification, moderation, and governance pressure.

Use this worksheet before drawing the final architecture. A senior answer should show that you understand the promise, actors, surfaces, authority boundaries, visibility grants, amplification tokens, admissible evidence, stop authority, ROCS loops, failure modes, economics, and replay requirements.

---

## 1. 7-Step Method Mapping

| Step | Social Networking Application | Senior Architect Framing | Reader Notes |
|---|---|---|---|
| 1. Clarify the problem | Are we designing Following feed, For You, Trending, Search, Notifications, moderation, or full influence lifecycle? | “I need to know whether the interview scope is feed serving or governed influence.” |  |
| 2. Identify actors | Viewer, creator, follower, moderator, advertiser, policy owner, recommender, regulator, platform. | “The system affects more than the user reading the feed.” |  |
| 3. Map the journey | Creator posts, follower sees, content enters discovery, user reports, moderation acts, appeal begins. | “The journey moves from visibility to amplification to enforcement and appeal.” |  |
| 4. Define constraints | Viral spread, policy, safety, profiling mode, non-profiling mode, fairness, replay, harm velocity. | “Influence can scale faster than governance.” |  |
| 5. Name commitments | Visibility grant, amplification token, notification token, promotion token, moderation action, appeal result. | “Grant is exposure; amplification is liability.” |  |
| 6. Choose architecture | Creation, eligibility, ranking, evidence gate, surface authority, stop authority, replay, moderation, appeal. | “I draw control surfaces, not only feed services.” |  |
| 7. Defend trade-offs | Push vs pull, relevance vs admissibility, engagement vs safety, personalization vs mode boundaries. | “A highly engaging post may still be inadmissible for amplification.” |  |

## 2. Customer Journey Mapping

| Journey Moment | Viewer Believes | Creator Believes | Platform Risk | Architecture Response |
|---|---|---|---|---|
| Creator posts | Post exists and may reach expected audience. | Content is published. | Eligibility not checked. | Create content ID, policy pin, initial eligibility state. |
| Follower feed | Followed content may appear. | Followers may see the post. | Push recall lag. | Visibility grant with scoped exposure. |
| Discovery candidate | Platform may recommend content. | Reach may expand. | Authority creep. | Amplification gate. |
| For You / Home | Platform is choosing content. | Content may gain reach. | Indefensible influence. | Amplification token and replay receipt. |
| Trending | Topic may become high-blast-radius. | Creator/topic gains massive reach. | Viral harm. | Promotion pipeline, stricter gates, freeze-first posture. |
| User reports | Platform should respond. | Creator may be affected. | Harm latency. | Stop authority, review, evidence update. |
| Moderation action | Enforcement should be explainable. | Creator expects due process. | Appeal reversal risk. | Moderation receipt and appeal pointer. |
| Appeal | Platform should justify or reverse. | Creator expects fairness. | Trust collapse if no proof. | Replay evidence and policy version. |

## 3. Capability Map

| Capability | Responsibility | Commitment Boundary | Owner |
|---|---|---|---|
| Content Creation | Accept and store content. | No amplification yet. | Creation owner |
| Eligibility | Decide whether content can be visible. | Visibility gate. | Policy/eligibility owner |
| Ranking | Order admissible content. | Ranking cannot create admissibility. | Ranking owner |
| Visibility Grant | Allow scoped exposure. | `visibilityGrantId`. | Distribution owner |
| Amplification Gate | Decide whether reach may expand. | `amplificationToken`. | Influence governance owner |
| Surface Authority | Enforce power by surface. | Surface-specific token. | Surface owner |
| Recommendation Mode | Enforce profiling/non-profiling path. | Mode boundary. | Personalization/privacy owner |
| Moderation | Review and act on policy violations. | Enforcement action. | Moderation owner |
| Stop Authority | Throttle, freeze, or hard-stop reach. | HVI / replay thresholds. | Trust and safety owner |
| Replay / Audit | Prove why reach changed. | Receipt and replay card. | Governance owner |

## 4. ARCHVIEW Mapping

| ARCHVIEW Concern | Social Networking View |
|---|---|
| Actors | Viewer, creator, moderator, advertiser, policy owner, regulator, platform. |
| Responsibilities | Creation, eligibility, ranking, grant, amplification, moderation, appeal, replay. |
| Control surfaces | Surface authority, mode boundary, evidence gate, HVI, replay coverage, DAG budgets. |
| Commitment points | Visibility grant, amplification token, promotion token, notify token, moderation action. |
| Ownership | Surface owners, policy owners, trust/safety owners, replay owners. |
| Evidence | Policy version, evidence tier, model version, mode, surface, token, reason codes. |
| Degradation | Grant-only, throttle, freeze, review, non-profiling fallback, notification quiet mode. |
| Stop authority | HVI thresholds and replay hard stops. |

## 5. AI Primitives Mapping

| AI Primitive | Social Networking Application | Artifact |
|---|---|---|
| Authority | Which surface can mint which token? | Surface-authority matrix |
| Commitment | Visibility is grant; amplification is liability. | Grant and amplification schemas |
| Time | Evidence changes after distribution starts. | HVI and harm-latency policy |
| Degradation | Throttle, freeze, review, grant-only mode. | Stop-authority policy |
| Evidence/Replay | Explain why a post was shown, boosted, frozen, or suppressed. | Amplification replay card |
| Ownership | Each stop and re-enable action needs an owner. | Ownership and re-enable checklist |

## 6. ROCS Mapping

| ROCS Dimension | Social Networking Pressure | Control |
|---|---|---|
| Reliability | Influence must remain bounded under viral spread. | Promotion caps and freeze paths. |
| Observability | Reach-changing decisions must be replayable. | Receipts and policy pins. |
| Cost | Reranking, rechecking, notifying, and moderation rework multiply. | DAG budgets and fanout caps. |
| Sustainability | Trust must survive repeated policy changes and viral spikes. | Fairness/safety guardrails and stop authority. |

## 7. Scale Mapping

| Scale Pressure | Social Failure Shape | Control |
|---|---|---|
| Celebrity key | Fanout pressure and hotspot timelines. | Hybrid push/pull and celebrity handling. |
| Viral topic | Reach expands faster than review. | HVI and staged promotion. |
| Notification storm | User interruption becomes spam. | Notify-token caps and quiet mode. |
| Ranking loops | Rechecking and reranking recurse. | DAG budgets. |
| Moderation backlog | Harm latency rises. | Freeze, throttle, review queues. |

## 8. Consistency Mapping

| Boundary | Trust Rule | Artifact |
|---|---|---|
| Visible | Can be seen in scoped lane. | `visibilityGrantId` |
| Amplified | Platform chose to accelerate reach. | `amplificationToken` |
| Mode | Profiling/non-profiling must change data path. | Mode policy bundle |
| Surface | Surface determines authority. | Surface-authority matrix |
| Enforcement | Moderation action must be explainable. | Moderation receipt |
| Appeal | Reversal must connect to policy and evidence. | Appeal replay card |

## 9. Latency Mapping

| Latency Type | Social Meaning | Control |
|---|---|---|
| Feed latency | User experience delay. | Cache, push, pull, rank budgets. |
| Harm latency | Time content keeps spreading after evidence changes. | HVI, freeze, throttle. |
| Moderation latency | Time to review after signal. | Prioritization and freeze-first posture. |
| Replay latency | Time to explain decision. | Receipt-first design. |
| Appeal latency | Time to correct wrong enforcement. | Appeal workflow and evidence bundle. |

## 10. Failure Mapping

| Failure Signal | What It Looks Like | Response |
|---|---|---|
| Engagement high, evidence weak | Platform amplifies what it cannot defend. | Freeze or defer amplification. |
| Mode leakage | Non-profiling still uses behavioral features. | Hard stop affected path. |
| Replay gap | Amplification lacks proof. | Hard stop amplification. |
| HVI spike | Reach accelerates with harm risk. | Throttle, freeze, hard stop. |
| Surface authority creep | Following or notification acts like amplification. | Enforce token boundary. |

## 11. Economics Mapping

| Economic Multiplier | Social Example | Control |
|---|---|---|
| Reranking loops | Content repeatedly re-evaluated. | Rerank cap. |
| Promotion stages | Post moves across surfaces. | Promotion-stage cap. |
| Notification fanout | Interruptions multiply. | Notify caps. |
| Moderation rework | Poor evidence causes appeal/review load. | Receipts and evidence gate. |
| Replay gaps | Manual investigation becomes default. | Mandatory replay card. |

## Final Senior Line

> A social networking system is not just a feed. It is a governed influence engine. The senior design separates visibility grants from amplification tokens, enforces recommendation mode as a real data-path boundary, defines admissible evidence for reach-changing decisions, scopes authority by surface, caps distribution DAG loops, uses Harm Velocity Index for stop authority, and preserves replay receipts so the platform can defend why content was shown, boosted, frozen, or suppressed.
