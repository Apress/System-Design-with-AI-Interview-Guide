# Semantic State Review Prompt

Review my system design for semantic-state risks.

Look for words such as available, held, reserved, pending, confirmed, settled, final, and approved.

For each word, tell me:
- What it appears to mean
- What it must mean architecturally
- What evidence is required
- Whether the user can act
- Whether AI or automation can say it
- What compensation path is needed if the state fails

Then rewrite the state model to make the language defensible.
