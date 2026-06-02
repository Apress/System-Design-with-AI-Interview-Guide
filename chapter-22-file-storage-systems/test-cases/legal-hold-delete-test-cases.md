# Legal Hold Delete Test Cases

| Hold Status | Delete Request | Expected Behavior |
|---|---|---|
| Active | hard delete | Refuse. |
| Unknown | hard delete | Defer/escalate. |
| Released + retention active | hard delete | Refuse/defer. |
| Released + retention clear | hard delete | Allow if policy/replay ready. |
