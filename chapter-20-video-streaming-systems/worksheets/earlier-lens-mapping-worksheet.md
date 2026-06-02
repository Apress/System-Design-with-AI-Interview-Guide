# Earlier-Lens Mapping Worksheet: Video Streaming Systems

This worksheet helps you apply the earlier lenses from Part I and Part II to Chapter 20: Video Streaming Systems.

The purpose is not to memorize a “design Netflix” answer. The purpose is to prove that you can reuse the same system design method when media, time, quality, entitlement, DRM, ads, CDNs, devices, live clocks, and QoE collide inside a continuous experience.

Use this worksheet before drawing the final architecture. A senior answer should show that you understand experience claims, session-grant authority, tokenized playback proof, time-addressable media, multi-CDN control, player degradation, low-latency clocks, ad side effects, stop authority, ROCS loops, failure modes, economics, and replay requirements.

---

## 1. 7-Step Method Mapping

| Step | Streaming Application | Senior Architect Framing | Reader Notes |
|---|---|---|---|
| 1. Clarify the problem | Are we designing VOD, live, low latency, ad-supported streaming, offline download, rights enforcement, or full platform lifecycle? | “I need to know which experience claim the platform is allowed to make.” |  |
| 2. Identify actors | Viewer, device, player, entitlement, DRM, CDN, origin, ad system, licensor, advertiser, support, operator. | “Streaming has more actors than viewer and video.” |  |
| 3. Map the journey | Request play, grant session, serve manifest, issue DRM, fetch segments, adapt quality, insert ads, measure QoE, support/replay. | “The product is the experience over time.” |  |
| 4. Define constraints | Hot titles, origin stampede, CDN brownout, device cohort failures, stale manifests, DRM failures, ad stalls, live drift. | “The platform must stay honest while reality changes.” |  |
| 5. Name commitments | `playbackSessionId`, `entitlementTokenId`, `manifestVersionId`, `drmLicenseId`, `adDecisionId`, QoE receipt. | “Playable is a claim. Session grant creates liability.” |  |
| 6. Choose architecture | Ingest, encode, package, entitlement, DRM, manifest, CDN, player control, ads, QoE, replay, stop authority. | “I draw the session-grant boundary before drawing CDNs.” |  |
| 7. Defend trade-offs | Quality vs stability, low latency vs buffer safety, CDN switch vs thrash, ads vs experience, cost vs rescue behavior. | “A slower honest experience is better than a fast false claim.” |  |

---

## 2. Customer Journey Mapping

| Journey Moment | Viewer Believes | Platform Risk | Architecture Response |
|---|---|---|---|
| Press Play | Content should start. | Access may not be lawful or defensible. | Session grant gate. |
| Session granted | Platform says Playable. | Missing entitlement, policy, manifest, or DRM proof. | Token chain and replay receipt. |
| Manifest served | Player has valid time map. | Stale or inconsistent manifest. | Manifest version and validation. |
| Segments fetched | Playback should continue. | CDN/ISP/device failures. | Multi-CDN control and QoE monitoring. |
| Quality changes | Platform optimizes experience. | ABR oscillation and false HD claim. | ABR governance and receipts. |
| Live playback | Viewer is near real time. | Clock drift and low-latency instability. | Low-latency clock contract. |
| Ads run | Interruption should be bounded. | Ad deadlock or bad measurement. | Ad safe mode and `adDecisionId`. |
| Support asks why | Platform must explain. | Logs scattered across vendors. | Streaming Decision Replay Card. |

---

## 3. Capability Map

| Capability | Responsibility | Commitment Boundary | Owner |
|---|---|---|---|
| Capture/Ingest | Accept source media and validate tracks/time. | Source receipt. | Media ingest owner |
| Encode | Produce renditions and ABR ladder. | ABR ladder version. | Encoding owner |
| Package | Produce manifest and segments. | `manifestVersionId`. | Packaging owner |
| Entitlement | Decide access rights. | `entitlementTokenId`. | Rights/access owner |
| DRM | Grant decryption authority. | `drmLicenseId`. | DRM owner |
| Manifest Service | Serve time map and renditions. | Manifest grant. | Manifest owner |
| CDN Distribution | Deliver segments and shield origin. | CDN path receipt. | Distribution owner |
| Player Control | Adapt quality, buffer, retry, degrade. | ABR/QoE receipt. | Player owner |
| Ads | Decide and execute interruptions. | `adDecisionId`. | Ads owner |
| QoE Measurement | Measure experience. | QoE receipt. | Observability owner |
| Replay/Audit | Prove session behavior. | Streaming Replay Card. | Governance owner |
| Stop Authority | Freeze risky capabilities. | Stop event. | Platform operations owner |

---

## 4. ARCHVIEW Mapping

| ARCHVIEW Concern | Streaming View |
|---|---|
| Actors | Viewer, player, device, entitlement, DRM, CDN, origin, ad system, licensor, advertiser, support, operator. |
| Responsibilities | Ingest, encode, package, entitlement, DRM, manifest, delivery, playback, ads, QoE, replay. |
| Control surfaces | Session grant, entitlement policy, manifest version, DRM issuance, CDN switch, ABR ladder, ad safe mode. |
| Commitment points | `playbackSessionId`, `entitlementTokenId`, `manifestVersionId`, `drmLicenseId`, `adDecisionId`, QoE receipt. |
| Ownership | Ingest, encoding, packaging, rights, DRM, CDN, player, ads, observability, replay, stop authority owners. |
| Evidence | Policy pin, entitlement facts, manifest integrity, DRM license, CDN route, ABR timeline, ad decision, QoE. |
| Degradation | Conservative ABR, buffer widen, CDN switch, rendition clamp, low-latency fallback, ad safe mode, precise refusal. |
| Stop authority | Freeze low latency, 4K/HD claim, DRM issuance, ad path, CDN route, or session grants by cohort. |

---

## 5. AI Primitives Mapping

| AI Primitive | Streaming Application | Artifact |
|---|---|---|
| Authority | What is the platform allowed to play, license, show, route, or refuse? | Entitlement and DRM policy |
| Commitment | Session grant creates experience liability. | `playbackSessionId` and token chain |
| Time | Live and low latency are clock contracts. | Low-latency mode policy |
| Degradation | Reduce ambition before experience collapse. | Player control ladder |
| Evidence/Replay | Prove why experience happened. | Streaming Decision Replay Card |
| Ownership | Owners must freeze risky capabilities. | Stop-authority matrix |

---

## 6. ROCS Mapping

| ROCS Dimension | Streaming Pressure | Control |
|---|---|---|
| Reliability | Playback must survive CDN, DRM, manifest, device, and ad failures. | ABR clamp, buffer widen, scoped CDN shift, refusal. |
| Observability | Platform must replay why the session behaved as it did. | Replay card, policy pins, manifest/DRM/ad/CDN receipts. |
| Cost | Egress, retries, transcode, ad loops, and support multiply. | Budgets, ladder caps, request collapsing, cooldowns. |
| Sustainability | Trust must survive degraded quality. | Honest degradation, reason codes, re-enable criteria. |

---

## 7. Scale Mapping

| Scale Pressure | Streaming Failure Shape | Control |
|---|---|---|
| Hot title/event | Origin stampede and CDN pressure. | Origin shielding, request collapse, cache policy. |
| Device diversity | One firmware cohort fails. | Cohort-specific clamp or feature disable. |
| CDN brownout | ISP/metro-specific stalls. | Scoped CDN switch with hysteresis. |
| Live event | Clock drift and latency pressure. | Low-latency mode budget and fallback. |
| Ad fanout | Waterfall or SDK bottleneck. | Ad safe mode. |

---

## 8. Consistency Mapping

| Boundary | Trust Rule | Artifact |
|---|---|---|
| Source accepted | Media truth begins. | Source receipt |
| Encoded | Renditions are valid. | ABR ladder version |
| Packaged | Time map is defensible. | `manifestVersionId` |
| Session granted | Playable claim begins. | `playbackSessionId` |
| Entitled | Viewer is allowed. | `entitlementTokenId` |
| Licensed | Decryption allowed. | `drmLicenseId` |
| Ad planned | Interruption authorized. | `adDecisionId` |
| CDN switched | Path changed materially. | CDN-switch receipt |
| Quality changed | Experience changed. | ABR decision receipt |

---

## 9. Latency Mapping

| Latency Type | Streaming Meaning | Control |
|---|---|---|
| Startup latency | Time to first frame. | Session grant and manifest/DRM budget. |
| Segment fetch latency | Risk of rebuffering. | ABR shift, buffer widen, CDN switch. |
| Live latency | Viewer distance from event time. | Clock contract and mode fallback. |
| Manifest staleness | Incorrect time map. | Pin fallback or disable low latency. |
| Ad latency | Interruption risk. | Ad safe mode. |
| Replay latency | Time to reconstruct truth. | Replay card completeness. |

---

## 10. Failure Mapping

| Failure Signal | What It Looks Like | Response |
|---|---|---|
| Rebuffer spike by cohort | Buffering every few seconds. | Clamp ABR, widen buffer, scoped CDN switch. |
| Manifest staleness | Player follows bad time map. | Disable low latency or pin fallback manifest. |
| DRM failure spike | Entitled viewers cannot decrypt. | Freeze affected DRM issuance path and remediate. |
| Ad deadlock | Content blocked behind ad. | Activate ad safe mode. |
| Replay gap | Cannot prove session grant or switch. | Freeze affected path. |
| Device regression | One device class collapses. | Disable risky renditions or features. |

---

## 11. Economics Mapping

| Economic Multiplier | Streaming Example | Control |
|---|---|---|
| Egress waste | Retry loops and over-fetching. | Retry budgets and ABR clamp. |
| Origin pressure | CDN failover stampede. | Origin shielding and request collapse. |
| Transcode cost | Overbuilt ladders. | Ladder policy and caps. |
| Ad make-goods | Broken ad measurement or delivery. | Ad replay receipts and safe mode. |
| Support load | Viewers report buffering. | Replay cards and cohort diagnosis. |
| Churn risk | HD claimed while experience is red. | Honest degradation and stop authority. |

## Final Senior Line

> A video streaming system is not a media pipeline. It is a continuous-experience commitment engine. The senior design separates serving bytes from session grant, treats Playable, Live, HD, Ad-supported, and Available in region as claims requiring proof, governs ABR, CDN, DRM, ads, and low-latency as control surfaces, and emits replay cards so the platform can defend why a viewer played, buffered, switched CDN, dropped quality, saw ads, disabled low latency, or was refused.
