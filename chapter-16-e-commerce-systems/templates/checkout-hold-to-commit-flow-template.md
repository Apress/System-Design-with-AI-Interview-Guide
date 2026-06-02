# Checkout Hold-to-Commit Flow Template

## Request

checkoutIntentId:
correlationId:
idempotencyKey:
cartSnapshotId:

## Gates

| Gate | Evidence | Pass/Fail |
|---|---|---|
| Inventory freshness |  |  |
| Fulfillment cutoff |  |  |
| Payment authorization |  |  |
| Fraud/risk |  |  |
| Policy pin |  |  |
| Replay ready |  |  |

## Tokens

inventoryHoldId:
reservationId:
paymentAuthId:
orderCommitId:

## Outcome

Confirmed:
Pending:
Backorder:
Requires review:
Refused:
