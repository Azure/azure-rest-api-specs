---
name: azure-lint-rule-evaluation
license: MIT
metadata:
  version: "1.0.0"
description: 'Evaluate the violations produced by a new or changed TypeSpec/OpenAPI linter rule (typically from a typespec-azure or tooling PR) when it is run against Azure/azure-rest-api-specs, and decide for each violation whether it is a real author error, a false positive (rule bug), or indeterminate. USE FOR: "validate the failures from this lint rule PR", "is this new linter rule catching real bugs or false positives", "triage lro-response-mismatch / <rule-id> violations across these specs", "evaluate External Integration / typespec-next check failures for a candidate rule". Produces a markdown report with source links + evidence, suppresses confirmed author errors with a fixme justification, and validates with tsv. DO NOT USE FOR: authoring/changing spec content to add features (use azure-typespec-author), API design review (use azure-api-review), SDK generation, or fixing the rule implementation itself.'
compatibility: "Node.js >= 20, npm; a local clone of Azure/azure-rest-api-specs; the candidate rule packages installable via pkg.pr.new (or a local build); npx tsv (@azure-tools/typespec-validation)."
---

# Azure Lint Rule Evaluation

Given a PR that introduces or changes a linter rule (e.g. an
`@azure-tools/typespec-azure-*` rule) and a set of specs that now fail, decide
**per violation** whether the rule caught a genuine authoring error, produced a
false positive, or is indeterminate — then suppress the real errors, leave the
false positives visible, and report the analysis with evidence.

## Rules

- **Classify against author intent, not against the rule.** A violation is a
  _user-error_ only when the flagged encoding genuinely differs from what the
  author intended on the wire; it is a _false-positive_ when the encoding matches
  intent but the rule's expectation is wrong; otherwise _indeterminate_.
- **Get ground truth first.** Never guess what the rule computed. Capture the
  rule's own inputs/outputs (see [ground-truth instrumentation](references/ground-truth-and-diagnostics.md))
  so every determination cites the actual computed values, not an assumption.
- **Gather intent evidence** from the PR (rule description, message text, test
  cases), the spec source, the generated Swagger, and repo conventions before
  deciding. When intent cannot be established, mark **indeterminate** — do not
  force a call.
- **Only suppress confirmed user-errors**, in-place, with the justification
  string the requester specified (e.g. `"fixme-invalid-lro-result"`). Never
  suppress false positives — they must remain visible so the rule can be fixed.
- **Validate**: after suppressing, the user-error diagnostics must disappear
  under `tsv`; the false positives should remain. Confirm before reporting.
- **Commit** suppressions (and the report) — `tsv` compares generated Swagger and
  the working tree against the base branch, so uncommitted `.tsp` edits make it
  fail on git differences.

## Workflow

1. **Read the rule.** Fetch the PR. Extract the rule id, `severity`, `messages`
   (each message = one violation variant), the `url`, and the decision logic
   (what it computes and what it compares against). Read the rule's own test
   cases — they encode the author's intended pass/fail examples.

2. **Set up the environment.** Check out the target branch (usually
   `typespec-next`). Install the candidate rule packages from pkg.pr.new and pin
   the matching dev-versions. See
   [environment setup](references/environment-setup.md).

3. **Reproduce.** Run `npx tsv <spec-dir>` in each failing spec directory. `tsv`
   recurses into every sub-directory containing a `tspconfig.yaml`, so one
   invocation covers all sub-projects of a service — no manual enumeration.
   Record which specs from the requested list produce **zero** violations too;
   they belong in the report.

4. **Collect ground truth.** Enumerate every violation and, for each, the exact
   values the rule computed (the encoded/actual value vs the expected value) and
   a stable source location. Prefer lightweight instrumentation of the rule over
   inference. See [ground-truth & diagnostics](references/ground-truth-and-diagnostics.md).

5. **Classify** each violation as `user-error`, `false-positive`, or
   `indeterminate`, recording the evidence. See
   [classification](references/classification.md) for the general procedure and
   the worked LRO (`lro-response-mismatch`) heuristics.

6. **Suppress** confirmed user-errors and **let the formatter place them.** Insert
   `#suppress "<rule-id>" "<justification>"` above each flagged operation, then run
   `tsp format` on the edited files so the directive lands in canonical position.
   See [suppress & validate](references/suppress-and-validate.md).

7. **Validate.** Re-run `tsv` on the affected specs; confirm every suppressed
   user-error is gone and the false positives remain. The working tree must be
   clean (changes committed) or `tsv`'s git checks fail.

8. **Report.** Write a markdown report grouping violations by determination, each
   with a base-branch source link, the encoded vs expected values, the evidence,
   and — for user-errors — **how to fix it at the source instead of suppressing**.
   Include the no-violation specs. See [reporting](references/reporting.md).

> The steps above are rule-agnostic: they apply to any new or changed
> TypeSpec/OpenAPI linter rule, not just `lro-response-mismatch`. Everywhere this
> skill uses that rule, treat it as a worked example — substitute the rule under
> evaluation's own contract, computed values, and conventions.

## Examples

- "Validate the failures from typespec-azure PR #4145's new `lro-response-mismatch`
  rule against these 24 specs and tell me which are real bugs vs false positives."
- "The External Integration check on typespec-next is red for this candidate rule —
  triage each violation, suppress the real ones with `fixme-invalid-lro-result`,
  and give me a report."

## Troubleshooting

- **`npx tsv` finds nothing / wrong packages** — confirm the pkg.pr.new install and
  dev-version pins actually landed (`npm ls <rule-package>`); use
  `--registry https://registry.npmjs.org` for the `next` dev-version pins.
- **`tsv` fails on "Files have been changed after `tsp format`"** — your suppress
  directive isn't in canonical position; run `tsp format` on the file and re-check.
- **`tsv` fails on git differences** — commit the suppressions (and report); the
  Swagger/format/diff checks compare against the base branch.
- **Editors add a BOM** — writing `.tsp` with a BOM-adding encoding corrupts line 1;
  write UTF-8 **without** BOM and preserve the file's original line endings.
