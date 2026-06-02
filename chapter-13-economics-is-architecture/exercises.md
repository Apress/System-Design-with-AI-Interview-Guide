# Chapter 13 Exercises

## Exercise 1: Economics as System Behavior

DreamInsurance launches an AI claims assistant. In the pilot, it reduces claim cycle time. After scaling, each claim costs far more than expected because the agent retrieves more documents, calls more tools, retries after timeouts, and routes more cases to manual review.

Explain why this is an architecture problem, not only a finance problem.

Your answer should include:

- The difference between diagram architecture and behavior architecture
- Why cost is shaped by repeated system behavior
- How retries, retrieval fan-out, tool loops, and human rework multiply cost
- Why a system can meet reliability goals and still become financially toxic
- What should be measured at the capability boundary
- What enforcement mechanisms should change runtime behavior

## Exercise 2: Unit of Value and Unit Cost

A team says, “Our AI system costs $40,000 per month.”

Why is that number incomplete?

Define the **unit of value** and **unit cost** for one of the following capabilities:

- DreamInsurance claim handling
- DreamLogistics route planning
- DreamMedia personalization
- DreamMart AI shopping assistant

Your answer should include:

- What business outcome the system is supposed to produce
- What one unit of successful value means
- What system work is required to produce that value
- How to measure cost per decision, claim, route, delivery, conversion, or resolved case
- Why Finance and Engineering need different but connected views

## Exercise 3: FinOps as Architectural Control

A company uses FinOps only as a monthly cloud-bill review. When spend spikes, engineering is asked to reduce cost after the fact.

Why is this weak?

Design FinOps as an architectural control surface.

Your answer should include:

- Cost visibility by capability and execution path
- Spend attribution to behaviors, not only services
- Optimization by removing multiplication
- Budgets tied to units of value
- Runtime enforcement when budgets are exceeded
- Stop authority for pausing or narrowing automation
- How the system should tier down, cache, defer, escalate, compress, or stop

## Exercise 4: AI Cost Multiplier

DreamMart’s AI assistant receives only 20 percent more traffic during a promotion, but inference cost increases 5x.

Diagnose the cost explosion.

Your answer should include:

- Retrieval fan-out
- Retry storms
- Tool loops
- Prompt/context inflation
- Multi-agent cascades
- Model-tier escalation
- Evaluation loops
- Human rework
- Which budget caps should exist
- Which owner should be allowed to stop or narrow the behavior

## Exercise 5: Cost Budget Contract

Create a **Cost Budget Contract** for a high-scale capability, such as AI claim handling, order modification, route planning, or personalization.

Your answer should include:

- Unit of value
- Unit cost
- Normal-path budget
- Degraded-path budget
- Escalated-path budget
- Retry limit
- Retrieval/tool-call limit
- Model-tier rule
- Stop condition
- Owner with authority to pause or narrow automation

Explain how this contract prevents cost from becoming a postmortem.

---

# Bonus GitHub Exercises

## Bonus Exercise 6: Sustainability as Scaling Without Regret

A DreamManufacturing analytics system runs heavy AI batch jobs, repeated inference, and large data movement in the most expensive and carbon-intensive windows, even when the work is not urgent.

Design a sustainability control strategy.

## Bonus Exercise 7: Waste Pattern Analysis

Choose five waste patterns and explain how you would control them:

- Retry storms
- Retrieval fan-out inflation
- Tool-call cascades
- Prompt/context inflation
- Overpowered model-tier usage
- Reprocessing due to unclear commitment
- Always-on real-time where batch would work
- Human rework as hidden runtime
- Carbon-blind scheduling

## Bonus Exercise 8: Economics Design Review Table

Create an economics-as-architecture design-review table for one capability.

## Bonus Exercise 9: Value vs. Waste

DreamMedia personalization adds another retrieval source, another feature-store join, another model pass, and another verifier. Engagement improves slightly, but cost keeps rising.

Analyze the value-versus-waste curve.

## Bonus Exercise 10: Senior Architect Economics Defense

An interviewer says:

“Cost optimization is simple: monitor spend, use smaller models, trim prompts, and buy reserved capacity.”

Defend a more mature economics strategy.
