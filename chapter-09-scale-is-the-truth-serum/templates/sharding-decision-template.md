# Sharding Decision Template

## Capability / Data Domain

Domain:
Primary access pattern:

## Candidate Shard Keys

| Shard Key | Benefit | Risk |
|---|---|---|
| User ID |  |  |
| Order ID |  |  |
| Product ID |  |  |
| SKU |  |  |
| Region |  |  |
| Tenant |  |  |
| Time range |  |  |

## Local Operations

Which operations must remain local?

## Cross-Shard Operations

Which operations may cross shards?

## Hot Partition Risk

Potential hot keys:
Mitigation:

## Routing

Routing method:
Directory needed?
Consistent hashing needed?

## Final Decision

Shard key:
Reason:
Trade-off:
