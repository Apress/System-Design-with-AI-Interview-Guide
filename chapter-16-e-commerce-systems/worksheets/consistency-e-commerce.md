# Consistency: E-Commerce

| Boundary | Trust Rule | Artifact |
|---|---|---|
| Browse | Estimate only. | Availability label |
| Cart | Intent. | Cart snapshot |
| Hold | Temporary inventory intent. | inventoryHoldId |
| Reserve | Inventory allocated. | reservationId |
| Authorize | Payment admissible. | paymentAuthId |
| Commit | Liability. | orderCommitId |
| Release | Warehouse action starts. | fulfillmentReleaseId |
| Refund | Money approved. | refundDecisionId |
