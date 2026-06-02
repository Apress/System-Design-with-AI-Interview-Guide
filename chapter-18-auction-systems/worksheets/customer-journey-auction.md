# Customer Journey: Auction

| Moment | Participant Believes | Risk | Response |
|---|---|---|---|
| Seller creates auction | Rules are fixed. | Rule drift. | Pin policy. |
| Bidder bids | Bid may count. | Received != admissible. | Bid ledger. |
| Near close | Fairness depends on time. | Lag/skew/sniping. | Server close policy. |
| Close | Winner is final. | Two realities. | Single closeCommitId. |
| Settlement | Money moves. | Duplicate capture. | Idempotent settlementEffectId. |
| Dispute | Platform must prove. | Missing evidence. | Replay receipt. |
