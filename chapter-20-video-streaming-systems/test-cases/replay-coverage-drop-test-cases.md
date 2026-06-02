# Replay Coverage Drop Test Cases

| Case | Coverage | Expected Behavior |
|---|---:|---|
| Session grants | 100% | Continue. |
| Session grant replay gap | <100% | Freeze affected grant path. |
| CDN receipts missing | <100% | Freeze automated expansion. |
| Ad decision replay gap | <100% | Safe mode/review. |
