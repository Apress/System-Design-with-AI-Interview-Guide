# Index Freshness Test Cases

| Lag | Expected Behavior |
|---:|---|
| < normal budget | Continue. |
| Between normal and max | Show indexing. |
| > max budget | Truth-first mode and rebuild. |
| Index drift affects delete | Freeze lifecycle/delete decisions based on index. |
