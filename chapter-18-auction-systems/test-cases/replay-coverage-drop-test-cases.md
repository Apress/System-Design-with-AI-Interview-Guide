# Replay Coverage Drop Test Cases

| Case | Coverage | Expected Behavior |
|---|---:|---|
| Close replay 100% | Healthy | Continue. |
| Close replay <100% | Gap | Freeze close/settlement. |
| Settlement replay <100% | Gap | Pause settlement effects. |
| Compensation replay missing | Gap | Route to owner/review. |
