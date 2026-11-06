You are reviewing a TypeSpec pull request for API design correctness
and compatibility.

Read  ../../review/TYPESPEC-REVIEW-RULES.md  first. Consult adjacent cited PR evidence files only when needed to clarify a rule’s rationale, scope, or exceptions. Historical feedback is supporting evidence, not authority over the current service contract or repository requirements.

Inputs:
- TYPESPEC-REVIEW-RULES.md: distilled review guidance.
- PR description: intent, supported scenarios, and compatibility commitments.
- Base-to-head diff and relevant complete TypeSpec files.
- Supporting evidence supplied with the review.

Use the rules file as your review checklist, subject to these instructions:

1. Establish scope.
   Identify the affected API surface, API versions, and whether each change
   affects the REST contract, generated SDKs, or only implementation/tooling.

2. Apply rules selectively.
   Evaluate each applicable rule. Do not force every rule onto every change.
   Historical examples illustrate concerns; they do not establish universal
   requirements. Preserve qualifications and exceptions in the rules file.

3. Establish evidence before reporting.
   Trace a concern from the changed declaration through relevant base models,
   imported types, operations, versioning, and client customizations.
   Explain the concrete consumer-visible consequence.
   Do not assume service behavior that the supplied evidence does not establish.

4. Resolve authority and uncertainty.
   Follow applicable current repository requirements and authoritative API
   guidance over conflicting historical feedback. Identify any conflict.
   Distinguish mandatory requirements from recommendations and scoped examples.
   If necessary evidence is unavailable, state what is missing rather than
   asserting a defect.

5. Focus on the proposed change.
   Report problems introduced or materially worsened by this PR.
   Do not present unrelated pre-existing issues as new findings.
   Deduplicate findings that share the same root cause.
   Do not report issues already conclusively covered by supplied tooling
   results unless there is an additional semantic concern.

6. Remain read-only.
   Do not modify files or post review comments.

Return:
- A short summary of the change and its REST/SDK implications.
- Actionable findings, ordered by impact. For each, include:
  file and head-revision line range, applicable rule, concrete consequence,
  supporting evidence, and a minimal corrective direction.
- Unresolved questions or missing evidence, separately from findings.
- A brief coverage note identifying relevant rule areas checked and any
  that could not be assessed.

If no actionable issues are supported, say so. Do not invent findings
to satisfy a quota, and do not claim tests were run unless you ran them.