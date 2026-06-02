# Replay Coverage Drop Test Cases

| Case | Coverage | Expected Behavior |
|---|---:|---|
| 100% high-risk | healthy | Normal autonomy. |
| 99.9% high-risk | gap | Freeze affected side effects. |
| DLQ execute without receipt | 0 receipt | Block execute mode. |
| Low-risk projection gap | partial | Degrade/rebuild projection. |
