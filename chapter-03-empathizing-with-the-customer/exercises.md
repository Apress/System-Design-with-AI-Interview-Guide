# Chapter 3 Exercises

Use these exercises after reading Chapter 3. The goal is to practice designing from the customer experience before jumping into infrastructure, services, databases, queues, or caches.

## Exercise 1: Customer Journey Warm-Up

A customer opens DreamMart, searches for a laptop, compares products, adds one to the cart, applies a coupon, checks delivery availability, pays, and receives an order confirmation.

Map this journey as a sequence of user steps.

For each step, identify:

- What the customer is trying to accomplish
- What system capability supports the step
- What information must be accurate
- What could cause user frustration
- What the system should do if that step fails

Explain how this journey changes your architecture priorities.

## Exercise 2: Trust Moment Analysis

In an e-commerce system, not every step has the same trust level. A product recommendation can be approximate, but payment, inventory, delivery promise, and order confirmation must be reliable.

Identify the top three trust moments in the DreamMart customer journey.

For each trust moment, explain:

- What the customer believes the system has promised
- What backend state must be correct
- Which failure would damage trust the most
- Whether the system should retry, degrade, refuse, or escalate
- What evidence should be recorded for later replay or support

## Exercise 3: Friction and Failure Analysis

A customer tries to buy a popular phone during a holiday sale. The product page shows “In stock,” but checkout fails after payment authorization because inventory is no longer available.

Analyze this failure from the customer’s point of view.

Your answer should include:

- What the customer experienced
- Which system capabilities likely failed to coordinate
- What the system should have shown earlier
- How the design could reduce this failure
- What customer support evidence should be available
- Whether AI should be allowed to explain or resolve the issue

## Exercise 4: AI Customer Assistant Boundaries

DreamMart introduces an AI shopping assistant that helps customers compare products, find coupons, answer delivery questions, and summarize return policies.

Design the assistant from a customer empathy perspective.

Your answer should address:

- What the assistant can safely personalize
- What it must not overpromise
- When it should ask for clarification
- When it should hand off to a human or deterministic system
- What evidence it should cite
- How it should behave when product, inventory, or policy data is uncertain

## Exercise 5: Experience-to-Architecture Stress Test

DreamMart’s leadership says, “Our checkout system is technically available, but customers still do not trust it during peak events.”

How would you investigate and redesign the system using customer journey thinking?

Your answer should include:

- The customer journey segments you would analyze
- The signals that show experience degradation even when systems are “up”
- The architectural changes needed to protect trust moments
- The observability needed to connect backend failures to customer pain
- The AI behavior controls needed during degraded conditions
- The one experience metric you would make visible to executives

## Bonus Exercise: Green Infrastructure, Red Customer Experience

A dashboard shows all core services as healthy, but support tickets show customers are confused about order status after payment authorization.

Explain how this can happen. Then propose a journey-level monitoring approach that would reveal the problem earlier.
