# Replay Coverage Drop Test Cases

| Capability | Coverage | Expected Behavior |
|---|---:|---|
| Writes | 100% | Continue. |
| Delete | <100% | Freeze hard delete. |
| Restore | <100% | Stop recoverable claim for affected scope. |
| Legal hold | <100% | Freeze destructive actions. |
