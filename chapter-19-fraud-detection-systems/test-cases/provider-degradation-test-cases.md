# Provider Degradation Test Cases

| Provider State | Impact | Expected Behavior |
|---|---|---|
| Step-up latency high | User friction | Cap and fallback. |
| Step-up unavailable | No proof | Avoid hard enforcement for missing identity. |
| Identity provider stale | Old records | Refresh/review. |
| Provider false-fail spike | Legitimate users fail | Freeze punitive actions. |
