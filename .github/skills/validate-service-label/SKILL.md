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
| `azsdk_check_service_label` | Check if a service label exists and get its status |
| `azsdk_create_service_label` | Create a new service label PR |

## Steps

1. **Explain Importance** — Service labels enable automatic owner assignment, issue notifications, and PR reviewer assignment across Azure SDK repos.
2. **Get Label** — Ask user for their service label. If unknown, direct them to the [Common Labels CSV](https://github.com/Azure/azure-sdk-tools/blob/main/tools/github/data/common-labels.csv).
3. **Validate** — Run `azsdk_check_service_label`. Handle results:
   - **Exists**: Success — proceed with release process.
   - **InReview**: Pending approval — user can proceed.
   - **DoesNotExist** or **NotAServiceLabel**: Go to step 4.
4. **Create Label** — Generate a label name following guidelines: match official product name, Title Case, no "Microsoft/Azure" prefix, no service group separators. Confirm with user, then run `azsdk_create_service_label` with confirmed name and documentation link.

## Related Skills

- `validate-codeowners` — Validate CODEOWNERS entries for SDK repos
- `prepare-release-plan` — Create release plan (requires valid service label)
- `typespec-to-sdk-workflow` — Full end-to-end release workflow
