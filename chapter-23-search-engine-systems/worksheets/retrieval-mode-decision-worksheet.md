# Retrieval Mode Decision Worksheet

| Query Type | Preferred Mode | Why | Risk | Controls |
|---|---|---|---|---|
| Exact SKU / product code | Lexical | Exact terms matter. | Misses paraphrase. | Normalization. |
| Order status | Vectorless | Truth in APIs. | API rigidity. | Tool contract. |
| Policy lookup | Hybrid / vectorless | Current authority matters. | Stale source. | Freshness + citations. |
| Exploratory discovery | Vector / hybrid | Semantic recall. | Plausible wrong. | Filters + ranking. |
| Product discovery with constraints | Hybrid | Structured + semantic. | Sponsored/fuzzy override. | Hard constraints first. |
