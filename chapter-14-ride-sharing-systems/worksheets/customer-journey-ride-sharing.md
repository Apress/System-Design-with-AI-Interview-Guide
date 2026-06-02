# Customer Journey: Ride-Sharing

| Moment | Rider Believes | Driver Believes | Architecture Response |
|---|---|---|---|
| Quote | Price is explainable and time-bound. | Earnings are governed. | Pricing receipt. |
| Request | Platform is searching seriously. | A trip may appear. | Correlation ID and idempotency. |
| Hold | A driver may be assigned. | Offer is temporary. | matchHoldId with TTL. |
| Accept | Driver is likely mine. | Trip is becoming real. | Recheck gates. |
| Commit | This is my driver. | This is my trip. | matchId after admissibility. |
| Post-commit conflict | Disruption should be fair. | Lost time should be recognized. | Repair, reassign, compensate. |
