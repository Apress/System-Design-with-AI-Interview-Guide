# Replay Coverage Drop Test Cases

| Case | Coverage | Expected Behavior |
|---|---:|---|
| Healthy | 100% | Normal autonomy. |
| High-risk commit gap | 99.9% | Hard-stop affected path. |
| Refund replay gap | < 100% | Route to review. |
| Modification replay gap | < 100% | Stop automated modifications. |
