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
and type `Review PR #43694`. Narrate what happens rather than waiting for it: the
agent fetches the PR, picks a review track, loads the applicable rule sets,
compares against the previous API version, and runs an independent verification
pass before showing anything.

**2. Switch to a session where the review already completed (about 4 minutes).**

- **Open the posted review.** Findings are inline, on the exact line, with a rule
  ID and a concrete fix.
- **Walk through one long-running operation finding.** An async DELETE returns
  202 with a `Location` header but no `Azure-AsyncOperation` header. The
  consequence in one sentence: the client polls and never reliably learns the
  operation finished. This is the 4.9x category on the next slide.
- **Show the new versus pre-existing split**, so the audience sees the author is
  accountable only for what this PR introduced.
- **Explain what happens to the review queue.** If the agent publishes a blocking
  finding it marks the PR `ARMChangesRequested` and takes it out of the feedback
  queue. If the review is clean it changes nothing and leaves the PR where it is.
  The weekly primary reviewer picks it up from there.

> **The sentence worth landing.** The agent can return a change for rework. Only
> a person can approve one. Sign-off stays human.

**Candidate PR:** `Azure/azure-rest-api-specs` #43694, a new
Microsoft.ProgramEnrollment TypeSpec API version. It carries the async DELETE
finding above, and it is a new preview version, so the audience sees the agent on
exactly the kind of change where mistakes cost the most.

> **Do not wait for a review to finish on stage.** An interactive review takes 20
> to 25 minutes. Have the completed session and the PR tabs open before you
> start, and keep screenshots as backup.

---

# Slide 4. The impact

_Target: 3 minutes. This is the payoff. Protect this time._

|                                    | **May to July 2025**<br>human review only                                                                                                           | **May to July 2026**<br>with the agent                                                                                                                                                                            |
| ---------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Average review comments per PR** | **3.7**                                                                                                                                             | **8.4** on PRs the agent reviewed **(2.3x)**                                                                                                                                                                      |
| **Top issue types surfaced**       | 1. Schema and property design<br>2. Documentation and examples<br>3. Naming and enums<br>4. Review readiness and CI chasing<br>5. Resource modeling | 1. Schema and property design **(1.7x)**<br>2. Resource modeling **(3.2x)**<br>3. Versioning and compatibility **(4.0x)**<br>4. Operations and HTTP semantics **(4.0x)**<br>5. Long-running operations **(4.9x)** |

> Human reviewers covered **14 percent more changes** while writing **45 percent
> fewer comments each**. Total feedback per change still rose from 3.7 to 8.4,
> and security findings rose **2.7x** per 100 changes.

**Row 2 is about the mix, not the volume.** Before the agent, three of the top
five categories were documentation polish, naming, and chasing CI. Now the whole
top five is API contract risk. Multipliers are rates per 100 reviewed changes, so
they are not an artifact of reviewing more PRs.

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
- **Long-running operations move to the front.** Partners have been asking for
  this, and it is the category with the largest gap on the previous slide.
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

- Lead slide 4 with long-running operations at 4.9x. Largest multiplier, and the
  demo already made that failure concrete.
- If the room questions attribution, switch to **5.7 agent findings per reviewed
  change** against the 3.7 human baseline. That figure is cleanly attributable to
  the agent.
- Do not claim a speed benefit. Reasoning is in the supporting data.
- Slide 5 carries the question time. If questions run long, the next steps list
  can be summarized in one sentence and the slide left up.
