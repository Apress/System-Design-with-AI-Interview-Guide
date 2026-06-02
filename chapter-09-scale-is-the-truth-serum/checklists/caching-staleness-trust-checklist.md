# Caching, Staleness, and Trust Checklist

For every cached value, classify:

- Advisory
- Provisional
- Committed

Then decide:

- Cache friendly
- Cache carefully
- Do not casually cache

Ask:

- What is the TTL?
- How is it invalidated?
- Is revalidation required?
- Can stale data break trust?
- What does the user see when freshness is uncertain?
