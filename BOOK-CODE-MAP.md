# System Design with AI Interview Guide
## Official Companion Repository

> **The book is the masterclass. This repository is the practice lab.**
>
> The book teaches the full reasoning, chapter walkthroughs, trade-off narratives, and interview storytelling. This repository helps you practice that thinking through templates, prompts, rubrics, diagrams, and companion artifacts.

---

# Book-to-Repository Map

This file maps the book chapters to companion artifacts. It is a navigation guide, not a replacement for the chapters. For complete explanations, trade-off reasoning, interview narratives, and diagrams, read the book.

> The repository gives you practice surfaces. The book gives you the reasoning model.

## Suggested Folder Naming

Use clear chapter folders such as:

```text
chapter-01-seven-step-method/
chapter-02-customer-domain/
chapter-14-ecommerce-system/
chapter-18-video-streaming-system/
```

## Chapter Map

| Chapter | Topic / System | Suggested Folder | What to Practice in GitHub | What the Book Gives You |
|---|---|---|---|---|
| 1 | 7-Step System Design Method | `chapter-01-seven-step-method/` | Method worksheet, interview framing prompts | Full explanation of the method and why the sequence matters |
| 2 | Customer Domain / Running Example | `chapter-02-customer-domain/` | Domain context worksheet | How domain knowledge changes architecture choices |
| 3 | Customer Journey and Actors | `chapter-03-customer-journey/` | Journey map and actor checklist | How to design from user experience before drawing boxes |
| 4 | Business Capabilities | `chapter-04-business-capabilities/` | Capability map template | How capabilities connect business goals to architecture |
| 5 | High-Level Architecture | `chapter-05-high-level-architecture/` | Context and component diagrams | How to structure responsibility before implementation detail |
| 6 | Scalability | `chapter-06-scalability/` | Scale assumptions and bottleneck worksheet | Trade-offs across horizontal scale, caching, queues, and partitions |
| 7 | Data Modeling and Storage | `chapter-07-data-modeling-storage/` | Data model comparison worksheet | How to choose storage based on access patterns and consistency |
| 8 | Availability and Fault Tolerance | `chapter-08-availability-fault-tolerance/` | Failure-mode checklist | How to design graceful degradation and recovery |
| 9 | API Design | `chapter-09-api-design/` | API contract template | How to design APIs for humans, services, and AI agents |
| 10 | Microservices | `chapter-10-microservices/` | Service boundary worksheet | How to avoid microservice sprawl and coupling traps |
| 11 | Security | `chapter-11-security/` | Trust boundary checklist | How to reason about identity, abuse, privacy, and compliance |
| 12 | Ride-Sharing System | `chapter-12-ride-sharing-system/` | Matching, location, surge, and replay artifacts | Complete end-to-end design walkthrough |
| 13 | Social Networking System | `chapter-13-social-networking-system/` | Feed generation and graph modeling artifacts | Trade-offs for feeds, privacy, graph scale, and personalization |
| 14 | E-Commerce System | `chapter-14-ecommerce-system/` | Checkout, inventory, and recommendation artifacts | Full applied design using the book method |
| 15 | Messaging System | `chapter-15-messaging-system/` | Presence, delivery, ordering, and receipt artifacts | How to reason about real-time communication guarantees |
| 16 | Auction System | `chapter-16-auction-system/` | Bid ordering and time-bound consistency artifacts | How to handle fairness, clocks, and concurrency |
| 17 | Fraud Detection System | `chapter-17-fraud-detection-system/` | Feature pipeline and risk scoring artifacts | AI-aware risk design and false-positive trade-offs |
| 18 | Video Streaming System | `chapter-18-video-streaming-system/` | CDN, ABR, rights, ads, and playback evidence artifacts | How streaming becomes a continuous-experience contract |
| 19 | Payment Systems | `chapter-19-payment-systems/` | Idempotency, ledger, reconciliation, and fraud artifacts | How to design secure, reliable transaction flows |
| 20 | File Storage Systems | `chapter-20-file-storage-systems/` | Object metadata, durability, and lifecycle artifacts | How storage becomes long-lived proof over time |
| 21 | Search Engine Systems | `chapter-21-search-engine-systems/` | Crawling, indexing, ranking, and freshness artifacts | How search balances recall, relevance, latency, and trust |
| 22+ | Additional / Advanced Chapters | `chapter-22-.../` | Chapter-specific exercises | Full synthesis and extension of earlier methods |
| Final | Conclusion / Designing for Uncertainty | `chapter-final-conclusion/` | Personal practice plan and next-step checklist | How the book’s ideas come together into a design mindset |

## How to Use This Map

Start with the chapter you are reading. Use the corresponding folder only after you understand the chapter narrative. If you start from the repository first, use this map to decide which chapter to read next in the book.

## Maintaining This Map

As chapter folders evolve, keep the table current. The map should remain a clear bridge between the book and the repository, not a second table of contents for the full manuscript.
