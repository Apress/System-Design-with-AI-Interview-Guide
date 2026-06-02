# ARCHVIEW: E-Commerce

| Concern | View |
|---|---|
| Actors | Customer, inventory, payment, fraud, warehouse, carrier, support, policy owner. |
| Responsibilities | Browse, cart, checkout, commit, fulfillment, shipping, returns, refunds, replay. |
| Controls | Freshness, idempotency, tokens, refusal lines, stop authority. |
| Commit Points | Hold, reservation, auth, commit, release, shipment, refund. |
| Evidence | Policy version, snapshots, tool calls, tokens, customer-visible state. |
| Degradation | Pending, backorder, requires review, refused, compensated. |
