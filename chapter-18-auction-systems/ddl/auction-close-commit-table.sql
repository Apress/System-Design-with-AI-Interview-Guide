CREATE TABLE auction_close_commits (
    close_commit_id              VARCHAR(200) PRIMARY KEY,
    auction_id                   VARCHAR(200) NOT NULL UNIQUE,
    winner_bidder_id             VARCHAR(200),
    winning_bid_id               VARCHAR(200),
    clearing_price               DECIMAL(18, 2),
    currency                     VARCHAR(10),
    close_policy_version         VARCHAR(100) NOT NULL,
    price_formation_policy       VARCHAR(100),
    fraud_pressure_score         DECIMAL(8, 4),
    reserve_met                  BOOLEAN,
    tie_breaker_applied          BOOLEAN,
    admissible_bid_count         INTEGER NOT NULL,
    close_status                 VARCHAR(50) NOT NULL,
    committed_at                 TIMESTAMP NOT NULL,
    replay_receipt_id            VARCHAR(200),
    close_evidence_hash          VARCHAR(300) NOT NULL
);

CREATE INDEX idx_close_commits_status ON auction_close_commits (close_status);
CREATE INDEX idx_close_commits_committed_at ON auction_close_commits (committed_at);
