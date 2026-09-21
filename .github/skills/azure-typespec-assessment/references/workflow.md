# Complete Read-Only Workflow

Run the assessment in order. Each phase reference is self-contained; load only
the phase currently being performed.

1. [Prepare and run deterministic analysis](workflow/preparation.md).
2. When preparation reports `awaiting-agent-judgment`, complete the
   [bounded Agent judgment](workflow/agent-judgment.md).
3. Perform the [Azure Guidelines search and materialize the decisions](workflow/compliance-and-materialization.md).
4. [Finalize and serve the validated report](workflow/finalization.md).

Do not skip phases, substitute manual repository inspection for preparation, or
stop between preparation and Agent judgment. Assessment is complete only after
guarded finalization produces validated `assessment.json` and
`assessment.html`.
