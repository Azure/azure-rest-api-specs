# Complete Read-Only Workflow

Run the assessment in order. Each phase reference is self-contained; load only
the phase currently being performed.

1. [Prepare and run deterministic analysis](workflow/preparation.md).
2. When preparation reports `awaiting-agent-judgment`, complete the
   [bounded Agent judgment](workflow/agent-judgment.md).
3. Perform the [Azure Guidelines search and materialize the decisions](workflow/compliance-and-materialization.md).
4. [Finalize and serve the validated report](workflow/finalization.md).

In fast mode (`--assessment-mode fast`), preparation emits no Azure Guidelines
search requests. Skip guideline catalog scoring, retrieval, and judgments in
steps 2-3. Complete Semantic intent summaries, REST breaking, downstream SDK
breaking, Documentation Completeness, and the same guarded finalization.
Preserve the full report layout and intent links; Azure Guidelines remains
visible with `0 findings` and a skipped status.

Do not skip phases, substitute manual repository inspection for preparation, or
stop between preparation and Agent judgment. Assessment is complete only after
guarded finalization produces validated `assessment.json` and
`assessment.html`, the attached report server is running, and the response
includes its clickable `http://127.0.0.1:<port>/assessment.html` URL.
