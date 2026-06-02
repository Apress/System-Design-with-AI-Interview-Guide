# eventId / businessTxnId / effectId Checklist

- eventId answers: what arrived?
- businessTxnId answers: which business story?
- effectId answers: which side effect?
- One event may produce multiple effectIds
- Duplicate delivery should produce NO_OP if effect committed
- Replay should use effectId, not eventId alone
