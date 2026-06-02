# Ranking Precedence Test Cases

| Case | Expected Behavior |
|---|---|
| Stale popular policy vs current policy | Current policy ranks first. |
| Sponsored item violates hard constraint | Suppress sponsored item. |
| Free text implies Nike but structured brand differs | Structured brand wins. |
| Unsafe candidate highly engaging | Safety suppresses. |
