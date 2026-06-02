# Chapter 15 Exercises

## Exercise 1: Social Feed as an Influence Engine

A candidate says, “A social network feed is just a ranked list of posts from people you follow and content you may like.”

Why is that incomplete?

Your answer should include:

- Why a feed is an influence engine, not just a read model
- The difference between visibility and amplification
- Why distribution decisions create obligations
- Which actors are affected: viewers, creators, moderators, advertisers, regulators, and the platform
- Why “engagement is up” can still mean trust is going down
- What evidence must exist before the platform accelerates reach
- What must be replayable later

## Exercise 2: Push vs. Pull as a Power Boundary

Most engineers explain push vs. pull as fanout-on-write versus fanout-on-read.

Explain why, in a social networking system, push versus pull is also a power and recallability decision.

Your answer should include:

- Where push works well
- Why push makes recall harder after new evidence arrives
- Where pull gives the platform more control
- Why pull can become a compute furnace if unbounded
- Why Following, For You, Trending, Search, and Notifications need different distribution strategies
- How hybrid distribution reduces both latency and blast radius

## Exercise 3: Visibility Grant vs. Amplification Token

Design a state model using `visibilityGrantId` and `amplificationToken`.

Your answer should include:

- What a visibility grant means
- What an amplification token means
- Why “can be seen” is not the same as “should be amplified”
- What gates must pass before amplification
- What budgets must be checked before promotion
- What happens when evidence conflicts
- What receipt should be emitted for a reach-changing decision

## Exercise 4: Recommendation Mode Boundary

A platform offers users a non-profiling feed mode, but internally the ranking pipeline still uses behavioral features from a shared feature store.

Analyze the architecture failure.

Your answer should include:

- Why recommendation mode must be a real architecture boundary
- How profiling and non-profiling modes should differ
- Which evidence is allowed in profiling mode
- Which evidence is allowed in non-profiling mode
- Why a UI preference is not enough
- What replay fields should prove which mode and signal classes were used
- What failure behavior should occur if the mode boundary leaks

## Exercise 5: Admissible Evidence for Amplification

A post receives unusually high engagement and begins to qualify for discovery and trending surfaces. However, provenance confidence is low, coordination signals are rising, and moderation reports are increasing.

Should the system amplify the post?

Your answer should include:

- Why engagement cannot create admissibility by itself
- Tier 1 authoritative evidence required before amplification
- Tier 2 model evidence and replay requirements
- Tier 3 engagement evidence and its limits
- What should happen when evidence conflicts
- When to throttle, freeze, defer, or review
- What replay evidence must be preserved

---

# Bonus GitHub Exercises

## Bonus Exercise 6: Surface Authority Matrix

Create a surface authority matrix for Following Feed, For You / Home, Trending / Top, Search + Topic Feeds, and Notifications.

## Bonus Exercise 7: Harm Velocity Index Stop Authority

Design a stop-authority mechanism using a Harm Velocity Index.

## Bonus Exercise 8: Distribution DAG Budget

Design budgets for a social distribution DAG that includes retrieval, embeddings, ranking, safety checks, fairness adjustment, grant, amplification, fanout, feedback ingestion, and requalification.

## Bonus Exercise 9: Incident Response — Trending Stayed Green While Trust Went Red

Analyze a case where a topic enters Trending, engagement is high, service dashboards are green, but reports spike, provenance becomes murky, coordination risk rises, and replay coverage drops.

## Bonus Exercise 10: Senior Architect Social Networking Defense

An interviewer says, “Designing a social network is straightforward: users create posts, followers see posts, the feed ranks content, and we use Kafka, Redis, and a graph database for scale.”

Defend a more mature design.
