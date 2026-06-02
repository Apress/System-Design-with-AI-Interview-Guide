# AI Derivative Invalidation Test Cases

| Event | Expected Behavior |
|---|---|
| New source version | Mark derivatives stale and rebuild. |
| ACL change | Invalidate search/embedding exposure. |
| Model deprecated | Rebuild by policy. |
| Source deleted/restricted | Remove or restrict derivatives. |
