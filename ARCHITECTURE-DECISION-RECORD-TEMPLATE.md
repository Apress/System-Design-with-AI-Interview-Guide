# System Design with AI Interview Guide
## Official Companion Repository

> **The book is the masterclass. This repository is the practice lab.**
>
> The book teaches the full reasoning, chapter walkthroughs, trade-off narratives, and interview storytelling. This repository helps you practice that thinking through templates, prompts, rubrics, diagrams, and companion artifacts.

---

# Architecture Decision Record Template

Use this template to practice trade-off defense. It is useful after reading a chapter and completing a design exercise.

```md
# ADR: [Decision Title]

## Status
Proposed / Accepted / Rejected / Superseded

## Context
What problem are we solving? What constraints matter? What assumptions are we making?

## Decision
What decision did we make? State it clearly.

## Alternatives Considered
1. Option A
2. Option B
3. Option C

## Why This Decision
Why is this the best choice for the current requirements?

## Trade-offs
What improves? What gets worse? What complexity are we accepting?

## Failure Modes
How can this decision fail? What is the fallback?

## Observability
What metrics, logs, traces, alerts, or replay evidence are needed?

## Security and Compliance Impact
What risks or controls are introduced?

## Cost Impact
What are the major cost drivers?

## AI Impact, If Applicable
Does this involve models, prompts, retrieval, tools, evidence, evaluation, or human review?

## Consequences
What must future teams know because this decision was made?
```

## Interview Use

In an interview, you do not need to write a full ADR. But thinking in this structure helps you sound senior because you explain context, decision, alternatives, and consequences.

For full examples of trade-off reasoning, read the corresponding chapters in the book.
