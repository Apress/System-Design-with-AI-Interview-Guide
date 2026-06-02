# Stop Authority Test Cases

| Trigger | Expected Action |
|---|---|
| Index lag | Suppress AI answers for affected governed corpus. |
| Missing citations | Show sources only. |
| Ranking drift | Revert ranker. |
| Policy mismatch | Fail closed/narrow visible set. |
| Stale cache | Bypass cache. |
| Vector policy-wrong | Constrain vector behind filters. |
