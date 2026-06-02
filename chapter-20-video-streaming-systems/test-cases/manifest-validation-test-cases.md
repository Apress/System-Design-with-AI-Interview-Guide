# Manifest Validation Test Cases

| Case | Problem | Expected Behavior |
|---|---|---|
| Missing captions | Required accessibility track missing | Quarantine or repair. |
| Irregular GOP cadence | Encode issue | Re-encode or block publish. |
| Segment timeline discontinuity | Package issue | Repair or fallback manifest. |
| Low-latency partial unstable | LL issue | Fall back to standard latency. |
