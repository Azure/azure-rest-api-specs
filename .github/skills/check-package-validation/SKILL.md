---
name: check-package-validation
license: MIT
metadata:
  version: "1.0.0"
description: >-
  **UTILITY SKILL**
  Run validation checks on Azure SDK packages including changelog, dependency, linting, format, and more.
  USE FOR: "run package check", "validate package", "check changelog", "lint SDK", "format check", "cspell check", "package validation".
  DO NOT USE FOR: release readiness (use package-release-readiness), SDK generation (use generate-sdk-locally), environment setup (use verify-setup).
  INVOKES: azsdk_package_run_check.
  FOR SINGLE OPERATIONS: Use azsdk_package_run_check directly with packagePath and checkType.
compatibility: >-
  Requires: azure-sdk-mcp server, SDK package in azure-sdk-for-{language} repo.
  Supports check types: All, Changelog, Dependency, Readme, Cspell, Snippets, Linting, Format, CheckAotCompat, GeneratedCodeChecks, Samples.
---

# Run SDK Package Validation Checks

## MCP Tools

| Tool                      | Purpose                                 |
| ------------------------- | --------------------------------------- |
| `azsdk_package_run_check` | Run validation checks on an SDK package |

## Steps

1. **Collect Info** — Ask user for the absolute package path and the check type to run. Present valid check types: All, Changelog, Dependency, Readme, Cspell, Snippets, Linting, Format, CheckAotCompat, GeneratedCodeChecks, Samples.
2. **Execute** — Run `azsdk_package_run_check` with `packagePath` and `checkType`. Optionally set `fixCheckErrors: true` to auto-fix.
3. **Present Results** — If all checks pass, confirm success. If failures occur, display each failing check with details and suggest fixes.
4. **Iterate** — If user wants to fix issues, offer to re-run with `fixCheckErrors: true` or guide manual fixes, then re-run validation.
5. **If MCP unavailable** — Inform user azure-sdk-mcp server is required; suggest `verify-setup` skill.

## Related Skills

- `verify-setup` — Verify environment prerequisites
- `package-release-readiness` — Full release readiness check
- `generate-sdk-locally` — Generate SDK code before validation
