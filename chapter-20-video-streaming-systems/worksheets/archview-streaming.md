# ARCHVIEW: Streaming

| Concern | View |
|---|---|
| Actors | Viewer, player, device, entitlement, DRM, CDN, ads, support, operator. |
| Responsibilities | Ingest, encode, package, entitlement, delivery, playback, ads, QoE, replay. |
| Controls | Session grant, manifest version, DRM, CDN switch, ABR, ad safe mode. |
| Commit Points | playbackSessionId, entitlementTokenId, manifestVersionId, drmLicenseId, adDecisionId. |
| Evidence | Policy, entitlement, manifest, DRM, CDN route, ABR, ad, QoE. |
| Degradation | Conservative ABR, buffer widen, CDN switch, clamp, fallback, safe mode. |
