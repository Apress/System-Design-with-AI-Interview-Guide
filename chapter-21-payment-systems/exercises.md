# Chapter 21 Exercises

## Exercise 1: Payments as a Liability Commitment Engine
Why is “a payment system moves money between a customer and a merchant” incomplete?

## Exercise 2: Token Chain and Side-Effect Boundary
Design the payment token chain using paymentIntentId, authId, effectId, captureId, refundId, refundDenyId, payoutHoldId, disputeId, and responseId.

## Exercise 3: Idempotency versus Exactly-Once
Analyze the statement: “We can solve duplicate payments by using exactly-once delivery from Kafka and making the consumer idempotent.”

## Exercise 4: Ambiguous Capture Timeout
A capture request is sent to the processor. The processor times out. The message is redelivered after consumer restart. What should the system do?

## Exercise 5: Ledger Truth and Delayed Truth
A capture is recorded in the ledger. Settlement arrives with a mismatch. A chargeback arrives later. How should the architecture handle this?

# Bonus GitHub Exercises

## Bonus Exercise 6: Liability Action Matrix
Create a matrix for authorize, capture, void, refund, refund denial, payout hold, and chargeback response.

## Bonus Exercise 7: Scoped Ordering
Defend scoped ordering instead of strict global ordering for all payment events.

## Bonus Exercise 8: DLQ Replay and Controlled Recovery
Analyze the risk of replaying DLQ messages to clear backlog.

## Bonus Exercise 9: Incident Response — Green Dashboards, Duplicate Money
Analyze a duplicate-capture incident during processor latency and consumer restart.

## Bonus Exercise 10: Senior Architect Payment Defense
Defend a mature payment architecture beyond gateway + ledger + webhooks + retry.
