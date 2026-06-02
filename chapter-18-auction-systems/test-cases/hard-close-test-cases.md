# Hard Close Test Cases

| Case | Condition | Expected Behavior |
|---|---|---|
| Fixed close time reached | No late bids | Close commit. |
| Bid after hard cutoff | Too late | Exclude. |
| Sniping bid before close | Valid ingest | Count. |
| Close replay missing | No receipt | Freeze close/settlement. |
