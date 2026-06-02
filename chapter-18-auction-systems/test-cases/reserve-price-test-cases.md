# Reserve Price Test Cases

| Highest Clearing Price | Reserve | Expected Outcome |
|---:|---:|---|
| 380 | 400 | No sale. |
| 400 | 400 | Reserve met; sale exists. |
| 420 | 400 | Winner committed. |
| Hidden reserve | Public view | Do not expose amount; expose reserve-met status if policy allows. |
