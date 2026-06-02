# Capability Map: Streaming

| Capability | Responsibility | Boundary | Owner |
|---|---|---|---|
| Ingest | Validate source. | Source receipt | Ingest owner |
| Encode | Produce ABR ladder. | Ladder version | Encoding owner |
| Package | Manifest/segments. | manifestVersionId | Packaging owner |
| Entitlement | Access rights. | entitlementTokenId | Rights owner |
| DRM | Decryption authority. | drmLicenseId | DRM owner |
| CDN | Deliver media. | CDN path receipt | Distribution |
| Player | Adapt/degrade. | ABR/QoE receipt | Player owner |
| Ads | Interruptions. | adDecisionId | Ads owner |
| Replay | Prove session. | Replay card | Governance |
