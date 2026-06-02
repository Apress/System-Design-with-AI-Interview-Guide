# Hard Delete Test Cases

| Case | Expected Behavior |
|---|---|
| Replay coverage missing | Freeze hard delete. |
| Policy mismatch | Quarantine/rollback. |
| Destruction proof missing | Do not claim hard deleted. |
| Key destruction with legal hold | Refuse. |
