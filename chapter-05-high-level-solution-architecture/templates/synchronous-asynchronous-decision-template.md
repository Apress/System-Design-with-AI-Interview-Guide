# Synchronous vs. Asynchronous Decision Template

## User Journey

## Customer Promise

What does the customer believe the system has committed?

## Operations

| Operation | Sync or Async? | Why? | Failure Behavior |
|---|---|---|---|
| Cart validation |  |  |  |
| Price validation |  |  |  |
| Coupon validation |  |  |  |
| Payment authorization |  |  |  |
| Inventory reservation |  |  |  |
| Fraud check |  |  |  |
| Order creation |  |  |  |
| Email notification |  |  |  |
| Fulfillment trigger |  |  |  |
| Analytics update |  |  |  |

## Minimum Synchronous Path

1.
2.
3.

## Event-Driven Path

1.
2.
3.

## Idempotency Strategy

Idempotency key:
Duplicate request behavior:
Retry behavior:

## User-Visible State

Confirmed:
Pending:
Failed:
Recoverable:
