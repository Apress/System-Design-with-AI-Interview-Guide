# Interactive Challenges and Practice Drills

Use this guide alongside *System Design with AI Interview Guide* by Rohit Bhardwaj. Start with a prediction, test one decision, inspect the evidence, and revise. The book provides the full explanations; these activities help you practice.

[Back to the repository](README.md) · [Chapter map](BOOK-CODE-MAP.md) · [Copy a scorecard](CHALLENGE-SCORECARD.md)

## Live Interactive Practice

[AI Architect Circle](https://www.aiarchitectcircle.com/) hosts browser-based learning activities. Choose a scenario, then return to the linked chapter exercises to explain the architecture in your own words.

| Activity | What you practice | Related repository exercises | Access |
|---|---|---|---|
| [Challenge 1: The Refund That Disappeared](https://www.aiarchitectcircle.com/challenge-one.html) | Lost replies, duplicate refunds, idempotency, bounded retries, and recovery ownership | [Ch. 12: Failure](chapter-12-failure-is-a-system-behavior/exercises.md), [Ch. 21: Payments](chapter-21-payment-systems/exercises.md) | Free with sign-in and a confirmed AI Architecture Brief subscription |
| [Challenge 2: Save the Ticket Launch](https://www.aiarchitectcircle.com/challenges/save-ticket-launch) | Competing reservations, lease fencing, late payments, and unsupported AI confirmations | [Ch. 10: Consistency](chapter-10-consistency-is-a-trust-contract/exercises.md), [Ch. 16: E-commerce](chapter-16-e-commerce-systems/exercises.md) | Requires an active Founding Learner Pass and confirmed Brief subscription; see the live page for eligibility |
| [Challenge 3: The Request That Should Have Failed](https://www.aiarchitectcircle.com/challenges/cloudflare-isolation) | Tenant isolation, serving boundaries, and evidence for a repaired retrieval/LLM application | [Ch. 7: Trust and safety](chapter-07-trust-safety-llm-shield/exercises.md), [Ch. 23: Search](chapter-23-search-engine-systems/exercises.md) | Free subscriber lab with a confirmed Brief subscription |
| [System design and AI quizzes](https://www.aiarchitectcircle.com/quizzes) | Choose an answer, reveal the reasoning, and reconsider it under a changed constraint | [Ch. 9: Scale](chapter-09-scale-is-the-truth-serum/exercises.md), [Ch. 6: AI primitives](chapter-06-ai-architecture-primitives/exercises.md) | [Public samples](https://www.aiarchitectcircle.com/quizzes#sample) need no account; full quizzes require a confirmed Brief subscription |

The live pages describe current availability and participation terms. You can complete every repository drill below without signing in or subscribing.

## Repository Drills

Allow 15–30 minutes per drill. Write your answer before opening the hints. Each scenario is a teaching exercise with stated assumptions; change an assumption and defend the resulting design.

### Drill 1: The Reply Was Lost

**Scenario:** An assistant is authorized to refund $45 once. The provider commits the refund, but the reply is lost. A worker restarts and receives the same task. The fictional provider deduplicates requests with the same key for 24 hours and offers a status lookup that may lag.

**Your task:**

- Draw the states and transitions for the refund, including an unresolved outcome.
- Define the stable operation identity, where it is persisted, and who owns recovery.
- Show the customer message after the timeout.
- Explain how recovery changes if the task returns after 25 hours.

**Use:** [Idempotency review](chapter-21-payment-systems/templates/idempotency-review-template.md) and [ambiguous-outcome review](chapter-21-payment-systems/templates/ambiguous-outcome-review-template.md).

<details>
<summary>Hint: separate the business action from the delivery attempt</summary>

A worker restart creates another delivery attempt, not another authorized refund. Which durable record lets the new worker discover the original intent, key, and provider reference? A missing or delayed lookup result is not proof that the provider did nothing.

</details>

<details>
<summary>Review your answer after attempting the drill</summary>

- Reuse the persisted identity for the same business operation within the provider's documented deduplication contract.
- Treat a timeout as an unknown outcome. Avoid a new key merely to make the retry succeed.
- Bound retries and status checks; assign an owner and an escalation path for unresolved work.
- After the deduplication window, require authoritative reconciliation or review before any action that could repeat the effect.
- Show the customer a pending/review state until evidence supports a final outcome.

**Change the constraint:** Two workers recover the task simultaneously. Identify what serializes the recovery decision and what the provider still needs to guarantee.

</details>

### Drill 2: One Seat, Two Confirmations

**Scenario:** Two customers see the last seat as available. Holds expire after two minutes. Customer A's payment result arrives after the hold expires and Customer B has acquired the seat. An AI assistant is about to tell both customers that their booking is confirmed.

**Your task:**

- Name the authority for inventory and the atomic operation that settles ownership.
- Show how a stale hold is prevented from confirming the seat.
- Define how to handle the late payment and duplicate webhook delivery.
- State the evidence required before the assistant can say "confirmed."

**Use:** [Checkout hold-to-commit flow](chapter-16-e-commerce-systems/templates/checkout-hold-to-commit-flow-template.md) and [consistency contract](chapter-10-consistency-is-a-trust-contract/templates/consistency-contract-template.md).

<details>
<summary>Hint: a payment event does not grant inventory ownership</summary>

A cached availability view helps browsing. It does not settle competing claims. Show which authoritative write checks the current hold owner, version, and expiry. Then handle payment and inventory as separate facts.

</details>

<details>
<summary>Review your answer after attempting the drill</summary>

- Make the ownership transition atomic at the inventory authority.
- Reject a stale holder using an authority-checked version or fencing token; a timer in a worker is insufficient.
- Deduplicate payment events and reconcile late success without revoking another customer's valid reservation.
- Define a compensation or review path when payment succeeds but inventory cannot be committed.
- Generate confirmation only from an authoritative booking commitment. Preserve a pending or failed state otherwise.

**Change the constraint:** The inventory authority is unavailable during a launch. Explain which browsing functions can continue and which commitments must wait.

</details>

### Drill 3: The Answer Crossed a Tenant Boundary

**Scenario:** A support assistant serves Tenant A and Tenant B. Each request carries an authenticated tenant identity, but a shared response cache uses only the question text as its key. Tenant B asks the same question as Tenant A and receives an answer containing A's private document excerpt.

**Your task:**

- Draw the trust boundaries across identity, retrieval, cache, and answer generation.
- Define where tenant and document permissions are enforced.
- Write a negative test that would have caught the leak.
- Explain how permission revocation affects cached answers and citations.

**Use:** [Zero Trust retrieval-augmented generation (RAG) isolation template](chapter-07-trust-safety-llm-shield/templates/zero-trust-rag-isolation-template.md) and [AI-answer review](chapter-23-search-engine-systems/templates/ai-answer-review-template.md).

<details>
<summary>Hint: a prompt cannot enforce a cache boundary</summary>

The request may bypass the model entirely on a cache hit. Start with the authenticated identity and follow every path that can return protected content, including citations and tool results.

</details>

<details>
<summary>Review your answer after attempting the drill</summary>

- Derive tenant context from authenticated identity and enforce authorization in retrieval and serving code.
- Scope cached content to the relevant tenant and authorization context; a tenant ID alone may not cover different permissions within one tenant.
- Revalidate access or invalidate affected entries when permissions change. Apply the same rules to excerpts, citations, and tool results.
- Test identical queries across tenants and across users with different permissions, both on cold and warm caches.
- Record enough evidence to diagnose the boundary failure without copying sensitive content into unrestricted logs.

**Change the constraint:** A document becomes private after an answer is cached. Demonstrate that an unauthorized user cannot receive either the excerpt or its citation.

</details>

## Make Practice Repeatable

1. Copy the [challenge scorecard](CHALLENGE-SCORECARD.md) into your own notes or fork.
2. Save your prediction and first design before reading the hints.
3. Record the observed result from a lab, or the expected trace for a paper exercise.
4. Revise one decision and explain the trade-off.
5. Use the full [interview rubric](INTERVIEW-RUBRIC.md) after a complete mock interview.

For a pair session, alternate between designer and reviewer. The reviewer changes one constraint; the designer updates the states, authority, and evidence rather than only adding more components.

## Watch, Discuss, and Continue

- [YouTube — @AIArchitectCircle](https://www.youtube.com/@AIArchitectCircle): walkthroughs, workshops, and short explanations. Pause before the answer and compare your reasoning afterward.
- [Instagram — @aiarchitectcircle](https://www.instagram.com/aiarchitectcircle/).
- [Live sessions](https://www.aiarchitectcircle.com/live.html): bring a diagram, a trace, and a specific trade-off question.
- [All challenges](https://www.aiarchitectcircle.com/challenges) and [quizzes](https://www.aiarchitectcircle.com/quizzes): return for additional practice.
- Found a broken link or want to contribute a concise exercise? Follow the [contribution guide](CONTRIBUTING.md).
