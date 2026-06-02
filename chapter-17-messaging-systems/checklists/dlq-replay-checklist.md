# DLQ Replay Checklist

DLQ message must carry:

- Original payload
- eventId
- businessTxnId
- intended effectId
- schema version
- policy version
- consumer version
- failure class
- retry count
- timestamps
- evidence snapshot
- owner

Replay must be simulate-first.
