# Retry and DLQ Policy Template

## Retry Budget

Max attempts:
Max elapsed time:
Backoff:

## Automatic Retry Conditions

- transient failure:
- idempotent side effect:
- evidence admissible:
- external state not ambiguous:

## DLQ Conditions

- retry exhausted:
- schema mismatch:
- poison message:
- ambiguous external state:
- policy/evidence invalid:

## DLQ Metadata


## Replay Mode

simulate:
execute:
