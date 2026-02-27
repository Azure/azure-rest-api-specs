---
name: package-release-readiness
license: MIT
metadata:
  version: "1.0.0"
description: >-
  **UTILITY SKILL**
  Check SDK package release readiness, run validation, and trigger releases.
  USE FOR: "is package ready for release", "check release readiness", "run validation checks", "release SDK package", "verify changelog", "check API review status".
  DO NOT USE FOR: SDK generation (use generate-sdk-locally), TypeSpec authoring, release plans (use prepare-release-plan), pipeline troubleshooting.
  INVOKES: azsdk_release_sdk, azsdk_package_run_check, azsdk_package_update_changelog_content, azsdk_package_update_metadata, azsdk_package_update_version.
  FOR SINGLE OPERATIONS: Use azsdk_release_sdk with checkReady:true directly for quick checks.
compatibility: >-
  Requires: azure-sdk-mcp server, SDK package in azure-sdk-for-{language} repo.
  Optional: API review approval in APIView.
---

# Package Release Readiness

## MCP Tools Used

| MCP Tool                                 | Purpose                            |
| ---------------------------------------- | ---------------------------------- |
| `azsdk_release_sdk`                      | Check readiness or trigger release |
| `azsdk_package_run_check`                | Run validation checks              |
| `azsdk_package_update_changelog_content` | Update changelog                   |
| `azsdk_package_update_metadata`          | Update metadata                    |
| `azsdk_package_update_version`           | Update version                     |

## Steps

1. **Check Readiness** — Collect package name and language, run `azsdk_release_sdk` with `checkReady: true`. See `references/readiness-details.md`.
2. **Resolve Issues** — Fix changelog, metadata, or version using appropriate tools.
3. **Validate** — Run `azsdk_package_run_check` to identify specific failures.
4. **Release** — Confirm with user, run `azsdk_release_sdk`, instruct user to approve pipeline stage.

## Prerequisites

Azure SDK MCP server required. No CLI fallback — prompt user to configure MCP if unavailable.

## Related Skills

- `generate-sdk-locally` — SDK generation
- `prepare-release-plan` — Release plan management
- `typespec-to-sdk-workflow` — Full workflow
