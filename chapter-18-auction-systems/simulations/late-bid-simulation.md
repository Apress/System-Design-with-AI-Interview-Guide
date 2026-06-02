# Late Bid Simulation

## Scenario

Bid A ingests before close. Bid B ingests inside late window. Bid C ingests after hard cutoff.

## Expected Decision

- Count A if otherwise valid
- Count B only if late-window policy allows
- Reject C even if client event time claims before close
- Preserve replay evidence
