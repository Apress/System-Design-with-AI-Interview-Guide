# Scale: Messaging

| Pressure | Failure Shape | Control |
|---|---|---|
| High volume | Lag. | Backpressure. |
| Hot partition | Entity backlog. | Key design. |
| Fanout | Too many tasks. | Stream-plus-queue split. |
| Retry storm | Work multiplies. | Count/time budgets. |
| DLQ spike | Unsafe automation. | Triage/simulate-only. |
