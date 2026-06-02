# Truth vs. Derivatives Worksheet

| Artifact | Source of Record? | Regeneratable? | Required Pins | Invalidation Rule |
|---|---|---|---|---|
| Original object version | Yes | No | versionId, hash, key lineage | Never invalidate source truth. |
| Legal hold receipt | Yes | No | legalHoldId, policyVersion | Supersede only by release receipt. |
| OCR text | No | Yes | sourceVersionId, extractorVersion | New version or policy change. |
| Embedding | No | Yes | sourceVersionId, modelVersion | New version, model deprecation, ACL change. |
| Summary | No | Yes | sourceVersionId, model/promptVersion | New version or classification change. |
| Thumbnail | No | Yes | sourceVersionId, rendererVersion | New version or delete/restrict. |
| Search index | No | Yes | sourceVersionId, metadataVersion | Metadata or ACL change. |
