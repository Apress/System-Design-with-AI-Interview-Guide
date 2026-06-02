# Chapter 16 Exercises

## Exercise 1: E-Commerce as a Commitment Engine

A candidate says, “An e-commerce system is catalog, cart, checkout, payment, order management, and fulfillment.”

Why is that incomplete?

Your answer should include:

- Why DreamMart is a commitment engine, not just an online store
- The difference between browsing, intent, hold, and confirmed liability
- Why “in stock” is not the same as “reserved”
- Why “order created” is not the same as “order confirmed”
- Which actors are affected: customer, inventory system, payment provider, warehouse, carrier, fraud system, support, and policy owner
- What evidence must exist before the UI can show **Confirmed**
- What must be replayable later

## Exercise 2: Hold Token vs. Commit Token

Design the checkout flow using `inventoryHoldId`, `reservationId`, `paymentAuthId`, and `orderCommitId`.

Your answer should include:

- Customer checkout request creation
- Inventory freshness check
- Inventory hold creation
- Payment authorization
- Fraud/policy check
- Fulfillment cutoff validation
- Inventory reservation or allocation acknowledgment
- `orderCommitId` issuance
- What happens if inventory, payment, fraud, or fulfillment evidence fails
- How idempotency prevents duplicate orders from retries or repeated clicks

## Exercise 3: Freshness Budgets as Admissible Reality

A team says, “We use the latest inventory, payment, fulfillment, and policy data available in the system.”

Why is that not precise enough?

Define freshness budgets for:

- Inventory snapshot
- Fulfillment state
- Payment authorization
- Policy bundle

For each signal, explain:

- Soft TTL
- Hard TTL
- What can happen inside the soft TTL
- What must happen after the hard TTL
- Why stale evidence may support exploration but not liability
- What evidence must be included in the replay record

## Exercise 4: Checkout Latency and Duplicate Commitment

During a promotion, checkout slows down. Customers refresh, retry, press **Place Order** multiple times, and contact support. Some orders are duplicated, some payment authorizations are ambiguous, and some confirmations are later reversed.

Analyze this as a commitment-boundary failure.

Your answer should include:

- Why latency at checkout is different from latency during browsing
- How retries and repeated clicks create duplicate commitment risk
- Why idempotency must be tied to the checkout intent
- Why payment authorization ambiguity should not become customer-visible confirmation
- When to show Pending, Backorder, Requires review, or Refused
- What retry and compensation budgets should exist
- What replay evidence proves the system acted responsibly

## Exercise 5: Order Modification After Fulfillment Cutoff

A customer requests an address change after placing an order. CRM says the order is modifiable, but the warehouse system says picking has already started.

Should DreamMart allow the modification?

Your answer should include:

- Why order modification is a phase-aware commitment problem
- Why fulfillment state must be authoritative at the modification boundary
- Why conflicting evidence should not be smoothed into a confident answer
- When to refresh, defer, escalate, or hard-stop
- Why automated modification should stop after picking or carrier handoff
- When compensation or customer communication is required
- What replay evidence must be preserved

---

# Bonus GitHub Exercises

## Bonus Exercise 6: Defensible Refund

A customer requests a high-value refund. The order was delivered, the customer account is new, the payment state is unclear, and the return policy recently changed.

Design a defensible refund workflow.

## Bonus Exercise 7: Stop Authority for Commerce Commitments

Design a stop-authority mechanism for checkout, order modification, fulfillment release, and refunds.

## Bonus Exercise 8: ROCS Commerce Control

Apply ROCS to DreamMart commerce commitments.

## Bonus Exercise 9: Decision Replay Card Design

Create a Decision Replay Card for one high-risk e-commerce action: order confirmation, address modification, refund approval, fulfillment release, or carrier handoff.

## Bonus Exercise 10: Senior Architect E-Commerce Defense

An interviewer says, “E-commerce design is straightforward: product catalog, cart, checkout, payment, order service, inventory service, fulfillment service, and notifications.”

Defend a more mature design.
