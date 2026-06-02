# Auction Readiness Checklist

Before launch, confirm:

- Close policy is pinned
- Bid ledger is append-only
- Bid received vs bid admissible are separate
- Server-controlled time is authoritative
- Hard/soft close behavior is explicit
- Proxy/increment/reserve rules are replayable
- Fraud pressure can change close posture
- closeCommitId is unique per auctionId
- Settlement is idempotent
- Stop authority can freeze close/settlement
- Replay receipts are mandatory
