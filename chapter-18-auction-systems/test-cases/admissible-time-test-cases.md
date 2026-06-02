# Admissible Time Test Cases

| Case | Event Time | Ingestion Time | Expected Behavior |
|---|---|---|---|
| Bid before close | before close | before close | Count if otherwise valid. |
| Client before close, ingested late window | before close | within late window | Count only if policy allows. |
| Client before close, ingested after hard cutoff | before close | after hard cutoff | Reject. |
| Clock skew exceeded | uncertain | uncertain | Delay/freeze/review. |
