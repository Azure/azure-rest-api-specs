---
name: typespec-authoring
license: MIT
metadata:
  version: "1.0.0"
description: >-
  **UTILITY SKILL**
  Create, modify, and validate TypeSpec API specifications for Azure services.
  USE FOR: "create TypeSpec project", "convert swagger to TypeSpec", "validate TypeSpec", "tsp compile errors", "update TypeSpec definitions", "ARM service spec", "data-plane spec".
  DO NOT USE FOR: SDK generation (use generate-sdk-locally), release planning (use prepare-release-plan), client.tsp customizations (use typespec-customization), OpenAPI JSON review.
  INVOKES: azsdk_init_typespec_project, azsdk_run_typespec_validation, azsdk_typespec_generate_authoring_plan, tsp compile, npx tsp-client convert.
  FOR SINGLE OPERATIONS: Use azsdk_run_typespec_validation directly for quick compile checks.
compatibility: >-
  Requires: azure-sdk-mcp server, Node.js 18+, npm.
  Optional: PowerShell 7+ (for MCP server startup).
---

# TypeSpec Authoring and Validation

## MCP Tools

| Tool | Purpose |
|------|---------|
| `azsdk_init_typespec_project` | Initialize new TypeSpec project |
| `azsdk_run_typespec_validation` | Validate TypeSpec compilation |
| `azsdk_typespec_generate_authoring_plan` | Generate authoring plan |

## Steps

1. **Identify or Create** — New: collect org/service/type, run `azsdk_init_typespec_project`. Existing: locate `tspconfig.yaml`.
2. **Author** — Define `@service`, `@server`, `@useAuth`, `@versioned`. Use `union` for enums, `/** */` docs. Conversions: `npx tsp-client convert --swagger-readme <path>`. See `references/authoring-steps.md`.
3. **Validate** — Run `azsdk_run_typespec_validation`. Fix errors, re-validate. See `references/authoring-steps.md`.
4. **Best Practices** — camelCase operations, customizations in `client.tsp` only.

## Related Skills

- `typespec-customization` — Client customizations
- `generate-sdk-locally` — SDK from TypeSpec
- `typespec-to-sdk-workflow` — Release workflow
