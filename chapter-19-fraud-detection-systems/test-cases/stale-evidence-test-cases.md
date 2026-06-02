# Stale Evidence Test Cases

| Evidence | Age | Expected Behavior |
|---|---:|---|
| Identity inside soft TTL | Fresh | Can use. |
| Identity between soft/hard TTL | Aging | Refresh before high liability action. |
| Identity beyond hard TTL | Stale | Do not hard enforce. |
| Velocity stale | Stale | Reduce to weak signal or refresh. |
