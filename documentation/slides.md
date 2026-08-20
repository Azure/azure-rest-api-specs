# ARM API Reviewer

Five slides for a 15 minute slot. Figures compare two three-month blocks:
**May through July 2025** (human review only) and **May through July 2026**
(with the agent).

**Time budget**

| Segment                          |     Target |
| -------------------------------- | ---------: |
| Slide 1, intro                   |      1 min |
| Slide 2, problem and solution    |      3 min |
| Slide 3, demo                    |      5 min |
| Slide 4, impact                  |      3 min |
| Slide 5, next steps and feedback |      3 min |
| **Total**                        | **15 min** |

The demo runs before the numbers on purpose. Once the room has seen a single
finding on a real PR, the multipliers on slide 4 mean something concrete. Slide 4
is the payoff; if you are running long, take time from slide 2.

---

# Slide 1. ARM API Reviewer

_Target: 1 minute._

**A codified reviewer for Azure API specifications.** It checks OpenAPI,
TypeSpec, and example files against 100+ rules drawn from the ARM Resource
Provider Contract, the Azure REST API Guidelines, and patterns found across tens
of thousands of past reviews.

It runs three ways, all applying the same rules:

- **Automatically**, when a pull request is waiting on ARM feedback
- **On demand**, when a reviewer comments `/arm-review`
- **Interactively**, in VS Code, while a reviewer works through a change

**Where it stands today:** **269 pull requests** reviewed across 113 or more
service areas, by **8 reviewers**.

> **One line if you only get one.** Every ARM specification change now gets a
> consistent design review, and the reviewers decide what to do about it.

---

# Slide 2. The problem, and what changed

_Target: 3 minutes. Roughly 40 seconds per pair._

Specification changes already went through human review plus automated checks
such as LintDiff and Avocado. Four problems remained that neither more reviewers
nor more lint rules could solve.

| The problem                                                                                                                                                                    | What the agent does about it                                                                                     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------- |
| **Depth was rationed as volume grew.** The same 19 reviewers covered 14 percent more changes year over year, and comments per change fell from 3.7 to 2.0.                     | Review depth no longer depends on who is available that week. Every change gets the same pass.                   |
| **Automated checks stop at syntax.** Linters validate structure. They cannot judge that a boolean should have been an enum, or that a property change breaks existing clients. | Rules encode design judgment, not just document validity.                                                        |
| **The most expensive defects are least visible in a diff.** Versioning, long-running operations, and resource modeling need the whole contract and its prior versions in view. | The agent compares against the previous API version and builds a structural view of the resource before judging. |
| **Feedback was inconsistent and hard to act on.** 85.6 comments per 100 changes were free-form remarks that resist categorization, against 4.2 for the agent.                  | Every finding carries a rule ID, file, line, and the exact fix, and marks whether the PR introduced the issue.   |

> **Closing line.** More reviewers scale linearly and cost headcount. More lint
> rules cannot reach design questions. The agent separates review depth from
> reviewer bandwidth.

---

# Slide 3. Demo

_Target: 5 minutes. Show how a review starts, then cut to completed results._

**1. Show how a review is started (about 1 minute).**
In VS Code, open Copilot Chat, pick **ARM API Reviewer** from the agent picker,
and type `Review PR #45650`. Narrate what happens rather than waiting for it: the
agent fetches the PR, picks a review track, loads the applicable rule sets,
compares against the previous API version, and runs an independent verification
pass before showing anything. Mention that the same review also runs
automatically on pull requests waiting for ARM feedback.

**2. Switch to a review that already completed (about 4 minutes).**

- **Open the posted review.** Findings are inline, on the exact line, with a rule
  ID and a concrete fix.
- **Walk through one finding end to end.** On #45650 the agent flagged a new
  nullable property and a numeric type choice, both with the rule cited.
- **Show what happened on the next push.** The agent came back, confirmed the
  first issue was fixed, and accepted the author's rationale for keeping the
  second as it was. This is the moment worth spending time on: it responds to
  the argument rather than repeating itself.
- **Show the new versus pre-existing split.** #45650 carries five new findings
  and one pre-existing, so the audience sees the author is accountable only for
  what this PR introduced.
- **Explain what happens to the review queue.** The agent posts its findings and
  leaves the decision to a person. It never signs a change off. The weekly
  primary reviewer confirms the findings hold, then moves the labels that take
  the PR out of the feedback queue and back to the author.

> **The sentence worth landing.** The agent can flag a change for rework. Only a
> person can approve one. Sign-off stays human.

**Which PR to use.** All four were reviewed by the automated workflow, with
findings posted by the bot.

| PR         | Files | Why it is useful                                                                        |
| ---------- | ----: | --------------------------------------------------------------------------------------- |
| **#45650** |     8 | **Primary.** Findings, a confirmed fix, a conceded point, and a new vs pre-existing mix |
| #44986     |    16 | A blocking finding on a reused top-level ARM property; now in `ARMChangesRequested`     |
| #45604     |     4 | Two findings citing RPC and ARM mutability rules                                        |
| #45618     |   700 | Only if you want to show a very large change being scoped rather than skipped           |

Long-running operations are one of the four categories behind the contract-risk
figure on the next slide. They are easier to explain from that slide than to hunt
for live.

> **Do not wait for a review to finish on stage.** An interactive review takes 20
> to 25 minutes. Have the completed session and the PR tabs open before you
> start, and keep screenshots as backup.

---

# Slide 4. The impact

_Target: 3 minutes. This is the payoff. Protect this time._

|                                  | **May to July 2025**<br>a human reviewer | **May to July 2026**<br>the agent |
| -------------------------------- | ---------------------------------------- | --------------------------------- |
| **Design comments per PR**       | **3.3**                                  | **5.2** **(1.6x)**                |
| **Share aimed at contract risk** | **22%**                                  | **56%**                           |

> Contract risk means resource modeling, versioning, operations and HTTP
> semantics, and long-running operations. These are the failures that break
> clients already in production, and the hardest to spot by reading a diff.

**The agent produces more per PR, and aims it better.** Lower-severity feedback,
documentation wording, naming, and vague remarks that resist categorization, fell
from **43 percent** of a reviewer's output to **8 percent** of the agent's.

**What the author actually sees.** On a PR the agent reviewed, the author now
receives **8.4 review comments instead of 3.7**, because the reviewer is still
there on top of the agent. Of those 8.4, the reviewer writes 2.7.

**Attribution note, if asked.** These findings came from reviewer-initiated
sessions, where a reviewer ran the agent and approved what was posted. Automated
review on the pull request came later and is not represented in this comparison.

---

# Slide 5. Next steps, and what we need from you

_Target: 3 minutes, including questions._

**Where the agent goes next**

- **Into maintenance mode.** The major pieces are in place and triggering works.
  From here the work is logging issues, working through them, and increasingly
  letting Copilot handle the fixes.
- **Widen coverage.** The agent reviewed 43 percent of changes that went through
  ARM review. On the rest, authors received noticeably less design feedback.
  Closing that gap is the highest-value next step.
- **Long-running operations move to the front.** Partners have been asking for
  this, and it is the category with the largest gap in the data.
- **Build behind feature flags next quarter.** Check work in without enabling it,
  so it can be reviewed and tested ahead of exposure.
- **Open up more broadly to customers early next year.**

**What we are asking for**

- Try it on your own pull requests and tell us where it is wrong.
- Tell us which rules you would want next.
- If a finding was unhelpful, we want that more than we want the ones that
  worked.

> **Close on this.** The agent is only as good as the rules behind it, and those
> rules came from reviews people like you wrote. Keep telling us where it is
> wrong.

---

# Delivery notes

- Lead slide 4 with row 2. "Twenty-two percent to fifty-six percent" is the line
  that lands, because it says the agent is not just producing more but aiming it
  at the failures that reach customers.
- If the room questions attribution, both columns are single-channel: 2025 is
  what a human reviewer produced with no agent, 2026 is the agent alone with
  human comments excluded.
- Expect "what about overall?" Design feedback across every reviewed change went
  from 3.3 to 3.8, because the agent covered 43 percent of them. Give that figure
  openly; the supporting data has the breakdown.
- Do not claim a speed benefit, and do not claim faster turnaround. Agent-reviewed
  PRs take longer to sign off because more gets found and fixed.
- Slide 5 carries the question time. If questions run long, the next steps list
  can be summarized in one sentence and the slide left up.
