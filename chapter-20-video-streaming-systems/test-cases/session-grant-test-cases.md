# Session Grant Test Cases

| Case | Evidence | Expected Behavior |
|---|---|---|
| Full proof chain | Entitlement, manifest, DRM, policy, replay | Grant Playable. |
| Entitled but no manifest | Missing manifestVersionId | Refuse/remediate, no Playable. |
| Manifest valid but no DRM | Protected content | Refuse/remediate. |
| Replay missing | Proof incomplete | Freeze affected grant path. |
