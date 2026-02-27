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
  Requires: azure-sdk-mcp server (provides azsdk_verify_setup tool).
  Optional: Language-specific SDKs (.NET, Java, Python, Node.js, Go) for full validation.
  CLI fallback: When MCP is unavailable, manually check tool versions (dotnet, java, python, node, go).
---

# Verify Developer Environment Setup

## Prerequisites

- **azure-sdk-mcp** server running (provides `azsdk_verify_setup`)
- PowerShell installed on host

## MCP Tools

| Tool                 | Purpose                                                          |
| -------------------- | ---------------------------------------------------------------- |
| `azsdk_verify_setup` | Validate dev environment for SDK tools and language requirements |

## Steps

1. **Identify Context** — Determine repo root path and map to language: .NET, Java, JavaScript, Python, Go.
2. **Run Verification** — Call `azsdk_verify_setup` with `langs` and `packagePath`. Pass all supported languages to check everything.
3. **Present Results** — Confirm success or display resolution instructions grouped by category.
4. **Resolve Issues** — Provide install commands per missing requirement. For Python, mention `AZSDKTOOLS_PYTHON_VENV_PATH`.

## When MCP Is Unavailable

Fall back to manual checks: `dotnet --version`, `java -version`, `python --version`, `node --version`, `go version`.

## Related Skills

- `check-package-validation` — Package-level validation
- `generate-sdk-locally` — Local SDK code generation
- `typespec-to-sdk-workflow` — End-to-end release workflow
