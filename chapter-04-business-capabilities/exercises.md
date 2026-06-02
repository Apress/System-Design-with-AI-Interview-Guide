# Chapter 4 Exercises

Use these exercises after reading Chapter 4 to practice moving from business capabilities to architecture boundaries.

## Exercise 1: Capability Mapping Warm-Up

DreamMart wants to support product discovery, cart management, checkout, payment, inventory, fulfillment, delivery tracking, customer support, fraud detection, and personalized recommendations.

Create a business capability map for DreamMart.

For each capability, identify:

- The business outcome it supports
- The primary users or actors involved
- The core data it owns or depends on
- Whether it is customer-facing, operational, financial, risk-related, or intelligence-driven
- Whether it should be treated as a core differentiating capability or a supporting capability

Explain how this capability map helps you avoid designing services too early.

## Exercise 2: Capability Boundary Analysis

A team proposes a single `OrderService` that handles cart validation, coupon application, payment authorization, inventory reservation, fraud checks, order confirmation, shipment creation, email notifications, and refund initiation.

Analyze this design from a capability-boundary perspective.

Your answer should include:

- Which responsibilities are incorrectly grouped together
- Which capabilities should have separate ownership
- Which decisions must be synchronous
- Which activities can be asynchronous
- What data ownership problems may appear
- How poor boundaries could create failure or scaling issues

## Exercise 3: AI Capability Placement

DreamMart leadership wants to add AI features across the platform: product recommendations, fraud scoring, customer support summaries, delivery prediction, price optimization, and seller coaching.

For each AI feature, decide whether it should be:

- Embedded inside an existing business capability
- Exposed as a shared intelligence service
- Operated as a human-reviewed decision support tool
- Kept out of the critical path

Choose three examples and justify your placement.

Your answer should address:

- Business value
- Data dependencies
- Latency requirements
- Authority to act
- Risk of incorrect output
- Evidence and replay needs

## Exercise 4: Ownership and Accountability

During Black Friday, customers complain that orders are confirmed but later canceled because inventory was unavailable. The checkout team says payment succeeded. The inventory team says reservation failed. The order team says it only recorded the final order state. The AI assistant told customers their orders were confirmed.

Using capability ownership thinking, identify where accountability is unclear.

Your answer should include:

- Which capability owns the customer promise
- Which capability owns payment authorization
- Which capability owns inventory reservation
- Which capability owns final order commitment
- Which capability controls customer-visible messaging
- How ownership should be reflected in APIs, events, logs, and replay records

## Exercise 5: Capability-to-Architecture Stress Test

You are asked to design DreamMart’s checkout platform for scale, reliability, and future AI integration.

Before drawing the architecture, define the capability model that should guide the design.

Your answer should include:

- Core checkout capabilities
- Supporting capabilities
- Capabilities that require strong consistency
- Capabilities that can tolerate eventual consistency
- Capabilities where AI can assist but not commit
- Capabilities that need auditability and replay
- One capability boundary you would defend strongly in an architecture review

## Bonus Exercise: Split the God Service

Given a large service that owns customer profile, cart, orders, payments, coupons, recommendations, and customer messaging, propose a cleaner capability model.

For each proposed capability, define:

- The business outcome
- The owned data
- The main API commands
- The events emitted
- The failure behavior
- Whether AI is allowed to suggest, decide, or commit
