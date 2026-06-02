# Customer Journey: Fraud

| Moment | User/Seller Believes | Risk | Response |
|---|---|---|---|
| User acts | Action should proceed. | Fraud or legitimate. | Intake. |
| Scored | Platform evaluates risk. | Model overconfidence. | riskDecisionId advisory. |
| Evidence checked | Real facts used. | Stale/conflicting evidence. | Evidence-tier gate. |
| Step-up | Can prove legitimacy. | Excess friction. | stepUpChallengeId. |
| Enforcement | Denied/held/blocked. | False enforcement. | enforcementId + replay. |
| Appeal | Challenge allowed. | No proof. | Appeal review + replay. |
| Label arrives | Truth learned. | Retro-justification. | Link label, do not rewrite. |
