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

- **A blocking finding is published:** the agent adds `ARMChangesRequested` and
  removes `WaitForARMFeedback`. The PR leaves the feedback queue and goes back to
  the author.
- **No blocking finding:** the agent leaves `WaitForARMFeedback`,
  `ARMChangesRequested`, and `ARMSignedOff` exactly as they were. A clean
  automated review is advisory and deliberately does not advance the queue.

**What the agent never does.** It never applies `ARMSignedOff`. Approval is
human-only by design. The one-line version: the agent can return a change for
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

**Worth knowing.** During the measured window the label transitions were entirely
human. Of **491** `ARMChangesRequested` applications on agent-reviewed PRs, every
one was applied by a person. That is consistent with the window predating routine
automated runs, and it is why slide 4 carries an attribution note.

---

## 3. Slide 4 figures

### Row 1: review depth

| Measure                               |           2025 |                                      2026 |
| ------------------------------------- | -------------: | ----------------------------------------: |
| Human feedback items                  |          1,948 |                                     1,220 |
| Human reviewed changes                |            529 |                                       602 |
| Human items per change                |            3.7 |                                       2.0 |
| Agent findings, duplicates removed    | not applicable |                                     1,470 |
| Agent findings, before de-duplication | not applicable |                                     1,665 |
| Changes with agent findings           | not applicable |                                       259 |
| Combined reviewed changes             |            529 |                                       606 |
| **Average per reviewed change**       |        **3.7** | **8.4** on agent-reviewed, 4.4 across all |

Arithmetic if challenged:

- 1,948 / 529 = **3.7**
- (1,470 agent + 702 human on those same changes) / 259 = **8.4**
- 8.4 / 3.7 = **2.3x**
- Change coverage: 529 to 602 = **13.8 percent more**
- Comments per change: 3.7 to 2.0 = **45 percent fewer**

Reviewer headcount was **19 accounts in both windows**, so this is not a
staffing change.

**Denominator.** 262 changes received an agent review; 259 received at least one
actionable finding. 259 is the denominator for the 8.4 and 5.7 figures. The
other 3 were clean.

**If attribution is challenged.** The 8.4 figure is total depth the author
receives, human and agent combined, against a human-only baseline. The cleanly
agent-attributable number is **5.7 agent findings per agent-reviewed change**
against the 3.7 human baseline. Use that with a skeptical audience, and note
that human contribution per change fell over the same period, so none of the
increase comes from reviewers writing more.

**Which entry point produced these numbers.** All **1,815** agent findings in the
window were posted from reviewer-initiated sessions, where a person ran the agent
and approved what went on the PR. None came from the automated workflow, which
was introduced after the comparison window. If asked whether automation inflated
the figures, the answer is that automation contributed nothing to them.

### Row 2: issue mix, rate per 100 reviewed changes

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
Partly, and only in the conservative direction. When it publishes a blocking
finding it adds `ARMChangesRequested` and removes `WaitForARMFeedback`, sending
the change back to the author. When the review is clean it changes nothing. It
never applies `ARMSignedOff`, so approval remains human. The weekly primary
reviewer sees the findings already on the PR and decides what happens next.

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
