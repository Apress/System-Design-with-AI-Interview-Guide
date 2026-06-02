# Hold Expiry Test Cases

| Case | Condition | Expected Behavior |
|---|---|---|
| Hold expires before driver response | TTL exceeded | Release hold; no matchId issued. |
| Hold expires after acceptance but before gates | Gate delay | Revalidate or restart within budget; no casual commit. |
| Multiple hold expiries | Attempt budget spent | Conservative mode, assisted lane, or no match. |
