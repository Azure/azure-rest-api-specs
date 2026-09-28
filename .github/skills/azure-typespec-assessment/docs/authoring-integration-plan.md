# Authoring and Assessment Integration Plan

Status: Implemented.

## Goal

Integrate `azure-typespec-assessment` into the validation workflow of
`azure-typespec-author`. Add a fast assessment mode that skips Azure Guidelines
assessment while retaining semantic analysis, REST and downstream SDK
breaking-change checks, and documentation completeness.

Full assessment remains the default for standalone use. Both modes produce a
validated report, highlight findings in the response, and provide a clickable
report link.

For the first version, authoring invokes assessment exactly once after existing
validation completes, presents the findings and report link, then stops. Neither
skill automatically changes source code to mitigate assessment findings.
Remediation requires a separate explicit user request. When the user asks to fix
findings, authoring updates the code, validates it, and invokes assessment once
again to generate a fresh report. "Once" applies to each user-requested authoring
or remediation pass, not to the entire conversation.

## Current Behavior

- The assessment skill explicitly prohibits invocation from the authoring skill.
- Assessment requires guideline search and compliance coverage throughout its
  workflow and output contract.
- Authoring validation runs TypeSpec validation, compilation, and applicable
  case-specific checks, but does not generate an assessment report.
- Assessment completion already requires validated JSON and HTML artifacts and
  a running localhost report server.

The integration requires coordinated instruction and runtime changes, rather
than only an additional authoring instruction.

## Proposed Changes

### 1. Add an Explicit Assessment Mode

Introduce `--assessment-mode full|fast`, defaulting to `full`.

- Persist the selected mode through analysis, Agent inputs, materialization,
  finalization, and report data.
- Reject unsupported mode values explicitly.
- Preserve the existing Git comparison scope and baseline requirements.
- Preserve existing full-mode behavior and compatibility with existing reports.

### 2. Skip Guideline Work End to End in Fast Mode

Fast mode skips only Azure Guidelines assessment:

- Do not generate guideline search requests.
- Do not rank the official document catalog or fetch guideline documents.
- Do not require compliance judgments or guideline evidence for completion.
- Keep semantic analysis, REST and downstream SDK checks, optional inference,
  and compiler-derived documentation completeness checks.
- Preserve evidence integrity and exact coverage checks for active dimensions.
- Represent the guideline dimension explicitly as "Skipped - fast mode", not
  as passed or as an accidental blocker.
- Update schemas, runtime types, materialization, assembly, and validation to
  support this distinction without weakening full-mode requirements.

### 3. Highlight Findings and Link the Report

The final response should provide:

- A concise summary of detected REST breaking changes, downstream SDK breaking
  changes, and missing documentation.
- An explicit statement when no findings were detected.
- Any incomplete assessment or blocked checks, distinguished from a clean
  result.
- A clickable **Assessment report** link using the existing localhost report
  server.
- The absolute path to `assessment.json` for structured results.

The report must identify the selected mode and label Azure Guidelines as
skipped in fast mode. Existing full-mode guideline findings remain visible.
Retain the existing guarded finalization and report-serving requirements.

#### Non-Blocking Invitation to Request Fixes

When a completed assessment has findings, place a short invitation after the
findings summary and report link. Do not automatically open a confirmation
dialog or wait for a decision; finish the report-only response.

Example wording (replace counts and the link with actual assessment results):

> **Assessment found 3 issues:** 2 downstream SDK breaking changes and 1 missing
> documentation finding.
>
> [View assessment report](actual-served-report-url)
>
> No fixes were applied. To request fixes, reply **"Fix all findings"**,
> **"Fix downstream breaking changes"**, or **"Fix finding 2."** I'll update the
> code, validate it, and generate a fresh report.

"No fixes were applied" refers to assessment-driven remediation, not the
preceding user-requested authoring changes. After a remediation pass, instead
state that no further fixes were applied after reassessment.

Give findings visible identifiers linked to existing canonical finding IDs and
report anchors. Keep the mapping stable within each report so a request such as
"Fix finding 2" resolves unambiguously to the report the user is referencing;
do not silently reinterpret old numbers against a newer report.

Omit the invitation when no findings are detected. If assessment is incomplete,
explain the blocker and identify any findings as partial rather than presenting
them as a complete set to fix. An explicit fix request authorizes scoped
remediation, not arbitrary API redesign; clarify design-sensitive choices before
editing.

### 4. Invoke Fast Assessment from Authoring Validation

Add **Step 5.3 - Fast assessment** after general validation and all applicable
case-specific validation have completed.

- Invoke `azure-typespec-assessment` exactly once per completed authoring
  workflow, with fast mode and the authored project scope.
- Reuse an explicitly supplied or confirmed comparison baseline. If none is
  available, ask the user before starting assessment; do not silently choose
  `origin/main`.
- Follow the assessment coordinator-first workflow once the baseline is known.
- Generate the assessment from the final validated changes, including the
  existing staged, unstaged, and relevant untracked scope.
- Remove the assessment skill's standalone-only integration prohibition while
  preserving its read-only boundary.
- Report assessment findings separately from compilation or validation errors.
  Step 5.3 is report-only: do not apply authoring's "fix every failed check"
  instruction to assessment findings, even when they identify breaking changes
  or missing documentation.
- After assessment, present the findings and report link, output authoring's
  reference links, and stop. Do not edit source to mitigate findings or
  automatically run another assessment to obtain a clean result.
- Any remediation requires a separate explicit user request. Automatic
  fix-and-reassess cycles are out of scope for the first version.
- Existing validation fixes occur before this single assessment invocation.
  Assessment's bounded correction of invalid decision/report artifacts may
  remain within that invocation; it must not change assessed source or restart
  the authoring workflow.
- Preserve authoring's existing guideline research and reference-link output.
  Fast mode skips only the assessment's guideline pass.

#### User-Requested Remediation and Reassessment

Support follow-up requests such as "fix the findings" or "fix the downstream
breaking changes" as a new authoring pass:

1. Use the previous report to identify the requested findings and confirm any
   ambiguous scope or design decisions. Route source changes through
   `azure-typespec-author`; assessment itself remains read-only.
2. Apply scoped fixes and complete the existing general and applicable
   case-specific validation.
3. Invoke assessment once on the updated source to generate fresh JSON and HTML
   artifacts. Retain the previously confirmed comparison baseline and scope
   unless the user requests a change; preserve the resolved baseline commit
   rather than silently advancing a moving ref such as `HEAD`. Use fast mode
   for the authoring handoff unless the user explicitly requests full assessment.
4. Serve and link the new report, clearly identifying it as the updated result.
   Summarize fixes and any remaining or new findings. Do not present the previous
   report as evidence for the modified source or claim findings are resolved
   without fresh assessment evidence.
5. Stop after reporting. Remaining findings do not authorize further automatic
   source edits or another assessment cycle. The user may request another
   remediation pass.

If validation or reassessment is blocked, report the blocker and identify the
previous report as stale for the modified source; do not claim a fresh report
was generated.

### 5. Align Instructions and Documentation

Update the directly related surfaces:

- Both skills' `SKILL.md` files.
- Authoring's `references/validation.md`.
- Assessment's workflow overview and phase references.
- Assessment's output contract.
- Assessment's usage and architecture documentation.
- Related workflow evaluations.

Document the mode defaults, skipped-dimension semantics, baseline handoff,
read-only boundary, findings summary, and report-link completion requirement
consistently. Explicitly distinguish the report-only assessment step from the
existing validation checks that require fixes. Document the explicit
user-requested remediation path and its fresh-report requirement.

#### Remove Conflicting Invocation Prompts

As part of implementation, remove or replace the earlier instructions added to
prevent authoring from invoking assessment. Do not leave a new integration
instruction alongside an older prohibition.

- In assessment's `SKILL.md`, replace the Boundaries bullet beginning "V1 is
  standalone and opt-in". Remove its explicit prohibition on invocation from
  `azure-typespec-author`, its prohibition on automatic post-validation
  assessment, and the statement that integration is deferred. Permit standalone
  assessment on explicit request and fast assessment from authoring Step 5.3.
- In `evals/assessment.eval.yaml`, clarify the `anti-trigger-author-typespec`
  routing test. Its current prompt only loads the initial skill and prohibits
  file inspection or edits, so assessment should still not run at that point.
  Rename or describe it as an initial-routing check rather than a blanket
  prohibition on authoring-to-assessment invocation. Add separate coverage that
  requires assessment after authoring validation.
- Search related skill references, repository instructions, documentation, and
  evaluation prompts for equivalent standalone-only restrictions and update any
  remaining conflicts. Preserve restrictions unrelated to this integration,
  including the SDK-generation routing exclusion and assessment's prohibition
  on modifying TypeSpec source.

These prompt changes are included in the implementation.

### 6. Add Focused Regression Coverage

Extend the existing tests and evaluations to cover:

- Default invocation retains full assessment behavior.
- Explicit full mode retains guideline search and judgment requirements.
- Fast mode propagates through the complete artifact pipeline.
- Fast mode generates no guideline requests and requires no guideline judgments.
- Fast mode preserves REST, SDK, and documentation findings.
- Skipped guidelines are rendered explicitly and never reported as passed.
- Invalid modes fail explicitly.
- No-change and blocked outcomes remain accurate.
- Guarded finalization retains schema, evidence, and coverage safeguards.
- Authoring invokes fast assessment exactly once after existing validation and
  returns a findings summary with the report link.
- A report containing findings does not cause source edits, another assessment
  invocation, or re-entry into authoring validation. Verify that assessed source
  remains unchanged through assessment and the final response.
- An explicit follow-up request to fix findings routes to authoring, updates the
  requested code, validates it, and invokes assessment once again with the same
  confirmed comparison baseline and scope.
- The remediation response links a newly generated report reflecting the fixed
  source and reports remaining findings without starting another automatic
  remediation cycle. Blocked reassessment never reuses a stale report as current.
- Completed assessments with findings include the non-blocking fix invitation
  without opening a confirmation dialog. Clean results omit it, and incomplete
  results clearly disclose blockers and partial coverage.
- Requests targeting a finding identifier resolve to the referenced report's
  canonical finding, including when a newer report has different numbering.
- Existing full-mode reports remain supported.

Use the existing Node test runner for targeted script tests and the existing
skill evaluation tooling for workflow checks. Expand test scope when failures
indicate broader effects.

### 7. End-to-End Test with the Employee Baseline

Run this manual integration test after implementation. It exercises two
user-requested passes: initial authoring and reporting, followed by explicit
remediation and a second report.

#### Preparation

- Use `specification\widget\resource-manager\Microsoft.Widget\Widget` as the
  TypeSpec project.
- Start from the restored demo baseline originating in commit
  `b83d8cc958c0a142d0d8baebc479dbd6dfb42a37`: `UpdateEmployeeState` extends
  `EmployeeActionConfig`, the scoped `composition-over-inheritance` suppression
  exists, and neither API version has a `reason` property.
- Verify the action and its examples exist in both `2021-11-01` and
  `2024-10-01-preview`.
- With explicit user authorization, commit the restored baseline separately
  before the demo edits and record its resolved commit SHA. Supply or confirm
  that SHA as the comparison baseline for both reports. Do not compare against a
  revision that lacks the inherited action, as that would test a new API rather
  than a compatibility change.
- Load the implemented skills and ensure the required validation tools and
  compiler are available. Keep report artifacts outside assessed source, using
  separate work directories for the first and second reports.

#### First Pass: Author and Inspect the First Report

Send this prompt to the agent:

> Help me fix the suppression first, then add an optional reason to the employee
> state-update action, so callers can explain why they're enabling or disabling
> an employee.

Confirm the project and recorded baseline if asked. Specify
`2024-10-01-preview` as the target for the optional reason if the agent asks;
the stable API must not gain the property.

Verify the following:

- The agent uses authoring, applies the requested changes, updates the preview
  example, and completes existing validation.
- The agent invokes fast assessment exactly once and produces the first JSON
  and HTML report.
- Open the returned report link. Check that it identifies the correct baseline
  and project, labels Azure Guidelines as skipped, and shows actual findings
  from the modified source.
- If authoring replaces inheritance with a spread to remove the suppression,
  the report should identify the downstream compatibility impact even if REST
  compatibility is preserved.
- The response highlights findings and includes the report link and
  non-blocking invitation to request fixes.
- After reporting, the agent does not change source or launch another
  assessment on its own. Preserve the first report and the assessed source
  snapshot for comparison.

Do not require the authoring agent to introduce a break or fabricate a finding.
If it preserves inheritance and the first report has no findings, record that
as a valid clean first pass; it does not exercise remediation. To cover the
remediation path deterministically, use a separately authorized negative-test
variant that replaces inheritance with a spread, assess it, and then run the
follow-up below. Keep that variant distinct from the unmodified prompt test.

#### Second Pass: Request Fixes and Inspect the Second Report

After reviewing the first report's findings, send:

> Help me to fix them.

Verify the following:

- The agent resolves "them" to the findings in the first report, using authoring
  for source changes and clarifying any genuinely ambiguous design choices.
- For the inheritance regression, the fix preserves or restores
  `UpdateEmployeeState extends EmployeeActionConfig` with a justified scoped
  suppression, while retaining the optional preview-only `reason` property.
- The agent validates the fixes and invokes assessment exactly once more,
  against the same resolved baseline SHA and project scope.
- The agent generates fresh JSON and HTML artifacts in the second work
  directory, serves the second report, and returns its clickable link rather
  than the first report's link.
- Open the second report and verify the requested findings are resolved based
  on fresh evidence. The stable API still lacks `reason`, the preview API
  includes it as optional, and the inheritance relationship is preserved.
- Any remaining or new findings are reported honestly. The agent stops without
  automatically starting a third fix-and-assess cycle.

Record both report URLs and JSON paths, the shared baseline SHA, the findings
before and after remediation, and the two assessment invocations. If validation
or report generation is blocked, record the test as incomplete, not passed.

## Acceptance Criteria

1. Standalone assessment defaults to full mode without changing existing
   behavior.
2. Fast mode skips guideline assessment only and retains the other dimensions.
3. JSON and HTML distinguish intentionally skipped guidelines from passed,
   failed, and blocked assessment.
4. Authoring validation invokes fast assessment exactly once against a confirmed
   baseline and the authored project scope after its existing checks.
5. Successful assessment returns prominent findings and a working clickable
   report link.
6. Assessment remains read-only. Authoring presents findings and the report link
   without automatically modifying source to mitigate findings or invoking
   assessment again. Remediation requires a separate explicit user request.
7. Related instructions, contracts, tests, and evaluations agree on the new
   behavior.
8. No active prompt prohibits the intended authoring Step 5.3 assessment call;
   initial skill routing still selects authoring before any validation occurs.
9. Users can explicitly request fixes to reported findings. Each such remediation
   pass updates and validates the code, then generates and links a fresh
   assessment report once, without an autonomous fix-and-reassess loop.
10. Completed reports with findings include a concise invitation explaining how
    to request all, category-specific, or individual fixes. The response ends
    without requiring a decision or starting remediation.

## Implementation Status

The fast assessment mode, authoring handoff, report-only behavior,
user-requested remediation path, output contract, and focused regression tests
described above are implemented. The restored Employee project remains the
manual end-to-end test baseline.
