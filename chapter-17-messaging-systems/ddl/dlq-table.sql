CREATE TABLE dlq_messages (
    dlq_message_id        VARCHAR(200) PRIMARY KEY,
    event_id              VARCHAR(200) NOT NULL,
    business_txn_id       VARCHAR(200) NOT NULL,
    intended_effect_id    VARCHAR(300),
    schema_version        VARCHAR(100),
    policy_version        VARCHAR(100),
    consumer_version      VARCHAR(100),
    failure_class         VARCHAR(100) NOT NULL,
    retry_count           INTEGER NOT NULL DEFAULT 0,
    first_failed_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_attempt_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    evidence_snapshot_id  VARCHAR(200),
    replay_eligibility    VARCHAR(50) NOT NULL,
    owner                 VARCHAR(100) NOT NULL,
    payload_json          TEXT NOT NULL,
    failure_details_json  TEXT
);

CREATE INDEX idx_dlq_owner ON dlq_messages (owner);
CREATE INDEX idx_dlq_failure_class ON dlq_messages (failure_class);
