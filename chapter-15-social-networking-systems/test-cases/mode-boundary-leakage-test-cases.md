# Mode-Boundary Leakage Test Cases

| Case | Active Mode | Leak | Expected Behavior |
|---|---|---|---|
| Non-profiling | non_profiling | Behavioral embedding used | Hard stop path and fallback. |
| Non-profiling | non_profiling | Watch history feature used | Block and emit incident receipt. |
| Profiling | profiling | Consent missing | Use non-profiling fallback. |
