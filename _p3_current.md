Parent epic: #16344

## Goal

Turn Vally results into actionable insight without standing up a separate data warehouse: inspectable trajectories, a durable pipeline history, a dashboard, and AI-generated quality trend reports -- all sourced directly from pipeline run artifacts instead of a Kusto ingestion pipeline.

## Scope

### A. Results UX (local + CI) -- was #15861
- Self-contained HTML trajectory viewer per stimulus (local-first).
- Append-only `history.csv` for cross-run trend analysis.
- Nightly CI wiring: upload artifact, point CSV `trajectory_url` at the artifact.
- Granular sub-issues #15862, #15863, #15866 continue to track the individual scripts.

### B. Result identifiers & failure taxonomy -- trimmed from #16346
- Versioned scenario IDs stable across file/name refactors.
- Failure taxonomy: pass / grader failure / execution error / timeout / auth error / infra error / skipped -- captured directly in `results.jsonl`/`history.csv` so the dashboard and AI reports don't need a separate ingestion/schema pipeline to get it.

### C. Durable pipeline retention -- new
- Wire `eng/common/pipelines/templates/steps/retain-run.yml` into the eval pipelines (`skill-eval.yml`, `workflow-eval.yml`, `live-eval.yml`); today none of them set a retention lease, so runs fall back to the ADO project's default (~30 day) retention window.
- Pick and document a retention window long enough to support the trend queries in D/E.

### D. Dashboard integration -- was #16268 (co-owned with epic #15726)
- Read pass-rate trends, per-run timing, and per-category breakdowns directly from `history.csv` and retained pipeline run artifacts -- no Kusto ingestion step.
- Surface this in the SDK framework's existing reporting surface.
- Also tracked under the "[Epic][TypeSpec Authoring][Benchmark] Continuous improvement" epic (#15726) -- coordinate with that epic's owners before making structural changes here.

### E. AI trend reports -- was #16351 (depends on C and D)
- Daily/weekly AI summaries generated directly from `history.csv` and retained pipeline history (no Kusto dependency).
- Every regression links to source build + trajectory evidence.
- Remediation proposals (prompt fixes, timeout tuning, missing mocks) are reviewable only, never auto-applied, never auto-weaken thresholds/graders.

## Sequencing

A and B land together (same artifacts). C (retention wiring) can happen any time but must land before D/E need more than the default ~30-day history window. D depends on B/C. E depends on D.

## Acceptance criteria

- [ ] Trajectory HTML + history CSV shipped and wired into nightly CI (A).
- [ ] Scenario IDs are stable and the failure taxonomy is captured in results/history output (B).
- [ ] Eval pipelines have an explicit retention lease covering the dashboard/report trend window (C).
- [ ] Dashboard surfaces trends/timing/category breakdowns read directly from pipeline history, coordinated with epic #15726 (D).
- [ ] AI reports link every regression to build/trajectory evidence, sourced from retained pipeline history, and require human review before any fix lands (E).

## Related

Supersedes and closes #15861, #16346, #16350, #16268, #16351. Part of #16344. Kusto ingestion (#16350) is dropped entirely, not replaced 1:1 -- dashboard/report data comes directly from pipeline artifacts instead. Scope item D remains cross-linked with epic #15726.

