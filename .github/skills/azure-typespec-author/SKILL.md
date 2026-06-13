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

## MCP Tools

| Tool                                                   | Purpose                                                   |
| ------------------------------------------------------ | --------------------------------------------------------- |
| `azure-sdk-mcp:azsdk_typespec_generate_authoring_plan` | Generate grounded authoring plan (General Authoring only) |
| `azure-sdk-mcp:azsdk_run_typespec_validation`          | Validate TypeSpec                                         |

**Prerequisite:** `azure-sdk-mcp` server must be running.

## Constraints

- **Always follow the full workflow** — even seemingly simple changes (e.g. adding a default value) can require complex versioning decorator changes. Never skip steps.
- **Mandatory for ALL `.tsp` edits** — even a single `?` change can be breaking.
- **Minimal, scoped edits** — only change what the request requires.
- **Always validate** — run every steps in [validation](references/validation.md) after every edit.
- **Always cite references** — provide links that justify the approach.
- **Follow the authoring plan exactly** — code changes in Step 4 MUST follow the authoring plan generated in Step 3. Do not deviate by referring to existing code patterns in the TypeSpec project; the authoring plan is the single source of truth for what to change.
- **ALWAYS display SDK breaking change warnings.** If the MCP plan output includes any `SDK Breaking Changes` section, you MUST display it before applying any edits. Never skip, suppress, or downplay breaking change warnings (see Step 3, bullet 1).

---

## Workflow

> Classify → Intake → Plan → Apply → Validate

### Progress Checklist

Copy and update as you progress:

- [ ] Step 1: Analyzed project & classified as: \_\_\_
- [ ] Step 2: Collected intake inputs
- [ ] Step 3: Retrieved authoring plan
- [ ] Step 4: Applied changes
- [ ] Step 5: Validated with TypeSpec validation and `tsp compile .`

### Step 1: Analyze & Classify

Follow [analyze project & classify task](references/analyze-project-and-classify-task.md).

Classify as exactly one:

| Task Type                 | When                                                                              | `azsdk_typespec_generate_authoring_plan` |
| ------------------------- | --------------------------------------------------------------------------------- | ---------------------------------------- |
| **API Version Evolution** | Adding a new preview or stable API version to an existing ARM service. (ARM only) | **MUST NOT** call                        |
| **General Authoring**     | Any other `.tsp` change (resources, operations, models, properties, etc.)         | **MUST** call                            |

State your classification explicitly before proceeding.

---

### Step 2: Intake

Collect inputs needed for the change. Branch by task type:

- **API Version Evolution** → Follow [API version evolution reference — Step 2](references/api-version-evolution.md#step-2-intake).
- **General Authoring** → Follow [intake guide](references/general-authoring-intake.md).

---

### Step 3: Retrieve Authoring Plan

Check your classification from Step 1, then branch:

- **API Version Evolution** → Follow [API version evolution reference — Step 3](references/api-version-evolution.md#step-3-retrieve-authoring-plan). **MUST NOT** call `azsdk_typespec_generate_authoring_plan`.
- **General Authoring** → **MUST** invoke `azure-sdk-mcp:azsdk_typespec_generate_authoring_plan` with:

  | Parameter                 | Value                                                                                                                                                                       |
  | ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
  | `request`                 | User request (verbatim)                                                                                                                                                     |
  | `additionalInformation`   | All content gathered from Steps 1–2 (intake analysis, user answers, relevant `.tsp` code read from the project), **including any case-specific Defaults noted in Step 2.2** |
  | `typeSpecProjectRootPath` | TypeSpec project root path                                                                                                                                                  |

  Do not proceed without an authoring plan from this tool.

  > ⚠️ **CRITICAL:** The MCP tool output may includes an `SDK Breaking Changes` section (if applicable). You MUST inspect this and prepare to display breaking change warnings in Step 3. Do NOT skip or minimize this check.

---

### Step 4: Apply Changes

Confirm uncertainties with the user, then make minimal `.tsp` edits.

- **API Version Evolution** → Apply the plan from Step 3.
- **General Authoring** → Apply the authoring plan from Step 3 and follow these principles:

  1. **MANDATORY:** Always check the plan output for an `SDK Breaking Changes` section. If any breaking changes are present, display a dedicated warning block titled `🚨 SDK Breaking Changes` and list each breaking change one-by-one as its own warning bullet under that heading. Do NOT skip this step, even if the impact seems minor.
  2. Confirm with user if any non-mitigation uncertainties remain.
  3. Make the minimal changes required in the relevant `.tsp` files for the requested TypeSpec change.
  4. **MANDATORY:** After the requested TypeSpec change has been applied, if the plan includes a mitigation for any SDK breaking change, explicitly ask the user whether they want that mitigation applied.
  5. If the user confirms they want mitigation, apply the mitigation solution described in the plan in the relevant mitigation files. If the user declines, proceed without mitigation and state that choice in the summary.
  6. Prefer the official template/pattern from retrieved context even if the repo has older patterns.
  7. **MANDATORY GATE:** Complete items 1–6 before starting Step 5. Do not proceed to validation until all applicable items above are finished and documented in the response.

---

### Step 5: Validate

See [validation guide](references/validation.md) for sub-steps. You must run TypeSpec validation (5.1), `tsp compile .` (5.2), and example verification (5.3, API Version Evolution only).

---

## Reference Files

| File                                                                                    | Purpose                                   |
| --------------------------------------------------------------------------------------- | ----------------------------------------- |
| [analyze-project-and-classify-task.md](references/analyze-project-and-classify-task.md) | Step 1: project analysis + classification |
| [api-version-evolution.md](references/api-version-evolution.md)                         | Steps 2–4 for API Version Evolution tasks |
| [general-authoring-intake.md](references/general-authoring-intake.md)                   | Step 2 for General Authoring tasks        |
| [agentic-search.md](references/agentic-search.md)                                       | Procedure for fetching external docs      |
| [validation.md](references/validation.md)                                               | Step 5: validation sub-steps              |

## Examples

- "Add a new preview API version 2026-01-01-preview for widget resource manager"
- "Bump to stable version 2026-01-01 for Microsoft.Widget"
- "Add an ARM resource named Asset with CRUD operations"
- "Add a new property to the Widget model"

## Troubleshooting

- **TypeSpec validation fails** — display all errors, provide fix suggestions, re-run validation.
- **API Version Evolution** — use the versioning guide URLs in the [version evolution reference](references/api-version-evolution.md); do not call the authoring plan tool.
