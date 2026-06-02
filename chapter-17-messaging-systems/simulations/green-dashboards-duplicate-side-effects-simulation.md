# Green Dashboards, Duplicate Side Effects Simulation

## Scenario

Broker is healthy, consumers are running, and dashboards show throughput recovery. Later, support reports duplicate payments and duplicate emails.

## Analyze

- Which side effects lacked durable idempotency?
- Which metrics were missing?
- Which stop authority should have fired?
- What replay evidence is needed?
