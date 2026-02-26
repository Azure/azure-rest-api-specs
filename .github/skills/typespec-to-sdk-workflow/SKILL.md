---
name: typespec-to-sdk-workflow
license: MIT
metadata:
  version: "1.0.0"
description: |
  **WORKFLOW SKILL**
  INVOKES: typespec-authoring, typespec-customization, generate-sdk-locally, package-release-readiness, prepare-release-plan, apiview-feedback-resolution, pipeline-troubleshooting.
  Orchestrate the full TypeSpec to SDK release workflow for Azure services.
  USE FOR: "full SDK release workflow", "TypeSpec to SDK end to end", "guided SDK generation", "resume release workflow", "experiment with TypeSpec SDK".
  DO NOT USE FOR: single-step tasks like validate TypeSpec (use typespec-authoring), check readiness (use package-release-readiness), or generate SDK only (use generate-sdk-locally).
  FOR SINGLE OPERATIONS: Use the individual utility skills listed in INVOKES directly.
---

# TypeSpec to SDK Release Workflow

Two paths: **Experimentation** (local) or **Release** (full workflow).

## MCP Tools Used

| MCP Tool | Purpose |
|----------|---------|
| `azsdk_create_release_plan` | Create plan |
| `azsdk_run_generate_sdk` | Pipeline generation |
| `azsdk_run_typespec_validation` | Validate TypeSpec |
| `azsdk_get_modified_typespec_projects` | Detect changes |
| `azsdk_create_pull_request_for_current_branch` | Create PR |

## Steps

1. **Intent** — Release or experiment.
2. **Plan** — Use `prepare-release-plan`.
3. **TypeSpec** — Use `typespec-authoring` to validate.
4. **Path** — Experiment: `generate-sdk-locally`. Release: continue.
5. **Spec PR** — Commit, push, create PR, link to plan.
6. **Generate** — Local or pipeline. See `references/workflow-details.md`.
7. **Link PRs** — Use `prepare-release-plan`.
8. **APIView** — Use `apiview-feedback-resolution`.
9. **Release** — Use `package-release-readiness`.

See `references/workflow-details.md` for resume points.

## Related Skills

- `typespec-authoring`, `typespec-customization`, `generate-sdk-locally`, `prepare-release-plan`, `package-release-readiness`, `apiview-feedback-resolution`
