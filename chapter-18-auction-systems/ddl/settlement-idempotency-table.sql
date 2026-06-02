CREATE TABLE settlement_effects (
    settlement_effect_id      VARCHAR(300) PRIMARY KEY,
    settlement_intent_id      VARCHAR(200) NOT NULL,
    auction_id                VARCHAR(200) NOT NULL,
    close_commit_id           VARCHAR(200) NOT NULL,
    operation                 VARCHAR(50) NOT NULL,
    effect_status             VARCHAR(50) NOT NULL CHECK (effect_status IN ('in_progress', 'committed', 'failed', 'no_op', 'unknown')),
    provider_trace_id         VARCHAR(200),
    idempotency_key           VARCHAR(300) NOT NULL,
    amount                    DECIMAL(18, 2),
    currency                  VARCHAR(10),
    first_attempt_at          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_attempt_at           TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    committed_at              TIMESTAMP,
    replay_receipt_id         VARCHAR(200),
    failure_reason_code       VARCHAR(100),
    metadata_json             TEXT
);

CREATE UNIQUE INDEX idx_settlement_idempotency_key ON settlement_effects (idempotency_key);
CREATE INDEX idx_settlement_auction ON settlement_effects (auction_id);
