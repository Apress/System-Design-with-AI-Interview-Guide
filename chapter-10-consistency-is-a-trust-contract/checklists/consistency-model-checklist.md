# Consistency Model Checklist

Choose consistency based on trust risk.

Ask:

- Is this path informational, advisory, actionable, or committed?
- Is stale data acceptable?
- Does the user expect to see their own update?
- Can state appear to go backward?
- Must cause and effect be preserved?
- Is a single global order required?
- What latency/availability trade-off is acceptable?
- What compensation path exists?
