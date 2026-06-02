# Churn Budget Spec

| Budget | Limit | Exhausted Behavior | Receipt |
|---|---:|---|---|
| Retry attempts | 2 | Park/reconcile, do not blind retry | retryBudgetReceipt |
| Fan-out calls | 5 | Narrow sources | fanoutBudgetReceipt |
| Tool calls | 3 | Stop agent loop, route to review | toolBudgetReceipt |
| Token budget | 8,000 | Compress context or sources only | tokenBudgetReceipt |
| Cost per outcome | $0.25 | Tier down/defer/approval | costBudgetReceipt |
| Decision time | 2 seconds | Pending/defer | timeBudgetReceipt |
