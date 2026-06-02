# Stop Authority Mode Ladder

| Mode | Trigger | Allowed Behavior | Blocked Behavior | Re-enable Proof |
|---|---|---|---|---|
| Normal | Proof healthy | Commit normally | None | N/A |
| Conservative | Signals drifting | Tighten thresholds, reduce autonomy | High fan-out or weak evidence | Signals stabilize |
| Defer | Evidence incomplete | Pending, wait, reconcile | Final commitment | Evidence arrives |
| Freeze Liability Actions | High-risk action unsafe | Safe reads, drafts, review | Capture, hard delete, final answer, denial | Receipts + validation |
| Human Review | Trust boundary reached | Escalate with evidence | Automated commitment | Reviewer decision |
| Re-enable | Proof restored | Resume with new policy version | Old unsafe path | Owner approval + replay tests |
