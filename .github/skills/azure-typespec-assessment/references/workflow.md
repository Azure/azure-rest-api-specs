# Complete Read-Only Workflow

Run the 3-stage assessment in order. Each reference is self-contained; load only
the phase currently being performed.

1. **Stage 1 — Deterministic Preparation & Analysis:**
   [Prepare and run deterministic analysis](workflow/preparation.md).
2. **Stage 2 — Unified AI Judgment & Post-Judgment Source Association (Single Agent Context):**
   - **Step 2a (Judgment & Guidelines):** When preparation reports `awaiting-agent-judgment`, complete the [bounded Agent judgment](workflow/agent-judgment.md) and [Azure Guidelines search, judgment materialization, and source association](workflow/compliance-and-materialization.md).
   - **Step 2b (Source Association in the same AI turn):** When `materialize-assessment-results.ts` reports `sourceAssociationRequired: true`, associate canonical TypeSpec source for confirmed REST/downstream breaking findings in the same AI turn (`materialize-assessment-results.ts --work <work> --source-association`). Zero confirmed breakings automatically record `not-applicable` and transition directly to `ready-for-finalization`.
3. **Stage 3 — Guarded Finalization & Serving:**
   [Finalize and serve the validated report](workflow/finalization.md).

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

Use the originating runtime commands in the Agent index throughout the run.
Phase integrity is based on the runtime binding, successful phase records, and
input/output content hashes. Filesystem timestamps and inode identity are not
integrity signals: touching a file or replacing it with identical bytes does
not invalidate a phase. Changed content or runtime code still requires recovery.
