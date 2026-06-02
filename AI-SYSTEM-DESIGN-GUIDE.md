# System Design with AI Interview Guide
## Official Companion Repository

> **The book is the masterclass. This repository is the practice lab.**
>
> The book teaches the full reasoning, chapter walkthroughs, trade-off narratives, and interview storytelling. This repository helps you practice that thinking through templates, prompts, rubrics, diagrams, and companion artifacts.

---

# AI System Design Guide

AI changes system design because some outputs are probabilistic, evidence-dependent, policy-sensitive, and expensive to run at scale. This guide is a compact orientation. The book provides the full explanation through applied examples.

## What Changes When AI Enters the System

| Traditional Concern | AI-Era Extension |
|---|---|
| API response | Model answer, tool action, or recommendation |
| Database version | Data, embedding, model, prompt, and policy version |
| Logging | Evidence capture and decision replay |
| Error handling | Low-confidence fallback and human escalation |
| Authorization | Tool permissions and action boundaries |
| Testing | Golden datasets, adversarial tests, and evaluation metrics |
| Latency | Inference time, retrieval time, reranking, and tool calls |
| Cost | Tokens, GPU/CPU inference, retrieval, and retries |

## Six AI Architecture Primitives

| Primitive | Design Question |
|---|---|
| Authority | What is the AI allowed to see, say, or do? |
| Commitment | When does the system make a promise or take action? |
| Time | Which data, model, prompt, and policy version were used? |
| Degradation | What happens when confidence is low or dependencies fail? |
| Evidence / Replay | Can the decision be explained later? |
| Ownership | Who can stop, override, correct, or improve the system? |

## AI Belongs Where It Improves the System

Do not add AI only because it sounds modern. Add AI where it improves prediction, personalization, classification, summarization, routing, anomaly detection, recommendation, or decision support. Even then, design the surrounding system: data pipelines, permissions, evaluation, fallback, observability, and cost controls.

## Questions to Ask in an Interview

- Is AI part of the core path or an assistive path?
- What happens when the model is wrong?
- What evidence grounds the output?
- What data is the model allowed to access?
- Is the result explainable enough for the domain?
- Can the decision be replayed after an incident?
- How are prompts, policies, and models versioned?
- What is the cost per successful outcome?

## Common AI Design Mistakes

- Treating model output as truth.
- Forgetting authorization around tools and data.
- Ignoring model latency and cost.
- Failing to capture evidence.
- Having no fallback when confidence is low.
- Not evaluating the system after deployment.

## Use With the Book

This file is a quick reference. The full book explains how these ideas appear in real system design examples such as search, fraud detection, recommendations, e-commerce, streaming, and agentic architectures.
