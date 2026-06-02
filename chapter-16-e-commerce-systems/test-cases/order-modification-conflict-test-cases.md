# Order Modification Conflict Test Cases

| Case | CRM State | Warehouse State | Expected Behavior |
|---|---|---|---|
| Both modifiable | modifiable | created | Modify with acknowledgments. |
| Conflict | modifiable | picking_started | Do not commit; escalate/refuse. |
| Stale warehouse | modifiable | stale | Refresh before decision. |
| Post-commit divergence | changed | label already printed | Repair/compensate/replay. |
