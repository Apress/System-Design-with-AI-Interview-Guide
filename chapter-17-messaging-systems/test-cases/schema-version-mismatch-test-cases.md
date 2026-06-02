# Schema Version Mismatch Test Cases

| Case | Change | Expected Behavior |
|---|---|---|
| Optional field added | Compatible | Continue with default. |
| Required field removed | Breaking | Quarantine. |
| Type changed | Breaking | Stop affected consumer. |
| Semantic meaning changed | Dangerous | Require version bump and review. |
