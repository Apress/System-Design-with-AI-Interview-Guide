# Canonical Truth vs AI Derivatives Worksheet

| Artifact | Canonical? | Derivative? | Required Lineage | Invalidation |
|---|---|---|---|---|
| Source document version | Yes | No | sourceId/sourceVersion | Never overwritten. |
| Structured source record | Yes | No | record version | Source update. |
| Extracted text | No | Yes | sourceVersion/parser | Source or parser change. |
| Chunk | No | Yes | sourceVersion/chunk policy | Source or policy change. |
| Embedding | No | Yes | chunk/model version | Source/model change. |
| Summary | No | Yes | source/model/prompt | Source/prompt change. |
| Query rewrite | No | Yes | original query/model | Model/config change. |
| Generated answer | No | Yes | citations/model/prompt/policy | Citation/source/policy change. |
