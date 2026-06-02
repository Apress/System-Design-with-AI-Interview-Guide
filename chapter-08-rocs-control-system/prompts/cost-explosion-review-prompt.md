# ROCS Cost Explosion Review Prompt

Analyze my AI system for cost explosion risks.

Look for:

- Token drift
- Retrieval fan-out
- Agent loops
- Retry cascades
- Tool-call bursts
- Vector cold starts
- GPU queue buildup
- Autoscaling lag
- Manual cleanup after false success

Then define budgets for retries, tools, retrieval, tokens, latency at commit, evidence coverage, and model tiering.
