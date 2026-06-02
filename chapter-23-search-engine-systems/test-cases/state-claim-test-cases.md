# State Claim Test Cases

| Case | Evidence | Expected Claim |
|---|---|---|
| Crawled only | crawlReceiptId | Observed, not searchable. |
| Parsed but not indexed | parseReceiptId only | Not searchable. |
| Indexed fresh | indexReceiptId current | Searchable. |
| Filtered with receipt | filterReceiptId | Admissible. |
| Citation current | citationReceiptId | Citable. |
| Answer receipt exists | answerReceiptId | Answerable. |
