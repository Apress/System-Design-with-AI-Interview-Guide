# Consistency: Auction

| Boundary | Rule | Artifact |
|---|---|---|
| Bid received | Intent exists. | bidId |
| Bid admissible | Counts under policy. | Admissibility decision |
| Auction ended | Window ended. | Close policy state |
| Winner committed | Outcome owned. | closeCommitId |
| Settlement | Money attempted. | settlementEffectId |
| Compensation | Correction path. | compensationId |
