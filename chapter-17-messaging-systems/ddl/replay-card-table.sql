CREATE TABLE messaging_replay_cards (
    replay_card_id        VARCHAR(200) PRIMARY KEY,
    correlation_id        VARCHAR(200) NOT NULL,
    chain_id              VARCHAR(200),
    event_id              VARCHAR(200) NOT NULL,
    business_txn_id       VARCHAR(200) NOT NULL,
    effect_id             VARCHAR(300) NOT NULL,
    capability            VARCHAR(100) NOT NULL,
    schema_version        VARCHAR(100) NOT NULL,
    policy_version        VARCHAR(100) NOT NULL,
    consumer_version      VARCHAR(100) NOT NULL,
    evidence_snapshot_id  VARCHAR(200),
    outcome_code          VARCHAR(100) NOT NULL,
    card_json             TEXT NOT NULL,
    created_at            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_replay_effect ON messaging_replay_cards (effect_id);
CREATE INDEX idx_replay_business_txn ON messaging_replay_cards (business_txn_id);
