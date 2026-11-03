# Release Plan Auto-Generation

This document explains how release plans are automatically discovered or created by the `eng/tools/release-plan` tool and the `eng/pipelines/release-plan.yml` pipeline.

## Overview

The release-plan pipeline is a post-merge automation for specification updates.

High-level lifecycle:

1. A spec PR merges into `main` in `Azure/azure-rest-api-specs` or `Azure/azure-rest-api-specs-pr`.
2. The pipeline is triggered by changes under `specification/**`.
3. Stage (`ReleasePlanCreation`) runs and resolves the commit SHA to analyze.
4. The tool tries to map the commit to an associated PR and inspects TypeSpec changes.
5. The tool first attempts to find an existing release plan.
6. The tool creates a release plan only when creation is allowed by label policy and if a release plan does not exists.
7. The pipeline always emits a JSON result artifact for downstream stages/jobs.

From pipeline execution perspective, the release-plan tool operates in this order:

1. Resolve associated PR from commit SHA (if any).
2. Detect TypeSpec project and API version from changed spec files.
3. Check whether the associated PR has the `new-api-version` label.
4. Find an existing release plan first.
5. Create a new release plan only when allowed.
6. Publish JSON output as a pipeline artifact.

## Trigger Model (When This Runs)

Pipeline trigger behavior in `eng/pipelines/release-plan.yml`:

- `trigger.paths.include: specification/**`
- `pr: none`

Meaning:

- This pipeline does not run as a PR-validation pipeline.
- It runs on branch updates (CI trigger) when files under `specification/**` change.
- In the common path, this happens automatically after a spec PR is merged to `main`.

Commit SHA source:

1. Primary: `$(Build.SourceVersion)`
2. Fallback: repository `HEAD` via `git rev-parse HEAD` when `Build.SourceVersion` is empty

So after a merge to `main`, the pipeline analyzes the latest merged commit (or latest `HEAD` if fallback is needed).

## Inputs

The tool is invoked with:

- `--commit-sha`: commit to analyze
- `--repo`: repository in `owner/repo` format
- `--workspace`: local repo path
- `--azsdk-path`: azsdk CLI path
- `--output-file`: optional JSON output path for artifact publishing

## How TypeSpec Project Is Determined

Changed files are inspected under `specification/**`.

Project detection logic:

1. Prefer changed `tspconfig.yaml` paths.
2. Otherwise, walk up from changed files to find nearest `tspconfig.yaml`.
3. If no project is found: no release plan action.
4. If multiple projects are found: no automatic create (manual handling required).

## How API Version Is Determined

API version is selected from detected project changes in this order:

1. Version-like strings found in changed file paths (`YYYY-MM-DD` or `YYYY-MM-DD-preview`).
2. If not found, scan project `main.tsp` for version-like strings.
3. Sort versions descending and pick the first one.

Sorting rules:

- Newer date wins.
- For same date, GA wins over `-preview`.

Result:

- Selected value is used as `apiVersion` in release-plan metadata.
- Preview detection (`-preview`) drives SDK release type and API release type mapping.

## Create vs No-Create Scenarios

### Scenario A: Associated PR has `new-api-version` label

Behavior:

1. Try `release-plan get --pull-request` (if PR URL exists).
2. Try `release-plan get --typespec-path --api-release-type`.
3. If still not found, run `release-plan create`.

Outcome:

- Existing plan is returned if found.
- New plan is created only in this scenario.

### Scenario B: Associated PR does NOT have `new-api-version` label

Behavior:

1. Try `release-plan get --pull-request` (if PR URL exists).
2. Try `release-plan get --typespec-path --api-release-type`.
3. Do NOT create a new release plan.

Outcome:

- Existing plan is returned if present.
- If no existing plan is found, result is `not_found`.

### Scenario C: No PR associated with commit SHA

Behavior:

- Project/version detection falls back to commit-level file changes.
- PR URL is unavailable.
- Existing-by-path lookup still runs.
- Create is not possible without PR URL and is skipped unless a PR is resolved.

Outcome:

- Existing plan may still be returned by path.
- If none found and create is not allowed, result is `not_found`.

## API Release Type and SDK Release Type

It uses selected API version status and repo name:

- Repo `azure-rest-api-specs-pr` -> API release type: `Private Preview`
- Repo `azure-rest-api-specs`:
  - preview API version -> `Public Preview`
  - stable API version -> `GA`

SDK release type:

- preview API version -> `preview`
- stable API version -> `stable`

## PR Comment Behavior

PR comment is posted only when:

- A new release plan is created, and
- An associated PR number is available.

## Pipeline Artifact Output

The pipeline writes release-plan result JSON to:

- `$(Build.ArtifactStagingDirectory)/release-plan/release-plan.json`

It publishes artifact:

- `release-plan-details`

If no file is generated, pipeline creates a fallback JSON:

- `{"outcome":"not_found","releasePlan":null,"details":{}}`

## Stage Layout

Current pipeline stage:

- Stage 1: `ReleasePlanCreation`

This stage:

- Authenticates npm
- Logs into GitHub
- Installs azsdk CLI
- Runs release-plan tool
- Publishes release-plan details artifact


## Future enhancement

Run SDK generation for the release plan as stage 2 using release plan details identified in stage 1.