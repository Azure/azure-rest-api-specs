<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-05-31
     Source of truth for the downstream-CI impact-check procedure shared
     between Reviewer Step 4.5 and Critic Re-validation step 4.5. Both
     agents reference this file; do not restate the procedure in either
     agent file. Conflict-aware rule entries live in
     `linter-rule-coverage.md`. -->

# Downstream-CI impact check

A review recommendation that **adds or tightens** a type, format,
decorator, `x-ms-*` extension, or schema constraint can produce
generator output that itself fails a required LintDiff / SDK-breaking
rule. The canonical example is recommending `format: uuid` on an ARM
control-plane property: the resulting Swagger trips
[`R3017 GuidUsage`](./guid-and-uuid-on-arm.md), which is a required CI
check, so the recommendation blocks the PR it was meant to improve.

This check exists to keep the agents from posting that class of
recommendation as-is. The procedure runs at two points:

- **Reviewer Step 4.5** -- before assembling the Step 6 report. The
  Reviewer authors the recommendation to comply with the rules below.
- **Critic Re-validation step 4.5** -- before the Reviewer's report is
  presented for posting. The Critic verifies the Reviewer's
  recommendation complies with the rules below.

Both perform the same checks; the role split is "author vs. verify."

## Scope: when this check applies

A finding falls in scope if **all** of the following are true:

1. The finding's proposed fix would add or tighten a type, `format`,
   decorator, `x-ms-*` extension, or schema constraint in the output
   Swagger (this includes TypeSpec source changes that emit such output).
2. The affected rule area has a row in
   [`linter-rule-coverage.md`](./linter-rule-coverage.md) flagged
   `⚠️ Conflict-aware`.
3. The conflict-aware row points at a dedicated reference file
   documenting the acceptable / unacceptable cases and the required
   suppression form (e.g., [`guid-and-uuid-on-arm.md`](./guid-and-uuid-on-arm.md)).

Findings outside that scope are not subject to this check. If
`linter-rule-coverage.md` is missing a row for the affected rule,
**do not invent one**: downgrade the finding to a question for the
author or drop it.

## Required shape of an in-scope finding

The Reviewer's finding (and any Critic re-statement of it) **MUST**
satisfy all five:

1. **Multi-option recommendation, not a directive.** The finding
   presents the option set specified in the dedicated reference file
   (typically: apply the fix + scoped suppression, keep the current
   shape, or ARM reviewer override). It does not tell the author "you
   must add `format: uuid`."
2. **Default severity is Suggestion** unless the property unambiguously
   meets the "acceptable" criteria documented in the reference file.
3. **Suppression `where:` matches the actual generator output.** For
   TypeSpec-generated specs, suppressions on shared scalars
   (`Azure.Core.uuid`, etc.) target the **shared definition**, not the
   per-property `$ref` paths. The reference file documents Form A
   (TypeSpec) vs Form B (handwritten OpenAPI).
4. **`where:` equals the LintDiff `jsonpath` exactly, segment for
   segment, including the trailing leaf segment** (`.format`, `.type`,
   `.x-ms-secret`, etc.). The validator's `where:` is an **exact-match**
   comparison, not an ancestor match. An ancestor `where:` (e.g.,
   `$.definitions["Azure.Core.uuid"]` when the violation is at
   `$.definitions["Azure.Core.uuid"].format`) silently does not match
   and the failure persists.
   - If a failing LintDiff run exists on the PR, the finding **MUST**
     quote the validator's reported `jsonpath` array verbatim
     (e.g., `["definitions", "Azure.Core.uuid", "format"]`) and render
     the `where:` clause from it.
   - If no failing run exists yet, the suppression form **MUST** be
     labeled `provisional, confirm where: against the first failing run`
     and the recommendation **MUST** instruct the author to commit the
     suppression only after the first LintDiff run, using the exact
     `jsonpath` it reports.
5. **The per-comment telemetry marker carries `downstream-rule:
<rule-id>`** (e.g., `downstream-rule: R3017`). The Critic uses this
   field to identify in-scope findings.

## Failure modes (Critic FAILs)

The Critic returns a non-overridable FAIL when any of the following is
true. **Non-overridable** means the per-comment `critic: override`
marker does NOT clear it -- see
[protocol → Non-overridable FAIL catalog](../../../agents/protocols/arm-api-review-critic.protocol.md#non-overridable-fail-catalog).

| Critic FAIL                 | Triggered when                                                                                                                | Recovery                                                                                           |
| --------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| `downstream-ci-conflict`    | Required shape items 1, 2, 3, or 5 are not satisfied; or the `downstream-rule:` marker is missing on an in-scope finding.     | Reviewer rephrases the finding as a multi-option recommendation with the correct suppression form. |
| `suppression-path-mismatch` | Required shape item 4's exact-match check fails (rendered `where:` does not equal the quoted `jsonpath` segment-for-segment). | Reviewer re-renders `where:` from the quoted `jsonpath` array verbatim.                            |
| `rule-not-found`            | The `downstream-rule:` value does not appear in [`linter-rule-coverage.md`](./linter-rule-coverage.md).                       | Reviewer cites a real entry or drops the finding; do not invent coverage entries.                  |

Self-checks by the Reviewer do not substitute for this verification --
the Critic re-runs the procedure independently.

## Source rule pointers

- Conflict-aware rule catalog:
  [`linter-rule-coverage.md`](./linter-rule-coverage.md)
- GUID / UUID on ARM (the canonical conflict-aware case):
  [`guid-and-uuid-on-arm.md`](./guid-and-uuid-on-arm.md)
- Reviewer Step 4.5 entry point:
  [`arm-api-reviewer.agent.md` → Step 4.5](../../../agents/arm-api-reviewer.agent.md#step-45-downstream-ci-impact-check-mandatory)
- Critic Re-validation step 4.5 entry point:
  [`arm-api-review-critic.agent.md` → Step 4.5](../../../agents/arm-api-review-critic.agent.md#step-45-re-verify-downstream-ci-impact-mandatory)
