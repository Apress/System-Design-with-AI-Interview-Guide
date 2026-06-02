# Admissibility and Freshness Contract

| Evidence Source | Clock | Freshness Window | Required Policy | Missing Evidence Behavior | Stale Evidence Behavior | Conflict Resolution |
|---|---|---:|---|---|---|---|
| Payment provider | providerTime | 2 minutes | payment-policy-v1 | pending_reconcile | query provider | provider + ledger reconciliation |
| Policy repository | sourceUpdateTime | 60 seconds | policy-search-v1 | sources_only | suppress answer | source-of-record wins |
| Inventory | inventoryTime | 30 seconds | checkout-v1 | defer confirmation | refresh inventory | reservation system wins |
| Legal hold | legalTime | immediate | deletion-v1 | freeze delete | freeze delete | legal hold wins |
