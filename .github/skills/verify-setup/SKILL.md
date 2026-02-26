---
name: verify-setup
license: MIT
metadata:
  version: "1.0.0"
description: >-
  **UTILITY SKILL**
  Verify the developer environment has all required tools for Azure SDK development and release.
  USE FOR: "verify setup", "check environment", "check requirements", "missing tools", "dev environment", "setup check".
  DO NOT USE FOR: running package checks (use check-package-validation), release readiness (use package-release-readiness).
  INVOKES: azsdk_verify_setup.
  FOR SINGLE OPERATIONS: Use azsdk_verify_setup directly with language and packagePath parameters.
compatibility: >-
  Requires: azure-sdk-mcp server.
  Optional: Language-specific SDKs (.NET, Java, Python, Node.js, Go) for full validation.
---

# Verify Developer Environment Setup

## MCP Tools

| Tool | Purpose |
|------|---------|
| `azsdk_verify_setup` | Validate dev environment for SDK tools and language requirements |

## Steps

1. **Identify Context** — Determine the repo root path (e.g., `azure-sdk-for-js`). Map the repo to its language: .NET, Java, JavaScript, Python, Go.
2. **Run Verification** — Call `azsdk_verify_setup` with `langs` (language list) and `packagePath` (repo root). To check all languages, pass all supported languages.
3. **Present Results** — If all checks pass, confirm success. If requirements are missing, display step-by-step resolution instructions grouped by category.
4. **Resolve Issues** — For each missing requirement, provide shell-specific install commands. For Python issues, mention the `AZSDKTOOLS_PYTHON_VENV_PATH` environment variable.

## Related Skills

- `check-package-validation` — Run package-level validation checks
- `generate-sdk-locally` — Generate SDK code locally
- `typespec-to-sdk-workflow` — Full end-to-end release workflow
