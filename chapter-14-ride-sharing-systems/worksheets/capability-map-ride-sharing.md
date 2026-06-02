# Capability Map: Ride-Sharing

| Capability | Responsibility | Commitment Boundary | Owner |
|---|---|---|---|
| Request | Capture rider intent. | No commitment. | Rider experience |
| Location | Timestamp GPS. | Location admissible only within TTL. | Location platform |
| Candidate Search | Find eligible drivers. | Candidate is not promised. | Matching |
| Ranking | Score candidates. | Exploration. | Ranking |
| Dispatch | Offer ride. | matchHoldId. | Dispatch |
| Commit Gate | Create match. | matchId. | Marketplace commitment |
| Pricing | Quote fare. | Replayable quote. | Pricing |
| Fairness | Control disparity. | Optimization boundary. | Marketplace governance |
| Safety/Fraud | Stop unsafe automation. | Hard stop. | Safety/fraud |
| Replay | Explain decisions. | Accountability. | Governance/support |
