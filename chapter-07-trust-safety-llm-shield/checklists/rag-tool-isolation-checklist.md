# RAG and Tool Isolation Checklist

Confirm:

- Retrieval is scoped by user permission
- Metadata ACLs travel with chunks
- Documents have provenance
- Documents have TTL or freshness rules
- Context packet has token budget
- Sensitive fields are redacted
- Retrieved instructions are treated as untrusted
- Conflicting sources are detected
- Authoritative sources are prioritized
- Tool allowlist exists
- Tool side effects are classified
- Unauthorized tools are inaccessible
- Tool calls are logged and replayable
