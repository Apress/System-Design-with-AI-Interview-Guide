# Capability Map: Fraud

| Capability | Responsibility | Boundary | Owner |
|---|---|---|---|
| Intake | Receive events. | Raw event | Ingestion owner |
| Scoring | Advisory risk. | riskDecisionId | Model owner |
| Evidence Gate | Tier/freshness check. | Evidence snapshot | Policy owner |
| Step-up | Reversible proof. | stepUpChallengeId | Identity owner |
| Enforcement | Deny/hold/block. | enforcementId | Enforcement owner |
| Appeals | Challenge decision. | Appeal result | Appeals owner |
| Labels | Delayed truth. | Label link | Data/ML owner |
| Replay | Prove action. | Replay card | Governance |
| Stop Authority | Freeze unsafe path. | Stop event | Risk owner |
