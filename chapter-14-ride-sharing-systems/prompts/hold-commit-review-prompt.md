# Hold/Commit Review Prompt

Review my ride-sharing design for hold versus commit correctness.

Check:

- Whether candidate search is exploratory
- Whether matchHoldId has TTL
- Whether driver acceptance is necessary but not sufficient
- Whether commit gates exist
- Whether matchId creates liability only after evidence passes
- Whether hold expiry and gate failure are handled
- Whether rematches are bounded

Then rewrite the design as a safer hold-to-commit flow.
