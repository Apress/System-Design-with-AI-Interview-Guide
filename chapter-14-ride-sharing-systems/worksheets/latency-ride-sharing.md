# Latency: Ride-Sharing

| Moment | Behavior | Control |
|---|---|---|
| Request delay | Rider cancels or taps again. | Idempotency and honest search state. |
| Driver offer delay | Driver ignores/rejects. | Offer TTL. |
| Commit delay | Uncertainty rises. | Commit budget. |
| ETA jitter | Confidence drops. | ETA confidence band. |
| Post-commit repair delay | Support contact. | Repair window and replay. |
