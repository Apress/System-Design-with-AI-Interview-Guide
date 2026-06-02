# Auction 7-Step Method Map

| Step | Auction Application | Notes |
|---|---|---|
| Clarify | Auction type, close policy, proxy, reserve, settlement, full lifecycle. |  |
| Actors | Bidder, seller, marketplace, fraud, payment, fulfillment, dispute, policy owner. |  |
| Journey | Create, bid, close, commit winner, settle, fulfill, dispute/refund. |  |
| Constraints | Late bids, clock skew, bid storms, proxy rules, fraud pressure, settlement failures. |  |
| Commitments | bidId, closeCommitId, allocationId, settlementIntentId, settlementEffectId. |  |
| Architecture | Bid ledger, close authority, fraud scoring, replay, settlement idempotency. |  |
| Trade-offs | Hard vs soft close, fairness vs load, speed vs proof. |  |
