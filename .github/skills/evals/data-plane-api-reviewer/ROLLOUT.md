# Data-Plane API Review Rollout

This document contains maintainer guidance for the unattended
[`data-plane-api-review.md`](../../../workflows/data-plane-api-review.md) workflow. It lives
outside the workflow because that workflow's Markdown body is sent to the reviewer as its
run-time prompt.

The workflow is at **Phase 1**. Phase 0 was the dark launch; phases 1-4 form the rollout
ladder. Do not skip steps; each gate exists because the previous one produced evidence.

| Phase | Trigger                                                              | Outputs                                     | Gate to advance                                                                                                                                                                                                          |
| ----- | -------------------------------------------------------------------- | ------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 0     | `workflow_dispatch` only                                             | Run log only (`noop`)                       | FP rate on a corpus of merged data-plane PRs at or below the eval bar, **and** new true-negative fixtures derived from the failures it surfaces. See [Phase 0](#phase-0-qualifies-the-eval-suite-not-just-the-reviewer). |
| **1** | **Label `data-plane-api-review-needed` (current)**                   | **One summary comment**                     | **True-negative suite green (0 blocking FPs across 3 runs) AND phase-0 evidence on real PRs; non-blocking FP count trending flat or down; phase-1 comments demonstrably acted on.**                                      |
| 2     | Same label                                                           | Summary comment and up to 5 inline comments | Sustained low FP rate on real PRs over a meaningful sample.                                                                                                                                                              |
| 3     | `[opened, synchronize]` plus path and new-version guards             | Same as phase 2                             | --                                                                                                                                                                                                                       |
| 4     | Paired `DataPlaneAPIReviewRequired` / `DataPlaneAPISignedOff` labels | Sign-off gate                               | Separate workstream; needs `.github/protected-labels.yml` and `labelling.js` integration.                                                                                                                                |

Phase 3 requires **two** guards, not one: a path filter for TypeSpec data-plane projects
under `specification/` (excluding `resource-manager/`), and a first-step check that the PR
introduces a new API version directory. Commenting on a two-line fix to a shipped version
is pure noise.

## Phase 0 qualifies the eval suite, not just the reviewer

Phase 0 is not a warm-up. It is the only place two things can be established that the
synthetic true-negative suite cannot establish on its own, and **phase-2 promotion depends
on evidence from it -- not on the synthetic suite alone.**

1. **Real pull requests are a better false-positive source than fixtures.** Synthetic true
   negatives are written by the same person who wrote the rules, against the same mental
   model, and the current ones announce in a header comment that they are true negatives.
   A merged data-plane PR does none of that. It is also messier in the ways that actually
   generate false positives: partial edits, unusual-but-accepted patterns, service-specific
   conventions, and prior review history the agent cannot see.
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
gating on afterwards.

The suite and the dark launch check different things and neither substitutes for the
other: the suite is a **regression** check -- cheap, repeatable, run per-PR -- while the
dark launch is a **validity** check on whether the suite is measuring anything real.
Passing the suite while never having run against a real PR means only that the reviewer has
not regressed against assumptions never tested.

Changing the production model without re-running the eval suite invalidates every gate in
this table.
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
