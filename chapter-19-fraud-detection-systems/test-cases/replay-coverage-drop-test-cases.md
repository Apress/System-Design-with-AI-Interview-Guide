# Replay Coverage Drop Test Cases

| Case | Coverage | Expected Behavior |
|---|---:|---|
| Liability actions | 100% | Continue. |
| Refund denials | 99.9% | Freeze refundDenyId minting. |
| Payout holds | <100% | Route to review/step-up. |
| Hard blocks | <100% | Hard stop hardBlockId minting. |
