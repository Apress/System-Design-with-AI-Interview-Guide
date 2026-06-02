# ARCHVIEW: Auction

| Concern | View |
|---|---|
| Actors | Bidder, seller, marketplace, fraud, payment, fulfillment, dispute, policy. |
| Responsibilities | Create, bid, close, settle, fulfill, dispute, replay. |
| Controls | Close policy, admissible time, fraud pressure, stop authority. |
| Commit Points | bidId, closeCommitId, allocationId, settlementIntentId, settlementEffectId. |
| Evidence | Bid ledger, timestamps, policy, proxy/increment/reserve, fraud signals. |
| Degradation | Extend, delay, freeze, review, pause settlement, compensate. |
