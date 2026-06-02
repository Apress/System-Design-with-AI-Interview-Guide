# Chapter 20 Solution Guide

## Exercise 1 Solution: Streaming as a Continuous-Experience Commitment Engine

A strong answer should explain that video streaming is not merely a media storage, encoding, CDN, and player problem. A streaming platform owns a continuous experience over time. It makes customer-visible claims such as Playable, Live, HD, Ad-supported, Downloaded, and Available in this region while network, device, CDN, manifest, DRM, entitlement, ad, and clock realities keep changing underneath it.

“Playable” is not a button label. It is a claim that the platform is allowed to make only when entitlement, policy, manifest, DRM, device, region, concurrency, CDN, and session evidence are sufficient. “Session started” is also not the same as “experience defensible.” A player can start and still collapse into buffering, quality oscillation, caption drift, ad deadlock, or low-latency drift.

A senior design separates:

- Media pipeline: ingest, encode, package, distribute.
- Session authority: entitlement, policy, manifest, DRM, concurrency, region.
- Experience control: ABR, buffer, CDN path, retry, low-latency mode.
- Side effects: ad decisioning, measurement, entitlement grants, DRM issuance.
- Replay: proof of why the viewer experienced what they experienced.

Actors include:

- Viewer
- Player
- Device and OS/firmware cohort
- Entitlement system
- DRM provider
- CDN and origin
- Ad decision and measurement systems
- Licensor/rightsholder
- Advertiser
- Support
- Platform operator
- Policy owner

Before the platform claims Playable, HD, Live, Ad-supported, or Available in region, it needs evidence:

- `playbackSessionId`
- `entitlementTokenId`
- `policyBundleVersion`
- `manifestVersionId`
- `drmLicenseId`, if protected content
- region and rights-window proof
- concurrency/device check
- CDN path state
- ABR ladder version
- ad decision state, if ad-supported
- QoE measurement path
- precise refusal/degradation reason if proof is incomplete

Later, the platform must replay why a viewer:

- played,
- buffered,
- dropped quality,
- switched CDN,
- saw ads,
- skipped ads,
- entered low-latency mode,
- fell back to standard latency,
- was refused,
- or was blocked in a region.

Senior answer:

> I am not designing only HLS, DASH, encoders, CDNs, and players. I am designing a continuous-experience commitment engine. Playable, Live, HD, and Ad-supported are claims. Session grant creates liability, and every material experience change must be governed, bounded, and replayable.

---

## Exercise 2 Solution: Playback Token Chain and Session-Grant Boundary

A mature streaming design uses explicit tokens to name the proof chain.

| Token | What It Proves | Why It Matters |
|---|---|---|
| `playbackSessionId` | The platform created a session envelope for this viewer/content/device. | It ties entitlement, manifest, DRM, ads, CDN, ABR, and QoE together. |
| `entitlementTokenId` | Viewer is allowed under account, region, tier, license window, device, and concurrency policy. | Without it, Playable is not lawful or defensible. |
| `policyBundleVersion` | The rules in force at grant time. | Later disputes need the exact policy, not today’s policy. |
| `manifestVersionId` | The exact time map and rendition set served. | It proves what the player was told to follow. |
| `drmLicenseId` | Decryption authority was granted. | DRM issuance is an access liability. |
| `segmentId` / `chunkId` | Which media units were fetched or attempted. | Needed for QoE, buffering, and CDN path proof. |
| `adDecisionId` | Ad plan, interruption, targeting/eligibility, consent, and measurement mode. | Ads are side effects; they change user experience and revenue claims. |

`playbackSessionId` is not a request ID. A request ID traces one call. A playback session is the envelope of responsibility for the experience. It links policy, entitlement, manifest, DRM, ad decisions, CDN choices, ABR timeline, QoE, and stop actions.

Session grant is the liability boundary. Before grant, the platform can refresh entitlement, re-authenticate, choose a different manifest, fall back from low latency, or refuse. After grant, it owns the experience and must be able to explain material behavior.

If entitlement proof exists but manifest proof is missing, do not claim Playable. The viewer may be allowed in principle, but the system has not proven a valid time map. If DRM proof is missing for protected content, do not issue a playable grant. The platform should remediate or refuse precisely.

Possible reason codes:

- `ENTITLEMENT_MISSING`
- `REGION_NOT_ALLOWED`
- `CONCURRENCY_LIMIT_EXCEEDED`
- `MANIFEST_NOT_DEFENSIBLE`
- `DRM_LICENSE_UNAVAILABLE`
- `DEVICE_NOT_SUPPORTED`
- `LOW_LATENCY_NOT_ADMISSIBLE`
- `AD_DECISION_TIMEOUT_SAFE_MODE`
- `SESSION_REPLAY_RECEIPT_MISSING`

Streaming Decision Replay Card should contain:

- correlation ID / playback session ID
- asset ID / live event ID
- entitlement token and policy bundle version
- manifest version
- DRM license ID
- CDN route decisions
- ABR ladder and timeline
- segment/chunk fetch outcomes
- ad decision and safe-mode path
- QoE outcome: startup time, rebuffering, bitrate, latency
- stop actions: clamp, switch, disable, refuse
- privacy posture
- re-enable events

Senior answer:

> The session grant is where the platform stops negotiating and starts owning experience. A session is defensible only when entitlement, policy, manifest, DRM, ad, CDN, ABR, and QoE evidence are tied to the same playbackSessionId.

---

## Exercise 3 Solution: Ingest, Encode, and Package as Truth Gates

Publishing as soon as encoding completes is unsafe if caption tracks are missing, GOP cadence is irregular, or low-latency partial segments are unstable. Streaming truth begins at ingest because downstream systems can only defend the experience if the source media and time map are coherent.

Bad ingest creates downstream failure shapes:

- black screen,
- audio/video desync,
- caption drift,
- missing audio tracks,
- unsupported renditions,
- player crashes,
- manifest inconsistency,
- low-latency instability,
- non-defensible playback.

At ingest, the system must prove:

- source receipt,
- decodable video tracks,
- decodable audio tracks,
- monotonic timestamps,
- audio/video presence,
- caption availability,
- language and accessibility metadata,
- source policy compliance.

If missing or invalid: quarantine or reject. Do not publish undefined media.

At encode, the system must prove:

- ABR ladder version,
- codec and rendition availability,
- GOP cadence,
- keyframe alignment,
- device compatibility,
- bitrate/rendition policy,
- audio/caption track preservation.

If missing or invalid: re-encode, reduce ladder, or block publish.

At package, the system must prove:

- `manifestVersionId`,
- segment timeline,
- media sequence continuity,
- DRM packaging,
- ad markers,
- cache rules,
- low-latency partial segment state.

If missing or invalid: do not serve manifest; route to repair.

Low-latency mode requires stricter evidence because it reduces buffering tolerance and compresses recovery time. The system must prove:

- partial segment stability,
- publish cadence,
- edge freshness,
- CDN compatibility,
- player support,
- clock budget,
- fallback readiness.

Correct decisions:

- quarantine bad ingest,
- re-encode invalid ladders,
- repair broken package/manifest,
- fall back from low latency to standard latency,
- block publish if media truth is undefined,
- emit validation receipts.

Senior answer:

> Quarantine is not failure. Quarantine is the platform refusing to publish a lie.

---

## Exercise 4 Solution: Multi-CDN as Control, Not Redundancy

A strong answer should explain that CDNs fail unevenly. They do not fail like a single database. One ISP in one metro may degrade. One POP may serve stale manifests. One device firmware cohort may hit a TLS or playback quirk. Global averages may remain green while a real cohort buffers every ten seconds.

Multi-CDN is not generic redundancy. It is a control plane. The platform should switch paths only when scoped evidence shows that a cohort is harmed and the alternate path is likely safer.

A safer multi-CDN design includes:

### 1. Scoped evidence

Measure CDN behavior by:

- ISP,
- metro/region,
- device class,
- player version,
- asset/live event,
- manifest version,
- segment/chunk fetch outcome,
- error type,
- QoE impact.

### 2. Canary switch

Start with a small affected cohort. Do not move all traffic immediately.

### 3. Hysteresis and cooldown

Prevent oscillation by requiring sustained improvement before expanding or reverting.

### 4. Max switches

Set max switches per session and per cohort. A viewer should not bounce repeatedly between CDNs.

### 5. Origin shielding

When CDNs wobble, the origin should not become the shock absorber. Use request collapsing, shield caches, retry budgets, and origin protection.

### 6. Replay receipt

Every material switch should emit a receipt with:

- playbackSessionId or cohort ID,
- old CDN,
- new CDN,
- trigger signal,
- evidence window,
- ISP/metro/device scope,
- manifest version,
- segment error profile,
- canary size,
- QoE before/after,
- cost impact,
- policy version,
- rollback path.

### 7. Freeze condition

If replay coverage is missing, freeze automated expansion. If you cannot explain why the switch occurred, do not expand it.

Senior answer:

> Multi-CDN does not mean “send traffic somewhere else.” It means controlled, scoped, auditable path switching with hysteresis, origin protection, and receipts.

---

## Exercise 5 Solution: Playback Control Ladder and ABR Governance

Playback is not just an app screen. It is a closed-loop control system at the edge. It senses throughput, segment fetch time, buffer depth, stall risk, device behavior, CDN path health, manifest freshness, ad state, DRM state, and QoE. Then it chooses the least harmful mode.

A good playback control ladder:

| Mode | Trigger | Behavior | Recovery |
|---|---|---|---|
| Normal ABR | Stable throughput, low stall rate. | Explore ladder for quality. | Continue. |
| Conservative ABR | Throughput volatility or segment timeouts rise. | Downshift earlier; avoid aggressive upshift. | Stable window required. |
| Buffer widen | Rebuffer risk rising. | Increase buffer target; reduce reload pressure. | Cooldown plus stable QoE. |
| CDN switch | Path-specific segment errors. | Switch scoped path with hysteresis. | Revert only after proof. |
| Rendition clamp | Device/network cohort unstable. | Clamp to stable rendition. | Gradual ladder restore. |
| Honest failure/refusal | DRM, manifest, entitlement, or unrecoverable playback failure. | Show precise reason. | Recheck only under policy. |

In the incident described, retrying harder is dangerous. Retries can amplify egress, origin load, ad delays, and frustration. ABR oscillation is a sign that the system is over-optimizing under uncertainty.

The player should:

1. Detect rising segment timeouts by cohort.
2. Enter conservative ABR.
3. Widen buffer target.
4. Clamp risky renditions.
5. Use controlled CDN switch if path-specific evidence exists.
6. Disable low-latency mode if clock evidence is no longer admissible.
7. Show honest failure if entitlement, manifest, DRM, or content proof is missing.

Receipts should be emitted for:

- ABR mode change,
- rendition clamp,
- CDN switch,
- buffer widening,
- low-latency disable,
- honest refusal/failure,
- recovery/re-enable event.

Recovery must be slow and evidence-based. The platform should not return to aggressive ABR after one successful segment. It should require stability windows, cooldowns, hysteresis, and replay coverage.

Senior answer:

> The player is not only trying to maximize bitrate. It is trying to minimize harm while keeping the experience defensible.

---

## Bonus Exercise 6 Solution: Live and Low-Latency Clock Contract

A senior answer should begin by saying that Live is not just faster VOD. Live is a clock contract. The platform is promising a relationship between reality and what the viewer sees.

Streaming clocks:

| Clock | Meaning | Design Rule |
|---|---|---|
| Event time | When reality happened at source. | Defines live truth. |
| Ingest time | When the platform received it. | Detects upstream delay and jitter. |
| Segment time | How reality was cut into chunks/partials. | Governs manifest and playback timing. |
| Playback time | What viewer is currently seeing. | Determines glass-to-glass latency and drift. |
| Policy time | Which latency mode is active. | Determines what the platform is allowed to claim. |

Low-latency mode is a mode boundary, not an aspiration. It should be active only when evidence proves the platform can maintain the contract.

Evidence required:

- publish cadence,
- partial segment stability,
- segment availability,
- encoder health,
- manifest freshness,
- CDN compatibility,
- player support,
- buffer depth,
- glass-to-glass latency,
- jitter budget,
- fallback readiness.

Fallback to standard latency when:

- partial segments are unstable,
- CDN path cannot serve reliably,
- player buffer underruns rise,
- manifest staleness increases,
- encoder cadence drifts,
- glass-to-glass latency exceeds budget,
- replay coverage is missing,
- low-latency mode oscillates.

Prevent oscillation by using:

- cooldowns,
- minimum stable windows,
- hysteresis,
- max mode changes per session/cohort,
- cohort-scoped rollout,
- explicit re-enable criteria.

Replay evidence should prove:

- viewer session,
- live event ID,
- active latency policy,
- event/ingest/segment/playback/policy times,
- measured latency,
- buffer state,
- CDN path,
- manifest version,
- mode transition,
- fallback reason,
- re-enable decision.

Senior answer:

> Low latency is not a tuning knob. It is a policy-bound promise about clocks. If the clock contract breaks, the honest move is standard latency, not pretending the stream is still live enough.

---

## Bonus Exercise 7 Solution: DRM, Entitlement, and Region Policy

The platform should not show **Playable** unless the full access proof chain is defensible.

Case 1: viewer is allowed by account tier but traveling in restricted region.  
The platform should refuse or provide rights-safe fallback because region rights are part of entitlement authority. Reason code: `REGION_NOT_ALLOWED`.

Case 2: viewer is in the correct region but exceeds concurrency limit.  
The platform should not grant a new session unless policy allows session replacement. Reason code: `CONCURRENCY_LIMIT_EXCEEDED`.

Case 3: viewer has entitlement but DRM provider fails.  
For protected content, entitlement alone is not enough. If lawful decryption cannot be granted, the platform should remediate, retry within budget, degrade only if rights-safe, or refuse precisely. Reason code: `DRM_LICENSE_UNAVAILABLE`.

Playable requires proof of:

- account entitlement,
- region,
- subscription tier,
- license window,
- device class,
- parental control posture,
- concurrency limit,
- manifest eligibility,
- DRM license, if applicable,
- policy bundle version,
- refusal or remediation path.

Issuing a DRM license creates liability because the platform has authorized decryption. It must be able to prove why access was allowed under policy at that time.

Remediation options:

- entitlement refresh,
- re-authentication,
- device verification,
- session replacement,
- rights-safe fallback,
- retry DRM within budget,
- precise refusal.

Replay evidence:

- playbackSessionId,
- viewer/account pseudonymous ID,
- asset/liveEventId,
- entitlementTokenId,
- region decision,
- device/concurrency decision,
- policyBundleVersion,
- manifestVersionId,
- drmLicenseId or refusal reason,
- support-safe reason code,
- appeal/support path.

Senior answer:

> Entitlement and DRM are not side checks. They are the authority boundary that determines whether the platform is allowed to say Playable.

---

## Bonus Exercise 8 Solution: Ads as Replayable Side Effects

Ads are side effects because they alter the viewer’s experience, advertiser delivery, measurement claims, consent posture, and revenue accounting. Once the system mints `adDecisionId`, it owns interruption, pacing, measurement, and fallback.

A safe ad strategy should include:

| Failure Shape | Safe Mode |
|---|---|
| Waterfall timeout | Shorter pod, house ad, or skip under policy. |
| SSAI origin stall | Switch insertion mode or serve slate. |
| CSAI SDK deadlock | Disable client ad path for device cohort. |
| Frequency-cap drift | Clamp ad load and emit receipt. |
| Measurement unavailable | Limited measurement path if policy allows. |
| Ad gate blocks content | Play content with degraded monetization if allowed. |

The system should not trap a viewer behind a broken ad gate when policy permits content playback under degraded monetization.

`adDecisionId` should be policy-pinned and include:

- playbackSessionId,
- consent state,
- ad eligibility,
- targeting class,
- frequency-cap state,
- ad pod plan,
- insertion mode: SSAI or CSAI,
- measurement mode,
- timeout budget,
- fallback path,
- revenue/measurement limitation reason.

Safe-mode decisions:

- shorten ad pod when waterfall latency exceeds budget,
- use house ad or slate if inventory is unavailable,
- switch SSAI/CSAI path if one insertion method fails,
- disable CSAI for a broken SDK cohort,
- clamp frequency if state is drifting,
- proceed with limited measurement only if allowed,
- play content without ad gate if monetization is degraded but content entitlement is valid.

Replay receipt should show:

- why the ad decision was made,
- which policy and consent state applied,
- which ad plan was attempted,
- what failed,
- which safe mode was selected,
- what the viewer saw,
- what advertiser measurement was or was not claimed.

Senior answer:

> Ads are experienced by the viewer and audited by advertisers. They must degrade safely, not deadlock the content experience.

---

## Bonus Exercise 9 Solution: Green Dashboards, Red Experience

This is not an uptime incident. It is an experience-defensibility incident.

The services are healthy, startup is fine globally, and APIs return 200s. But a real cohort is suffering. Global averages hide cohort pain because they flatten ISP, metro, device, player, CDN path, and manifest-specific issues.

HD being “green” can be a false claim if the viewer cohort is experiencing:

- frequent rebuffering,
- unstable bitrate,
- repeated downshift/upshift,
- segment timeout loops,
- ad stalls,
- live drift,
- support complaints.

Retries and quality rescue loops create cost:

- egress waste,
- origin pressure,
- compute and transcode waste,
- CDN cost,
- ad make-goods,
- support load,
- churn risk,
- trust damage.

Stop authority should fire for the affected cohort:

- clamp ABR ladder,
- widen buffer,
- freeze aggressive upswitch,
- canary-switch CDN with hysteresis,
- disable low-latency mode,
- downgrade or remove HD claim if not defensible,
- activate ad safe mode if ads contribute to stalls,
- freeze session grants if replay coverage is incomplete.

Replay evidence should reconstruct:

- playbackSessionId,
- device class,
- player version,
- metro/ISP,
- CDN route,
- manifest version,
- ABR timeline,
- segment fetch errors,
- buffer depth,
- rebuffer events,
- ad decisions,
- low-latency mode state,
- stop actions,
- QoE before and after intervention.

Re-enable criteria:

- cohort QoE back inside bounds,
- segment timeout baseline restored,
- CDN error rate stable,
- ABR oscillation reduced,
- replay coverage restored,
- low-latency evidence admissible,
- ad path stable,
- stop action and re-enable receipts emitted,
- owner approval or policy version recorded.

Senior answer:

> The platform did not go down. It stayed up and over-promised. That is why stop authority must govern experience claims, not just service health.

---

## Bonus Exercise 10 Solution: Senior Architect Streaming Defense

A mature answer should acknowledge that HLS/DASH, encoders, manifests, CDNs, and players are necessary, but incomplete. They do not define when the platform is allowed to make experience claims.

A senior answer starts like this:

> I am not designing only a media pipeline. I am designing a continuous-experience commitment engine.

Key defense points:

### Experience claims

Playable, Live, HD, Ad-supported, Downloaded, and Available in region are claims that require proof.

### Session-grant boundary

The moment the platform grants a playback session, it owns the experience. Everything after session grant must be replayable, throttled, and stoppable.

### Token chain

Use `playbackSessionId`, `entitlementTokenId`, `policyBundleVersion`, `manifestVersionId`, `drmLicenseId`, `segmentId`, `adDecisionId`, and QoE receipts.

### Ingest and package truth

Bad source truth creates downstream experience failure. The system should quarantine invalid media, not publish undefined playback.

### Multi-CDN control

CDN switching requires scoped evidence, canary expansion, hysteresis, cooldowns, origin shielding, and switch receipts.

### Playback governance

The player is a control loop. It should move from normal ABR to conservative ABR, buffer widen, CDN switch, rendition clamp, low-latency disable, or honest refusal.

### Low latency

Live is a clock contract. Low-latency mode should be active only when event, ingest, segment, playback, and policy clocks remain inside budget.

### Ads

Ads are side effects. `adDecisionId` must be policy-pinned, consent-aware, measurable, replayable, and safe to degrade.

### ROCS and stop authority

Reliability keeps playback from spiraling. Observability proves the session. Cost controls egress, retries, ad loops, and rescue behavior. Sustainability preserves trust through honest degradation and re-enable criteria.

### Replay

The platform must prove why a viewer played, buffered, switched CDN, dropped quality, saw ads, disabled low latency, or was refused under pinned policy and evidence.

Senior interview line:

> I would not frame streaming as upload, transcode, manifest, CDN, and player. I would frame it as a continuous-experience commitment engine. Playable is a claim, Live is a clock contract, HD is a proof obligation, ads are side effects, and session grant creates liability. I tokenize the session, pin entitlement and manifest policy, govern CDN, ABR, DRM, low-latency, and ads as control surfaces, and emit replay cards so the platform can defend the experience later.
