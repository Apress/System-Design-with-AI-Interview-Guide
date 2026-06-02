# Chapter 5 Solution Guide

## Exercise 1 Solution: High-Level Architecture Warm-Up

A strong answer should include:

- Channels such as web, mobile, seller portal, support console, and admin tools
- API gateway or edge layer
- Core capabilities such as product, search, cart, checkout, payment, inventory, fulfillment, delivery, support, fraud, and recommendation
- Systems of record for orders, payments, inventory, customer profiles, catalog, and support cases
- Event streaming for order events, inventory updates, payment status, fulfillment events, and analytics
- AI/ML components with clear authority boundaries
- Observability across customer journeys, services, events, and AI decisions
- Security boundaries for authentication, authorization, PCI/payment data, and AI tool access

## Exercise 2 Solution: Architecture Views

A strong answer should separate architecture into multiple views:

- Context view: who uses the system and which external systems it depends on
- Service view: major services and ownership boundaries
- Data flow view: how important state moves through the system
- Runtime sequence view: what happens during checkout or another critical journey
- Failure/degradation view: what happens when dependencies fail
- AI trust/evidence view: what AI can access, what it can say, and what must be logged

## Exercise 3 Solution: Synchronous vs. Asynchronous Design

Minimum synchronous path before confirmation:

- Validate cart
- Revalidate price
- Validate coupon
- Authorize payment
- Reserve inventory
- Run critical fraud check
- Create durable order record
- Return confirmation or pending state

Asynchronous after confirmation:

- Send email/SMS notification
- Update analytics
- Trigger fulfillment workflow
- Update recommendation signals
- Generate support timeline
- Run non-blocking fraud enrichment
- Update warehouse planning

## Exercise 4 Solution: AI Architecture Integration

A strong answer should distinguish:

- Customer-facing AI: shopping assistant, recommendations
- Internal AI: support summarization, fraud analyst assistance, seller coaching
- Critical-path AI: only low-latency, bounded, validated decisions
- Non-critical-path AI: summarization, explanation, ranking, enrichment
- Evidence: catalog, policy, inventory, order, support, and delivery data
- Replay: model version, prompt, retrieved evidence, tool calls, confidence, output, and final system decision

## Exercise 5 Solution: Senior Architect Trade-Off Defense

A strong answer should defend necessary complexity while rejecting unnecessary complexity.

Necessary complexity:

- Separate payment from checkout because payment has financial, compliance, and idempotency concerns
- Separate inventory because it owns stock truth and reservation rules
- Separate order because it owns durable customer commitment
- Use async events for fulfillment, analytics, notifications, and downstream processing
- Place AI behind authority, evidence, and replay boundaries

Complexity to avoid:

- Too many microservices too early
- AI in the critical path without guardrails
- Distributed transactions everywhere
- Separate databases without ownership clarity
- Event-driven design for simple synchronous lookups
