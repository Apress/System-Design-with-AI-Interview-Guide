# Payment Ambiguity Simulation

## Scenario

Payment provider times out after possibly authorizing. Customer retries checkout.

## Expected Controls

- Do not create a new payment attempt until idempotency/reconciliation is checked
- Show Pending Payment Confirmation
- Reconcile provider trace ID
- Confirm only with paymentAuthId and reservation evidence
