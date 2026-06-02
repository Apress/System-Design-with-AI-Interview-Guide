# Query Routing Test Cases

| Query | Route | Reason |
|---|---|---|
| Where is my order? | Order/status API | Source-of-record system. |
| Refund policy | Policy repository | Governed source. |
| Red Nike shoes under $100 | Catalog + inventory + shipping | Structured product truth. |
| Internal error code | Lexical docs/log index | Exact term evidence. |
