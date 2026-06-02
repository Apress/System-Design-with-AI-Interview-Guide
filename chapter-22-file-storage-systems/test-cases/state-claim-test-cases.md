# State Claim Test Cases

| Case | Evidence | Expected Claim |
|---|---|---|
| Version + write receipt exists | writeReceiptId present | Stored. |
| No index receipt | index missing | Stored, not Discoverable. |
| Legal hold active | legalHoldId active | Retained/delete blocked. |
| Delete receipt soft mode | soft delete | Deleted but recoverable in window. |
| Restore receipt exists | restore verified | Recoverable. |
