# Marketplace Instability Simulation

## Scenario

A city event creates rapid rider demand in two adjacent zones. Driver supply is adequate on paper, but driver GPS becomes stale, traffic changes quickly, and driver acceptance drops.

## Signals

| Signal | Normal | Stress |
|---|---:|---:|
| Rematch rate | 1–2% | 6–8% |
| Hold expiry | < 3% | 12% |
| Driver GPS hard-stale | < 1% | 9% |
| Driver acceptance | 72% | 55% |
| Replay coverage | 99.9% | 98.5% |

## Questions

- Which threshold fires first?
- Which posture change is safest?
- What user-visible state should riders see?
- What happens to pricing?
- How do you prove recovery?
