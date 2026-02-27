---
name: typespec-authoring
license: MIT
metadata:
  version: "1.0.0"
description: >-
  **UTILITY SKILL**
  Create, modify, and validate TypeSpec API specifications for Azure services.
  USE FOR: "create TypeSpec project", "convert swagger to TypeSpec", "validate TypeSpec", "tsp compile errors", "update TypeSpec definitions", "ARM service spec", "data-plane spec".
  DO NOT USE FOR: SDK generation (generate-sdk-locally), release planning (prepare-release-plan), client.tsp customizations (typespec-customization), OpenAPI review.
  INVOKES: azsdk_init_typespec_project, azsdk_run_typespec_validation, azsdk_typespec_generate_authoring_plan, tsp compile, npx tsp-client convert.
compatibility: >-
  Requires: azure-sdk-mcp server, Node.js 18+, npm.
  Optional: PowerShell 7+ (for MCP server startup).
---

# TypeSpec Authoring and Validation

## Prerequisites

Requires `azure-sdk-mcp` server for MCP tool access. Node.js 18+ and npm. Run `npm ci` at repo root.

## CLI Fallback

Without MCP: `tsp compile .` for validation, `npx tsp-client convert --swagger-readme <path>` for conversions, manual project setup per `specification/widget/` templates.

## MCP Tools

| Tool                                     | Purpose       |
| ---------------------------------------- | ------------- |
| `azsdk_init_typespec_project`            | Init project  |
| `azsdk_run_typespec_validation`          | Validate spec |
| `azsdk_typespec_generate_authoring_plan` | Plan changes  |

## Steps

1. **Create/Find** — New: collect org/service/type, run `azsdk_init_typespec_project`. Existing: locate `tspconfig.yaml`.
2. **Author** — Define `@service`, `@server`, `@useAuth`, `@versioned`. Use `union` for enums, `/** */` docs. Convert: `npx tsp-client convert --swagger-readme <path>`. See `references/authoring-steps.md`.
3. **Validate** — Run `azsdk_run_typespec_validation`. Fix errors, re-validate.
4. **Practices** — camelCase operations, customizations in `client.tsp` only.
