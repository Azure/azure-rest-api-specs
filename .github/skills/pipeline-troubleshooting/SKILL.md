---
name: pipeline-troubleshooting
license: MIT
metadata:
  version: "1.0.0"
description: |
  **UTILITY SKILL**
  Diagnose and resolve failures in Azure SDK CI pipelines and SDK generation pipelines.
  USE FOR: "pipeline failed", "build failure", "CI check failing", "SDK generation error", "reproduce pipeline locally", "debug SDK pipeline".
  DO NOT USE FOR: TypeSpec authoring (use typespec-authoring), release plans, APIView feedback (use apiview-feedback-resolution), package publishing.
  INVOKES: azsdk_analyze_pipeline, azsdk_verify_setup, azsdk_package_build_code, azsdk_package_run_check.
  FOR SINGLE OPERATIONS: Use azsdk_analyze_pipeline directly for quick failure analysis.
---

# PR and CI Pipeline Troubleshooting

## MCP Tools Used

| MCP Tool | Purpose |
|----------|---------|
| `azsdk_analyze_pipeline` | Analyze pipeline logs and identify failures |
| `azsdk_verify_setup` | Verify local environment matches pipeline |
| `azsdk_package_build_code` | Reproduce build locally |
| `azsdk_package_run_check` | Reproduce validation checks locally |

## Steps

1. **Identify Failure** — Get pipeline URL, run `azsdk_analyze_pipeline`. Categorize as build/test/validation/infrastructure failure.
2. **Analyze Root Cause** — See `references/failure-patterns.md` for patterns by failure type.
3. **Reproduce Locally** — Run `azsdk_verify_setup`, then `azsdk_package_build_code` and `azsdk_package_run_check`.
4. **Apply Fixes** — Use `typespec-customization` for TypeSpec changes, direct edits for code fixes, or re-run for infra issues.
5. **Verify** — Confirm fix locally, update SDK PR, monitor pipeline re-run.

## Related Skills

- `typespec-customization` — TypeSpec customizations
- `generate-sdk-locally` — Local SDK generation
- `apiview-feedback-resolution` — APIView issues
- `typespec-to-sdk-workflow` — Full workflow
