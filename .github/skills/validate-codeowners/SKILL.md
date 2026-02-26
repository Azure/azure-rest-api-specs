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

## Steps

1. **Validate Label** — Run `azsdk_check_service_label`. If DoesNotExist/NotAServiceLabel, direct user to create one first (use validate-service-label).
2. **Select Repo** — Map language: .NET→azure-sdk-for-net, Python→azure-sdk-for-python, Java→azure-sdk-for-java, JS→azure-sdk-for-js, Go→azure-sdk-for-go.
3. **Check Owners** — Run `azsdk_engsys_validate_codeowners_entry_for_service` with `serviceLabel`/`repoPath`. ≥2 valid owners = success. <2 = CRITICAL.
4. **Fix/Create** — Collect GitHub usernames for service owners (issues) and source owners (PRs). Run `azsdk_engsys_codeowner_update`. Minimum 2 valid owners (PUBLIC Microsoft/Azure org members with write access). See [access docs](https://aka.ms/azsdk/access).
5. **Re-validate** — Run validation again to confirm.

## Related Skills

- `validate-service-label` — Service labels
- `prepare-release-plan` — Release planning
