# Chapter 4 Solution Guide

This guide provides expanded solution notes for the Chapter 4 practice exercises. Use it to compare your thinking after attempting the exercises first.

## Exercise 1 Solution: Capability Mapping Warm-Up

A strong answer groups DreamMart capabilities by business outcome, not by technology choice.

Example capability groups:

- Customer-facing: product discovery, search, cart, checkout, order tracking, customer support
- Financial and risk: payment, fraud, refunds, tax, settlement
- Operational: inventory, fulfillment, delivery tracking, warehouse operations, seller management
- Intelligence-driven: recommendations, personalization, demand forecasting, delivery prediction
- Governance/supporting: analytics, audit, compliance, observability

Senior architect additions:

- Separate capabilities that own customer promises from those that merely support them.
- Identify which capabilities require strong consistency, such as payment commitment and inventory reservation.
- Identify which capabilities can tolerate eventual consistency, such as recommendations and analytics.
- Avoid turning every capability directly into a microservice too early.

Common mistakes:

- Treating capability maps as service maps.
- Hiding financial, risk, or support capabilities behind checkout.
- Introducing AI features before clarifying the business outcome they serve.

## Exercise 2 Solution: Capability Boundary Analysis

The proposed `OrderService` is too broad. It mixes multiple capabilities with different ownership, latency, consistency, risk, and scaling requirements.

Responsibilities to separate:

- Cart validation belongs to cart or checkout orchestration.
- Coupon validation belongs to promotion/pricing.
- Payment authorization belongs to payment.
- Inventory reservation belongs to inventory.
- Fraud checks belong to fraud and risk.
- Order confirmation belongs to order commitment.
- Shipment creation belongs to fulfillment.
- Email notification belongs to customer communication.
- Refund initiation belongs to refunds/payment operations.

Synchronous decisions:

- Validate cart eligibility.
- Confirm price and promotion terms.
- Authorize payment.
- Reserve inventory, or explicitly decide how reservation failure is handled.
- Commit the order only after required preconditions are met.

Asynchronous activities:

- Email confirmation.
- Shipment workflow creation, if the customer promise is not immediate shipment.
- Analytics updates.
- Recommendation learning signals.
- Some fraud review workflows, depending on risk threshold.

Better boundary design:

- Use checkout orchestration for the customer purchase flow.
- Keep payment, inventory, fraud, order, promotion, and notification as separately owned capabilities.
- Use idempotency keys, correlation IDs, events, and replayable decision records.

## Exercise 3 Solution: AI Capability Placement

Example placements:

### Product recommendations

Placement: embedded in product discovery or exposed as a shared recommendation capability.

Reasoning:

- High business value and personalization impact.
- Usually not a committing decision.
- Can tolerate approximation and fallback.
- Should not block checkout.

### Fraud scoring

Placement: risk capability, often in the critical decision path but with deterministic policy controls.

Reasoning:

- Incorrect output can cause financial loss or customer friction.
- AI should produce a score and evidence, not own final irreversible action alone.
- High-risk cases may require rule validation or human review.

### Customer support summaries

Placement: human-reviewed decision support inside customer support.

Reasoning:

- Helpful for reducing handle time.
- Should cite source records.
- Should not invent policy or approve refunds without authority.

### Delivery prediction

Placement: shared intelligence service consumed by delivery, checkout, and customer communication.

Reasoning:

- Valuable across multiple capabilities.
- Must distinguish prediction from promise.
- Checkout should commit only validated delivery promises.

Senior architect principle:

AI can assist many capabilities, but authority to commit business outcomes should remain with the owning deterministic capability unless explicitly governed.

## Exercise 4 Solution: Ownership and Accountability

The failure shows unclear customer-promise ownership.

Ownership model:

- Checkout owns orchestration of the purchase attempt.
- Payment owns authorization and capture state.
- Inventory owns reservation state.
- Order owns final order commitment.
- Customer communication owns the message format, but it should not invent commitment state.
- AI assistant can explain only from confirmed evidence.

What should have happened:

- Payment authorization should not automatically mean order confirmation.
- Inventory reservation should produce a clear event or failure reason.
- Order commitment should occur only after required conditions are satisfied.
- The AI assistant should not say “confirmed” unless an order-committed event exists.

Required records:

- `checkoutAttemptId`
- `paymentAuthorizationId`
- `inventoryReservationId`
- `orderId`
- `correlationId`
- `decisionStatus`
- `failureReason`
- `policyVersion`
- `aiResponseEvidence`

Senior architect addition:

The architecture must distinguish authorization, reservation, and commitment. These are not the same business event.

## Exercise 5 Solution: Capability-to-Architecture Stress Test

Core checkout capabilities:

- Checkout orchestration
- Cart validation
- Pricing and promotion validation
- Payment authorization
- Inventory reservation
- Fraud assessment
- Order commitment
- Customer communication

Supporting capabilities:

- Analytics
- Recommendations
- Experimentation
- Customer support evidence
- Observability and replay

Strong consistency candidates:

- Order commitment
- Payment state transitions
- Inventory reservation for scarce items
- Refund approval and settlement

Eventual consistency candidates:

- Recommendations
- Search indexing
- Analytics
- Email delivery
- Post-order fulfillment updates, depending on customer promise

AI assist but not commit:

- Product comparison
- Coupon suggestions
- Support summaries
- Delivery explanation
- Fraud explanation
- Seller coaching

Audit and replay needs:

- Payment decisions
- Fraud decisions
- Inventory reservation outcomes
- Order commitment
- AI responses about order, payment, delivery, or refund status

Boundary to defend:

Do not let the AI assistant, customer communication layer, or checkout UI independently claim order confirmation. Only the order commitment capability can make that promise, based on evidence from payment, inventory, and policy-controlled checkout state.
