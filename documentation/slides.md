# ARM API Reviewer

Three slides plus a demo, built for a 15 minute slot.

Figures compare two three-month blocks: **May through July 2025** (human review
only) and **May through July 2026** (with the agent).

**Time budget**

| Segment                    |     Target |
| -------------------------- | ---------: |
| Slide 1, the problem       |      3 min |
| Slide 2, what the agent is |      2 min |
| Slide 3, the impact        |      3 min |
| Demo                       |      5 min |
| Questions                  |      2 min |
| **Total**                  | **15 min** |

Slide 3 is the payoff. If you are running long, cut depth from slide 2, not
slide 3.

---

# Slide 1. Review depth should not be rationed by reviewer bandwidth

_Target: 3 minutes. Roughly 40 seconds per problem._

Every ARM API specification change goes through human review plus automated
checks such as LintDiff and Avocado. That worked while volume was manageable. It
leaves four problems that neither more reviewers nor more lint rules can solve.

**1. Depth gets rationed as volume grows.**
The same 19 reviewers covered 14 percent more changes year over year, and
comments per change fell from 3.7 to 2.0. Reviewers were not doing worse work.
They were spreading finite attention across more surface.

**2. Automated checks stop at syntax.**
Linters validate structure. They cannot judge that a boolean should have been an
enum, that a resource is missing its collection operation, or that a property
change breaks existing clients.

**3. The most expensive defects are the least visible in a diff.**
Versioning, long-running operations, and resource modeling require holding the
whole API contract and its prior versions in mind. They were the lowest-rate
findings under human-only review, and the most costly to fix after a version
ships.

**4. Feedback was inconsistent and hard to act on.**
Under human-only review, 85.6 comments per 100 changes were free-form remarks
that resist categorization, against 4.2 for the agent. "This does not look
right" and "this violates RPC-Patch-V1-10, here is the fix" are very different
things for an author to receive.

> **Closing line.** More reviewers scale linearly and cost headcount. More lint
> rules cannot reach design questions. The agent separates review depth from
> reviewer bandwidth.

---

# Slide 2. What the agent is today

_Target: 2 minutes. Cut here first if you are running long._

**A codified reviewer, not a chat assistant.** It checks OpenAPI, TypeSpec, and
example files against 100+ rules from the ARM Resource Provider Contract, the
Azure REST API Guidelines, and patterns found across tens of thousands of past
reviews.

- **Runs three ways:** automatically on PRs awaiting ARM feedback, on demand via
  `/arm-review`, or interactively in VS Code. Same rules, same de-duplication.
- **A second agent verifies every finding.** An independent Critic re-fetches the
  files and re-checks each finding before anything posts. It is read-only, which
  is what makes the check real rather than a rubber stamp.
- **Findings are specific and attributed.** Each carries a rule ID, file, line,
  and suggested fix, and separates new issues from pre-existing ones.

**Where it stands:** **269 pull requests** reviewed across 113 or more service
areas, **8 reviewers** using it, and **67 percent of the threads it raised were
resolved** by authors. That last number is the clearest signal the findings are
actionable rather than noise.

---

# Slide 3. The impact

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
top five is API contract risk. Multipliers are rates per 100 reviewed changes,
so they are not an artifact of reviewing more PRs.

---

# Demo

_Target: 5 minutes. Show how a review starts, then cut to completed results._

**1. Show how a review is started (about 1 minute).**
In VS Code, open Copilot Chat, pick **ARM API Reviewer** from the agent picker,
and type `Review PR #43694`. Narrate what happens next rather than waiting for
it: the agent fetches the PR from GitHub, picks a review track, loads the
applicable rule sets, compares against the previous API version, and runs the
Critic pass before showing anything. Mention that reviewers can also get this
automatically on the PR or on demand with `/arm-review`.

**2. Switch to a session where the review already completed (about 4 minutes).**

- **Open the posted review.** Findings are inline, on the exact line, with a rule
  ID and a concrete fix.
- **Walk through one long-running operation finding.** An async DELETE returns
  202 with a `Location` header but no `Azure-AsyncOperation` header. The
  consequence in one sentence: the client polls and never reliably learns the
  operation finished. This is the 4.9x category.
- **Show the new versus pre-existing split**, so the audience sees the author is
  accountable only for what this PR introduced.
- **Show a PR that was reviewed twice** and point out that resolved findings were
  not re-posted on the second pass.

**Candidate PR:** `Azure/azure-rest-api-specs` #43694, a new
Microsoft.ProgramEnrollment TypeSpec API version. It carries the async DELETE
finding above, and it is a new preview version, so the audience sees the agent on
exactly the kind of change where mistakes cost the most.

> **Do not wait for a review to finish on stage.** An interactive VS Code review
> takes 20 to 25 minutes. Have the completed session and the PR tabs open before
> you start, and keep screenshots as backup.

---

# Delivery notes

- Lead slide 3 with long-running operations at 4.9x. Largest multiplier, and the
  failure explains in one sentence.
- If the room questions attribution, switch to **5.7 agent findings per reviewed
  change** against the 3.7 human baseline. That figure is cleanly attributable to
  the agent.
- Do not claim a speed benefit. Reasoning is in the supporting data.
- Expect interruptions on slide 3. That is the slide people engage with, so the
  2 minute question buffer is really a slide 3 buffer.
- Slide 1 carries four problems in 3 minutes. If you fall behind, problem 4 is
  the one to compress, because problems 1 and 2 set up the impact table.
