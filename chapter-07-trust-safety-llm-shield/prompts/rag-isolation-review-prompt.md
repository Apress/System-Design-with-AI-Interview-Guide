# RAG Isolation Review Prompt

Review my RAG architecture for isolation risks.

Evaluate:

- Whether retrieval is access-scoped
- Whether documents carry metadata and ACLs
- Whether provenance is checked
- Whether source freshness is enforced
- Whether context packets have token budgets
- Whether sensitive fields are redacted
- Whether retrieved instructions are treated as untrusted
- Whether conflicting sources are detected
- Whether authoritative evidence is separated from explanatory evidence
- Whether tool calls are isolated and allowlisted

Then propose a safer Zero Trust RAG design.
