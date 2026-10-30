# Azure TypeSpec assessment eval

`assessment.eval.yaml` contains seven checks:

- two prompts that must invoke `azure-typespec-assessment`;
- one authoring prompt that must invoke `azure-typespec-author`;
- one SDK generation prompt that must invoke
  `azsdk-common-generate-sdk-locally`;
- one live PR entry-point check that invokes the coordinator first (not a
  full-assessment or report-quality test);
- one local entry-point check against an explicitly supplied `HEAD` baseline;
- one no-changes assessment that invokes the production coordinator against a
  temporary Git repository and verifies its command, files, structured status,
  workflow state, and response.

The local checks prepare a temporary Git repository and need no live service or
compiler execution. The PR check needs GitHub access and the sparse cache
referenced by `agent_environment.git`; the pipeline primes that cache automatically.
The eval contains no assessment replay data, benchmark fixtures, or custom eval
scripts.

Always pass `--skill-dir .` when running from `.github\skills`. Execution checks
use the original skill directory so its dependency resolver can find the repository's
pnpm workspace and lockfile. Routing-only checks declare `agent_environment.skills`
to restrict skill selection; Vally copies those skills into an isolated workspace.

From `.github\skills`, run:

```powershell
vally lint azure-typespec-assessment `
  --eval-spec azure-typespec-assessment\evals\assessment.eval.yaml --strict
vally eval -e azure-typespec-assessment\evals\assessment.eval.yaml `
  --skill-dir . --workers 1 --max-retries 0 `
  --output jsonl --output-dir <output-directory>
```

The manual `eng\pipelines\azure-typespec-assessment.yml` pipeline uses Node 24,
the pinned Vally CLI in `eng\common\scripts\eval`, and the configured Copilot PAT.
`SkillBranch` overlays the assessment skill's instructions, references, scripts,
and package manifest, but preserves the pipeline branch's evaluation cases.
The selected skill must remain compatible with that branch's pnpm workspace
and lockfile. Summary publishes test failures without failing the pipeline
(`failOnFailedTests: false`); missing or incomplete result artifacts still fail
summary validation.
