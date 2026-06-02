# Sharding Review Prompt

Review my sharding strategy.

Evaluate:

- Whether the shard key follows the access pattern
- Which operations remain local
- Which operations become cross-shard
- Hot partition risk
- Large tenant or hot entity risk
- Rebalancing complexity
- Routing dependency
- Consistency impact
- Regional/data residency impact

Then propose a better shard key if needed.
