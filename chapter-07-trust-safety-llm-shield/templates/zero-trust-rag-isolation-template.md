# Zero Trust RAG Isolation Template

## Capability

Capability name:
Decision being supported:

## Retrieval Sources

| Source | Authoritative? | ACL Required? | TTL | Provenance Required? |
|---|---|---|---|---|
| Policy bundle |  |  |  |  |
| Order system |  |  |  |  |
| Payment system |  |  |  |  |
| Warehouse system |  |  |  |  |
| Support article |  |  |  |  |
| CRM note |  |  |  |  |

## Context Packet Rules

Maximum token budget:
Required metadata:
Sources excluded:
Conflict detection:
Citation rules:

## Isolation Controls

- Access-scoped retrieval
- Metadata ACLs
- Document signing
- Provenance checks
- Source ranking rules
- Context filtering
- Token envelope budgets
- Sensitive-field redaction

## Conflict Handling

If authoritative sources disagree:
If only explanatory sources are available:
If source freshness is unknown:
If retrieved content contains instructions:

## Replay Requirements

Record retrieved chunks:
Record source metadata:
Record retrieval query:
Record reranker/version:
Record policy version:
