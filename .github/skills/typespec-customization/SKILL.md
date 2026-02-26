---
name: typespec-customization
license: MIT
metadata:
  version: "1.0.0"
description: >-
  **UTILITY SKILL**
  Apply SDK-specific customizations to TypeSpec projects by editing client.tsp with decorators.
  USE FOR: "rename type for SDK", "split into multiple clients", "@clientName", "client.tsp", "language-specific customization", "@scope", "APIView rename feedback".
  DO NOT USE FOR: modifying the service API definition in main.tsp (use typespec-authoring), post-generation code edits in SDK repos, creating new TypeSpec projects.
  INVOKES: azsdk_package_customize_code, azsdk_run_typespec_validation, tsp compile.
  FOR SINGLE OPERATIONS: Edit client.tsp directly and run tsp compile for quick decorator changes.
compatibility: >-
  Requires: azure-sdk-mcp server, Node.js 18+, npm, TypeSpec project with tspconfig.yaml.
  Optional: PowerShell 7+ (for MCP server startup).
---

# TypeSpec Customization

## MCP Prerequisites

Requires `azure-sdk-mcp` server connected and authenticated. Provides customization and validation tools for TypeSpec projects.

## MCP Tools

| Tool | Purpose |
|------|---------|
| `azsdk_package_customize_code` | Apply customizations for SDK generation |
| `azsdk_run_typespec_validation` | Validate TypeSpec after changes |

## CLI Fallback

Without MCP: edit `client.tsp` manually with decorators, run `tsp compile .` to validate, use `npx tsp-client` for SDK regeneration.

## Steps

1. **Identify** — Determine decorator: `@clientName`, `@client`, `@operationGroup`, `@access`, `@scope`, `@alternateType`, or `@override`.
2. **Set Up** — Ensure `client.tsp` exists with imports. See `references/customization-steps.md`.
3. **Apply** — Add decorators in `client.tsp`. See `references/decorators-reference.md`.
4. **Validate** — Run `tsp compile .` then `azsdk_run_typespec_validation`. Regenerate SDK to verify.

For language-specific customizations, see `references/customization-steps.md`.
