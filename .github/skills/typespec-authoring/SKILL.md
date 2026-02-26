---
name: typespec-authoring
license: MIT
metadata:
  version: "1.0.0"
description: |
  **UTILITY SKILL**
  Create, modify, and validate TypeSpec API specifications for Azure services.
  USE FOR: "create TypeSpec project", "convert swagger to TypeSpec", "validate TypeSpec", "tsp compile errors", "update TypeSpec definitions", "ARM service spec", "data-plane spec".
  DO NOT USE FOR: SDK generation (use generate-sdk-locally), release planning (use prepare-release-plan), client.tsp customizations (use typespec-customization), OpenAPI JSON review.
  INVOKES: azsdk_init_typespec_project, azsdk_run_typespec_validation, azsdk_typespec_generate_authoring_plan, tsp compile, npx tsp-client convert.
  FOR SINGLE OPERATIONS: Use azsdk_run_typespec_validation directly for quick compile checks.
---

# TypeSpec Authoring and Validation

## MCP Tools Used

| MCP Tool | Purpose |
|----------|---------|
| `azsdk_init_typespec_project` | Initialize a new TypeSpec project |
| `azsdk_run_typespec_validation` | Validate TypeSpec compilation |
| `azsdk_typespec_generate_authoring_plan` | Generate authoring plan |

## Steps

1. **Identify or Create Project** — For new projects, collect org/service/type info and run `azsdk_init_typespec_project`. For existing, locate `tspconfig.yaml` and `main.tsp`.
2. **Author TypeSpec** — Define `@service`, `@server`, `@useAuth`, `@versioned`. Use `union` for enums, add `/** */` docs. For conversions: `npx tsp-client convert --swagger-readme <path>`. See `references/authoring-steps.md`.
3. **Validate** — Run `azsdk_run_typespec_validation`. Fix errors and re-validate. See `references/authoring-steps.md` for common error patterns.
4. **Best Practices** — camelCase operations, customizations in `client.tsp` only. See `references/authoring-steps.md`.

## Related Skills

- `typespec-customization` — SDK customizations
- `generate-sdk-locally` — Generate SDK from TypeSpec
- `typespec-to-sdk-workflow` — Full release workflow
