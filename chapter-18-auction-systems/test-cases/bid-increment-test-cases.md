# Bid Increment Test Cases

| Current Price | Proposed Bid | Increment | Expected |
|---:|---:|---:|---|
| 100 | 105 | 10 | Reject or normalize per policy. |
| 100 | 110 | 10 | Accept. |
| 490 | 500 | 10/25 boundary | Apply pinned table. |
| 1000 | 1025 | 50 | Reject if increment is 50. |
