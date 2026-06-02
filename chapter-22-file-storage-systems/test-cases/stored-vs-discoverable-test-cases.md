# Stored vs Discoverable Test Cases

| Case | Write | Index | Expected Behavior |
|---|---|---|---|
| Write complete, index pending | yes | no | Stored-not-discoverable. |
| Write complete, index fresh | yes | yes | Discoverable. |
| Index stale | yes | stale | Truth-first mode. |
| Index says public, source says private | yes | conflict | Source metadata wins. |
