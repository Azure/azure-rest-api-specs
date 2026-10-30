# Prompt 05 — Generate documentation-gap report

You are producing the final documentation-gap report for the
`azure-typespec-author` skill.

## Input

Read the Step 4 `analysis.md` path provided by the orchestrator. Treat that analysis as
the only source for eval results, pass rates, failure evidence, and gap attribution.
Do not inspect older result directories or invent evidence that is not in the analysis.

## Task

Convert the analysis into a concise, actionable report for skill maintainers:

1. Summarize the evaluated suites, overall result, and the most important systemic
   failures.
2. Preserve the per-case pass rates and concrete failing-grader evidence.
3. Separate confirmed documentation-coverage gaps from skill-logic, eval-scoring, and
   flaky/one-off failures.
4. For every confirmed documentation gap, identify:
   - affected cases;
   - missing or ambiguous guidance;
   - the evidence supporting the attribution;
   - the reference file or public documentation area that should be improved.
5. Do not classify a failure as a documentation gap without evidence from Step 4.

## Output

Write the report to the exact path supplied by the orchestrator, replacing any existing
file at that path.

Use this structure:

```markdown
# Azure TypeSpec Author Documentation Gap Report

## Evaluation Summary

## Per-Case Failure Analysis

## Confirmed Documentation Gaps

## Non-Documentation Failures
```

If no documentation gaps are confirmed, state that explicitly under
`Confirmed Documentation Gaps`; do not manufacture recommendations.
