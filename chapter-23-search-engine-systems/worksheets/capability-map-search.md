# Capability Map: Search

| Capability | Responsibility | Boundary | Owner |
|---|---|---|---|
| Crawl/Ingest | Observe/admit. | crawl/ingest receipt | Ingest owner |
| Parse | Extract content. | parseReceiptId | Parser owner |
| Index | Make searchable. | indexReceiptId | Index owner |
| Query Understanding | Intent/entities. | query trace | Search API |
| Routing | Select truth source. | routing receipt | Platform |
| Retrieval | Candidate evidence. | retrieval trace | Retrieval owner |
| Ranking | Order results. | rank receipt | Ranking owner |
| Filtering | Enforce policy. | filterReceiptId | Policy owner |
| Citation | Source proof. | citationReceiptId | Evidence owner |
| Answer | Visible claim. | answerReceiptId | AI owner |
| Replay | Reconstruct. | replay card | Governance |
