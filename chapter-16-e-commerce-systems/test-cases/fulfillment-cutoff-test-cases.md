# Fulfillment Cutoff Test Cases

| Case | Fulfillment State | Expected Behavior |
|---|---|---|
| Not released | created | Modification may proceed with checks. |
| Released | released | Conditional, refresh and validate. |
| Picking started | picking_started | Stop automated modification. |
| Carrier accepted | carrier_accepted | Hard stop; communicate/compensate as policy allows. |
