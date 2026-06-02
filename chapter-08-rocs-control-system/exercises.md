# Chapter 8 Exercises

## Exercise 1: ROCS Warm-Up

Apply Reliability, Observability, Cost, and Sustainability to an AI shopping assistant that uses a planner, retriever, vector database, reranker, LLM router, tool calls, recommendation engine, inventory API, pricing API, and response generator.

## Exercise 2: AI Inference DAG

Challenge the assumption that an AI assistant is “just one model call.” Draw or describe the hidden inference DAG behind a modern AI assistant and identify ROCS hotspots.

## Exercise 3: ROCS Loop

Use Sense, Interpret, Decide, Act, and Prove to respond when escalations rise, responses slow down, GPU bills increase, and customer complaints grow while dashboards remain green.

## Exercise 4: Reliability Is Not Uptime

Analyze a checkout system that is available and returning responses but confirms orders before inventory reservation is reliable.

## Exercise 5: Observability and Decision Replay

Design the ROCS-grade observability needed to answer, six months later, “Why did the system allow this AI-assisted order modification?”

---

# Bonus Exercises

## Bonus Exercise 6: Cost Governance

Diagnose why a 10 percent traffic increase created a 4x AI cost increase. Define budgets for retries, tool calls, retrieval fan-out, token usage, latency at commit, and evidence coverage.

## Bonus Exercise 7: Sustainability and Governable Change

Analyze a digital twin system where sensor drift causes more retrieval, longer prompts, extra agent hops, and higher GPU usage.

## Bonus Exercise 8: Instrumented Indecision

Analyze a company that has dashboards, traces, alerts, and postmortems but no authority to pause automation when replay coverage drops.

## Bonus Exercise 9: ROCS Design Review Table

Create a ROCS design-review table for one AI-enabled capability, including promise at commitment, drift, signal, containment decision, evidence, and owner.

## Bonus Exercise 10: Senior Architect ROCS Defense

Defend ROCS when an interviewer says, “Why not just monitor latency, errors, and cost, and let the platform autoscale?”
