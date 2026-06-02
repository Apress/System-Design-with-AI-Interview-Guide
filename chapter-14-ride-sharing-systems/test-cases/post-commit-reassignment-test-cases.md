# Post-Commit Reassignment Test Cases

| Case | Condition | Expected Behavior |
|---|---|---|
| ETA diverges but repair succeeds | Fresh signals converge | Keep match; honest ETA update. |
| Driver movement inconsistent | Repair fails | One controlled reassignment attempt. |
| Reassignment exceeds policy threshold | Platform-side disruption | Rider/driver compensation evaluation. |
| Redispatch cap spent | Continued conflict | Escalate or assisted handling. |
