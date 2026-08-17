# Data-Plane API Review Rollout

This document contains maintainer guidance for the unattended
[`data-plane-api-review.md`](../../../workflows/data-plane-api-review.md) workflow. It lives
outside the workflow because that workflow's Markdown body is sent to the reviewer as its
run-time prompt.

The workflow is at **Phase 2**. Phase 0 was the dark launch, Phase 1 tested summary-only
comments, and Phase 2 adds inline comments while retaining manual label control.

| Phase | Trigger                                                              | Outputs                                               | Evidence to advance                                                                                                             |
| ----- | -------------------------------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| 0     | `workflow_dispatch` only                                             | Run log only (`noop`)                                 | Real-PR failures feed the true-negative corpus and establish that the reviewer is useful enough for a label-gated canary.       |
| 1     | Label `data-plane-api-review-needed`                                 | One summary comment                                   | Human feedback shows the review is useful and that line-local feedback would be easier to act on.                               |
| **2** | **Label `data-plane-api-review-needed` (current, manually applied)** | **One summary comment and up to 5 inline `COMMENT`s** | **Human feedback across a meaningful sample shows low noise, useful anchors, and findings that authors understand and act on.** |
| 3     | `[opened, synchronize]` plus path and new-version guards             | Same as Phase 2                                       | --                                                                                                                              |
| 4     | Paired `DataPlaneAPIReviewRequired` / `DataPlaneAPISignedOff` labels | Sign-off gate                                         | Separate workstream; needs `.github/protected-labels.yml` and `labelling.js` integration.                                       |

## Phase 2 is a human-feedback canary

The manually applied label is the safety control. A maintainer chooses each PR, the workflow
removes the label when it starts, and the submitted review uses GitHub's non-blocking
`COMMENT` event. Phase 2 therefore optimizes for learning from real authors rather than
waiting for a synthetic suite to approximate production feedback.

The inline limit is **up to five**, not a target. The reviewer posts the highest-severity,
highest-value findings inline when they have a valid diff anchor, using RIGHT by default and
LEFT only for a deleted-line finding with no meaningful RIGHT-side anchor. Overflow,
unanchorable findings, and Questions remain in the updateable summary comment.

The eval suite remains a valuable **regression signal**. Blocking false positives, rising
non-blocking noise, or format failures should trigger investigation, but a green synthetic
run is not a hard rollout gate. Promotion to Phase 3 depends primarily on manually observed
false positives, author corrections, whether findings are acted on, and operational
reliability across real pull requests.

Phase 3 requires **two** guards, not one: a path filter for TypeSpec data-plane projects
under `specification/` (excluding `resource-manager/`), and a first-step check that the PR
introduces a new API version directory. Commenting on a two-line fix to a shipped version
is pure noise.

## Phase 0 validates the eval suite, not just the reviewer

Phase 0 is not a warm-up. It is the only place two things can be established that the
synthetic true-negative suite cannot establish on its own. That evidence remains important
even though the manually controlled Phase 2 rollout no longer treats an eval score as a hard
promotion gate.

1. **Real pull requests are a better false-positive source than fixtures.** Synthetic true
   negatives are written alongside the rules and reflect the same mental model, even after
   explicit fixture labels were removed. A merged data-plane PR does none of that. It is also
   messier in the ways that actually generate false positives: partial edits,
   unusual-but-accepted patterns, service-specific conventions, and prior review history the
   agent cannot see.
2. **It is the only place the padding class appears.** The failure mode most likely to get
   this bot muted is a 90%-fine spec where the reviewer reports one genuine issue and then
   pads with adjacent low-value findings. Every synthetic true negative is all-clean or
   all-legitimate, so nothing in the suite stimulates it -- see
   ["Known coverage gaps"](README.md#known-coverage-gaps). Real merged PRs are almost all
   of this shape.

Phase 0 runs the reviewer over a corpus of already-merged data-plane PRs with
`safe-outputs: noop`, and its output is read by a human. Two things come out of it: a
false-positive rate on realistic input, and a set of _new fixtures derived from observed
failures_ rather than guessed ones. The second is what makes the true-negative suite worth
retaining as a regression check.

The suite and the dark launch check different things and neither substitutes for the
other: the suite is a **regression** check -- cheap, repeatable, run per-PR -- while the
dark launch is a **validity** check on whether the suite is measuring anything real.
Passing the suite while never having run against a real PR means only that the reviewer has
not regressed against assumptions never tested.

Changing the production model without re-running the eval suite invalidates comparisons
against its prior regression results.
[`data-plane-review-alignment.yaml`](../../../workflows/data-plane-review-alignment.yaml)
fails the build if the workflow model and eval model diverge.

## Two-stage split seam (not implemented in v1)

At phase 3 this workflow fires on every `[opened, synchronize]` event, and running the
review model on every one of them is expensive at this repo's PR volume. The intended
answer is a two-stage split: a cheap triage pass decides whether the PR contains anything
reviewable, and only then escalates to the review model. ARM already has this shape:
[`eval-fast-path-triage.yaml`](../arm-api-reviewer/vally/eval-fast-path-triage.yaml)
evaluates exactly such a pass on `claude-sonnet-4.6`.

v1 does not implement it, but nothing here forecloses it. The seam is:

- **Triage contract.** Input: the PR's changed-file list plus, at most, the diff of the
  changed `.tsp` files. Output: a binary escalate/exit decision, answering only "does this
  PR change data-plane TypeSpec in a way a design reviewer could have an opinion about".
  No findings, no severities, no comment. The workflow's
  [scope gate](../../../workflows/data-plane-api-review.md#constraints-for-this-run) is
  already written as a standalone predicate, so it becomes the triage prompt nearly
  verbatim.
- **Where it lands.** As a separate gh-aw workflow whose `safe-outputs` is `noop`, gated on
  the same label/path conditions, that dispatches the review workflow on escalation -- or
  as a preceding job in the review workflow's `on.steps`. Either keeps the review stage's
  prompt, tools, and agent file untouched.
- **Model.** Triage runs the cheap model; the review stage keeps the pinned top-level
  `model:`. **Only the review stage's model is constrained to equal the eval pin** -- the
  eval suite measures review output, not triage decisions. If a triage stage is added, give
  it its own eval file and its own recall bar. A triage false negative silently suppresses
  a whole review, which is materially different from a review false positive.
