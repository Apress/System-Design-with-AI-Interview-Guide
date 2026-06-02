CREATE TABLE auction_replay_receipts (
    replay_receipt_id      VARCHAR(200) PRIMARY KEY,
    auction_id             VARCHAR(200) NOT NULL,
    close_commit_id        VARCHAR(200),
    receipt_type           VARCHAR(50) NOT NULL,
    policy_version         VARCHAR(100) NOT NULL,
    evidence_hash          VARCHAR(300) NOT NULL,
    receipt_json           TEXT NOT NULL,
    created_at             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_replay_auction ON auction_replay_receipts (auction_id);
CREATE INDEX idx_replay_close_commit ON auction_replay_receipts (close_commit_id);
