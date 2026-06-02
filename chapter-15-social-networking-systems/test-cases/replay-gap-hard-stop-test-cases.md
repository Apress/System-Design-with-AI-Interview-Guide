# Replay-Gap Hard Stop Test Cases

| Case | Replay Coverage | Expected Behavior |
|---|---:|---|
| Full coverage | 100% | Continue if other gates pass. |
| Minor gap on low-risk grant | 99.5% | Investigate, restrict high-risk actions. |
| Gap on amplification | 99.9% | Hard stop affected amplification path. |
| Severe gap | < 99% | Freeze high-risk promotions and escalate. |
