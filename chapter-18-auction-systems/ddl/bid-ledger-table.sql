CREATE TABLE bid_ledger (
    bid_id                  VARCHAR(200) PRIMARY KEY,
    auction_id              VARCHAR(200) NOT NULL,
    bidder_id               VARCHAR(200) NOT NULL,
    amount                  DECIMAL(18, 2) NOT NULL,
    currency                VARCHAR(10) NOT NULL,
    proxy_max_amount        DECIMAL(18, 2),
    event_time              TIMESTAMP NOT NULL,
    ingestion_time          TIMESTAMP NOT NULL,
    server_received_node    VARCHAR(100),
    bid_status              VARCHAR(50) NOT NULL,
    exclusion_reason_code   VARCHAR(100),
    policy_version          VARCHAR(100) NOT NULL,
    fraud_pressure_score    DECIMAL(8, 4),
    device_session_id       VARCHAR(200),
    payload_json            TEXT,
    created_at              TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_bid_ledger_auction_ingestion ON bid_ledger (auction_id, ingestion_time);
CREATE INDEX idx_bid_ledger_auction_amount ON bid_ledger (auction_id, amount DESC);
CREATE INDEX idx_bid_ledger_bidder ON bid_ledger (bidder_id);
