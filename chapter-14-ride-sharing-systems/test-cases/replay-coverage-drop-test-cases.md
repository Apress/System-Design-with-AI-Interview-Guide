# Replay Coverage Drop Test Cases

| Case | Replay Coverage | Expected Behavior |
|---|---:|---|
| Healthy | 99.9% | Normal autonomy. |
| Warning | 99.2% | Investigate affected paths. |
| Hard breach | 98.6% | Lower autonomy, restore logging, stop high-risk commits if needed. |
