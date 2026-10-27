# Release Plan Tool

Find or create an Azure SDK release plan from API specification changes, refresh
SDK details, and generate eligible management-plane SDKs. These are three separate
commands; creating a release plan does not itself generate SDKs.

## Prerequisites

- Node.js >=24.14.1 and the repository's pnpm version.
- Run `pnpm install` from the repository root.
- Install and authenticate the `azsdk` CLI with access to release plans.
- For discovery and SDK PR checks, provide GitHub authentication through
  `GITHUB_TOKEN`, `GH_TOKEN`, or an authenticated `gh` CLI, in that order. Posting
  comments also requires access to comment on the specification PR.
- Use a checkout containing the relevant TypeSpec projects and their dependencies.
  `--workspace` must identify the repository root. Discovery reads changed-file
  information from GitHub but compiles the **local checkout**; it does not check
  out `--commit-sha`.

The tool invokes `azsdk` from `PATH` by default. Set `AZSDK` to an executable path
to override it; the tool also adds the current user's home `bin` directory to
the child process's `PATH`.

## Commands

Run these examples from the repository root in PowerShell. Commands can create
release-plan work items, post PR comments, update SDK details, or start SDK
generation; they are not dry runs.

### Find or create a release plan

```powershell
pnpm exec create-release-plan `
  --commit-sha (git rev-parse HEAD) `
  --repo Azure/azure-rest-api-specs `
  --workspace . `
  --output-file .\out\release-plan.json
```

| Option                | Behavior                                                                                                                                               |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `--commit-sha`, `-c`  | Resolve an associated PR and inspect its changes, or inspect commit changes when no PR is associated. Required unless `--release-plan-id` is supplied. |
| `--release-plan-id`   | Retrieve an existing plan directly, bypassing discovery and creation. Takes precedence over `--commit-sha`.                                            |
| `--repo`, `-r`        | Repository in `owner/repo` format. Defaults to `GITHUB_REPOSITORY`, then `Azure/azure-rest-api-specs`.                                                 |
| `--workspace`, `-w`   | Local repository root; defaults to the current directory.                                                                                              |
| `--output-file`       | Write the result as JSON, in addition to logging it.                                                                                                   |
| `--test-release-plan` | Pass `true` to create a test release plan. Defaults to `false`; this is not a dry-run switch.                                                          |
| `--help`, `-h`        | Show command help.                                                                                                                                     |

Use the private repository name for private-preview processing:

```powershell
pnpm exec create-release-plan --commit-sha (git rev-parse HEAD) `
  --repo Azure/azure-rest-api-specs-pr --workspace . `
  --output-file .\out\release-plan.json
```

Retrieve a known plan without inspecting specification changes:

```powershell
pnpm exec create-release-plan --release-plan-id 12345 `
  --output-file .\out\release-plan.json
```

The result contains `outcome`, `releasePlan`, and `details`. Outcomes are
`created`, `existing_by_pr`, `existing_by_path`, `existing_by_id`, or `not_found`.
Downstream commands read the plan's `release_plan_details`, including
`ReleasePlanId`, `WorkItemId`, and `APISpecProjectPath`.

Discovery skips, including ambiguous projects or a missing resolvable API version,
do not write a result artifact. Use a fresh output location for each run so a
previous artifact cannot be mistaken for a new result.

### Refresh SDK details

```powershell
pnpm exec update-sdk-details --artifact-file .\out\release-plan.json --workspace .
```

`--artifact-file` is required. `--workspace` / `-w` defaults to the current
directory; `--help` / `-h` shows help.

For created or existing plans, the command retrieves the current plan and runs
`azsdk release-plan update` only when its status is `In progress`. It uses the
project path from the artifact and SDK release type from the retrieved plan,
then retrieves the plan again to report completion. The input artifact is not
rewritten.

### Generate SDKs

```powershell
pnpm exec generate-sdk --artifact-file .\out\release-plan.json --workspace .
```

This command accepts the same options as `update-sdk-details`. It retrieves the
current plan and generates eligible SDKs for .NET, Java, JavaScript, Python,
and Go through `azsdk spec-workflow generate-sdk`.

Automatic generation is limited to management-plane plans. Languages with
release exclusion status `Requested`, `Approved`, or `MissingEmitterConfig` are
skipped, case-insensitively. For existing plans, released SDKs and SDKs whose PRs
are merged are also skipped. Open or closed-unmerged SDK PRs permit regeneration;
an indeterminate PR status causes that language to be skipped. Newly created
plans generate every non-excluded language. Generation attempts continue after
a language fails, then the command fails with the list of failed languages.

## Architecture

```text
cmd/create-release-plan.js
  -> args.ts + index.ts
  -> typespec-project.ts
       GitHub commit -> associated PR + labels -> changed files
       (or commit files when no PR is associated)
       -> ancestor discovery -> metadata emitter -> project + API version
  -> release-plan.ts -> azsdk release-plan get/create
  -> JSON artifact + pr-comment.ts

JSON artifact
  -> cmd/update-sdk-details.js -> update-sdk-details.ts -> azsdk release-plan update
  -> cmd/generate-sdk.js -> generate-sdk.ts -> azsdk spec-workflow generate-sdk
```

`types.ts` defines the shared artifact and client contracts.
`sdk-workflow-common.ts` supplies shared value and project-path conversion.
GitHub access uses Octokit; metadata generation uses
`@azure-tools/specs-shared/typespec-metadata`. Metadata is cached per analysis
and reused for shared ancestors and API-version extraction.

### Project and API-version selection

Every changed directory under `specification` is inspected. Discovery searches
upward for `tspconfig.yaml` and runs the metadata emitter at each candidate.
A candidate qualifies when metadata contains at least one configuration for Java,
JavaScript/TypeScript, .NET (`csharp`), Python, or Go. AutoRest and the metadata
emitter alone do not qualify. The search includes the service directory directly
below `specification`, but never checks `specification` itself or higher folders.
If no candidate qualifies, the nearest existing config is retained as a fallback.

Resolved paths are deduplicated. Multiple subservices can therefore resolve to
one SDK project. If multiple project paths remain, automation creates no plan,
writes no artifact, and posts a PR comment listing the paths when a PR is known.

API-version selection normally uses the first metadata configuration with both
`apiVersion` and `packageName`; it does not sort versions. For
`azure-rest-api-specs-pr`, if that produces no version, any emitter's non-empty
`apiVersion` can be used without package metadata. Values such as `all` and
`multiple-versions` are preserved. If private-preview metadata provides no version,
the tool skips creation and posts an error comment with the project path.

The private repository always selects the `Private Preview` API release type.
Other repositories select `Public Preview` for versions ending in `-preview`,
otherwise `GA`. SDK release type is independently `beta` for that suffix and
`stable` otherwise, including for `all` and `multiple-versions`.

### Plan creation and comments

PRs labeled `FolderMigrationV2` or `Skip-ReleasePlan-Automation` are skipped before
changed files are fetched. Otherwise, the tool looks for an existing plan by PR
and API release type, then by project path, API version, and API release type.
Creation is allowed only when the PR has `new-api-version` or a `tspconfig.yaml`
appears in the changed files. Creating a plan also requires an associated PR.
The target release month is next month.

Successful creation comments include the plan link/ID, API version, and resolved
TypeSpec project path. Reusing an existing plan does not post a creation comment.
API-version resolution errors are reported on the associated PR; failures from
the subsequent plan operation are commented when creation was eligible.

### Pipeline integration

[`eng/pipelines/release-plan.yml`](../../pipelines/release-plan.yml) runs after
specification PRs merge into `main` or `RPSaaSMaster` when changes include `.tsp`
files or `tspconfig.yaml` under `specification`. It does not run as PR validation.

1. **ReleasePlanCreation** finds or creates a release plan using
   `create-release-plan`, refreshes eligible SDK details using `update-sdk-details`,
   and publishes the release-plan JSON artifact.
2. **GenerateSdk** downloads that artifact and invokes `generate-sdk`. SDK
   generation is limited to management-plane release plans.

Missing artifacts cause SDK generation to be skipped. The pipeline excludes
private-repository runs from SDK generation and excludes private-repository and
manual runs from the SDK-details update step. Those pipeline restrictions are
separate from the CLI commands' own eligibility checks.

## Development and testing

Run from `eng\tools\release-plan`:

```powershell
pnpm run build
pnpm run lint
pnpm run format:check
pnpm exec vitest run
pnpm run test:integration
pnpm run test:ci
pnpm run check
```

`build` type-checks without emitting JavaScript. `pnpm exec vitest run` runs unit
tests only. `test:integration` runs the real metadata emitter against repository
projects: Compute and its subservices, Bulkactions, HealthDataAIServices, and an
AutoRest-only AWS Connector project. Paths are relative to the repository, not a
developer's clone location. These tests require the specification files and
TypeSpec dependencies and take longer than unit tests.

The package's `test:ci` runs unit tests with coverage followed by integration
tests. `check` adds type, lint, and formatting checks. The repository-root Vitest
workspace uses the standard package config and does not invoke this package's
`test:ci` script; the separate integration suite is not automatically included
in that workspace run.
