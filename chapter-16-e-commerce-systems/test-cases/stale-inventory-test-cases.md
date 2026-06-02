# Stale Inventory Test Cases

| Case | Inventory Age | Expected Behavior |
|---|---:|---|
| Fresh | 20s | Can proceed. |
| Soft-stale | 60s | Refresh before high-risk commit. |
| Hard-stale | 150s | Do not confirm; refresh/pending/refuse. |
| Browse stale | 150s | Can show estimate with label. |
