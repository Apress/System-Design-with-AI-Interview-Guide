# Chapter 8 Solution Guide

## Exercise 1 Solution: ROCS Warm-Up

A strong answer should define ROCS as a coupled control system.

- Reliability: identify the promise that must still hold under uncertainty.
- Observability: capture evidence that explains why the system acted.
- Cost: identify behavior that multiplies under volume.
- Sustainability: ensure the system remains governable as teams, models, policies, vendors, and regions change.

The key point is that these dimensions are coupled. A reliability fix such as retries may increase latency, cost, GPU load, and carbon impact. A cost fix such as aggressive caching may weaken correctness. ROCS forces these trade-offs to be governed together.

## Exercise 2 Solution: AI Inference DAG

A strong answer should show that an AI request may pass through:

- API gateway
- Planner or intent classifier
- Retriever
- Vector database
- Reranker
- Prompt builder
- Model router
- LLM
- Tool calls
- Evaluator or safety layer
- Memory/context store
- Observability and replay
- Escalation path

Each hop creates reliability, observability, cost, and sustainability risk. The design should trace the full path rather than monitoring only the model.

## Exercise 3 Solution: ROCS Loop

A strong answer should use:

- Sense: capture escalations, reversals, tool bursts, retry storms, cost spikes, policy drift, and replay gaps.
- Interpret: diagnose which promise is under pressure.
- Decide: assign authority to pause, cap, defer, or roll back behavior.
- Act: apply the smallest safe intervention.
- Prove: show updated tests, replay coverage, telemetry, and guardrails.

This prevents instrumented indecision: seeing the problem clearly but not being authorized to change behavior.

## Exercise 4 Solution: Reliability Is Not Uptime

A strong answer should state that uptime does not equal reliability.

If the system confirms an order before inventory reservation is defensible, the violated promise is order commitment integrity. The response should include explicit pending states, idempotency, retry budgets, single-flight control, queue-first inference, and evidence before commitment.

The system should not bluff confirmation when commitment proof is missing.

## Exercise 5 Solution: Observability and Decision Replay

A strong answer should include:

- Prompt-level tracing
- Vector query telemetry
- GPU queue telemetry
- Multi-agent span correlation
- Structured prompt logging
- Tool-call tracing
- Policy version
- Evidence snapshot
- Human approval or override
- Decision Replay Card
- Reversal link

Dashboards and logs are not enough because they may show activity without proving why the system was allowed to act.

## Bonus Exercise 6 Solution: Cost Governance

A strong answer should identify cost multipliers:

- Token drift
- Retrieval fan-out
- Agent loops
- Retry cascades
- Tool-call bursts
- Vector cold starts
- GPU queue buildup
- Autoscaling lag
- Manual cleanup

Budgets should exist for retries, tool calls, retrieval fan-out, token usage, latency at commitment, and evidence coverage. Each exceeded budget should trigger a defined behavior: compress, tier model, defer, escalate, hard stop, or switch to pending.

## Bonus Exercise 7 Solution: Sustainability and Governable Change

A strong answer should explain that sustainability means both responsible compute and governable change.

Controls may include:

- Carbon-aware routing
- Time-shifted inference
- Low-precision hardware
- Quantization
- Smaller models
- Less data movement
- Elimination of useless hops
- Per-inference carbon and cost measurement

## Bonus Exercise 8 Solution: Instrumented Indecision

A strong answer should state that observability without agency is not control.

The design must define who can pause, degrade, defer, throttle, or roll back behavior when thresholds are breached. Stop authority must include blast-radius control and re-enable criteria.

## Bonus Exercise 9 Solution: ROCS Design Review Table

A strong answer should include:

| Capability | Promise at Commitment | What Drifts | ROCS Signal | Containment Decision | Evidence Required | Decision Owner |
|---|---|---|---|---|---|---|

The table is valuable because it forces the team to identify the promise, the drift, the signal, the containment response, the required evidence, and the owner before production pressure arrives.

## Bonus Exercise 10 Solution: Senior Architect ROCS Defense

A strong answer should defend ROCS by explaining:

- AI reliability is not only uptime.
- Observability must include decision replay.
- Cost is behavior multiplied by volume.
- Sustainability includes governable change.
- AI inference is a DAG, not a single model call.
- Retries, tools, retrieval, token growth, and GPU queues need budgets.
- Stop authority prevents dashboards from becoming performance art.
