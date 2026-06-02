# System Design with AI Interview Guide
## Official Companion Repository

> **The book is the masterclass. This repository is the practice lab.**
>
> The book teaches the full reasoning, chapter walkthroughs, trade-off narratives, and interview storytelling. This repository helps you practice that thinking through templates, prompts, rubrics, diagrams, and companion artifacts.

---

# System Design Interview Rubric

Use this rubric after practicing a chapter artifact. It is a self-assessment tool, not a substitute for the book’s detailed examples and interview narratives.

## Scoring Scale

| Score | Meaning |
|---|---|
| 1 | Missing or unclear |
| 2 | Basic mention, little reasoning |
| 3 | Reasonable but incomplete |
| 4 | Strong and defensible |
| 5 | Senior-level, clear trade-offs and failure handling |

## Core Rubric

| Area | What Good Looks Like | Score |
|---|---|---|
| Problem framing | Clarifies scope, users, goals, and non-goals | 1-5 |
| Actors and journey | Identifies key actors and primary user journey | 1-5 |
| Requirements | Separates functional and non-functional requirements | 1-5 |
| Architecture structure | Components have clear responsibilities | 1-5 |
| Data design | Storage choices match access patterns and consistency needs | 1-5 |
| Scale and performance | Handles growth, hot paths, caching, queues, and bottlenecks | 1-5 |
| Reliability | Covers retries, timeouts, fallback, degradation, and recovery | 1-5 |
| Consistency | Explains where strong vs eventual consistency is acceptable | 1-5 |
| Security and abuse | Covers identity, authorization, privacy, fraud, and misuse | 1-5 |
| Observability | Defines metrics, logs, traces, alerts, and replay evidence | 1-5 |
| Cost awareness | Explains major cost drivers and control levers | 1-5 |
| AI-awareness | Uses AI responsibly, with grounding, evaluation, and fallback | 1-5 |
| Communication | Explains trade-offs clearly and adapts to interviewer feedback | 1-5 |

## Interpretation

| Total | Readiness Signal |
|---|---|
| 13-30 | Needs foundational practice |
| 31-45 | Understands basics but needs stronger trade-off defense |
| 46-55 | Good interview readiness |
| 56-65 | Senior-level readiness |

## Red Flags

Watch for these patterns:

- Starting with technologies before requirements.
- Using databases or queues without explaining why.
- Ignoring partial failure.
- Forgetting observability.
- Treating AI as a feature instead of a system responsibility.
- Claiming high availability without explaining failover.
- Claiming low latency without identifying the critical path.

## Senior-Level Signals

A senior answer usually includes:

- Clear commitment points.
- Explicit ownership boundaries.
- Failure behavior, not just happy-path behavior.
- Evidence and replay for important decisions.
- Cost and operational trade-offs.
- A realistic evolution path.

## Practice Instruction

After each chapter, score your own answer before reading the companion solution or asking an AI tool for feedback. The book teaches the full reasoning; this rubric helps you measure whether you can reproduce and defend it.
