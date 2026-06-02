# System Design with AI Interview Guide
## Official Companion Repository

> **The book is the masterclass. This repository is the practice lab.**
>
> The book teaches the full reasoning, chapter walkthroughs, trade-off narratives, and interview storytelling. This repository helps you practice that thinking through templates, prompts, rubrics, diagrams, and companion artifacts.

---

# Seven-Step System Design Method: Quick Reference

This is a compact field card for the method used throughout the book. It is intentionally brief. For complete teaching, examples, and applied walkthroughs, read Part I and the applied chapters of _System Design with AI Interview Guide_.

## The Method

| Step | Question | Output |
|---|---|---|
| 1. Clarify the problem | What are we designing and what is out of scope? | Requirements and assumptions |
| 2. Identify actors and journeys | Who uses the system and what journey matters most? | Actor map and journey map |
| 3. Map capabilities | What must the business or product be able to do? | Capability map |
| 4. Define quality attributes | What scale, latency, availability, consistency, security, and cost constraints matter? | Non-functional requirements |
| 5. Draw high-level architecture | Which components own which responsibilities? | Context and component view |
| 6. Deep dive critical flows | Where can the design fail or become expensive? | Sequence, data, and failure views |
| 7. Validate and evolve | Can we defend trade-offs and adapt over time? | Trade-off defense and evolution plan |

## What Strong Candidates Do

Strong candidates do not jump directly to boxes and arrows. They first identify the promise the system is making. Then they design the responsibilities, data flows, and failure behavior needed to keep that promise under pressure.

## Interview Questions for Each Step

| Step | Ask Yourself |
|---|---|
| Clarify | What user outcome must the system protect? |
| Actors | Who can start, block, abuse, or observe the flow? |
| Capabilities | Which business capabilities must exist before technology choices make sense? |
| Quality attributes | Which constraint will dominate the design: latency, scale, consistency, availability, cost, or trust? |
| Architecture | Which component owns the commitment? |
| Deep dive | What happens when dependencies fail, traffic spikes, or data arrives late? |
| Validate | What would I change if scale increased by 10x? |

## AI-Aware Extension

When AI is part of the system, add these questions:

- What is the AI allowed to do?
- What evidence grounds the answer or action?
- Which model, prompt, policy, and data version were used?
- What happens when confidence is low?
- Can the decision be replayed later?
- Who owns correction, escalation, or stop authority?

The book explains these ideas in depth through applied system chapters. This document is only a quick reference for practice.

## Common Mistakes

- Drawing architecture before clarifying the promise.
- Treating scale as only request volume.
- Ignoring failure modes because the happy path looks clean.
- Adding AI without defining evidence, authority, or fallback.
- Discussing technologies without explaining responsibilities.

## Practice Prompt

```text
Act as a senior system design interviewer. Ask me to design a system using the 7-Step Method. Do not let me jump to architecture until I clarify requirements, actors, capabilities, and quality attributes. Challenge me on trade-offs, failure modes, and cost.
```
