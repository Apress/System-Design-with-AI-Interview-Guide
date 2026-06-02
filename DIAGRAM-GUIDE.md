# System Design with AI Interview Guide
## Official Companion Repository

> **The book is the masterclass. This repository is the practice lab.**
>
> The book teaches the full reasoning, chapter walkthroughs, trade-off narratives, and interview storytelling. This repository helps you practice that thinking through templates, prompts, rubrics, diagrams, and companion artifacts.

---

# Diagram Guide

Good system design diagrams show responsibility. They do not merely draw boxes. This guide helps you create diagrams that support interview explanations and architecture reviews. For full examples, use the book and chapter artifacts.

## Diagram Types

| Diagram | Purpose |
|---|---|
| Context diagram | Shows users, external systems, and system boundary |
| Component diagram | Shows major services and ownership |
| Sequence diagram | Shows request flow and timing |
| Data-flow diagram | Shows data movement, storage, and transformation |
| Deployment diagram | Shows regions, zones, clusters, and edge locations |
| Failure-mode diagram | Shows fallback, retry, timeout, and degradation paths |
| Observability view | Shows metrics, logs, traces, alerts, and replay evidence |
| AI decision view | Shows model, prompt, policy, retrieval, tool calls, and evidence |

## Diagram Rules

1. Label responsibilities, not just service names.
2. Show synchronous and asynchronous flows differently.
3. Mark trust boundaries.
4. Show data ownership.
5. Show caches and invalidation points.
6. Show queues and backpressure.
7. Show fallback paths.
8. Show observability and audit evidence.
9. Avoid drawing every implementation detail in the first diagram.
10. Use multiple views instead of one overloaded diagram.

## What Interviewers Look For

Interviewers are not only judging whether the diagram looks clean. They are judging whether you understand responsibility, trade-offs, and failure behavior. A simple diagram with clear ownership is better than a complex diagram with vague boxes.

## AI Diagram Additions

For AI systems, include:

- Model or inference service.
- Retrieval source, if used.
- Prompt and policy version.
- Tool execution boundary.
- Human review or escalation path.
- Evaluation and feedback loop.
- Evidence capture for replay.

## Diagram Review Checklist

Before finalizing a diagram, ask:

- Can I explain every box in one sentence?
- Does each arrow have a reason?
- Where does the user wait?
- Where can the design fail?
- Where is data stored and who owns it?
- What gets cached and how does it expire?
- What is observable during an incident?
- What would change at 10x scale?

## Use With the Book

The book explains why different views matter. This guide helps you draw them consistently while practicing.
