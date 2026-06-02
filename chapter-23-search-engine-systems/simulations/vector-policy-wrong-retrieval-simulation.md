# Vector Policy-Wrong Retrieval Simulation

## Scenario

Vector search retrieves semantically close content from wrong jurisdiction or superseded policy.

## Expected Controls

- Constrain vector behind metadata filters
- Require policy/current-version checks
- Demote or suppress candidates
- Emit retrieval trace
