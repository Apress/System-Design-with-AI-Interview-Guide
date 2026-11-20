# System Design with AI Interview Guide
## Official Companion Repository

> **The book is the masterclass. This repository is the practice lab.**
>
> The book teaches the full reasoning, chapter walkthroughs, trade-off narratives, and interview storytelling. This repository helps you practice that thinking through templates, prompts, rubrics, diagrams, and companion artifacts.

---

# Practice Guide

This guide turns the book and repository into a training plan. It assumes you are using the repository alongside _System Design with AI Interview Guide_. The book gives the teaching. The repository gives the reps.

## Daily Practice Format

Use this 45-minute format:

| Time | Activity |
|---|---|
| 5 min | Clarify requirements and actors |
| 10 min | Sketch high-level architecture |
| 10 min | Deep dive one critical flow |
| 10 min | Discuss scale, failure, data, and security |
| 5 min | Explain trade-offs |
| 5 min | Score with the rubric |

## 7-Day Sprint

| Day | Focus |
|---|---|
| 1 | Read the method overview and practice one simple system |
| 2 | Practice requirements, actors, and journeys |
| 3 | Practice scalability and bottlenecks |
| 4 | Practice data modeling and consistency |
| 5 | Practice reliability and failure modes |
| 6 | Practice AI-aware design questions |
| 7 | Run one full mock interview and score yourself |

## Pair the Sprint with Interactive Practice

Use these activities within the daily practice block. The [challenge guide](CHALLENGES.md) includes access details and repository-only alternatives.

| Day | Activity | Evidence to save |
|---|---|---|
| 1 | [Try a public quiz sample](https://www.aiarchitectcircle.com/quizzes#sample) | Your answer before the reveal and one corrected assumption |
| 2 | Frame the actors and customer promise for [the refund drill](CHALLENGES.md#drill-1-the-reply-was-lost) | Scope, non-goals, and the customer-visible states |
| 3 | Add a traffic spike to [the ticket drill](CHALLENGES.md#drill-2-one-seat-two-confirmations) | The first bottleneck and your overload policy |
| 4 | Defend the ticket reservation's consistency boundary | Which operation owns the final seat and why |
| 5 | Replay the refund drill with a lost reply and a worker restart | An event trace and recovery owner |
| 6 | Complete [the tenant-isolation drill](CHALLENGES.md#drill-3-the-answer-crossed-a-tenant-boundary) | Authorization checks and a negative test |
| 7 | Present one design, introduce a new constraint, and score it | A completed [scorecard](CHALLENGE-SCORECARD.md) and one revision |

After attempting a problem, compare your reasoning with a relevant [YouTube walkthrough](https://www.youtube.com/@AIArchitectCircle). Bring an unresolved trade-off to a [live session](https://www.aiarchitectcircle.com/live.html).

## 30-Day Interview Plan

### Week 1: Method Foundation

Read the early chapters of the book. Practice the 7-Step Method on smaller systems. Focus on asking better questions before drawing architecture.

### Week 2: Classic Distributed Systems

Practice systems such as e-commerce, messaging, file storage, search, and payments. Focus on scale, consistency, data modeling, and reliability.

### Week 3: AI-Aware Systems

Practice recommendation, fraud detection, search relevance, agentic workflows, RAG-style systems, and AI-assisted decision flows. Focus on evidence, replay, authority, degradation, and ownership.

### Week 4: Mock Interviews

Run timed interviews. Use the prompt library to create pressure. Score every answer with the rubric. Revise weak areas.

## 60-Day Mastery Plan

Use the 30-day plan twice. The first pass builds familiarity. The second pass builds fluency. On the second pass, add constraints such as multi-region design, privacy, cost reduction, abuse prevention, or AI governance.

## How to Use AI as a Coach

Ask AI tools to challenge your design, not to simply produce answers. Strong prompts ask for critique, trade-off questions, failure cases, and scoring. Use the [prompt library](PROMPT-LIBRARY.md) for ready-to-use examples.

## Build a Portfolio

For each system, save:

- One-page problem framing.
- Architecture sketch.
- Critical flow sequence.
- Data model notes.
- Failure-mode analysis.
- ADR for one major trade-off.
- Final interview script.

Over time, this becomes your system design portfolio.

## Reminder

The repository helps you practice. The book explains how expert reasoning unfolds chapter by chapter. Use both together.
