# Restore Certification Test Cases

| Case | Expected Behavior |
|---|---|
| Restore + decrypt + hash verify | Recoverable. |
| Restore fails | Stop claim. |
| Metadata rebuild fails | Partial/quarantine. |
| Restore drill stale | Force certification before claim. |
