# Challenge Scorecard

Copy this file into your own notes or fork for each attempt. Use it with the [challenge guide](CHALLENGES.md), [practice plan](PRACTICE-GUIDE.md), and *System Design with AI Interview Guide* by Rohit Bhardwaj.

## Attempt Details

| Field | Your notes |
|---|---|
| Challenge / chapter / URL | |
| Date and attempt number | |
| Time limit | |
| Solo or reviewer name | |
| Scenario assumptions | |
| Learning goal | |

## Before the Hint or Replay

- **Customer promise:** What must remain true?
- **Prediction:** What do you expect to fail, and at which event?
- **Authority:** Which component may make the final commitment?
- **Evidence:** What must it know before acting?
- **Uncertainty:** What state is visible when the outcome is unknown?
- **Recovery:** Who retries, reconciles, escalates, or stops?

## Evidence and Revision

For a live lab, record observed events. For a paper drill, label your trace as an expected result.

| Case / changed constraint | Predicted result | Observed or expected evidence | Design revision |
|---|---|---|---|
| Initial scenario | | | |
| First failure or replay | | | |
| Additional constraint | | | |

## Review Checklist

- [ ] I stated the scope, actors, assumptions, and customer promise.
- [ ] I identified the authoritative commitment and its required evidence.
- [ ] I handled duplicate, delayed, or missing events.
- [ ] I explained authorization and relevant data boundaries.
- [ ] I named a recovery owner and a stop or escalation condition.
- [ ] I showed what the customer sees during uncertainty.
- [ ] I explained one alternative and its trade-off.
- [ ] I revised the design after feedback or a changed constraint.

## Full Mock Interview Score

For a complete mock interview, use the 13 areas in the [interview rubric](INTERVIEW-RUBRIC.md), scoring each from 1 to 5. The total ranges from 13 to 65. A short drill may cover only a few areas: record those separately without treating their subtotal as a full interview score.

| Measure | First attempt | Revised attempt |
|---|---|---|
| Full rubric total, if all 13 areas were assessed | /65 | /65 |
| Weakest area and supporting evidence | | |
| Most important decision changed | | |
| Next practice date and focus | | |

## Two-Minute Defense

Complete this in your own words:

> I chose ___ because ___. The main failure is ___. Before committing, the system checks ___. If the evidence is missing, it ___. Recovery belongs to ___. I would reconsider this design if ___.

Keep this record locally or share it with a study partner. There is no automatic GitHub scoring or submission in this worksheet.
