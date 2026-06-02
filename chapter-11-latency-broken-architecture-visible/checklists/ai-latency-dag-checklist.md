# AI Latency DAG Checklist

Budget and trace:

- Planner latency
- Retrieval fan-out
- Vector search latency
- Reranking
- Prompt construction
- Model queue
- Token generation
- Tool calls
- Evaluator loops
- Memory writes
- Replay/logging

Controls:

- Retrieval budget
- Token budget
- Tool-call budget
- Loop cap
- Model-tier routing
- GPU queue telemetry
- Streaming
- Defer/escalate behavior
