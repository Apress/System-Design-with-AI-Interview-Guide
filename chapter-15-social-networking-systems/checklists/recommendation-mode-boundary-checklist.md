# Recommendation Mode Boundary Checklist

Check:

- Profiling and non-profiling use different data paths
- Non-profiling bypasses behavioral feature store
- Allowed signal classes are explicit
- Disallowed signal classes are enforced
- Replay proves mode and feature bundle
- Mode leakage causes hard stop or safe fallback
