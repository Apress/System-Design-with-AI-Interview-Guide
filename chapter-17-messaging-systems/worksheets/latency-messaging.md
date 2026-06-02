# Latency: Messaging

| Latency | Meaning | Control |
|---|---|---|
| Broker lag | Delayed work. | Monitor but don't infer correctness. |
| Consumer timeout | External effect may have succeeded. | Reconcile. |
| Late retry | Old intent meets new reality. | Time budget. |
| DLQ delay | Unsafe work awaits owner. | Runbook. |
| Replay latency | Time to prove. | Replay cards. |
