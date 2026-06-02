# Idempotency Design Template

## Effect Identity

effectId formula:
businessTxnId:
eventId:

## Store

Durable table:
Cache accelerator:
Retention:

## States

IN_PROGRESS:
COMMITTED:
FAILED:
NO_OP:
UNKNOWN:

## Duplicate Behavior

Already committed:
Ambiguous external state:
Provider timeout:
