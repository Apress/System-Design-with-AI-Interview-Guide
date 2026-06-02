# Failure: Messaging

| Signal | Looks Like | Response |
|---|---|---|
| Duplicate delivery | Event arrives again. | effectId no-op. |
| Lost ack | External success internal loss. | Reconcile/idempotency. |
| Poison message | Fails repeatedly. | DLQ. |
| Schema mismatch | Unsafe interpretation. | Quarantine. |
| Unsafe replay | Re-executes effects. | Simulate first. |
| Replay gap | Cannot prove. | Freeze capability. |
