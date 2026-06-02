# ROCS Control Loop Worksheet

| ROCS Dimension | Signal | Threshold | Action | Owner | Feedback Update |
|---|---|---|---|---|---|
| Reliability | Duplicate side effects | > baseline | Freeze action + reconcile | Domain owner | Idempotency policy |
| Observability | Missing replay cards | > 0 for high-risk | Stop commitment | Governance owner | Receipt path fix |
| Cost | Retry/fan-out cost spike | > budget | Clamp retries/fan-out | Platform owner | Churn policy |
| Sustainability | Support escalations | rising | Degrade/human review | Ops owner | Threshold update |
