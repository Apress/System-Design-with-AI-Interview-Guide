# System Design with AI Interview Guide
## Official Companion Repository

> **The book is the masterclass. This repository is the practice lab.**
>
> The book teaches the full reasoning, chapter walkthroughs, trade-off narratives, and interview storytelling. This repository helps you practice that thinking through templates, prompts, rubrics, diagrams, and companion artifacts.

---

# System Design Checklist

Use this checklist before finishing a practice answer or mock interview. It is intentionally compact. The book explains these areas in detail.

## Problem Framing

- Did I clarify the goal?
- Did I identify users and actors?
- Did I define what is out of scope?
- Did I state assumptions clearly?

## Requirements

- Did I separate functional requirements from non-functional requirements?
- Did I identify the core user promise?
- Did I define scale, latency, availability, and consistency needs?

## Architecture

- Does every component have a clear responsibility?
- Did I avoid overloading one service?
- Did I explain synchronous vs asynchronous flows?
- Did I identify critical paths?

## Data

- Did I choose storage based on access patterns?
- Did I define ownership of important data?
- Did I explain consistency trade-offs?
- Did I address retention, privacy, or audit needs?

## Scale and Performance

- Did I identify bottlenecks?
- Did I use caching intentionally?
- Did I consider partitioning or sharding?
- Did I handle hot keys, hot content, or traffic spikes?

## Reliability

- Did I include timeouts, retries, and circuit breakers where appropriate?
- Did I discuss fallback and graceful degradation?
- Did I explain regional or dependency failures?
- Did I avoid retry storms and cascading failure?

## Security and Abuse

- Did I discuss authentication and authorization?
- Did I identify trust boundaries?
- Did I address abuse, fraud, or rate limiting?
- Did I protect sensitive data?

## Observability

- Did I define metrics?
- Did I include logs and traces?
- Can the system explain important decisions after the fact?
- Did I include alerting on user-impacting symptoms?

## Cost

- Did I identify major cost drivers?
- Did I mention cost controls?
- Did I avoid expensive work on the critical path where possible?

## AI, If Applicable

- Is AI actually needed?
- What evidence grounds the AI output?
- What happens when confidence is low?
- Can the AI decision be replayed?
- Who owns correction or escalation?

## Final Question

Can I defend why this design is good enough for the stated requirements and what I would change next as the system evolves?
