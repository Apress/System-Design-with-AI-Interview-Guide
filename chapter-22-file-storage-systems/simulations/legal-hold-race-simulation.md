# Legal Hold Race Simulation

## Scenario

Lifecycle worker prepares hard delete while legal hold propagation is delayed.

## Expected Controls

- Legal time outranks lifecycle time
- Treat unknown hold status as delete-defer
- Freeze hard delete if hold propagation lags
- Emit refusal/defer receipt
