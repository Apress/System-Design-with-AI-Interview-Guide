# Ownership and Accountability Review Prompt

Review my architecture and identify accountability gaps.

For each customer-visible promise, determine:

- Which capability owns the promise
- Which service owns the state
- Which service can commit the decision
- Which service owns customer messaging
- Which events prove the decision occurred
- What should be logged for replay
- Who owns recovery when the promise fails

Then rewrite the design to make ownership explicit.
