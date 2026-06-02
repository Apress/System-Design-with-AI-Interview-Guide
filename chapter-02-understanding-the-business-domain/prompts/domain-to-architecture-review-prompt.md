# Domain-to-Architecture Review Prompt

Use this prompt to review whether your design correctly follows from the business domain.

```text
Review my system design answer as a senior architect.

Check whether my architecture follows from the business domain instead of being a generic design.

Evaluate:
- Did I understand the primary actors?
- Did I identify the correct core entities?
- Did I map user journeys to capabilities?
- Did I distinguish customer-facing, operational, financial, AI-driven, and governance capabilities?
- Did I protect the main trust moment?
- Did I assign ownership of source-of-truth data correctly?
- Did I define AI authority boundaries clearly?
- Did I choose quality attributes based on the domain?
- Did I explain trade-offs in business language?

Give me:
1. A score out of 10
2. The strongest part of my domain reasoning
3. The weakest assumption
4. A sharper domain-to-architecture summary
5. Three improvements that would make the answer senior-level
```
