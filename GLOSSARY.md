# System Design with AI Interview Guide
## Official Companion Repository

> **The book is the masterclass. This repository is the practice lab.**
>
> The book teaches the full reasoning, chapter walkthroughs, trade-off narratives, and interview storytelling. This repository helps you practice that thinking through templates, prompts, rubrics, diagrams, and companion artifacts.

---

# Glossary

This glossary defines common acronyms and terms used across the book and repository. It is a quick reference. The book explains these terms in system context.

## Core System Design Terms

**API — Application Programming Interface**: A contract that allows software systems to communicate.

**SLA — Service Level Agreement**: A formal commitment, often contractual, about service availability or performance.

**SLO — Service Level Objective**: A target reliability or performance goal used internally to manage a service.

**RTO — Recovery Time Objective**: How quickly a system must recover after a failure.

**RPO — Recovery Point Objective**: How much data loss is acceptable after a failure.

**CQRS — Command Query Responsibility Segregation**: A pattern that separates write operations from read operations.

**DR — Disaster Recovery**: The strategy for recovering systems after major outages or disasters.

**HA — High Availability**: Designing systems to remain available despite failures.

**Idempotency**: The property that repeating the same operation produces the same intended result, preventing duplicate side effects.

**Backpressure**: A mechanism that prevents overwhelmed services from accepting more work than they can handle.

**Circuit Breaker**: A resilience pattern that stops calls to a failing dependency to prevent cascading failure.

**Saga**: A pattern for managing distributed transactions through a sequence of local transactions and compensating actions.

**Outbox Pattern**: A pattern that stores events in the same transaction as business data so messages can be reliably published later.

## Streaming Terms

**CDN — Content Delivery Network**: A distributed network of edge servers that serves content closer to users to reduce latency and improve scalability.

**ABR — Adaptive Bitrate Streaming**: A technique where the player switches between different video quality levels based on bandwidth, device capability, and buffer health.

**HLS — HTTP Live Streaming**: A streaming protocol that delivers video in small HTTP-based segments, widely used across devices.

**DASH — Dynamic Adaptive Streaming over HTTP**: An adaptive streaming standard that lets players select video quality from available segments.

**DRM — Digital Rights Management**: Technology that protects licensed content by controlling playback, decryption, downloading, and sharing.

**Manifest**: A playlist-like file that tells a video player which segments, bitrates, captions, and tracks are available.

**Transcoding**: Converting media into different formats, resolutions, or bitrates for different devices and networks.

**Egress**: Data transferred out of a cloud, storage, or CDN environment, often a major cost driver.

## AI Terms

**AI — Artificial Intelligence**: Software techniques that enable systems to perform tasks associated with reasoning, prediction, language, perception, or decision support.

**ML — Machine Learning**: A branch of AI where systems learn patterns from data.

**LLM — Large Language Model**: A model trained on large text corpora to generate, summarize, classify, or reason over language.

**RAG — Retrieval-Augmented Generation**: A pattern where a language model uses retrieved documents or data to ground its response.

**Embedding**: A numerical representation of text, image, or data that captures semantic meaning for search or comparison.

**Vector Database**: A database optimized for storing and searching embeddings.

**Graph Database**: A database that represents entities and relationships as nodes and edges.

**GraphRAG**: A retrieval approach that combines graph relationships with retrieval-augmented generation to improve context and explainability.

**Prompt Injection**: An attack where a user or document attempts to manipulate an AI system’s instructions or behavior.

**Reranking**: Reordering retrieved results to improve relevance before presenting them to a model or user.

**Token Budget**: The limit on how much text a model can process or generate, often affecting cost and latency.

## Cloud and Data Terms

**Kafka**: A distributed event streaming platform often used for high-throughput messaging and event pipelines.

**Cache Stampede**: A failure mode where many requests hit the backend at once after cached data expires.

**Hot Key**: A key or partition receiving disproportionate traffic, causing imbalance.

**Sharding**: Splitting data across multiple partitions or nodes to improve scale.

**Replication**: Copying data across nodes or regions for availability, durability, or performance.

**Eventual Consistency**: A consistency model where replicas may temporarily differ but converge over time.

More terms can be added as the repository evolves.
