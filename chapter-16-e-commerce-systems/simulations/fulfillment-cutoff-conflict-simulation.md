# Fulfillment Cutoff Conflict Simulation

## Scenario

Customer requests address change. CRM says modifiable. Warehouse says picking started.

## Expected Controls

- Treat warehouse state as authoritative for fulfillment cutoff
- Refresh if within budget
- If conflict remains, refuse automated modification or escalate
- Preserve replay and communicate clearly
