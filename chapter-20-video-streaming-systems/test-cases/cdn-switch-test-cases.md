# CDN Switch Test Cases

| Case | Signal | Expected Behavior |
|---|---|---|
| Global CDN error | Broad | Canary switch with evidence. |
| ISP/metro only | Scoped pain | Scoped switch. |
| Origin pressure high | Risk | Freeze expansion, protect origin. |
| Oscillation detected | Repeated switches | Enforce cooldown/hysteresis. |
