CREATE TABLE processed_effects (
    effect_id              VARCHAR(300) PRIMARY KEY,
    business_txn_id        VARCHAR(200) NOT NULL,
    event_id               VARCHAR(200) NOT NULL,
    correlation_id         VARCHAR(200),
    capability             VARCHAR(100) NOT NULL,
    status                 VARCHAR(30) NOT NULL CHECK (status IN ('IN_PROGRESS', 'COMMITTED', 'FAILED', 'NO_OP', 'UNKNOWN')),
    schema_version         VARCHAR(100) NOT NULL,
    policy_version         VARCHAR(100) NOT NULL,
    consumer_version       VARCHAR(100) NOT NULL,
    feature_flag_version   VARCHAR(100),
    evidence_snapshot_id   VARCHAR(200),
    external_call_id       VARCHAR(200),
    outcome_code           VARCHAR(100),
    error_class            VARCHAR(100),
    replay_card_id         VARCHAR(200),
    first_seen_at          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_attempt_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    committed_at           TIMESTAMP,
    expires_at             TIMESTAMP,
    metadata_json          TEXT
);

CREATE INDEX idx_processed_effects_business_txn ON processed_effects (business_txn_id);
CREATE INDEX idx_processed_effects_event ON processed_effects (event_id);
CREATE INDEX idx_processed_effects_status ON processed_effects (status);
