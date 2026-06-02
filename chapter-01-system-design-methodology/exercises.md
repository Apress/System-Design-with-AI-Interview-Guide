# Chapter 1 Exercises: The Seven-Step System Design Method

These exercises are designed for interview practice. Try answering each question aloud first, then write your answer using the seven-step method.

## 1. The Seven-Step Warm-Up Question

You are asked to design an online food delivery system like DoorDash or Uber Eats.

Before drawing the architecture, walk through the seven-step system design method. For each step, write one or two questions you would ask or one decision you would make.

Your answer should cover:

- Requirements and constraints
- Domain and users
- Customer journey
- Business capabilities
- High-level architecture
- Critical component deep dive
- Validation and stress testing

## 2. Requirements and Constraints Question

An interviewer asks you to “design a ride-sharing system.” A junior candidate immediately starts with microservices, Kafka, Redis, and geospatial indexing.

How would you slow the problem down and clarify the requirements first?

Identify at least five clarifying questions that would materially change the architecture. Explain why each question matters.

## 3. Customer Journey and Trust Question

For DreamMart checkout, identify the most important trust moment in the customer journey.

What must the system prove before it shows the customer an order confirmation page?

Discuss how your answer changes when payment authorization succeeds but inventory reservation times out.

## 4. AI Authority and Boundaries Question

Suppose DreamMart adds an AI shopping assistant that can recommend products, apply coupons, answer delivery questions, and help users modify orders.

Using the seven-step method, define what the AI assistant should be allowed to do, what it should only suggest, and what it should never directly commit without system validation.

Your answer should include:

- AI authority boundaries
- Evidence required before action
- Fallback or escalation behavior
- Replay or audit needs

## 5. Senior Architect Stress-Test Question

You have designed a high-level architecture for DreamMart checkout. Now traffic increases 10x during Black Friday, the payment provider becomes slow, users repeatedly click the Place Order button, and the AI assistant continues telling users that orders are confirmed.

How would you stress-test the design using Step 7 of the method?

Your answer should address:

- Duplicate requests
- Payment timeout behavior
- Inventory oversell prevention
- User-visible degradation
- AI response control
- Observability and replay
- The one design decision you would defend most strongly in an architecture review
