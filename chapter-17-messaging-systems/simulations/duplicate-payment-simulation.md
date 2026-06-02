# Duplicate Payment Simulation

## Scenario

A payment authorization event is consumed. The provider accepts the authorization, but the consumer restarts before writing COMMITTED to the idempotency store. The broker redelivers the event.

## Questions

- Which identity should prevent duplicate money movement?
- Why is eventId insufficient?
- What should IN_PROGRESS mean?
- How should ambiguous external state be reconciled?
- What stop authority should fire?

## Expected Controls

- Deterministic effectId
- Durable processed_effects
- Provider trace reconciliation
- NO_OP receipt on duplicate
- Replay card
