# System Design with AI Interview Guide
## Official Companion Repository

> **The book is the masterclass. This repository is the practice lab.**
>
> The book teaches the full reasoning, chapter walkthroughs, trade-off narratives, and interview storytelling. This repository helps you practice that thinking through templates, prompts, rubrics, diagrams, and companion artifacts.

---

# How to Use This Repository

This repository is best used alongside the book. Read the relevant chapter first, then use the matching artifacts to practice. The root documents orient you. The chapter folders give you focused exercises.

## The Recommended Workflow

```text
1. Read the chapter.
2. Review the chapter artifact.
3. Sketch the architecture from memory.
4. Explain the design aloud.
5. Score yourself using the rubric.
6. Use AI prompts to challenge your assumptions.
7. Revise your answer and repeat.
```

The goal is not to memorize a diagram. The goal is to learn how to reason under pressure.

## If You Are an Interview Candidate

Use this repository as a mock-interview gym. For each system, prepare a 35- to 45-minute answer. Start with requirements, identify actors, choose the core promise, draw the high-level architecture, deep dive into the most important flows, and defend trade-offs.

Recommended path:

1. Read the chapter in the book.
2. Open the chapter folder.
3. Complete the worksheet without looking at the suggested solution.
4. Use `PROMPT-LIBRARY.md` to ask an AI tool to interview you.
5. Score yourself with `INTERVIEW-RUBRIC.md`.
6. Rewrite the answer in your own words.

The book gives the full interview narrative. The repository helps you rehearse it.

## If You Are a Senior Engineer

Use the repository to sharpen practical design judgment. Focus on boundaries, ownership, failure modes, observability, data consistency, and cost. Do not stop at the happy path. Ask what happens when traffic spikes, dependencies degrade, data arrives late, users retry, or AI systems return uncertain results.

Recommended path:

1. Read the applied chapter.
2. Extend the design with one additional constraint.
3. Write an Architecture Decision Record using the template.
4. Add one failure-mode view.
5. Compare alternatives.

## If You Are an Architect

Use the repository as a decision-making toolkit. The most useful root artifacts for architects are the diagram guide, ADR template, AI system design guide, and system design checklist.

Recommended path:

1. Map the business capability.
2. Identify commitment points.
3. Define the evidence required before each commitment.
4. Draw architecture views that show responsibility, not just components.
5. Capture the decision and trade-offs in an ADR.

## If You Are an Instructor or Study Group Leader

Use one chapter per session. Ask learners to present the design, then challenge them on scale, reliability, data, security, cost, and AI behavior. Encourage learners to score themselves before receiving feedback.

Suggested session format:

| Segment | Activity |
|---|---|
| 10 minutes | Review the system prompt and constraints |
| 15 minutes | Individual sketching |
| 20 minutes | Group discussion |
| 20 minutes | Failure and trade-off challenge |
| 15 minutes | Rubric scoring and reflection |

## How to Pair the Book and Repository

The book explains why the design works. The repository helps you practice applying it.

| Book | Repository |
|---|---|
| Full explanations | Practice templates |
| Chapter walkthroughs | Companion artifacts |
| Trade-off narratives | Self-assessment rubric |
| Architecture reasoning | Diagram standards |
| AI-era concepts | Prompt library |

## What Not to Skip

Do not skip requirements. Do not skip actors. Do not skip failure modes. Do not skip cost. Do not add AI because it sounds modern. In strong system design, every component has a responsibility and every promise must be defensible.

## Start Here

1. Read `README.md`.
2. Review `SEVEN-STEP-METHOD.md`.
3. Pick one chapter from `BOOK-CODE-MAP.md`.
4. Practice using `PRACTICE-GUIDE.md`.
5. Score yourself using `INTERVIEW-RUBRIC.md`.

For the complete learning path, use this repository with _System Design with AI Interview Guide_.
