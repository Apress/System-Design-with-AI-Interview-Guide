# Degradation Ladder Template

| Rung | Behavior | Customer State | Evidence Requirement |
|---|---|---|---|
| Normal | Commit with proof | Confirmed | Full token chain |
| Cautious | Refresh evidence | Processing | Soft-stale |
| Pending | Accept intent only | Pending | Incomplete proof |
| Review | Human/specialist | Requires review | Risk/conflict |
| Refused | No commitment | Refused | Hard-stale/block |
| Hard stop | Stop path | Unavailable/Review | Governance trigger |
