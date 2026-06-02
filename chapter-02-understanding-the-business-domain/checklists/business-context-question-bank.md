# Business Context Question Bank

Use these questions during the first part of a system design interview or architecture discovery session.

## Scope

- Are we designing the whole platform or one critical journey?
- Which user journey matters most for this discussion?
- What should be explicitly out of scope?

## Users and Actors

- Who are the primary actors?
- Which actors directly affect revenue, trust, risk, or operations?
- Are there internal actors such as support, operations, finance, compliance, or fraud teams?

## Business Goals

- What business metric is most important?
- Are we optimizing for conversion, cost, reliability, safety, speed, compliance, or growth?
- Which stakeholder would be unhappy if the system behaved incorrectly?

## Domain Entities

- What are the core entities?
- Which entities represent money, commitment, identity, or legal obligation?
- Which entity owns the truth for each important state?

## Scale and Geography

- How many users, requests, transactions, or events should we assume?
- Is traffic steady or bursty?
- Is the system regional, national, or global?

## Quality Attributes

- What must be low latency?
- What must be strongly consistent?
- What can be eventually consistent?
- What must be auditable?
- What must degrade safely?

## AI-Specific Discovery

- What should AI suggest, decide, or act on?
- What source of truth must AI consult before answering?
- What actions require policy checks or human approval?
- What evidence should be logged for replay?
- What is the fallback when AI confidence is low?
