---
name: generate-sdk-locally
license: MIT
metadata:
  version: "1.0.0"
description: |
  **UTILITY SKILL**
  Generate, build, and test Azure SDKs locally from TypeSpec specifications.
  USE FOR: "generate SDK locally", "build SDK", "run SDK tests", "update changelog", "prepare SDK PR", "local SDK iteration".
  DO NOT USE FOR: pipeline-based generation (use azsdk_run_generate_sdk), release plans (use prepare-release-plan), releasing packages (use package-release-readiness).
  INVOKES: azsdk_verify_setup, azsdk_package_generate_code, azsdk_package_build_code, azsdk_package_run_check, azsdk_package_run_tests, azsdk_package_update_metadata, azsdk_package_update_changelog_content, azsdk_package_update_version.
  FOR SINGLE OPERATIONS: Use azsdk_package_build_code directly for quick builds.
---

# Generate SDK Locally

## Steps

1. **Select Language** — .NET, Java, JavaScript, Python, or Go.
2. **Verify** — Ensure repo is cloned (see `references/sdk-repos.md`), run `azsdk_verify_setup`.
3. **Generate** — Run `azsdk_package_generate_code` with config path.
4. **Build** — Run `azsdk_package_build_code`. On failure, use `typespec-customization`.
5. **Validate** — Run `azsdk_package_run_check` and `azsdk_package_run_tests`.
6. **Metadata** — Update metadata, changelog, and version.

## Related Skills

- `typespec-authoring` — TypeSpec authoring
- `typespec-customization` — TypeSpec customizations
- `package-release-readiness` — Release preparation
- `typespec-to-sdk-workflow` — Full workflow
