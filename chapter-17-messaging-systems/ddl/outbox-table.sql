CREATE TABLE outbox_events (
    event_id             VARCHAR(200) PRIMARY KEY,
    business_txn_id      VARCHAR(200) NOT NULL,
    correlation_id       VARCHAR(200),
    producer             VARCHAR(100) NOT NULL,
    event_type           VARCHAR(100) NOT NULL,
    schema_version       VARCHAR(100) NOT NULL,
    policy_version       VARCHAR(100),
    aggregate_type       VARCHAR(100),
    aggregate_id         VARCHAR(200),
    payload_json         TEXT NOT NULL,
    created_at           TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    published_at         TIMESTAMP,
    publish_status       VARCHAR(30) NOT NULL CHECK (publish_status IN ('pending', 'published', 'failed', 'quarantined')),
    retry_count          INTEGER NOT NULL DEFAULT 0
);

CREATE INDEX idx_outbox_status_created ON outbox_events (publish_status, created_at);
CREATE INDEX idx_outbox_business_txn ON outbox_events (business_txn_id);
