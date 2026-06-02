# Index Receipt Test Cases

| Case | Expected Behavior |
|---|---|
| Parser drops table | Quarantine/rebuild, do not claim complete searchability. |
| Chunk policy changes | Reindex affected corpus. |
| Source version stale | Mark stale. |
| Index validation fails | Freeze promotion. |
