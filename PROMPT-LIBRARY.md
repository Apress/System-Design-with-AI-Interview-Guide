# System Design with AI Interview Guide
## Official Companion Repository

> **The book is the masterclass. This repository is the practice lab.**
>
> The book teaches the full reasoning, chapter walkthroughs, trade-off narratives, and interview storytelling. This repository helps you practice that thinking through templates, prompts, rubrics, diagrams, and companion artifacts.

---

# Prompt Library

Use these prompts with ChatGPT, Claude, Gemini, or another AI assistant. They are designed to help you practice the ideas from the book. They do not replace the book’s explanations or chapter walkthroughs.

## Mock Interviewer Prompt

```text
Act as a senior staff engineer conducting a system design interview. Ask me to design [SYSTEM]. Do not give me the answer. Push me on requirements, actors, scale, latency, data modeling, reliability, security, cost, observability, and AI implications where relevant. Ask follow-up questions one at a time.
```

## Trade-Off Challenger Prompt

```text
Review my system design answer below. Challenge every major trade-off. Ask where my design may fail at 10x scale, during partial outages, under abuse, or when data becomes stale. Do not rewrite the answer yet. First list the strongest objections an interviewer might raise.
```

## Architecture Reviewer Prompt

```text
Act as an architecture review board. Evaluate this design for responsibilities, boundaries, coupling, data ownership, failure modes, observability, security, and cost. Score it using a 1-5 scale and identify the top five improvements.
```

## Failure-Mode Examiner Prompt

```text
Analyze this design from a failure-mode perspective. Identify dependency failures, timeout risks, retry storms, cache stampedes, data inconsistency, regional outages, backpressure issues, and degraded user experiences. Recommend graceful degradation behavior.
```

## Cost Reviewer Prompt

```text
Review this system design for cost drivers. Identify the biggest sources of compute, storage, network egress, database, queue, cache, AI inference, observability, and operational cost. Suggest practical cost-control levers without breaking the core user experience.
```

## Security Reviewer Prompt

```text
Review this design for security and abuse risks. Consider identity, authorization, data privacy, secrets, injection attacks, fraud, rate limiting, tenant isolation, supply chain risk, and auditability. Suggest controls appropriate for an interview answer.
```

## AI-Aware Design Prompt

```text
Review this design as an AI-aware architect. Identify where AI is useful, where it is unnecessary, what evidence is required, how model decisions should be evaluated, what fallback behavior is needed, and how decisions can be replayed later.
```

## Communication Coach Prompt

```text
Act as a system design communication coach. Help me explain this design more clearly in an interview. Improve the structure, remove unnecessary detail, sharpen the trade-off language, and help me sound senior without sounding vague.
```

## Diagram Critic Prompt

```text
Review my architecture diagram description. Identify missing trust boundaries, data flows, async flows, caches, ownership labels, failure paths, observability points, and user-impacting commitments. Suggest a cleaner diagram structure.
```

## Final Mock Interview Prompt

```text
Conduct a 45-minute system design mock interview for [SYSTEM]. Start with requirements. Interrupt me when I make assumptions. Push back on weak areas. At the end, score me using this rubric: requirements, architecture, data, scale, reliability, security, observability, cost, AI-awareness, and communication.
```

## Best Practice

Use AI to challenge your thinking, not to avoid thinking. Read the chapter first, attempt the design yourself, then use these prompts to improve.
