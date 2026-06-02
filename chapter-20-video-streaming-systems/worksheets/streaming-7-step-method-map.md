# Streaming 7-Step Method Map

| Step | Streaming Application | Notes |
|---|---|---|
| Clarify | VOD, live, low latency, ads, offline, rights, full lifecycle. |  |
| Actors | Viewer, device, player, entitlement, DRM, CDN, origin, ads, licensor, support. |  |
| Journey | Press play, session grant, manifest, DRM, segment fetch, ABR, ads, QoE, replay. |  |
| Constraints | Hot titles, CDN brownout, device failures, stale manifests, DRM failures, ad stalls. |  |
| Commitments | playbackSessionId, entitlementTokenId, manifestVersionId, drmLicenseId, adDecisionId. |  |
| Architecture | Ingest, encode, package, entitlement, DRM, CDN, player, ads, QoE, replay. |  |
| Trade-offs | Quality vs stability, low latency vs buffer, ads vs experience, cost vs rescue. |  |
