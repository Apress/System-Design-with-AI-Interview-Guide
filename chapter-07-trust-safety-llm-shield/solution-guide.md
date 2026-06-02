# Chapter 7 Solution Guide

## Exercise 1 Solution: LLM-SHIELD Warm-Up

A strong answer should define the capability across the full lifecycle:

- Scope: unacceptable failures, non-negotiables, attack surface
- Harden: versioned prompts, policies, guardrails, tests, and rollback
- Isolate: admissible evidence, scoped retrieval, memory boundaries, tool boundaries
- Empower: autonomy level, permission gates, confidence thresholds, approval requirements
- Live-Defend: AI firewall, anomaly detection, safety metrics, replay, kill switch
- Demonstrate: scorecards, red-team/blue-team loops, governance evidence, maturity roadmap

## Exercise 2 Solution: Scope and Unacceptable Failures

A strong scope should avoid vague language like “the agent helps customers.”

Better scope examples:

- No financial transaction without confirmed evidence
- No order modification after fulfillment picking begins
- No policy answer without active policy version
- No high-risk address change without human review
- No customer-visible commitment without replayable evidence

## Exercise 3 Solution: Prompt and Policy Hardening

A strong answer should treat prompts and policies as production assets.

Required controls:

- Version control
- Code review
- Owner and effective date
- Regression tests
- Golden conversations
- Jailbreak and adversarial tests
- Canary release
- Rollback path
- Production monitoring

## Exercise 4 Solution: Retrieval and Tool Isolation

A strong answer should define admissible evidence.

For order modification:

- Authoritative: order system, payment system, ERP, WMS, fulfillment status, active policy version
- Explanatory: support articles, FAQs, policy descriptions
- Non-authoritative: conversation history, stale CRM notes, unverified documents

When sources conflict, route to deterministic check, defer, or escalate. Do not let the model average conflicting truths.

## Exercise 5 Solution: Autonomy and Empowerment

A strong answer should treat autonomy as a budget.

Example classification:

- Observe only: classify, summarize, monitor
- Suggest: recommend refund path, draft customer email
- Act with approval: queue refund, address change, cancellation for review
- Bounded autonomy: low-risk reversible action with evidence and thresholds
- Restricted: high-value refunds, fraud-sensitive changes, post-fulfillment modifications

## Exercise 6 Solution: Runtime Defense

A strong Live-Defend architecture should include:

- AI firewall for prompt injection, jailbreaks, leakage, unsafe outputs
- Runtime policy engine that can allow, block, redact, escalate, or rephrase
- Semantic anomaly detection
- AI observability for prompts, models, RAG evidence, tool calls, and safety metrics
- SIEM/SOC integration
- Kill switch and session replay
- Metrics beyond uptime and latency

## Exercise 7 Solution: Demonstrate and Prove Controls

A strong answer should include:

- Threat coverage mapped to controls
- Test evidence for prompt injection, jailbreak, vector poisoning, retrieval, and tool abuse
- Runtime evidence: guardrail hits, blocked actions, escalations, replay coverage
- Governance evidence: owners, approvals, policy versions, exceptions, risk acceptances
- Improvement evidence: findings converted into tests, guardrails, and playbooks

## Exercise 8 Solution: Senior Architect Design Review

A strong review should challenge:

- What must never happen?
- Are prompts, policies, guardrails, retrieval rules, and tools versioned?
- Which evidence is admissible?
- Which tool actions are allowed?
- What autonomy level applies to each action?
- What runtime signals reveal silent failure?
- What scorecard proves controls still work?

The strongest design decision to defend is usually: no AI-involved state-changing action without scoped evidence, bounded autonomy, runtime defense, and replayable proof.
