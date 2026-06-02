# Capability Map: Auction

| Capability | Responsibility | Boundary | Owner |
|---|---|---|---|
| Auction Creation | Define listing/rules | Policy pin | Marketplace |
| Bid Acceptance | Record intent | bidId | Bidding |
| Bid Ledger | Append-only history | Evidence source | Data/platform |
| Close Engine | Commit winner/price | closeCommitId | Close owner |
| Fraud/Risk | Contain manipulation | Freeze/review | Risk |
| Settlement | Move money | settlementEffectId | Payments |
| Fulfillment | Deliver asset | allocationId | Fulfillment |
| Replay | Prove decision | replay receipt | Governance |
