# Capability Map: E-Commerce

| Capability | Responsibility | Commitment Boundary | Owner |
|---|---|---|---|
| Catalog | Discovery | None | Catalog |
| Cart | Intent | None unless hold exists | Cart |
| Inventory | Hold/reserve | inventoryHoldId/reservationId | Inventory |
| Checkout | Orchestrate commit | orderCommitId | Checkout |
| Payment | Authorize/capture/refund | paymentAuthId/refundDecisionId | Payment |
| Fulfillment | Pick/pack/release | fulfillmentReleaseId | Fulfillment |
| Shipping | Carrier handoff | carrierAcceptanceId | Shipping |
| Replay | Explain decisions | replay card | Governance |
