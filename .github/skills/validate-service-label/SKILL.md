---
name: validate-service-label
license: MIT
metadata:
  version: "1.0.0"
description: >-
  **UTILITY SKILL**
  Validate that a service label exists or create a new one for the Azure SDK release process.
  USE FOR: "check service label", "create service label", "validate label", "service label missing", "SDK label".
  DO NOT USE FOR: CODEOWNERS validation (use validate-codeowners), package checks (use check-package-validation).
  INVOKES: azsdk_check_service_label, azsdk_create_service_label.
  FOR SINGLE OPERATIONS: Use azsdk_check_service_label directly to check if a label exists.
compatibility: >-
  Requires: azure-sdk-mcp server.
  Optional: Access to Azure SDK tools common-labels.csv for label lookup.
---

# Validate or Create Service Label

## MCP Tools

| Tool | Purpose |
|------|---------|
| `azsdk_check_service_label` | Check if a label exists |
| `azsdk_create_service_label` | Create a new label PR |

**Prerequisites**: azure-sdk-mcp server must be running. Without MCP, direct user to [Common Labels CSV](https://github.com/Azure/azure-sdk-tools/blob/main/tools/github/data/common-labels.csv) manually.

## Steps

1. **Get Label** — Ask user for their service label. If unknown, point to Common Labels CSV.
2. **Validate** — Run `azsdk_check_service_label`:
   - **Exists** or **InReview**: Proceed with release process.
   - **DoesNotExist** or **NotAServiceLabel**: Go to step 3.
3. **Create** — Generate label name (match product name, Title Case, no "Microsoft/Azure" prefix). Confirm with user, then run `azsdk_create_service_label` with name and docs link.

## Related Skills

- `validate-codeowners` — CODEOWNERS validation
- `prepare-release-plan` — Requires valid service label
