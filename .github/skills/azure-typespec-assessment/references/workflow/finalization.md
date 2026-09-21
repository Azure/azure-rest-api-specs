# Guarded Finalization and Report Serving

After materialization, run:

```powershell
node (Join-Path $Skill "scripts\finalize-assessment.mjs") --work $Work
```

The finalizer re-verifies canonical artifact hashes; validates inference,
shared guideline evidence, and judgment coverage; assembles and validates the
complete assessment; and atomically writes `assessment.json` and
`assessment.html`. Failure to produce both valid artifacts is failure.
`workflow-state.json` records preparation, Agent artifact, finalization,
completion, blockers, artifact hashes, and phase timings.

After rendering, start the report server through the host's attached background
or long-lived process mechanism:

```powershell
node (Join-Path $Skill "scripts\serve-assessment.mjs") `
  --file (Join-Path $Work "assessment.html")
```

Do not detach at shell level. Wait for startup output, then provide its
`http://127.0.0.1:<port>/assessment.html` URL as the clickable **Assessment
report** link and the absolute `assessment.json` path for structured results.
Keep the server running while viewed. Do not use relative Markdown or `file:`
URLs.

Standalone rendering accepts an explicitly selected matching graph artifact:
append `--downstream-input (Join-Path $Work
"dimensions\downstream-breaking-input.json")`. Guarded finalization supplies it
automatically. The JavaScript API is
`renderAssessmentHtml(assessment, { downstreamInput })`; one-argument callers
remain supported. The renderer verifies root associations and recorded evidence
facts before using method-to-type paths and rejects mismatched snapshots. It
does not discover adjacent inputs or modify assessment data. Without verified
raw input, recorded method associations remain visible, while precise paths,
locations, and comparison roles are explicitly unavailable; aggregate root
locations are not shown as per-method evidence.

For a verified replay whose reconstructed root IDs differ, also pass
`--downstream-assessment <matching-replay-assessment.json>` (API option
`downstreamAssessment`, parsed JSON). Repository and comparison must match
exactly, as must complete downstream findings except `rootCauseIds`. The
renderer bridges only root associations, verifies candidate membership and raw
evidence facts, and leaves authoritative judgments, contracts, grouping, and
Semantic relationships unchanged. Persist both selected sidecars with the
report when reproducibility requires them; neither is auto-discovered.

If materialization or assembly rejects schema or coverage, send only compact
errors to the same Agent for **one correction turn**. Correct
`agent-workspace\agent-decisions.json`, rerun materialization, then guarded
finalization. Do not rerun preparation, compilation, analyzers, or create an
independent judgment. If correction still fails, stop and report the blocker.
