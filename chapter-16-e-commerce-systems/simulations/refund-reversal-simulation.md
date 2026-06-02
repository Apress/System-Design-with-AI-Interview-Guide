# Refund Reversal Simulation

## Scenario

High-value refunds for new accounts begin reversing because payment state was ambiguous and policy was not pinned.

## Expected Controls

- Require policy pin
- Require payment settlement evidence
- Route high-value/new-account refunds to review
- Emit refundDecisionId and replay card
- Trigger stop authority if reversal rate spikes
