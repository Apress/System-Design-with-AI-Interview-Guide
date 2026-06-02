# Scale: Auction

| Pressure | Failure Shape | Control |
|---|---|---|
| Hot listing | Bid storm. | Partition/write buffering. |
| Soft close | Extension storm. | Extension caps. |
| Fraud burst | Low-confidence late bids. | Step-up/freeze. |
| Fanout | Watcher updates. | Read models. |
| Settlement burst | Payment surge. | Settlement queue/idempotency. |
