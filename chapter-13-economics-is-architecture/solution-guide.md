# Chapter 13 Solution Guide

## Exercise 1 Solution: Economics as System Behavior

A strong answer should explain that the claims assistant did not become expensive because “the cloud bill went up.” It became expensive because the architecture repeatedly chose more work per claim under pressure.

The clean diagram may show:

- Customer claim
- AI assistant
- Policy retrieval
- Fraud check
- Draft decision
- Adjuster review
- Claim resolution

But the behavior architecture under scale may show:

- More documents retrieved per claim
- More model passes
- More fraud and policy tool calls
- More retries after timeout
- More adjuster review
- More rework from ambiguous claim state
- More audit artifacts created after the fact

That is an architecture problem because the system’s repeated behavior creates the cost. Cost is shaped by the path, not just the platform.

The cost multipliers are:

- Retrieval fan-out
- Tool loops
- Retry storms
- Prompt inflation
- Model-tier escalation
- Human rework
- Escalation churn
- Reprocessing after unclear commitment

A system can meet reliability goals and still become financially toxic if every successful claim requires too many expensive steps. The capability may be “up,” but its unit economics may be broken.

A better design measures cost at the capability boundary:

- Cost per claim resolved
- Cost per fraud triage
- Cost per prevented leakage
- Cost per escalated claim
- Cost by claim type, risk tier, and product line
- Cost by retrieval fan-out, tool calls, retries, and model tier

Enforcement mechanisms should change runtime behavior:

- Top-K document caps
- Tool-call budgets
- Retry budgets
- Model-tier routing
- Escalation thresholds
- Human-review gates
- Degraded mode for low-risk claims
- Kill switch by claim type or risk tier
- Stop authority for the claims automation owner

The senior answer: economics lives in the behavior architecture. If the system repeats waste, the bill is only the symptom.

---

## Exercise 2 Solution: Unit of Value and Unit Cost

“$40,000 per month” is incomplete because it does not explain whether the system produced enough value for that spend. A monthly cost number is useful for accounting, but weak for architecture. It does not show what the system spent money on, which behavior drove spend, or whether the cost was acceptable per business outcome.

A strong answer defines both the unit of value and the unit cost.

### Example: DreamInsurance claim handling

Unit of value:

- One claim resolved correctly
- One fraudulent claim prevented
- One claim leakage event avoided
- One adjuster cycle reduced without increasing appeals

Unit cost:

- Cost per claim decision
- Cost per resolved claim
- Cost per fraud triage
- Cost per escalated claim
- Cost per appeal avoided

System work per claim may include:

- Document ingestion
- OCR or extraction
- Retrieval
- Policy lookup
- Fraud checks
- Model reasoning
- Tool calls
- Adjuster-note generation
- Human review
- Evidence replay
- Customer communication

Finance view:

- Cost per claim
- Cost by product line
- Cost by risk tier
- Cost by region
- Cost per leakage prevented

Engineering view:

- Cost by execution path
- Retrieval fan-out
- Token usage
- Model tier
- Tool-call count
- Retry count
- Escalation rate
- Rework rate

The connected view matters because Finance needs business meaning, while Engineering needs system levers. The bridge is the capability boundary: “What does it cost us to produce one valuable outcome, and which system behaviors drive that cost?”

A strong interview line:

> I would not report only monthly spend. I would define the business unit of value, then measure the system cost required to produce that unit. Only then can we tell whether the architecture is economically healthy.

---

## Exercise 3 Solution: FinOps as Architectural Control

Monthly cloud-bill review is weak because it is retrospective. By the time Finance sees the spike, the system has already repeated the expensive behavior thousands or millions of times.

FinOps as architectural control should operate closer to runtime.

A strong design includes five moves: monitor, attribute, optimize, budget, and enforce.

### 1. Monitor by capability

Do not monitor only cloud account, cluster, or service. Monitor:

- Cost per claim decision
- Cost per route plan
- Cost per order modification
- Cost per AI support resolution
- Cost per conversion or engaged minute

### 2. Attribute spend to behavior

Spend should be attributed to:

- Retrieval fan-out
- Tool calls
- Retries
- Model tier
- Token usage
- Queue depth
- Reprocessing
- Human review
- Escalation

### 3. Optimize multiplication, not pennies

Do not only trim infrastructure. Remove repeated behavior:

- Shrink context
- Reduce source fan-out
- Collapse agent chains
- Cache stable evidence
- Tier models
- Batch non-urgent work
- Stop duplicate retries
- Make ambiguous states explicit

### 4. Budget by value unit

Budgets should match business outcomes:

- Maximum cost per claim
- Maximum cost per route plan
- Maximum cost per resolved support case
- Maximum tool calls per order modification
- Maximum retrieval documents per decision
- Maximum premium-model usage per risk tier

### 5. Enforce at runtime

When limits are exceeded, the system should change behavior:

- Tier down model
- Reduce retrieval fan-out
- Compress context
- Defer action
- Move to slow lane
- Escalate
- Pause automation
- Hard-stop wasteful work

Stop authority matters. Someone must be allowed to narrow or pause automation when the economics become unsafe. For example, the claims automation owner may pause high-risk auto-approval if cost per claim and appeal rate exceed threshold.

The senior answer: FinOps is not budget reporting. It is a runtime control surface.

---

## Exercise 4 Solution: AI Cost Multiplier

A 20 percent traffic increase causing a 5x cost increase means cost is not scaling linearly with requests. The system is multiplying work per request.

Likely causes:

### Retrieval fan-out

The assistant may be searching too many sources or retrieving too many documents. During promotion traffic, ambiguity rises, so the system may pull more policy docs, product docs, inventory records, prior cases, and support articles.

Controls:

- Top-K caps
- Source priority
- Admissible evidence lanes
- Cached policy docs
- Conflict routes

### Retry storms

Tail latency may cause clients, services, and agents to retry.

Controls:

- Retry budgets
- Exponential backoff
- Idempotency
- Single-flight control
- Backpressure

### Tool loops

The agent may repeatedly call inventory, pricing, payment, tax, order, shipment, or support tools to “be safe.”

Controls:

- Tool-call caps
- Tool allowlists
- Circuit breakers
- Deterministic workflows for high-risk actions
- Kill switch

### Prompt/context inflation

The prompt may include long chat history, retrieved docs, policy text, and tool traces.

Controls:

- Token budget
- Context compression
- Memory TTL
- Summarization lanes
- Prompt template versioning

### Multi-agent cascades

Planner, executor, verifier, policy checker, and explainer agents may all call models.

Controls:

- Max-depth rules
- Collapse roles
- Budgeted verification
- Use deterministic validators where possible

### Model-tier escalation

Simple questions may route to expensive models.

Controls:

- Intent classification
- Tiered model routing
- Low-cost model for FAQ/drafts
- Premium model only for high-risk decisions

### Evaluation loops

Self-checks and reruns may multiply cost.

Controls:

- Loop caps
- Confidence gates
- Stop conditions
- Human escalation

### Human rework

Ambiguous or low-quality decisions may increase support or operations cost.

Controls:

- Better state semantics
- Evidence packets
- Early escalation
- Stop automation when appeal or reversal rate rises

Owner:

- Capability owner owns business behavior
- AI platform owner owns model/tokens/tool budgets
- FinOps owner owns economic reporting
- Product owner owns value/cost trade-off
- Stop authority should be named before scale

The senior answer: AI cost is requests multiplied by hidden work. Control the DAG, not only the model.

---

## Exercise 5 Solution: Cost Budget Contract

Example capability: DreamMart AI order modification.

### Unit of value

One successful, policy-compliant order modification completed without increasing disputes, reversals, or support burden.

### Unit cost

Cost per order modification decision, including:

- Retrieval
- Model call
- Tool calls
- Policy checks
- Payment/fulfillment checks
- Replay logging
- Human escalation if needed

### Normal-path budget

For low-risk order modifications before fulfillment cutoff:

- Retrieval: max 3 authoritative sources
- Tool calls: max 4
- Model tier: standard model
- Retry: max 1 retry per tool
- Latency: within commitment budget
- Replay: mandatory

### Degraded-path budget

When a dependency is slow or evidence is incomplete:

- Reduce tool calls
- Use deterministic workflow
- No premium model unless risk requires
- Move to pending if proof is missing
- No automatic commitment

### Escalated-path budget

For high-risk changes:

- Human review required
- Evidence packet attached
- Model only drafts explanation
- No autonomous action
- Cost tracked separately as escalated path

### Retry limit

- Max 1–2 retries for idempotent reads
- No repeated state-changing tool calls without idempotency key
- Retry exhaustion moves to pending or escalation

### Retrieval/tool-call limit

- Top-K cap
- Source allowlist
- Tool allowlist
- Maximum tool-call count
- Stop if authoritative evidence conflicts

### Model-tier rule

- Small model for FAQ or drafting
- Standard model for normal support
- Premium model only for high-risk reasoning with value justification
- Deterministic workflow for final commitment checks

### Stop condition

Stop or narrow automation when:

- Cost per successful modification exceeds threshold
- Tool failure rate exceeds budget
- Dispute/reversal rate rises
- Replay coverage drops
- Escalation rate crosses threshold
- Evidence conflict rate rises

### Owner

Order-modification capability owner has authority to pause or narrow automation.

The contract prevents cost from becoming a postmortem because the system does not wait for the monthly bill. It changes behavior when budgets are breached.

---

## Bonus Exercise 6 Solution: Sustainability as Scaling Without Regret

A strong answer should define sustainability as behavior control, not branding.

The problem is not only that the system uses energy. The problem is that it repeatedly chooses wasteful execution when cheaper, cleaner, or less intensive options would preserve business value.

A sustainability control strategy should include:

### Boundary measurement

Measure energy or carbon per:

- Batch job
- Inference path
- Route decision
- Manufacturing anomaly review
- Digital-twin simulation
- Forecast run

### Carbon-aware scheduling

Non-urgent jobs should move to lower-carbon or lower-cost windows when business timing allows.

Examples:

- Batch analytics
- Model evaluation
- Index rebuilds
- Offline simulations
- Non-urgent report generation

### Workload shifting

Shift flexible workloads by:

- Time window
- Region
- Model tier
- Batch size
- Hardware type

Subject to:

- Data residency
- Latency
- Compliance
- Operational urgency

### Model right-sizing

Use:

- Smaller models for classification
- Quantized models where quality holds
- Distilled models for repeatable tasks
- Premium models only for high-risk/high-value decisions

### Reduced data movement

Controls:

- Co-locate data and compute
- Cache stable features
- Avoid repeated extraction
- Use event coalescing
- Avoid cross-region transfer unless needed

### Reduce repeated work

Control:

- Retries
- Reprocessing
- Duplicate inference
- Tool loops
- Prompt inflation
- Always-on real-time processing

### Execution-changing sustainability metrics

Metrics should change behavior:

- Carbon per inference
- Energy per batch job
- Carbon per decision
- Rework rate
- Cache efficiency
- Idle capacity waste
- Model-tier mix
- Retry waste

If a sustainability metric does not change routing, scheduling, model tiering, batching, or retry behavior, it is reporting, not architecture.

---

## Bonus Exercise 7 Solution: Waste Pattern Analysis

A strong answer should choose waste patterns and connect each one to architectural controls.

### 1. Retry storms

Where it comes from:

- Timeouts
- Tail latency
- Naive client/server retries
- Agent retries after tool failure

Why it grows:

- Every retry adds load to an already stressed dependency.

Control:

- Retry budgets
- Backoff
- Circuit breakers
- Idempotency
- Single-flight

Metric:

- Retry count per successful outcome
- Retry spend
- P99 latency after retries
- Duplicate request rate

### 2. Retrieval fan-out inflation

Where it comes from:

- “Just one more source”
- Too many documents
- Reranking layers
- No source priority

Why it grows:

- Ambiguity causes teams to add sources instead of defining admissible evidence.

Control:

- Top-K caps
- Source allowlists
- Evidence lanes
- Cached policy docs
- Conflict routes

Metric:

- Documents retrieved per answer
- Retrieval cost per successful decision
- Conflict rate
- Citation usefulness

### 3. Tool-call cascades

Where it comes from:

- Agents call tools repeatedly to verify
- Tools call other tools
- Missing stop conditions

Why it grows:

- Each tool call adds latency, cost, and failure surface.

Control:

- Tool budgets
- Tool allowlists
- Step limits
- Deterministic workflows
- Kill switch

Metric:

- Tool calls per task
- Tool failure rate
- Cost per tool path
- Escalation after tool failure

### 4. Prompt/context inflation

Where it comes from:

- Long histories
- More policies added into prompt
- Full transcripts appended “just in case”

Why it grows:

- Every release adds context, but old context rarely gets removed.

Control:

- Token budgets
- Context windows
- Memory TTL
- Summarization
- Template versioning

Metric:

- Tokens per request
- Prompt growth by release
- Cost per answer
- Latency per token band

### 5. Overpowered model-tier usage

Where it comes from:

- Defaulting every task to the largest model
- No risk-based routing
- Fear of quality regression

Why it grows:

- Teams choose the safest-looking model instead of the right model.

Control:

- Model right-sizing
- Intent classification
- Risk-based routing
- Fallback models
- Premium-model budget

Metric:

- Premium-model percentage
- Cost per model tier
- Quality delta by tier
- Business value per tier

The core lesson: waste is repeated behavior without governance.

---

## Bonus Exercise 8 Solution: Economics Design Review Table

Example: DreamInsurance claim handling.

| Capability | Unit of Value | Unit Cost | Cost Multipliers | Enforcement | Stop Authority | Finance View | Engineering View | Sustainability Metric |
|---|---|---|---|---|---|---|---|---|
| AI claim handling | Claim resolved or leakage prevented | Cost per claim decision | Retrieval fan-out, tool loops, retries, long context, adjuster rework | Top-K caps, model tiering, tool budgets, review gates, kill switch by risk tier | Claims automation owner | Cost by product line, claim type, region, risk tier | Cost by execution path, retrieval count, tool calls, token use, retry spend | Energy per claim + rework rate |

How this turns cost into a capability contract:

- Unit of value defines what the business is buying.
- Unit cost defines what the system spends to produce that value.
- Multipliers expose behaviors that make cost grow.
- Enforcement defines how behavior changes.
- Stop authority names who can intervene.
- Finance view translates cost into business language.
- Engineering view translates cost into technical levers.
- Sustainability metric keeps waste visible beyond dollars.

The senior answer: without this table, cost control becomes a monthly argument. With it, cost becomes an operating contract.

---

## Bonus Exercise 9 Solution: Value vs. Waste

A strong answer should explain that marginal improvement can flatten while cost continues rising.

In DreamMedia, each additional retrieval source, feature-store join, model pass, and verifier may improve relevance slightly. Early additions may produce meaningful lift. Later additions may produce only tiny improvements while increasing compute, latency, complexity, and operational risk.

This is the value-versus-waste curve:

- At first, cost increases and value increases.
- Then value starts to flatten.
- Cost continues to rise.
- The system enters the regret zone.

Fan-out intelligence becomes unsafe when:

- More retrieval does not improve engagement meaningfully
- Model passes add latency without conversion lift
- Verifiers reduce risk only marginally
- Feature joins increase infrastructure cost without business impact
- Personalization cost grows faster than engaged minutes or conversion

Budget gates in the inference DAG:

- Max retrieval sources
- Max feature joins
- Max model passes
- Max verifier calls
- Max cost per recommendation
- Max latency per surface
- Max premium model usage
- Minimum lift required for additional stage

Metrics:

- Cost per engaged minute
- Cost per conversion
- Cost per recommendation
- Marginal lift per added stage
- Latency impact per added stage
- Carbon per engaged minute
- Cache hit rate

Stop authority:

- Personalization owner
- Product owner
- FinOps owner
- Experimentation/governance owner

The key decision: stop adding intelligence when marginal value no longer justifies marginal cost.

---

## Bonus Exercise 10 Solution: Senior Architect Economics Defense

A mature answer should acknowledge that monitoring spend, smaller models, prompt trimming, and reserved capacity are useful tactics, but not a complete strategy.

Economics is architecture under volume because cost is created by repeated system behavior.

A senior strategy includes:

### Tie cost to value

Start with the unit of value:

- Claim resolved
- Route plan executed
- Delivery completed
- Conversion achieved
- Order modification completed
- Support case resolved

### Measure cost at capability boundaries

Measure:

- Cost per decision
- Cost per resolution
- Cost per conversion
- Cost per route
- Cost per successful action

### Expose multipliers

Look for:

- Retrieval fan-out
- Tool loops
- Retry storms
- Prompt inflation
- Model-tier drift
- Multi-agent cascades
- Human rework
- Reprocessing

### Enforce budgets at runtime

When budgets are exceeded, the system must change behavior:

- Tier down
- Cache
- Compress
- Defer
- Escalate
- Stop
- Route differently
- Reduce fan-out

### Name stop authority

A named owner must be able to pause or narrow automation when:

- Cost per value unit exceeds threshold
- Marginal value flattens
- Appeal/rework rate rises
- Sustainability limits are breached
- Premium model usage exceeds budget

### Make sustainability executable

Sustainability should change:

- Scheduling
- Routing
- Model tiering
- Retry behavior
- Batch windows
- Data movement
- Hardware choice

### Preserve evidence

Evidence should show:

- Request path
- Budget consumed
- Model tier used
- Tool calls
- Retrieval fan-out
- Retry count
- Outcome produced
- Value unit achieved
- Cost per value unit

One economic boundary to defend:

> No high-scale AI capability should run without a unit of value, unit cost, multiplier caps, runtime budget enforcement, and named stop authority.

Senior interview line:

> I would make cost legible at capability boundaries, enforceable in production, and explainable later. I would define the unit of value, unit cost, cost multipliers, runtime budgets, sustainability metric, and stop authority before the system scales.
