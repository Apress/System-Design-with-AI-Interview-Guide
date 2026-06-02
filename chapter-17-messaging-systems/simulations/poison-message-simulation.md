# Poison Message Simulation

## Scenario

A consumer repeatedly fails on the same event due to a semantic payload error.

## Expected Controls

- Count/time retry budget
- Failure class: POISON
- Route to DLQ
- Owner assigned
- Replay simulate-only until corrected
- Schema/policy review
