# Customer Journey: E-Commerce

| Moment | Customer Believes | Platform Risk | Architecture Response |
|---|---|---|---|
| Browse | Availability/price are hints. | Hints look like promises. | Label estimates. |
| Cart | Items are remembered. | Cart implies reservation. | Preserve intent only. |
| Checkout | Clicking Place Order buys it. | Duplicate intent/payment ambiguity. | Idempotent commit gate. |
| Confirmed | DreamMart owes the order. | False confirmation. | Token chain and replay. |
| Fulfillment | Order is being prepared. | Modification window closes. | Cutoff gates. |
| Refund | Money should be returned/explained. | Financial risk. | Policy pin and replay. |
