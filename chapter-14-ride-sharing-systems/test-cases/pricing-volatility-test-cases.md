# Pricing Volatility Test Cases

| Case | Condition | Expected Behavior |
|---|---|---|
| Small demand change | Within hysteresis | Keep quote stable. |
| Large demand spike | Surge needed | Apply policy, caps, reason codes. |
| Crisis posture | Emergency flag enabled | Apply crisis cap/dampening. |
| Quote expires | TTL exceeded | Reprice with reason; preserve old and new receipts. |
