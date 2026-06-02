# Chapter 20 Exercises

## Exercise 1: Streaming as a Continuous-Experience Commitment Engine

A candidate says, “A video streaming system stores videos, encodes them into multiple bitrates, serves manifests through a CDN, and plays them in the app.”

Why is that incomplete?

Your answer should include:

- Why streaming is a continuous-experience commitment engine, not only a media pipeline
- Why **Playable** is a claim, not a UI label
- Why “session started” is not the same as “experience defensible”
- Which actors are affected: viewer, player, device, entitlement system, DRM provider, CDN, ad system, licensor, advertiser, support, and platform operator
- What evidence must exist before the platform can claim Playable, HD, Live, Ad-supported, or Available in this region
- What must be replayable later when a viewer says the session buffered, dropped quality, showed broken ads, switched CDN, or was blocked

## Exercise 2: Playback Token Chain and Session-Grant Boundary

Design the token chain for a streaming session using `playbackSessionId`, `entitlementTokenId`, `policyBundleVersion`, `manifestVersionId`, `drmLicenseId`, `segmentId` / `chunkId`, and `adDecisionId`.

Your answer should include:

- What each token proves
- Why `playbackSessionId` is not just a request ID
- Why session grant is the liability boundary
- Why entitlement, manifest, DRM, segment, and ad proof must be tied to the same session envelope
- What happens if entitlement proof is present but manifest or DRM proof is missing
- What refusal or degradation reason should be emitted when proof is incomplete
- What the Streaming Decision Replay Card should contain

## Exercise 3: Ingest, Encode, and Package as Truth Gates

A team wants to publish media as soon as encoding completes, even if caption tracks are missing, GOP cadence is irregular, or low-latency partial segments are unstable.

Analyze this design.

Your answer should include:

- Why streaming truth begins at ingest
- Why bad ingest becomes downstream buffering, caption drift, missing tracks, and non-defensible playback
- What must be proven at ingest: source receipt, decodable tracks, monotonic timestamps, audio/video presence, caption availability
- What must be proven at encode: ABR ladder version, codec/rendition availability, GOP cadence, device compatibility
- What must be proven at package: `manifestVersionId`, segment timeline, DRM packaging, ad markers, cache rules
- Why low-latency mode requires stricter evidence
- When to quarantine, re-encode, repair, fall back to standard latency, or block publish

## Exercise 4: Multi-CDN as Control, Not Redundancy

A streaming service uses multiple CDNs and switches traffic automatically when one CDN shows elevated global errors. After the switch, origin load spikes, some viewers oscillate between paths, and one ISP/metro/device cohort still buffers.

Design a safer multi-CDN control plane.

Your answer should include:

- Why CDN failures are uneven by ISP, metro, device, manifest, and segment behavior
- Why global averages can hide cohort pain
- Why multi-CDN is a control system, not generic redundancy
- How to use scoped evidence before switching
- Why canary switching, hysteresis, cooldowns, and max switches per session/cohort matter
- How origin shielding and request collapsing prevent origin stampedes
- What a CDN-switch receipt should capture
- When automated switching should freeze because replay coverage is incomplete

## Exercise 5: Playback Control Ladder and ABR Governance

A viewer session starts normally, but segment fetch timeouts rise for one device cohort. The player keeps retrying, ABR oscillates, quality jumps up and down, buffer collapses, and support tickets spike.

Design the player control ladder.

Your answer should include:

- Why playback is a closed-loop control system, not just an app screen
- When to use normal ABR
- When to shift to conservative ABR
- When to widen buffer
- When to switch CDN
- When to clamp rendition
- When to show honest failure or precise refusal
- Why recovery must use cooldowns, stability windows, and hysteresis
- What receipts must be emitted for quality changes, CDN switches, clamps, and refusal

---

# Bonus GitHub Exercises

## Bonus Exercise 6: Live and Low-Latency Clock Contract

An interviewer asks, “How would you design low-latency live streaming?”

Give a senior answer.

## Bonus Exercise 7: DRM, Entitlement, and Region Policy

A viewer is allowed by account tier but is traveling in a restricted region. Another viewer is in the right region but exceeds the concurrency limit. A third viewer has entitlement but the DRM provider fails.

Should the platform show **Playable**?

## Bonus Exercise 8: Ads as Replayable Side Effects

An ad waterfall times out. The SSAI path stalls for a cohort. A CSAI SDK deadlocks on one device class. Frequency-cap state is drifting, and measurement is partially unavailable.

Design the ad safe-mode strategy.

## Bonus Exercise 9: Incident Response — Green Dashboards, Red Experience

Global startup time is healthy, API success rates are green, and sessions start. But one device cohort in two metros experiences buffering every ten seconds. Segment retries stack up, ABR oscillates, ad make-goods rise, and support tickets spike.

Analyze the incident.

## Bonus Exercise 10: Senior Architect Streaming Defense

An interviewer says, “Video streaming is straightforward: upload videos, transcode to multiple bitrates, generate HLS/DASH manifests, put segments on a CDN, and build a player.”

Defend a more mature design.
