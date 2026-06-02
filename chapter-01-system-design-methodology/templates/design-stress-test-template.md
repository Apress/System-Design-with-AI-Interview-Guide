# Design Stress-Test Template

Use this template during Step 7 of the seven-step system design method.

## Scale Stress

What happens at 10x traffic?

What bottleneck appears first?

What should be cached, queued, partitioned, or degraded?

## Failure Stress

Which dependency can fail?

What does the user see?

Does the system retry, degrade, queue, refuse, or escalate?

## Consistency Stress

Where can duplicate, stale, missing, or conflicting state appear?

What commitment boundary must be protected?

## Latency Stress

What is on the critical path?

What can move async?

What timeout budget should apply?

## Cost Stress

What cost grows fastest?

What should be budgeted, capped, cached, or tiered?

## AI Stress

Can AI overclaim, hallucinate, call the wrong tool, or act without authority?

What evidence is required before an AI-assisted response or action?

## Observability and Replay

Can we reconstruct what happened after the fact?

What correlation IDs, state transitions, tool calls, policy versions, and evidence snapshots should be recorded?
