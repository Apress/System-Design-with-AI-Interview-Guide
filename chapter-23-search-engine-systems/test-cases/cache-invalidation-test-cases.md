# Cache Invalidation Test Cases

| Event | Expected Behavior |
|---|---|
| Source version changes | Invalidate cached results/answers. |
| Policy changes | Invalidate governed answers. |
| Ranking policy changes | Recompute ranked caches. |
| ACL changes | Invalidate access-sensitive caches. |
