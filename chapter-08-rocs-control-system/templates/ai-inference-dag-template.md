# AI Inference DAG Template

## Capability

Capability name:
User request:
Business promise:

## DAG Nodes

| Node | Purpose | Reliability Risk | Observability Signal | Cost / Sustainability Risk |
|---|---|---|---|---|
| API Gateway |  |  |  |  |
| Planner |  |  |  |  |
| Retriever |  |  |  |  |
| Vector DB |  |  |  |  |
| Reranker |  |  |  |  |
| Prompt Builder |  |  |  |  |
| LLM Router |  |  |  |  |
| Model Call |  |  |  |  |
| Tool Call |  |  |  |  |
| Evaluator |  |  |  |  |
| Memory |  |  |  |  |
| Replay Logger |  |  |  |  |

## Critical Path

Which nodes are on the critical path?

## Retry Policy

Retry allowed:
Retry budget:
Backoff:
Single-flight needed?

## Budget Controls

Token budget:
Tool-call budget:
Retrieval fan-out budget:
Latency budget:
GPU queue budget:

## Degradation

What can be skipped?
What can be cached?
What can move async?
What must defer to pending?
