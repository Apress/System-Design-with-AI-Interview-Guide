-- reconciliation-state-table
CREATE TABLE reconciliation_state_table (id VARCHAR(200) PRIMARY KEY, effect_id VARCHAR(300), status VARCHAR(80), receipt_json TEXT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
