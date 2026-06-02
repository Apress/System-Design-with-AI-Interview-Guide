# Failure: Storage

| Signal | Looks Like | Response |
|---|---|---|
| Index drift | Missing from search. | Truth-first/rebuild. |
| Receipt gap | Cannot prove. | Freeze. |
| Integrity failure | Hash/key mismatch. | Quarantine. |
| Restore failure | Backup exists but fails. | Stop recoverable claim. |
| Delete spike | Attack. | Freeze deletes. |
| Policy mismatch | Rule drift. | Quarantine/rollback. |
