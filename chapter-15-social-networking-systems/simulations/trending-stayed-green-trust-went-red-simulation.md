# Simulation: Trending Stayed Green While Trust Went Red

## Setup

A topic enters Trending at 10:02. Engagement rises quickly. Latency is normal. Ranking service is healthy.

At 10:06, reports begin rising.
At 10:07, provenance confidence drops.
At 10:08, coordination likelihood crosses warning threshold.
At 10:09, replay coverage drops below required coverage for one amplification path.

## Questions

- Why is this a failure if feeds are fast?
- Which signal matters more than engagement?
- When should Trending freeze?
- What happens if replay coverage is below 100 percent?
- What receipt must be emitted?
- What is required before re-enable?

## Expected Controls

- Freeze Trending promotion
- Clamp resharing
- Disable broad notification fanout
- Route to review
- Preserve amplification replay cards
- Require policy owner re-enable
