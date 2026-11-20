# System Design with AI Interview Guide
## Official Companion Repository

> **The book is the masterclass. This repository is the practice lab.**
>
> The book teaches the full reasoning, chapter walkthroughs, trade-off narratives, and interview storytelling. This repository helps you practice that thinking through templates, prompts, rubrics, diagrams, and companion artifacts.

---

# Book-to-Repository Map

This file maps the book chapters to companion artifacts. It is a navigation guide, not a replacement for the chapters. For complete explanations, trade-off reasoning, interview narratives, and diagrams, read the book.

> The repository gives you practice surfaces. The book gives you the reasoning model.

## Chapter Map

The links below match the chapter folders in this repository. Open a chapter's README for its resources, attempt the exercises, and then compare with its solution guide.

| Chapter | Topic and folder | Exercises | Practice focus |
|---|---|---|---|
| 1 | [System Design Methodology](chapter-01-system-design-methodology/README.md) | [Practice](chapter-01-system-design-methodology/exercises.md) | Frame the problem and rehearse the seven-step answer |
| 2 | [Understanding the Business Domain](chapter-02-understanding-the-business-domain/README.md) | [Practice](chapter-02-understanding-the-business-domain/exercises.md) | Map domain rules and business commitments |
| 3 | [Empathizing with the Customer](chapter-03-empathizing-with-the-customer/README.md) | [Practice](chapter-03-empathizing-with-the-customer/exercises.md) | Identify actors, journeys, and customer promises |
| 4 | [Business Capabilities](chapter-04-business-capabilities/README.md) | [Practice](chapter-04-business-capabilities/exercises.md) | Assign capability boundaries and ownership |
| 5 | [High-Level Solution Architecture](chapter-05-high-level-solution-architecture/README.md) | [Practice](chapter-05-high-level-solution-architecture/exercises.md) | Draw responsibility and critical-flow views |
| 6 | [AI Architecture Primitives](chapter-06-ai-architecture-primitives/README.md) | [Practice](chapter-06-ai-architecture-primitives/exercises.md) | Choose AI primitives and their evidence requirements |
| 7 | [Trust, Safety, and the LLM-SHIELD Lens](chapter-07-trust-safety-llm-shield/README.md) | [Practice](chapter-07-trust-safety-llm-shield/exercises.md) | Review retrieval, tool access, and tenant isolation |
| 8 | [ROCS Control System](chapter-08-rocs-control-system/README.md) | [Practice](chapter-08-rocs-control-system/exercises.md) | Define controls, recovery, and stop authority |
| 9 | [Scale Is the Truth Serum](chapter-09-scale-is-the-truth-serum/README.md) | [Practice](chapter-09-scale-is-the-truth-serum/exercises.md) | Estimate load and identify bottlenecks |
| 10 | [Consistency Is a Trust Contract](chapter-10-consistency-is-a-trust-contract/README.md) | [Practice](chapter-10-consistency-is-a-trust-contract/exercises.md) | Define consistency and admissible-evidence contracts |
| 11 | [Latency Is How Broken Architecture Becomes Visible](chapter-11-latency-broken-architecture-visible/README.md) | [Practice](chapter-11-latency-broken-architecture-visible/exercises.md) | Trace critical paths and latency-driven failure |
| 12 | [Failure Is a System Behavior](chapter-12-failure-is-a-system-behavior/README.md) | [Practice](chapter-12-failure-is-a-system-behavior/exercises.md) | Design degradation, recovery, and replay |
| 13 | [Economics Is Architecture](chapter-13-economics-is-architecture/README.md) | [Practice](chapter-13-economics-is-architecture/exercises.md) | Explain cost drivers and resource budgets |
| 14 | [Ride-Sharing Systems](chapter-14-ride-sharing-systems/README.md) | [Practice](chapter-14-ride-sharing-systems/exercises.md) | Defend matching, location, and trip commitments |
| 15 | [Social Networking Systems](chapter-15-social-networking-systems/README.md) | [Practice](chapter-15-social-networking-systems/exercises.md) | Reason about feeds, privacy, and graph behavior |
| 16 | [E-Commerce Systems](chapter-16-e-commerce-systems/README.md) | [Practice](chapter-16-e-commerce-systems/exercises.md) | Distinguish holds, orders, and confirmed commitments |
| 17 | [Messaging Systems](chapter-17-messaging-systems/README.md) | [Practice](chapter-17-messaging-systems/exercises.md) | Defend delivery, ordering, and receipts |
| 18 | [Auction Systems](chapter-18-auction-systems/README.md) | [Practice](chapter-18-auction-systems/exercises.md) | Reason about bid order, clocks, and fairness |
| 19 | [Fraud Detection Systems](chapter-19-fraud-detection-systems/README.md) | [Practice](chapter-19-fraud-detection-systems/exercises.md) | Balance evidence, decisions, and false positives |
| 20 | [Video Streaming Systems](chapter-20-video-streaming-systems/README.md) | [Practice](chapter-20-video-streaming-systems/exercises.md) | Protect playback continuity and rights decisions |
| 21 | [Payment Systems](chapter-21-payment-systems/README.md) | [Practice](chapter-21-payment-systems/exercises.md) | Handle idempotency, ambiguous outcomes, and reconciliation |
| 22 | [File Storage Systems](chapter-22-file-storage-systems/README.md) | [Practice](chapter-22-file-storage-systems/exercises.md) | Defend durability, lifecycle, and access decisions |
| 23 | [Search Engine Systems](chapter-23-search-engine-systems/README.md) | [Practice](chapter-23-search-engine-systems/exercises.md) | Evaluate retrieval, freshness, citations, and AI answers |
| 24 | [Designing for Uncertainty Is the Job Now](chapter-24-designing-for-uncertainty/README.md) | [Practice](chapter-24-designing-for-uncertainty/exercises.md) | Combine commitment boundaries, evidence, and stop authority |

## Connect a Chapter to an Interactive Activity

| Focus | Companion activity |
|---|---|
| Chapters 12 and 21: failure and payments | [Refund recovery challenge and drill](CHALLENGES.md#drill-1-the-reply-was-lost) |
| Chapters 10 and 16: consistency and commerce | [Ticket booking challenge and drill](CHALLENGES.md#drill-2-one-seat-two-confirmations) |
| Chapters 7 and 23: isolation and search | [Tenant isolation challenge and drill](CHALLENGES.md#drill-3-the-answer-crossed-a-tenant-boundary) |
| Short practice across chapters | [Interactive quizzes](https://www.aiarchitectcircle.com/quizzes) |

See the [live practice table](CHALLENGES.md#live-interactive-practice) for website links and access details. Track your attempts with the [challenge scorecard](CHALLENGE-SCORECARD.md).

## How to Use This Map

Start with the chapter you are reading. Use the corresponding folder to practice the chapter's concepts. If you start from the repository first, use this map to choose a topic, then consult the book for the complete explanation.

## Maintaining This Map

When a chapter folder changes, update its README and exercise links here. Keep the map aligned with the actual repository rather than proposed folder names.
