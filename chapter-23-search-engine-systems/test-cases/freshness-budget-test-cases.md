# Freshness Budget Test Cases

| Corpus | Lag | Expected Behavior |
|---|---:|---|
| Governed policy | within budget | Searchable/current. |
| Governed policy | exceeds budget | Suppress AI answers. |
| Product catalog | minor lag | Mark freshness if needed. |
| Cache stale | any governed content | Bypass and invalidate. |
