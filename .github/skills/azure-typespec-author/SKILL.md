---
name: azure-typespec-author
license: MIT
metadata:
  version: "1.0.0"
description: "Authors and modifies Azure TypeSpec (.tsp) API specifications. USE FOR: any TypeSpec/tsp change — api versions (add, bump, preview, stable, promote), resources, operations, models, properties, decorators, visibility, constraints, breaking changes, LRO, suppressions, operationId, spread model. Covers ARM resource-manager and data-plane services. DO NOT USE FOR: SDK generation, releasing SDK packages, or single MCP tool calls. INVOKES: azure-sdk-mcp:azsdk_typespec_generate_authoring_plan, azure-sdk-mcp:azsdk_run_typespec_validation."
compatibility:
  requires: "azure-sdk-mcp server with azsdk_typespec_generate_authoring_plan and azsdk_run_typespec_validation tools"
---

# Azure TypeSpec Author

## Constraints

- **Never skip steps** — even trivial `.tsp` changes can require complex versioning decorators.
- **Minimal edits** — only change what the request requires.
- **Authoring plan is source of truth** — do not deviate by copying existing code patterns.

## Workflow

> Analyze → Intake → Plan → Apply → Validate

- [ ] Step 1 — Analyze project
- [ ] Step 2 — Intake
- [ ] Step 3 — Build authoring plan
- [ ] Step 4 — Apply changes
- [ ] Step 5 — Validate
- [ ] Step 6 — Output reference links

### Step 1: Analyze Project

See [analyze-project.md](references/analyze-project.md).

### Step 2: Intake

See [intake.md](references/intake.md).

### Step 3: Build Authoring Plan

See [authoring-plan.md](references/authoring-plan.md).

### Step 4: Apply Changes

Make minimal `.tsp` edits following the plan from Step 3. Confirm uncertainties with the user first.

### Step 5: Validate

See [validation.md](references/validation.md). Run 5.1 (TypeSpec validation) and 5.2 (`tsp compile .`) always; 5.3 (example verification) for API version evolution only.

### Step 6: Output Reference Links

Output all referenced document URLs from Step 3. This gives the user direct links to the documentation that informed the changes.

## Reference Files

| File                                                                  | Purpose                                     |
| --------------------------------------------------------------------- | ------------------------------------------- |
| [analyze-project.md](references/analyze-project.md)                   | Step 1: project analysis                    |
| [intake.md](references/intake.md)                                     | Step 2: general + case-specific intake      |
| [authoring-plan.md](references/authoring-plan.md)                     | Step 3: build authoring plan (Option A + B) |
| [agentic-search.md](references/agentic-search.md)                     | Procedure: fetch URLs → extract guidance    |
| [reference-document-links.md](references/reference-document-links.md) | Catalog of external guide URLs              |
| [validation.md](references/validation.md)                             | Step 5: validate → compile → verify         |

## Examples

- "Add a new preview API version 2026-01-01-preview for widget resource manager"
- "Add an ARM resource named Asset with CRUD operations"
- "Add a new property to the Widget model"
