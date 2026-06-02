# Close Mismatch Test Cases

| Case | Condition | Expected Behavior |
|---|---|---|
| Two closeCommitIds | Same auctionId | Reject second; freeze/reconcile. |
| Two prices | Same winner different price | Freeze settlement. |
| Two winners | Different outcomes | Incident; reconcile with evidence. |
| Replay gap | Cannot prove one outcome | Pause close/settlement. |
