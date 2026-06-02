# Architecture Views Template

## 1. Context View

Question answered:
Who uses the system and what external systems does it depend on?

Include:
- Actors
- Channels
- External systems
- Trust boundaries

## 2. Service / Container View

Question answered:
What are the major deployable components or services?

Include:
- Service boundaries
- Owned data
- APIs
- Events
- Dependencies

## 3. Data Flow View

Question answered:
How does important state move through the system?

Include:
- Systems of record
- Read models
- Events
- Derived data
- Data freshness needs

## 4. Runtime Sequence View

Question answered:
What happens during the most important user journey?

Include:
- Request path
- Synchronous calls
- Asynchronous events
- State transitions
- User response

## 5. Failure / Degradation View

Question answered:
What happens when dependencies fail?

Include:
- Timeout behavior
- Retry behavior
- Fallback behavior
- Customer-visible state
- Escalation path

## 6. AI Trust and Evidence View

Question answered:
What is AI allowed to do, and what evidence does it use?

Include:
- AI capabilities
- Evidence sources
- Tool boundaries
- Model outputs
- Logging and replay
- Human escalation
