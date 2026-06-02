# Latency: Auction

| Latency | Meaning | Control |
|---|---|---|
| Bid ingestion | Determines admissibility. | Time policy. |
| Close computation | Can create ambiguity. | Single close authority. |
| Clock skew | Fairness distortion. | Server time/skew budget. |
| Fanout | Stale leader UI. | Distinguish leader vs winner. |
| Settlement | Ambiguous money. | Idempotency. |
