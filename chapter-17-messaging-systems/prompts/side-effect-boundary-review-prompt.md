# Side-Effect Boundary Review Prompt

Review my messaging design.

Find the side-effect boundary. Check whether it has:

- deterministic effectId
- durable idempotency
- schema/policy versions
- evidence snapshot
- retry budget
- ordering check
- replay card
- stop authority

Then rewrite the design as a safer side-effect commitment flow.
