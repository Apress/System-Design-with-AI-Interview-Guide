# Failure: Ride-Sharing

| Signal | What It Looks Like | Response |
|---|---|---|
| GPS hard-stale | Location exists but is inadmissible. | Refuse/defer commit. |
| Rematch spike | Drivers change repeatedly. | Cap redispatch. |
| Hold expiry | Holds expire before commit. | Conservative mode. |
| Replay drop | Decisions cannot be defended. | Lower autonomy. |
| Safety/fraud signal | Optimization unsafe. | Hard stop and review. |
