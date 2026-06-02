# Refund Replay Test Cases

| Case | Evidence | Expected Behavior |
|---|---|---|
| Low-value, clear delivery, settled payment | Complete | Auto approve and emit refundDecisionId. |
| High-value new account | Risky | Requires review. |
| Payment unclear | Ambiguous | Defer. |
| Policy recently changed | Needs pin | Apply pinned policy or review. |
