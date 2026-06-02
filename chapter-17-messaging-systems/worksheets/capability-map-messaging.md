# Capability Map: Messaging

| Capability | Responsibility | Boundary | Owner |
|---|---|---|---|
| Producer | Record intent | Outbox commit | Producer owner |
| Event Log | Retain facts | Delivery boundary | Platform owner |
| Queue | Distribute work | Task boundary | Worker owner |
| Consumer | Interpret action | Before side effect | Consumer owner |
| Idempotency Store | Prove effect | Side-effect gate | Capability owner |
| DLQ | Hold unsafe work | Automation stops | DLQ owner |
| Replay | Simulate/execute | Replay mode | Replay operator |
| Schema Registry | Govern contract | Version boundary | Schema owner |
