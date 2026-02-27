---
name: validate-codeowners
license: MIT
metadata:
  version: "1.0.0"
description: >-
  **UTILITY SKILL**
  Validate and manage CODEOWNERS entries for Azure SDK repositories to ensure proper issue and PR routing.
  USE FOR: "validate codeowners", "check code owners", "add codeowners", "fix codeowners", "CODEOWNERS entry missing".
  DO NOT USE FOR: service label creation (use validate-service-label), package validation (use check-package-validation).
  INVOKES: azsdk_check_service_label, azsdk_engsys_validate_codeowners_entry_for_service, azsdk_engsys_codeowner_update.
  FOR SINGLE OPERATIONS: Use azsdk_engsys_validate_codeowners_entry_for_service directly to check an entry.
compatibility: >-
  Requires: azure-sdk-mcp server, valid service label.
  Supports: azure-sdk-for-net, azure-sdk-for-python, azure-sdk-for-java, azure-sdk-for-js, azure-sdk-for-go.
---

# Validate and Manage CODEOWNERS

## MCP Tools

| Tool                                               | Purpose             |
| -------------------------------------------------- | ------------------- |
| azsdk_check_service_label                          | Verify label exists |
| azsdk_engsys_validate_codeowners_entry_for_service | Validate entry      |
| azsdk_engsys_codeowner_update                      | Add/remove owners   |

**Prerequisites**: azure-sdk-mcp server. **No CLI fallback**.

## Steps

1. **Validate Label** — Run `azsdk_check_service_label`. If missing, direct user to validate-service-label skill.
2. **Select Repo** — .NET→azure-sdk-for-net, Python→azure-sdk-for-python, Java→azure-sdk-for-java, JS→azure-sdk-for-js, Go→azure-sdk-for-go.
3. **Check Owners** — Run `azsdk_engsys_validate_codeowners_entry_for_service` with `serviceLabel`/`repoPath`. ≥2 owners = pass.
4. **Fix/Create** — Collect GitHub usernames for service and source owners. Run `azsdk_engsys_codeowner_update`. Need ≥2 valid PUBLIC org members with write access.
5. **Re-validate** — Run validation again to confirm.
