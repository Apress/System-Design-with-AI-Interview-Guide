# Chapter 3 Solution Guide

This guide provides sample solution direction for the Chapter 3 exercises. It is meant to support practice after reading the chapter, not replace the chapter explanation.

## Exercise 1 Solution: Customer Journey Warm-Up

A strong answer should map the customer journey before naming architecture components.

| Step | Customer Goal | Supporting Capability | Required Truth | Possible Friction | Failure Behavior |
|---|---|---|---|---|---|
| Search product | Find relevant laptops | Search and catalog | Product data and ranking | Irrelevant results, slow response | Show cached/default results with clear filters |
| Compare products | Make a confident choice | Product detail, reviews, recommendations | Specs, price, reviews | Conflicting specs or stale price | Refresh product facts before checkout |
| Add to cart | Save intent to buy | Cart | Product ID, quantity, customer session | Cart item disappears | Persist cart and show recovery path |
| Apply coupon | Get discount | Promotion/pricing | Coupon eligibility and price rules | Coupon rejected late | Validate coupon early and explain reason |
| Check delivery | Know arrival date | Inventory and fulfillment | Stock, warehouse, carrier promise | Date changes later | Label estimates vs committed promises |
| Pay | Complete transaction | Payment | Authorization status | Timeout or duplicate click | Idempotent payment request and safe retry |
| Confirm order | Trust purchase completed | Order, inventory, payment | Order ID, payment auth, inventory reservation | Payment success but no order | Commit only after required state is valid |

### Senior Architect Additions

- Separate approximate experiences from commitment moments.
- Identify where stale data is acceptable and where it is dangerous.
- Treat order confirmation as a system promise, not a UI screen.
- Connect customer journey steps to owning capabilities and systems of record.

### Common Mistakes

- Starting with microservices before journey mapping.
- Treating product recommendations and payment confirmation as the same trust level.
- Ignoring what the customer sees during partial failure.

## Exercise 2 Solution: Trust Moment Analysis

Strong candidates usually identify payment, delivery promise, and order confirmation as top trust moments.

### Trust Moment 1: Payment Authorization

- Customer belief: “My payment was accepted for this purchase.”
- Required backend truth: Payment provider authorization status, amount, currency, order attempt, idempotency key.
- Worst failure: Customer is charged or authorized without clear order state.
- System response: Use idempotency, avoid duplicate charge, reconcile asynchronously when needed, show clear pending state.
- Evidence: Payment request ID, provider response, authorization timestamp, correlation ID.

### Trust Moment 2: Inventory Reservation

- Customer belief: “This item is available for me.”
- Required backend truth: Reservable stock, reservation hold, expiration policy.
- Worst failure: Product appears available but cannot be purchased after payment.
- System response: Reserve before final confirmation, use hold timeouts, release on failure.
- Evidence: Inventory reservation ID, SKU, quantity, warehouse, expiration timestamp.

### Trust Moment 3: Order Confirmation

- Customer belief: “DreamMart has accepted my order and will fulfill it.”
- Required backend truth: Order record, payment authorization, inventory reservation, delivery promise.
- Worst failure: Confirmation is shown while one required state is missing.
- System response: Refuse confirmation until commitments are valid; use pending state if reconciliation is required.
- Evidence: Order ID, commitment state, payment reference, inventory reservation, delivery estimate source.

### AI-Era Consideration

AI may explain status only from evidence. It should not invent confirmation, delivery promises, refunds, or payment outcomes.

## Exercise 3 Solution: Friction and Failure Analysis

From the customer’s point of view, the system allowed effort to accumulate before failing late. The customer searched, selected, trusted the product page, entered payment, and then learned the item was unavailable.

### Likely Coordination Failure

- Catalog showed stale availability.
- Inventory reservation happened too late.
- Payment authorization occurred before availability was confirmed.
- Checkout did not clearly distinguish “in stock” from “available to reserve now.”

### Better Design

- Use real-time or near-real-time availability during checkout.
- Revalidate inventory before payment authorization.
- Use short-lived inventory holds for high-demand items.
- Make availability language precise during peak events.
- Provide alternatives when reservation fails.

### Customer Support Evidence

Support should see:

- Product page availability snapshot
- Checkout availability check result
- Payment authorization attempt
- Inventory reservation failure reason
- User-visible message shown
- Correlation ID for replay

### AI Boundary

AI can explain the situation only using recorded evidence. AI should not promise fulfillment, refunds, credits, or delivery unless deterministic systems authorize those actions.

## Exercise 4 Solution: AI Customer Assistant Boundaries

The assistant should improve confidence without taking authority it does not own.

### Safe Personalization

- Recommend products based on preferences and history.
- Summarize reviews.
- Explain return policy from approved policy sources.
- Suggest coupons that the promotion engine validates.

### Must Not Overpromise

- “This item is guaranteed to arrive tomorrow.”
- “Your refund is approved.”
- “Your order is confirmed.”
- “This price will not change.”

### Clarification Behavior

The assistant should ask for clarification when:

- Product requirements are ambiguous.
- Delivery location is missing.
- Coupon eligibility depends on account or cart state.
- Policy interpretation depends on item category or region.

### Escalation Behavior

Escalate when:

- Payment status is unclear.
- Order status conflicts across systems.
- Refund or exception approval is needed.
- Customer expresses dissatisfaction after a failed trust moment.

### Evidence and Replay

Log cited sources, policy versions, tool calls, correlation IDs, confidence, and final response.

## Exercise 5 Solution: Experience-to-Architecture Stress Test

A technically available checkout can still create distrust if journey-level promises are degraded.

### Journey Segments to Analyze

- Product detail to cart
- Cart to checkout
- Checkout to payment
- Payment to order confirmation
- Confirmation to fulfillment tracking

### Experience Degradation Signals

- High cart abandonment after delivery estimate step
- Payment authorization without order confirmation
- Repeated Place Order clicks
- Support tickets about unclear status
- AI assistant responses that conflict with order state
- Increased pending order states during peak

### Architectural Changes

- Idempotency for order and payment requests
- Inventory reservation before final confirmation
- Clear pending state for reconciliation
- Stop authority for AI during degraded checkout
- Journey-level correlation IDs
- Replayable order-decision records

### Executive Metric

A strong metric is **Confirmed Order Trust Rate**: percentage of checkout attempts where payment, inventory, delivery promise, and order confirmation reach a consistent committed state within the expected user-visible window.

## Bonus Exercise Solution: Green Infrastructure, Red Customer Experience

This happens when technical health metrics measure service uptime, not customer promise integrity. APIs may return 200 responses while the experience is confusing, delayed, or inconsistent.

### Better Monitoring

Track journey-level indicators:

- Payment authorized but no order ID
- Order created but inventory missing
- AI answer without evidence
- Delivery promise changed after confirmation
- Support contact within 30 minutes of checkout
- Repeated user retries on the same action

The architecture should observe the promise, not just the process.
