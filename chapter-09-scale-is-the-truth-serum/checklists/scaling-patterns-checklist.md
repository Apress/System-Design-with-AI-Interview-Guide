# Scaling Patterns Checklist

When choosing a scaling pattern, ask:

- What promise does this pattern protect?
- Does it help reads, writes, or both?
- Does it protect discovery, commitment, or recovery?
- What bottleneck does it not fix?
- What new failure mode does it introduce?
- What observability is required?
- What degraded mode is needed?

Common patterns:

- Horizontal scaling
- Vertical scaling
- Load balancing
- Queues
- Caching
- Read replicas
- Sharding
- Autoscaling
- Rate limiting
- Backpressure
