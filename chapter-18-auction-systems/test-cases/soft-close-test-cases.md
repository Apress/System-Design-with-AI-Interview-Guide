# Soft Close Test Cases

| Case | Condition | Expected Behavior |
|---|---|---|
| Bid inside extension window | Extensions remaining | Extend auction. |
| Max extensions reached | Extension cap hit | Close after policy window. |
| Quiet window passes | No bids | Close commit. |
| Extension storm | High load | Apply caps/throttle. |
