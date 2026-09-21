# Azure TypeSpec Assessment

Use `azure-typespec-assessment` with your coding agent to review TypeSpec
changes and generate an assessment report without modifying your source.
Make sure the skill is available to your agent.

The coordinator verifies the assessment scripts' locked dependencies and runs
`npm ci` automatically when they are missing or stale. The first assessment
therefore requires npm registry access and a writable skill directory; later
runs reuse the installed dependencies.

## 1. Assess local code

Open your TypeSpec repository and ask:

```text
Use azure-typespec-assessment to assess the current TypeSpec changes in the Microsoft.ServiceNetworking/ServiceNetworking specification.
```

Replace the specification name with the one you are working on. Local assessment
is the primary experience; you do not need to open a PR first.

If you omit the baseline, the agent asks you to confirm `origin/main` or provide
another ref or commit ID before starting. You can specify a commit ID directly
to skip the question:

```text
Use azure-typespec-assessment to assess the current TypeSpec changes in the Microsoft.ServiceNetworking/ServiceNetworking specification against commit <commit-id>.
```

## 2. Assess a PR

Provide the PR URL:

```text
Use azure-typespec-assessment to assess the TypeSpec changes for PR https://github.com/Azure/azure-rest-api-specs/pull/44988.
```

The skill invokes the coordinator directly; it does not require a separate PR
checkout or manual project lookup. The equivalent CLI is:

```powershell
node <skill>\scripts\run-assessment-analysis.mjs `
  --repo $PWD `
  --pr https://github.com/Azure/azure-rest-api-specs/pull/44988 `
  --output <work-directory>
```

The PR mode requires authenticated `gh` and `git` commands. You may instead
assess locally available immutable commits without GitHub metadata:

```powershell
node <skill>\scripts\run-assessment-analysis.mjs `
  --repo $PWD `
  --base <base-commit> `
  --head <head-commit> `
  --output <work-directory>
```

For PR and explicit-head modes, the coordinator derives the changed TypeSpec
scope when `--specification` is omitted. It also writes
`agent-workspace\agent-index.json`, one bounded `model-input.json`, safe output
drafts, and `workflow-state.json`. API-version publication and version-wide
intents are reported deterministically without sending their operation facts
or exclusively associated candidates to the Agent.

After completing the bounded Agent decisions, finalize all outputs with one
guarded command:

```powershell
node <skill>\scripts\finalize-assessment.mjs --work <work-directory>
```

The command validates all Agent artifacts and canonical hashes before
atomically writing `assessment.json` and `assessment.html`.

Every coordinator invocation requires a new or empty output directory. This
prevents artifacts from an earlier Git comparison from being returned as a
current assessment.

## Results

The agent starts a local-only report server after rendering and returns a
clickable `http://127.0.0.1:<port>/assessment.html` link. Keep the assessment
session running while viewing the report. Structured results remain available
at the absolute `assessment.json` path returned by the agent.

[Browse reports for 12 existing PRs](https://wonderful-coast-0b5cc5a00.3.azurestaticapps.net)
or read the [high-level design spec](https://github.com/Azure/azure-sdk-tools/blob/main/tools/azsdk-cli/docs/specs/typespec-assessment.spec.md)
and [detailed design](design.md).
