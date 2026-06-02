# Chapter 2 Exercises: Understanding the Business Domain

Use these exercises to test whether you can move from a vague business domain to a design-ready problem. Strong system design candidates do not jump directly into databases, queues, caches, or services. They first understand the business model, users, core entities, trust moments, and success metrics.

## 1. Domain Understanding Warm-Up

You are asked to design an e-commerce platform like DreamMart.

Before proposing an architecture, identify the core domain elements that shape the design.

Your answer should include:

- Primary users and actors
- Core business entities
- Most important user journeys
- Business success metrics
- Technical quality attributes that matter most
- Areas where AI could improve the experience

Explain why understanding the domain first leads to a stronger system design answer.

## 2. Actor and Journey Analysis

DreamMart has shoppers, sellers, warehouse operators, delivery partners, customer support agents, fraud analysts, and internal business teams.

Choose three of these actors and describe the most important journey for each one.

For each journey, identify:

- The goal of the actor
- The systems or capabilities involved
- The trust moment where the user expects the system to be correct
- What could go wrong
- How the architecture should protect that journey

## 3. Business Capability Mapping

Create a capability map for DreamMart.

Group the platform into major business capabilities such as:

- Product discovery
- Search and recommendations
- Cart and checkout
- Payment
- Inventory
- Fulfillment
- Delivery tracking
- Customer support
- Fraud and risk
- Seller management
- Analytics and personalization

For each capability, identify whether it is primarily:

- Customer-facing
- Operational
- Financial
- Intelligence/AI-driven
- Governance or risk-related

Then choose the three capabilities that deserve the most architectural attention and explain why.

## 4. AI Opportunity and Boundary Analysis

DreamMart wants to add AI across the shopping journey. Leadership suggests AI for product recommendations, price optimization, customer support, fraud detection, delivery prediction, and seller coaching.

Select three AI opportunities that provide real business value.

For each one, explain:

- What business problem it solves
- What data it needs
- What decision or recommendation it influences
- Whether AI should suggest, decide, or act
- What evidence or audit trail is required
- What fallback behavior is needed when AI confidence is low

## 5. Senior Architect Domain-to-Architecture Question

DreamMart is preparing for a Black Friday launch. The business goal is to increase conversion while maintaining customer trust.

The CEO cares about revenue.  
The operations team cares about inventory accuracy.  
The finance team cares about payment correctness.  
The customer support team cares about reducing complaints.  
The AI team cares about personalization and recommendation quality.

How would you translate these business concerns into architectural priorities?

Your answer should include:

- Business goals
- System quality attributes
- Critical capabilities
- Data ownership concerns
- AI risk boundaries
- Metrics that prove the design is working
- One trade-off you would explicitly explain to executives

