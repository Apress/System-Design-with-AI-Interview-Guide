# Chapter 11 Solution Guide

## Exercise 1 Solution: Latency as Trust Pressure

A strong answer should explain that this is not merely an API performance issue. It is a trust and commitment problem.

During browsing, latency is usually an inconvenience. During checkout, latency creates ambiguity. After a customer clicks **Place Order**, the user wants to know whether the business accepted the commitment. If the system hesitates without a clear state, the customer may believe the request failed and click again, refresh, abandon the cart, or contact support.

Those user actions become new system load:

- Duplicate checkout attempts
- Duplicate payment authorization attempts
- Repeated inventory checks
- Additional support contacts
- More AI assistant or FAQ requests
- Higher retry pressure

A better design should make state explicit while the system is slow:

- **Confirmed** when inventory reservation, payment authorization, and durable order state exist
- **Pending** when the system has accepted the request but is waiting for downstream proof
- **Failed** when the request cannot be completed
- **Review required** when a human or policy check is needed

The system should enforce idempotency so repeat clicks do not create duplicate orders or duplicate payments. It should preserve replay evidence: correlation ID, idempotency key, cart snapshot, price/promotion version, inventory reservation attempt, payment authorization status, timestamps, queue delay, user-visible state, and final outcome.

The key point: latency at checkout is not just slowness. It is uncertainty at a commitment point.

## Exercise 2 Solution: Journey-Weighted Latency

A single 300 ms target is incomplete because not all latency is equal. Latency pain depends on where the user is in the journey and what the user believes is happening.

A stronger model:

| Journey Moment | User Expectation | Latency Pain | Trust Risk | Architecture Response |
|---|---|---|---|---|
| Browse | Explore products quickly | Low | User may leave, but no commitment exists | Cache, CDN, degrade, partial results |
| Add to cart | See my change immediately | Medium | User may retry if cart looks unchanged | Preserve session state, read-your-writes |
| Checkout | Submit an accurate order | High | Duplicate attempts, uncertain order state | Revalidate, idempotency, inventory reservation |
| Payment confirmation | Know whether money/order committed | Extreme | Duplicate charge fear, support escalation | Confirm/pending/failed clearly, replay evidence |
| Post-purchase support | Understand order state | Medium | Support becomes recovery architecture | Expose state, preserve replay evidence, route context |

The design should budget latency by journey moment. Browse can tolerate caching and partial results. Checkout requires authoritative validation. Payment confirmation requires explicit state and replay evidence. Post-purchase support requires clear state and context so the user does not have to reconstruct what happened.

The key point: latency budgets should follow trust, not just endpoints.

## Exercise 3 Solution: Tail Latency Behavior Loop

A strong answer should explain that averages hide the failure because only a small slice of users may experience the worst delay, but those users behave in ways that amplify load.

Tail latency creates the following loop:

1. A slow response creates doubt.
2. Doubt causes refresh, retry, restart, duplicate click, or support escalation.
3. Those actions create duplicate work.
4. Duplicate work increases load on already stressed services.
5. Increased load worsens tail latency.
6. The tail expands into a visible incident.

For DreamEntertainment, a stall during browsing may be tolerable, but a stall during playback start or a live-event climax is a trust event. Viewers who restart apps or switch devices may create repeated entitlement checks, playback session starts, manifest fetches, CDN requests, and support chats.

Controls:

- Idempotency for start-session and entitlement checks
- Bounded retries
- Rate limits for repeated refresh/device-switch behavior
- Backpressure on non-critical personalization or recommendation paths
- Priority for active playback and live-event traffic
- Clear playback state: buffering, retrying, degraded quality, or unavailable
- Observability by ISP, device, region, CDN path, playback phase, and live-event time window

The goal is to make repeated user behavior cheap and safe instead of letting it multiply work.

## Exercise 4 Solution: Moment of Commitment

A funds transfer is a commitment moment because the user may be moving money, creating financial obligation, or relying on the transfer status for another action. A spinner is dangerous because it does not tell the user whether the action succeeded, failed, or is still being evaluated.

The system should not use optimistic UI that implies completion before fraud and payment evidence exist.

A safer state model:

- **Pending review** if fraud is slow or risk is uncertain
- **Pending authorization** if payment rails have not responded
- **Confirmed** only when required payment/fraud evidence exists
- **Failed** if the transfer cannot proceed
- **Review required** if policy or fraud threshold requires human action

Idempotency is essential. The transfer request should carry an idempotency key so repeated submissions from the same user/session do not create duplicate transfers.

Backpressure protects downstream systems by limiting new commitment attempts when fraud or payment systems are saturated. The system may prioritize already-submitted transactions over new ones, shed low-priority traffic, or move uncertain transactions to pending.

Replay evidence should include:

- Correlation ID
- Idempotency key
- User/account context
- Transfer request
- Fraud-service status
- Payment authorization status
- Policy/risk version
- Timestamps
- User-visible state
- Final outcome
- Reversal/remediation link

The core rule: when commitment evidence is delayed, the system should not bluff. It should show an honest pending or review-required state.

## Exercise 5 Solution: Latency Myths

Both statements are incomplete because they treat latency as a surface-level experience problem rather than a trust and architecture problem.

### Myth 1: “We can hide latency with better UX.”

UX smoothing helps during low-risk moments:

- Browse
- Product discovery
- Search
- Recommendations
- Non-critical support answers

Spinners, skeleton screens, progress bars, streaming responses, and optimistic UI can make waiting feel better.

But UX smoothing becomes dishonest at commitment points if it hides uncertainty. During checkout, payment, funds transfer, claim approval, order modification, or booking confirmation, the user needs a truthful state, not prettier waiting. The system must say confirmed, pending, failed, or review required.

### Myth 2: “We can always add capacity.”

Capacity can improve throughput and reduce average latency. It cannot fix:

- Excessive hop count
- Slow external dependencies
- Queue buildup
- Retry amplification
- Missing idempotency
- Weak capability boundaries
- Ambiguous commitment semantics
- Unbounded AI DAG fan-out
- Partner or policy constraints

A more honest latency strategy includes:

- Journey-weighted latency budgets
- Idempotency keys
- Bounded retries
- Backpressure
- Priority queues
- Pending states
- Safe degradation
- Replay evidence
- AI retrieval/token/tool budgets

The core point: UX can soften waiting, and capacity can help throughput, but neither fixes uncertainty.

## Bonus Exercise 6 Solution: Latency Budget Design

A strong answer should budget the checkout journey by trust sensitivity.

| Path Segment | Example Budget | Why It Matters | If Exceeded |
|---|---:|---|---|
| UI/API gateway | 100–200 ms | User perceives responsiveness immediately | Show progress, preserve trace context, avoid blocking |
| Pricing/inventory | 100–300 ms | Checkout confidence depends on fresh price and availability | Use cache for discovery; revalidate at commit |
| Fraud/payment | 300–800 ms | Money movement creates anxiety and duplicate attempts | Move to pending, enforce idempotency, preserve replay |
| AI assistant/RAG | 500–1500 ms | Support explanation can tolerate delay if state is clear | Stream, cap retrieval, tier model, escalate |
| Confirmation | Strict and explicit | User needs certainty at commitment | Return confirmed, pending, or failed clearly |

The design should not treat all latency equally. For confirmation, the budget is not only a number. It is a contract. The system must return a clear state.

Evidence to preserve:

- Trace ID
- Latency per segment
- Queue depth
- Retry count
- Idempotency key
- Price/inventory evidence
- Payment/fraud response
- AI tool calls, if involved
- Final customer-visible state

## Bonus Exercise 7 Solution: AI Latency DAG

A strong answer should explain that AI latency is not one model delay. It is a DAG of hidden work.

Possible DAG:

1. User request
2. Intent classifier or planner
3. Query rewriting
4. Retriever
5. Vector search
6. Reranker
7. Prompt builder
8. Model gateway
9. LLM call
10. Tool calls
11. Evaluator loop
12. Memory write
13. Replay/logging
14. Final response

Controls:

- Retrieval fan-out budget
- Source priority and admissibility rules
- Token budget
- Context compression
- Prompt template versioning
- GPU queue telemetry
- Dynamic batching
- Warm model pools
- Tool-call budget
- Tool allowlist
- Circuit breakers
- Evaluator loop caps
- Confidence gates
- Model-tier routing
- Fallback models
- Streaming response for low-risk answers
- Escalation for high-risk or slow actions

When exceeded:

- Compress context
- Use cheaper/faster model
- Skip non-critical personalization
- Defer to support
- Return partial response
- Escalate to human review
- Hard stop state-changing action

The key point: budget the AI DAG, not just the model call.

## Bonus Exercise 8 Solution: Boundary Collapse Under Latency

A strong answer should identify that latency exposes a weak capability boundary.

Order modification is not just an update. It intersects:

- Jurisdiction rules
- Fraud posture
- Payment settlement timing
- Fulfillment cutoff
- Inventory guarantees
- Carrier handoff
- Partner constraints
- Customer communication

Under low volume, manual overrides may hide ambiguity. Under high volume, the system repeats ambiguity automatically. Tool retries may cross boundaries. Partner lag may turn “modified” into a false claim. Policy checks may be delayed. Human support may become the real boundary.

A stronger design:

- Define order modification as a capability with an owner
- Allow low-risk changes only before fulfillment cutoff
- Block or escalate after warehouse picking or carrier handoff
- Require policy/jurisdiction checks before action
- Require fraud/payment checks for sensitive changes
- Use pending states when partner or warehouse acknowledgment is delayed
- Use tool budgets and circuit breakers
- Preserve evidence for support

User-visible states:

- Modification requested
- Pending partner/warehouse confirmation
- Modified
- Not eligible for automatic modification
- Escalated to support

Support evidence:

- Order state
- Cutoff time
- Fulfillment status
- Policy version
- Tool calls
- Partner responses
- Decision timestamp
- Reason for pending/refusal/escalation

The key point: latency reveals whether the system owns the promise or merely hopes the workflow completes.

## Bonus Exercise 9 Solution: Latency Evidence and Replay

A strong evidence package should explain what happened during the eight-minute pending window and why confirmation was later allowed.

Minimum fields:

- Correlation ID
- Idempotency key
- Capability
- User/session context
- Cart/order snapshot
- Decision and timestamp
- User-visible states shown over time
- Policy version
- Price/promotion version
- Inventory evidence
- Payment/fraud evidence
- Queue depth by segment
- Retry attempts
- Tool calls
- Downstream dependency responses
- Human approval or override, if any
- Final outcome
- Reversal/remediation link

Why screenshots and dashboards are not enough:

- Screenshots show what a user saw, not why the system showed it.
- Dashboards show aggregate health, not the exact decision path.
- Logs may show activity but not the implied promise, evidence, policy version, or replayable decision.

A replay record should answer:

- What did the user ask the system to do?
- What did the system imply?
- What evidence existed at that time?
- Why did the system choose pending?
- What changed before confirmation?
- Was the final commitment defensible?

## Bonus Exercise 10 Solution: Senior Architect Latency Defense

A mature answer should reject the idea that latency is solved only by CDN, caching, async processing, and autoscaling.

Those tools help, but they are incomplete.

A senior strategy starts with the journey:

- Where does latency change user behavior?
- Where is the commitment point?
- What does the user believe while waiting?
- What duplicate work can retries create?
- What is safe to cache or move async?
- What must be revalidated before commitment?
- What evidence is needed later?

A mature design includes:

- Journey-weighted latency budgets
- Idempotency for user retries
- Retry budgets for downstream calls
- Backpressure to protect critical dependencies
- Priority queues for commitment-critical work
- Clear pending/failed/confirmed states
- Safe degradation
- AI DAG budgets for retrieval, tokens, tools, model tiers, and evaluator loops
- Replay evidence

One strong interview line:

> I would not start with average latency or generic caching. I would identify the journey moments where delay changes behavior, especially commitment points. Then I would define the latency budget, idempotency strategy, retry limits, backpressure behavior, safe degraded state, and evidence needed to replay any action taken while the user was waiting.

The key point: earn performance without hiding uncertainty.
