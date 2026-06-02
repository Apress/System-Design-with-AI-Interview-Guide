# Integrity Proof Test Cases

| Case | Expected Behavior |
|---|---|
| Hash matches version | Integrity pass. |
| Hash mismatch | Quarantine and block serve. |
| Wrong key | Stop recoverable claim. |
| Missing restore proof | Do not claim recoverable. |
| Serve cache mismatch | Purge/revalidate and emit incident receipt. |
