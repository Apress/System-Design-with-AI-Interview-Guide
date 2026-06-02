CREATE TABLE payment_idempotency (
  effect_id VARCHAR(300) PRIMARY KEY,
  effect_type VARCHAR(50) NOT NULL,
  business_entity_id VARCHAR(200) NOT NULL,
  payment_intent_id VARCHAR(200),
  auth_id VARCHAR(200),
  liability_token_id VARCHAR(200),
  amount DECIMAL(18,2),
  currency VARCHAR(10),
  idempotency_state VARCHAR(50) NOT NULL CHECK (idempotency_state IN ('IN_PROGRESS','COMMITTED','FAILED','PENDING_RECONCILE','NO_OP_ALREADY_COMMITTED','COMPENSATED')),
  provider_request_id VARCHAR(200),
  provider_response_id VARCHAR(200),
  provider_reference VARCHAR(200),
  ledger_entry_id VARCHAR(200),
  replay_card_id VARCHAR(200),
  ambiguity_classification VARCHAR(100),
  policy_version VARCHAR(100) NOT NULL,
  schema_version VARCHAR(100) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  committed_at TIMESTAMP
);
CREATE INDEX idx_payment_idempotency_business_entity ON payment_idempotency (business_entity_id);
CREATE INDEX idx_payment_idempotency_state ON payment_idempotency (idempotency_state);
