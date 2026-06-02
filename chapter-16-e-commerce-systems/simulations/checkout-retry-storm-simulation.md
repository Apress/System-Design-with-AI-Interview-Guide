# Checkout Retry Storm Simulation

## Scenario

A promotion launches at 9:00 AM. Checkout latency rises. Customers click Place Order multiple times. Payment provider responses time out. Some inventory holds expire while payment remains ambiguous.

## Analyze

- Where does repeated intent enter?
- Which operations need idempotency?
- Which state should be shown to the customer?
- When should payment reconcile rather than retry?
- What replay evidence proves the response?

## Expected Controls

- Checkout intent ID
- Idempotency key
- Single-flight processing
- Pending Payment Confirmation
- Retry budget
- Replay card
