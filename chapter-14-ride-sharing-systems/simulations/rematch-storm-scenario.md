# Rematch Storm Simulation

## Setup

At 6:02 PM, demand rises in two adjacent zones.

At 6:05 PM, traffic snapshots drift past the soft TTL.

At 6:07 PM, driver GPS staleness increases due to app backgrounding and throttled updates.

At 6:12 PM, rematch rate crosses 5 percent.

At 6:18 PM, replay coverage drops below threshold.

## Analyze

- Where did uncertainty enter?
- Which signal became present-but-stale?
- Which loops formed?
- Why did services remain green?
- What stop authority should fire?
- Which posture changes should happen?

## Expected Controls

- Hard GPS TTL enforcement
- Redispatch cap
- Surge dampening
- Tighter commit gates
- Lower autonomy
- Assisted handling
- Replay coverage restoration
