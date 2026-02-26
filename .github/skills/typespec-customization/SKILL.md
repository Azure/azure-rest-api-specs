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

## MCP Tools Used

| MCP Tool | Purpose |
|----------|---------|
| `azsdk_package_customize_code` | Apply TypeSpec customizations for SDK generation |
| `azsdk_run_typespec_validation` | Validate TypeSpec after applying customizations |

## Steps

1. **Identify Need** — Determine customization: `@clientName`, `@client`, `@operationGroup`, `@access`, `@scope`, `@alternateType`, or `@override`.
2. **Set Up client.tsp** — Ensure `client.tsp` exists with required imports. See `references/customization-steps.md`.
3. **Apply Customizations** — Use decorators in `client.tsp`. See `references/decorators-reference.md` for patterns.
4. **Validate** — Run `tsp compile .` then `azsdk_run_typespec_validation`. Regenerate SDK to verify effect.

For language-specific code customizations (when TypeSpec isn't enough), see `references/customization-steps.md`.

## Related Skills

- `typespec-authoring` — TypeSpec authoring
- `apiview-feedback-resolution` — Resolving APIView feedback
- `generate-sdk-locally` — Generate SDK after customization
