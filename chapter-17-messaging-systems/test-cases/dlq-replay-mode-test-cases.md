# DLQ Replay Mode Test Cases

| Case | Mode | Expected Behavior |
|---|---|---|
| Simulate | simulate | Validate only; no side effects. |
| Execute without approval | execute | Reject. |
| Execute with committed effect | execute | NO_OP receipt. |
| Execute with schema mismatch | execute | Quarantine. |
