# ARM API Reviewer: supporting data

Backing detail for the slides. Not for projection.

**Windows.** Two matched three-month blocks: **May through July 2025** (human
review only) and **May through July 2026** (with the agent). Same calendar
months on both sides, so holidays and release cadence fall in the same place.

**Scope.** The public `Azure/azure-rest-api-specs` repository and the private
`Azure/azure-rest-api-specs-pr`. A change appearing in both is counted once.

---

## 1. Slides 1 and 2: what the agent is

- **100+ codified rules**, including **58 ARM Resource Provider Contract rule
  IDs**, plus rules covering policy, template deployment, preflight, secrets,
  and property design.
- **29 shared reference documents** across cross-cutting, ARM control-plane, and
  data-plane areas.
- **Two agents.** The Reviewer is tuned for recall, finding every violation. An
  independent Critic is tuned for precision: it re-fetches files, re-quotes rule
  text, and re-checks new versus pre-existing before anything posts. The Critic
  is read-only with a narrower tool surface, which is what makes the check real
  rather than a rubber stamp.
- **Two review tracks.** A fast path for example-only or description-only
  changes under 200 lines, and a full review for anything touching a stable or
  preview specification, TypeSpec source, a new API version, or 200 or more
  lines. When uncertain, it defaults to full review.
- **Large PRs are scoped, not skipped.** Above 50 files or 5,000 lines it
  reviews the highest-risk subset, new API versions first, and states what was
  covered and what was not.
- **Fork PRs are handled safely.** The agent never checks out untrusted PR code.
  It reads through a read-only interface and writes through a constrained path.
- **Adoption:** 269 PRs reviewed, 113 or more service areas, 8 reviewers, median
  4 findings per reviewed PR.
- **67 percent of agent-raised threads were resolved** by authors, from 1,016
  resolved threads. This is the best signal that findings are actionable.
- **Run duration.** An interactive review in VS Code takes **20 to 25 minutes**.
  The automated workflow is faster because it runs a narrower path, at **8.8
  minutes median** with a longest observed run of 19.5. Neither fits inside a
  demo slot, which is why the demo shows how a review is started and then
  switches to a session that already completed.

---

## 2. Slide 3: how a review moves through the queue

This is the part most likely to be challenged, so the exact rules matter.

**How a review starts**

| Entry point   | Who triggers it                                                               |
| ------------- | ----------------------------------------------------------------------------- |
| Automatic     | A non-draft PR carrying `WaitForARMFeedback`, on open, push, or label applied |
| `/arm-review` | Any collaborator with write access, on demand, including on drafts            |
| VS Code       | A reviewer working interactively, who approves each finding before it posts   |

**What the review does to the queue**

The workflow is written to do this:

- **A blocking finding is published:** add `ARMChangesRequested` and remove
  `WaitForARMFeedback`, sending the change back to the author.
- **No blocking finding:** leave `WaitForARMFeedback`, `ARMChangesRequested`, and
  `ARMSignedOff` exactly as they were. A clean review is advisory and
  deliberately does not advance the queue.

**In practice, a person has moved every label so far.** Across 34 pull requests
reviewed by the automated workflow, `ARMChangesRequested` was applied **24 times,
every one by a reviewer and none by the automation**. Only one of those PRs
carried a bot-posted blocking finding, and on that one the label was applied by a
reviewer about seven hours after the finding was posted.

**So do not claim the automatic transition on stage.** Describe the queue
behavior as: the agent posts findings and never signs anything off, and the
reviewer decides what moves. That is both accurate and the safer claim. The
automatic path exists in the workflow and can be described as designed behavior
if someone asks, but it has not been observed firing yet.

**What the agent never does.** It never applies `ARMSignedOff`. Approval is
human-only by design. The one-line version: the agent can flag a change for
rework, but only a person can approve one.

**One distinction worth having ready.** A separate, long-standing automation
signs off low-risk changes such as incremental TypeSpec updates, and it posts
under the same `github-actions` identity. On agent-reviewed PRs in the window it
applied `ARMSignedOff` on 84 pull requests, and **all 84** also carried an
`ARMAutoSignedOff` label, which is what that automation stamps. So if someone
points at a bot sign-off on a PR the agent reviewed, that was the auto-signoff
path, not the reviewer.

**Who picks it up.** A primary ARM reviewer rotates weekly. That reviewer sees
the agent's findings already on the PR, confirms they hold, and decides what
moves next.

**Verified demo candidates.** All four were reviewed by the automated workflow,
with findings posted under the bot identity.

| PR                                                                 | Files | What it shows                                                                       |
| ------------------------------------------------------------------ | ----: | ----------------------------------------------------------------------------------- |
| [#45650](https://github.com/Azure/azure-rest-api-specs/pull/45650) |     8 | Five new findings and one pre-existing; agent later confirms a fix and concedes one |
| [#44986](https://github.com/Azure/azure-rest-api-specs/pull/44986) |    16 | A blocking finding citing ARM Section 2.5; PR now carries `ARMChangesRequested`     |
| [#45604](https://github.com/Azure/azure-rest-api-specs/pull/45604) |     4 | Two findings citing `RPC-Schema-V1-26.0` and `ARM-8.6-Mutability`                   |
| [#45618](https://github.com/Azure/azure-rest-api-specs/pull/45618) |   700 | A very large change reviewed at reduced scope rather than skipped                   |

The exchange on #45650 is the strongest single artifact. The agent posted a
warning about a new nullable property and a suggestion about a numeric type. On
the next push it confirmed the nullable issue was fixed, and on the numeric type
it accepted the author's reasoning that IPv6 allocation bounds exceed the range
of any available numeric type and that the string was correct. It engaged with
the argument instead of repeating the finding.

**Worth knowing.** During the measured window the label transitions were entirely
human. Of **491** `ARMChangesRequested` applications on agent-reviewed PRs, every
one was applied by a person. That is consistent with the window predating routine
automated runs, and it is why slide 4 carries an attribution note.

---

## 3. Slide 4 figures

### Row 1: design comments per PR, human against agent

This is a single-channel comparison. The 2025 column is what a human reviewer
produced when no agent existed. The 2026 column is what the agent produced,
with human comments excluded entirely.

| Measure                             | 2025 human | 2026 agent |
| ----------------------------------- | ---------: | ---------: |
| Changes reviewed                    |        529 |        262 |
| Changes receiving at least one item |        529 |        259 |
| Total items                         |      1,948 |      1,481 |
| Design items                        |      1,740 |      1,359 |
| Process items                       |        208 |        122 |
| **Design items per change**         |    **3.3** |    **5.2** |
| All items per change                |        3.7 |        5.7 |

- Design: 1,740 / 529 = **3.3** against 1,359 / 262 = **5.2**, a **1.6x** increase
- All items: 1,948 / 529 = **3.7** against 1,481 / 262 = **5.7**, a **1.5x** increase
- The denominator choice barely matters. Only 3 of the 262 changes the agent
  reviewed came back clean, so per-change-reviewed and per-change-with-findings
  agree to one decimal.

**The selection caveat, and it is a real one.** Reviewers chose which changes to
run the agent on, and they tended to choose the harder ones. The 2025 cohort is
every change that went through human review. So this compares the agent on the
work it was pointed at against humans on everything. State that plainly if
challenged; it does not undo the result, but it is not a controlled trial.

### Row 2: where each channel aims its feedback

Share of each channel own output, so the two columns are independent of volume.

| Theme                         | 2025 human | 2026 agent |
| ----------------------------- | ---------: | ---------: |
| Schema and property design    |      21.1% |      23.2% |
| Resource modeling             |       8.0% |      16.8% |
| Versioning and compatibility  |       6.1% |      15.9% |
| Operations and HTTP semantics |       5.4% |      14.0% |
| Long-running operations       |       3.0% |       9.6% |
| Security and secrets          |       2.3% |       4.0% |
| Review readiness and CI       |       8.1% |       6.6% |
| Documentation and examples    |      10.7% |       3.6% |
| Naming, enums, identifiers    |       9.4% |       3.3% |
| Other, resists categorization |      23.3% |       0.7% |

**Contract risk** is resource modeling, versioning, operations and HTTP
semantics, and long-running operations combined:

- 2025 human: (156 + 118 + 106 + 58) / 1,948 = **22.5 percent**
- 2026 agent: (249 + 236 + 208 + 142) / 1,481 = **56.4 percent**
- Adding security and secrets moves these to 24.7 and 60.4 percent

**Lower-severity feedback** is documentation, naming, and the bucket that resists
categorization: **43.3 percent** of human output against **7.7 percent** of the
agent output.

The 23.3 percent human "other" bucket is not a classifier failure so much as a
description of how people write review comments: terse, contextual, and often
referring to a conversation the reader was part of. Agent findings carry an
explicit rule ID, which is why almost none of them land in that bucket.

### What the author actually receives

The rows above isolate each channel. In practice the reviewer is still working
alongside the agent, so on a change the agent reviewed the author receives both:

| Measure                      |    2025 |    2026 |
| ---------------------------- | ------: | ------: |
| Agent findings per change    |       0 |     5.7 |
| Reviewer comments per change |     3.7 |     2.7 |
| **Total per change**         | **3.7** | **8.4** |

- 2026: (1,470 agent + 702 reviewer) / 259 changes = **8.4**
- Reviewer share fell from 3.7 to **2.7**, a **26 percent** reduction
- Across every change reviewers touched in 2026, not just agent-reviewed ones,
  they averaged 1,220 / 602 = **2.0** per change, a **45 percent** reduction,
  while covering **13.8 percent more changes** with the same 19 people. That uses
  a different denominator, so quote it separately.

### Design feedback per PR, and the coverage caveat

The 3.3 figure for 2025 covers every reviewed change in the window. The
comparable 2026 number depends on which changes you count, and the gap between
those two answers is the single most important caveat in this deck.

| Cohort                             | Changes | Design items |  Per PR |
| ---------------------------------- | ------: | -----------: | ------: |
| **2025, all reviewed changes**     |     529 |        1,740 | **3.3** |
| **2026, all reviewed changes**     |     606 |        2,299 | **3.8** |
| 2026, changes the agent reviewed   |     259 |        1,894 |     7.3 |
| 2026, changes with no agent review |     347 |          405 |     1.2 |

So there are two true answers to "what is the 2026 number":

- **3.8 across everything reviewed**, a 1.15x increase on 3.3. This is the
  strictly like-for-like comparison.
- **7.3 on the changes the agent actually reviewed**, a 2.2x increase. This is
  what the agent delivers where it runs.

The difference is coverage. The agent reviewed **259 of 606 reviewed changes, 43
percent**. The slide is scoped to agent-reviewed PRs and its column header says
so. If anyone asks what happened overall, give them 3.8 and explain the coverage
gap rather than letting them find it.

**The number worth noticing.** On 2026 changes the agent did not review, design
feedback was **1.2 per PR, down from 3.3 in 2025**. Reviewers are spread thinner
than they were, and where the agent is absent authors now get materially less
design feedback than they used to. That is the strongest argument for expanding
coverage, and it lines up with the roadmap on slide 5.

**The pattern is not an artifact of trivial changes.** Excluding everything that
was auto-signed off, so only substantive review remains, the shape holds and
sharpens: 2025 stays at 3.3, 2026 rises to 4.1 overall, 7.6 on agent-reviewed
changes and 1.1 where the agent was absent.

### How design and process were separated

The design figures above exclude two themes as process rather than design work:
**Review readiness and CI** (chasing lint failures, PR templates, stale threads)
and **Suppressions and tooling**.

| Cohort                              | Design | Process | Design per change |
| ----------------------------------- | -----: | ------: | ----------------: |
| 2025 human, 529 changes             |  1,740 |     208 |           **3.3** |
| 2026 agent, 262 changes             |  1,359 |     122 |           **5.2** |
| 2026 reviewer on agent-reviewed PRs |    535 |     167 |               2.1 |
| 2026 combined, 259 changes          |  1,894 |     289 |               7.3 |

Classifying **Suppressions and tooling** as process is a judgment call. Moving it
to design shifts the 2025 baseline from 3.3 to 3.4 and changes no conclusion.

### Contract risk as a rate, an alternative to the share figure

Slide 4 expresses contract risk as a share of each channel output, 22 percent
against 56 percent. The same shift expressed as a rate per 100 reviewed changes:

| Category                      | 2025 human | 2026 agent |
| ----------------------------- | ---------: | ---------: |
| Resource modeling             |       29.5 |       95.8 |
| Versioning and compatibility  |       22.3 |       89.2 |
| Operations and HTTP semantics |       20.0 |       80.3 |
| Long-running operations       |       11.0 |       54.4 |
| **Combined**                  |   **82.8** |  **319.7** |

Use the share figure on the slide because it is independent of volume and
therefore harder to argue with. Use the rate if someone specifically asks how
many more findings there are per PR rather than how the mix shifted.

### Full issue mix, if anyone wants it

Rate per 100 reviewed changes. This was an earlier version of row 2 and was cut
because five categories with five multipliers is difficult to deliver verbally.
Keep it here for questions.

| Issue type                    | 2025 human | 2026 agent | Multiplier |
| ----------------------------- | ---------: | ---------: | ---------: |
| Schema and property design    |       77.7 |      131.7 |       1.7x |
| Resource modeling             |       29.5 |       95.8 |       3.2x |
| Versioning and compatibility  |       22.3 |       89.2 |       4.0x |
| Operations and HTTP semantics |       20.0 |       80.3 |       4.0x |
| Long-running operations       |       11.0 |       54.4 |       4.9x |
| Security and secrets          |        8.3 |       22.8 |       2.7x |
| Review readiness and CI       |       29.7 |       37.8 |       1.3x |
| Documentation and examples    |       39.3 |       20.8 |       0.5x |
| Naming, enums, identifiers    |       34.6 |       18.5 |       0.5x |

Severity split: **443 blocking, 668 warning, 554 suggestion**. Blocking is
roughly one quarter. **1,537 findings were newly introduced** by the PR and
**128 were pre-existing**, so the agent mostly flags what the change brought in.

---

## 4. Issue types, with a real example each

Use these when someone asks what a category means. Every example is an actual
agent finding from the 2026 window.

### Schema and property design, 1.7x

How properties are typed and constrained: required versus optional, formats,
value limits, and reuse of common types. Mistakes here produce broken client
code and awkward SDKs.

> **Example.** `startDate` and `endDate` were plain strings, with the expected
> date format described only in the prose description. The agent required a
> proper date type so the generated contract emits `format: date` and clients
> get real date handling instead of an opaque string.
> [PR #28871](https://github.com/Azure/azure-rest-api-specs-pr/pull/28871#discussion_r3422392863)

### Resource modeling, 3.2x

Whether the resource follows the ARM contract: tracked versus proxy shapes,
resource identifiers, identity and SKU handling, and PATCH semantics. This is
where ARM correctness lives.

> **Example.** A PATCH body spread managed identity properties into the request
> schema, which made `type` a required field on PATCH. PATCH must accept partial
> updates, so this violated RPC-Patch-V1-10 and would have forced callers to
> resend fields they did not intend to change.
> [PR #27781](https://github.com/Azure/azure-rest-api-specs-pr/pull/27781#issuecomment-4684084670)

### Versioning and compatibility, 4.0x

Breaking changes and version hygiene: editing a published version in place,
removing a shipped version, or adding a version that is not TypeSpec generated.
Highest customer impact, because a mistake here breaks existing clients.

> **Example.** A new API version was hand-authored OpenAPI and missing the
> `x-typespec-generated` marker, so it bypassed the requirement that new
> versions come from TypeSpec.
> [PR #43781](https://github.com/Azure/azure-rest-api-specs/pull/43781#discussion_r3384703999)

### Operations and HTTP semantics, 4.0x

Verb and status-code correctness, headers, pagination, query parameters, and
keeping checked-in examples aligned with the contract.

> **Example.** `Licenses_Delete` returns `202` and `204`, but the checked-in
> example still declared `200` and `204`. Examples drive documentation and SDK
> tests, so a stale example teaches callers the wrong contract.
> [PR #43902](https://github.com/Azure/azure-rest-api-specs/pull/43902#discussion_r3399892201)

### Long-running operations, 4.9x

Async polling correctness: `Azure-AsyncOperation` and `Location` headers,
`final-state-via`, provisioning state, and matching 201 and 202 shapes. Largest
multiplier of any category, and the easiest to miss by eye.

> **Example.** An async DELETE returning `202` declared the `Location` header but
> omitted the required `Azure-AsyncOperation` header. The practical consequence
> is that the client polls and never reliably learns the operation finished.
> [PR #43694](https://github.com/Azure/azure-rest-api-specs/pull/43694#discussion_r3384426069)

### Security and secrets, 2.7x

Credentials, keys, and tokens not marked as secret, or secret-detection rules
suppressed instead of fixed. Small in volume, large in consequence.

> **Example.** An `activationKey` property shipped with a `#suppress` for the
> `secret-prop` rule rather than being marked `@secret`. Suppressing the check
> hides the credential from tooling instead of protecting it.
> [PR #44798](https://github.com/Azure/azure-rest-api-specs/pull/44798#discussion_r3618437448)

### Review readiness and CI, 1.3x

Blocked or incomplete PRs: failing required checks, broken suppressions, and
files that are not in a reviewable state. In 2025 this consumed 29.7 comments
per 100 changes of reviewer time spent on process rather than API design.

> **Example.** The generated Swagger contained unresolved Git merge conflict
> markers committed into the file. The agent caught it and confirmed the base
> branch was clean, so the problem came from this PR.
> [PR #29117](https://github.com/Azure/azure-rest-api-specs-pr/pull/29117#discussion_r3477750137)
>
> **Human equivalent, 2025:** "Please address LintDiff errors before ARM review."

### Documentation and examples, 0.5x

Example files that do not match the operations they illustrate, and AutoRest
configuration pointing at files that do not exist.

> **Example.** The `AccountPolicies_CreateOrUpdate` operation declares both `200`
> and `201` responses, but the checked-in example covered only the `200`. The
> `201` create path was therefore never exercised by example validation.
> [PR #43898](https://github.com/Azure/azure-rest-api-specs/pull/43898#discussion_r3399630097)
>
> **Human equivalent, 2025:** "I can't tell what this PR is for. Can you fill out
> the template at the top?"

### Naming, enums, and identifiers, 0.5x

Resource type names, property casing, operation IDs, and enum shape. Naming is
permanent once a version ships, so errors here are expensive to undo.

> **Example.** The `readerEndpoint` path segment was singular, but ARM resource
> type names must be plural. The spec contradicted itself: the accompanying
> example file already used `readerEndpoints`. Names are baked into every
> resource ID and SDK method once a version ships.
> [PR #39083](https://github.com/Azure/azure-rest-api-specs/pull/39083#discussion_r3241847016)
>
> **Human equivalent, 2025:** "Better name would be subnetResourceId. Also clarify
> the description by indicating this is a resource ID."

### Why two categories went down

Documentation and naming both dropped to 0.5x. Both are real but lower severity.
The agent did not stop reporting them; the mix shifted toward contract risk, so
they fell in relative terms. That is the intended outcome, with reviewer
attention moving from polish to correctness.

---

## 5. Slide 5: next steps detail

Backing for the roadmap slide, in case anyone asks for specifics.

**Maintenance mode.** The major components are built and automatic triggering
works, so the emphasis shifts from building to sustaining: issues get logged and
triaged, and Copilot increasingly handles the fixes. This frees engineering
attention for the next area rather than signalling that the work is finished.

**Widening coverage.** The agent reviewed 259 of 606 changes that went through
ARM review, 43 percent. On the 347 it did not review, design feedback averaged
1.2 per change against 3.3 in 2025. Closing that gap raises the floor for every
author rather than only those whose reviewer invoked the agent, and it is the
change most directly supported by the data. If asked how it gets closed, the
automated workflow already runs on PRs carrying `WaitForARMFeedback`; the work is
making that path the default rather than the exception.

**Long-running operations.** Partners have been asking for deeper support here,
and it is also the largest gap in the data at 4.9x. Picking it up next lines the
roadmap up with both partner demand and the measured evidence, which is a useful
point to make if someone asks how priorities were chosen.

**Feature flags next quarter.** The coming quarter is lighter. The plan is to
check work in behind flags rather than enabling it immediately, so changes can be
reviewed and tested well ahead of exposure.

**Broader customer availability early next year.** Sequenced after the
flagged work has had time to settle.

**Under consideration, not committed.** Triggering a review from an additional
dedicated label, which would give teams a way to request review without needing
comment access. Raised as an idea; mention it only if asked about extensibility.

---

## 6. Anticipated questions

**"Does the agent move the PR through the review queue by itself?"**
In practice, no. It posts findings and leaves the decision to a reviewer, and it
never applies `ARMSignedOff`, so approval is always human. The workflow does
contain a rule to add `ARMChangesRequested` and clear `WaitForARMFeedback` when a
blocking finding is published, but across the automated reviews to date every
label transition has been made by a person. Describe the reviewer as the one who
moves the change.

**"How do you tell an agent finding from a human comment?"**
Every agent finding carries a hidden marker. The split uses that marker, not the
posting account. This matters because in the interactive path a reviewer
approves findings and they post under that reviewer's own account. One reviewer
in the 2026 window accounts for 424 human comments and 312 agent findings,
correctly separated. Counting by account would have conflated the two.

**"Are you comparing like with like?"**
Same three calendar months, same two repositories, same reviewer definition
applied to both windows. Cross-repository duplicates count once. Agent findings
are de-duplicated, which removed 195 repeats from re-reviews of the same PR.

**"Is the agent just noisier?"**
Volume alone would suggest that, which is why row 2 is rate-based. The mix moved
toward contract risk: versioning 4.0x, long-running operations 4.9x, security
2.7x, while documentation and naming went down. About one quarter of findings
are blocking, and authors resolved 67 percent of the threads it raised.

**"Did human reviewers stop reviewing?"**
The opposite. Human reviewed changes rose from 529 to 602, about 14 percent
more, with the same 19 accounts. Comment volume fell from 1,948 to 1,220, which
is the agent absorbing itemized detail while reviewers covered more ground.

**"Is the agent replacing reviewers?"**
No. Every finding lands on a PR a human still owns and signs off. Only 4 changes
received agent findings with no human ARM review, and all 4 had entered the
review queue. The agent adds depth to human-reviewed changes.

**"Is the agent faster?"**
Do not claim this. Measured from a consistent starting point, the moment a PR
enters the review queue, the agent's median time to first feedback is 74.2 hours
against 50.4 for humans. The agent is normally triggered on demand, so that
number reflects when someone invoked it, not how long it takes to run. The
argument is depth, coverage of hard categories, and consistency.

**"What happened across all PRs, not just the ones the agent reviewed?"**
Design feedback went from **3.3 per PR in 2025 to 3.8 in 2026**, a 15 percent
increase. The slide is deliberately scoped to the changes the agent reviewed,
where the figure is 7.3, and the column header says so. The difference is
coverage: the agent reviewed 259 of 606 reviewed changes, 43 percent. Give the
3.8 figure openly if asked. The follow-on point is that on changes the agent did
not review, design feedback fell to 1.2 per PR from 3.3 in 2025, which is why
expanding coverage is on the roadmap.

**"Do PRs get through review faster?"**
No, and be ready for this one because it sounds like it should be yes. Measured
from queue entry to ARM sign-off, excluding changes that were auto-signed off:

| Cohort               | PRs | Median days to sign-off | Average change rounds |
| -------------------- | --: | ----------------------: | --------------------: |
| 2025, human only     | 824 |                     4.9 |                  0.61 |
| 2026, no agent       | 535 |                     1.1 |                  0.20 |
| 2026, agent reviewed | 152 |                     8.4 |                  1.84 |

The pattern holds when restricted to similarly sized pull requests of 5 to 50
changed files: 4.7 days for 2025 human-only against 9.4 days for agent-reviewed.

Two things are going on, and both are worth saying plainly. Reviewers invoke the
agent on the harder changes, so the cohorts are not equivalent. And the agent
finds more that needs fixing, 1.84 rounds of requested changes against 0.61, so
the extra time is rework rather than waiting. Issues fixed before a version ships
are far cheaper than issues fixed after. But the honest summary is that this
process finds more and therefore takes longer, and no speed claim is made.

**"How reliable is the categorization?"**
Keyword heuristics, one theme per item. Coverage is 76.7 percent for human
comments and 99.3 percent for agent findings. Human comments are terse and
context-dependent; agent findings carry an explicit rule ID. The unclassified
remainder is excluded from the top five rather than hidden.

**"Why is 2025 documentation feedback so high?"**
Human reviewers were carrying more polish and process work. That is the shift
the slide shows.

**"What stops the agent from posting something wrong?"**
The Critic re-verifies every finding's rule citation, line number, and
classification before posting. If the PR changes mid-review, the session is
invalidated rather than posted against stale content. In the interactive path
nothing posts without reviewer approval.

---

## 7. Caveats

1. **Units differ.** Agent findings are itemized, one issue each. Human comments
   are conversational, though most raise a single issue.
2. **Mean, not median.** The slide says average because that was requested. The
   2025 median is 2.0 per change; the distribution is skewed by a few very
   active reviewers.
3. **Theme classification is heuristic** and single-label. Directional, not
   exact.
4. **Service-area counts are minima**, based on the first 100 changed files per
   PR.
5. **Thread resolution rates are not compared across years**, because the two
   cohorts have different maturity.
6. **No causal claim.** The agent arrived alongside other process changes. This
   shows what authors received before and after, not a controlled experiment.
7. **The comparison covers reviewer-initiated reviews only.** Automated review on
   the pull request began after the window and contributed no findings to these
   figures.
