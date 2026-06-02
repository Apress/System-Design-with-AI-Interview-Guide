# Driver Decline Test Cases

| Case | Condition | Expected Behavior |
|---|---|---|
| Driver declines pre-hold | No liability | Try next candidate within budget. |
| Driver declines during hold | Hold released | Count attempt; redispatch within budget. |
| Repeated declines | Budget near limit | Conservative mode or assisted handling. |
| Decline after commit-like signal | State ambiguity | Verify actual commit; repair/reassign with evidence. |
