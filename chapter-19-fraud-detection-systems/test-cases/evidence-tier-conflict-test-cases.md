# Evidence Tier Conflict Test Cases

| Case | Tier 1 | Tier 2 | Expected Behavior |
|---|---|---|---|
| Clean payment/auth | Clean | High risk | Refresh/step-up/review, no auto-deny. |
| Missing identity | Missing | High risk | Step-up, no hard block. |
| Sanctions hard constraint | Block | Low risk | Compliance block/review. |
| Tier 1 fraud evidence | Bad | High risk | Enforcement allowed if replay ready. |
