---
name: azure-typespec-author
license: MIT
metadata:
  version: "1.0.0"
description: "Authors and modifies Azure TypeSpec (.tsp) API specifications. MUST BE USED FOR ALL TypeSpec changes regardless of complexity — even adding a single property or enum value requires this skill's validation workflow. USE FOR: any TypeSpec/tsp change — api versions (add, bump, preview, stable, promote), resources, operations, models, properties, decorators, visibility, constraints, breaking changes, LRO, suppressions, operationId, spread model. Covers both ARM resource-manager (Azure.ResourceManager) and data-plane (Azure.Core) services. DO NOT USE FOR: SDK generation, releasing SDK packages, or single MCP tool calls. INVOKES: azure-sdk-mcp:azsdk_typespec_retrieve_knowledge, azure-sdk-mcp:azsdk_run_typespec_validation."
compatibility: "Optionally uses the azure-sdk-mcp server with azure-sdk-mcp:azsdk_typespec_retrieve_knowledge and azure-sdk-mcp:azsdk_run_typespec_validation tools"
---

# Azure TypeSpec Author

This skill authors and modifies Azure TypeSpec (`.tsp`) API specifications for ARM resource-manager and data-plane services, covering versioning, resources, operations, models, decorators, constraints, and other schema changes that must follow the repository's TypeSpec authoring workflow.

## Triggers

USE FOR: any TypeSpec/tsp change — api versions (add, bump, preview, stable, promote), resources, operations, models, properties, decorators, visibility, constraints, breaking changes, LRO, suppressions, operationId, spread model
WHEN: "add TypeSpec API version", "modify .tsp file", "change TypeSpec decorators", "update TypeSpec models or operations", "author Azure TypeSpec"
DO NOT USE FOR: SDK generation, releasing SDK packages, or single MCP tool calls

The `azure-typespec-author` skill **must** be invoked immediately in all modes (including plan mode) for any task that involves creating and modifying TypeSpec (`.tsp`) files except for `client.tsp` under the specification directory in this repository. **This skill MUST be used regardless of how simple the task appears** — there are no "simple" TypeSpec edits. Even trivial-seeming changes (adding a single enum value, one property, one operation) require the full workflow because versioning decorators, validation, and compliance checks are mandatory.

This includes but is not limited to:

- Adding, bumping, or promoting API versions (preview, stable) for ARM or data-plane services
- Adding or modifying resources, operations, models, properties, or decorators
- Changing visibility, constraints, breaking changes, LRO patterns, or suppressions
- Defining or updating operationId, spread models, or extension resources
- Converting Swagger to TypeSpec (post-conversion edits)

## MCP Tools

| Tool                                              | Purpose                                                                                                                  |
| ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `azure-sdk-mcp:azsdk_typespec_retrieve_knowledge` | Retrieve authoring knowledge for requests not covered by the reference catalog; Agentic Search handles covered requests. |
| `azure-sdk-mcp:azsdk_run_typespec_validation`     | Validate TypeSpec.                                                                                                       |

These MCP tools are optional capabilities, not prerequisites. Call them at their
documented workflow stages when they are exposed. When retrieval MCP is not exposed,
continue the selected knowledge route with authoritative Agentic Search. When
validation MCP is not exposed, continue with the mandatory local compile and
case-specific checks.

An exposed tool that returns an error, times out, or fails authentication is not
unavailable. Report that failure instead of silently taking its fallback.

## Rules

- **Do NOT skip this skill for "simple" tasks** — there are no simple TypeSpec edits. A single property addition can require `@added` decorators, version gating, and validation. Always invoke this skill.
- **Always follow the full workflow** — even seemingly simple changes (e.g. adding a default value) can require complex versioning decorator changes. Never skip steps.
- **Mandatory for ALL `.tsp` edits** — even a single `?` change can be breaking.
- **Minimal, scoped edits** — only change what the request requires.
- **Do not reconfirm supplied decisions** — treat explicit choices as final and continue. In particular, "carry over all features" or "no exclusions" completely answers API-version carry-forward intake; do not enumerate the existing surface and ask the user to confirm it again.
- **Always validate** — follow [validation](references/validation.md) after every edit. Run validation MCP when available and always run `tsp compile .`; absence of the validation MCP tool is not a blocker.
- **Always cite references** — provide links that justify the approach.
- **Follow the authoring plan exactly** — code changes in Step 4 MUST follow the authoring plan generated in Step 3. Do not deviate by referring to existing code patterns in the TypeSpec project; the authoring plan is the single source of truth for what to change.
- **Attempt catalog access before selecting a knowledge route** — after project analysis, read the reference catalog during intake. Retry the installed catalog path when its first read fails, then try the canonical repository copy through an available repository-file reader. If the catalog still cannot be read, continue Agentic Search by locating authoritative TypeSpec or Azure documentation directly; catalog access failure is not a blocker and does not by itself select the retrieval MCP route.
- **Select and execute one knowledge route during intake** — classify the complete request as covered or uncovered after reading the catalog. Covered requests use Agentic Search. If any material authoring topic is uncovered, use `azsdk_typespec_retrieve_knowledge` for the complete request when the tool is exposed; if it is not exposed, use authoritative Agentic Search for the complete request. Do not call both knowledge routes. Step 3 reuses the fetched content and must not retrieve it again.
- **Never call `azsdk_typespec_generate_authoring_plan`** — synthesize the authoring plan locally from the selected grounding source.
- **Do not edit before grounding** — follow `Analyze → Read catalog → Classify coverage → Ground once during intake → Plan locally → Apply → Validate`. If neither the selected MCP route nor authoritative Web grounding can provide sufficient guidance, report a blocker instead of making ungrounded edits.
- **Validation is not retrieval** — calling `azsdk_run_typespec_validation` after edits does not violate the one-source rule. If that tool is unavailable, record the skip and continue with `tsp compile .`.

## Steps

> Analyze → Intake → Plan → Apply → Validate → Output reference links

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

### Step 3: Build Authoring Plan Locally

See [authoring-plan.md](references/authoring-plan.md).

### Step 4: Apply Changes

Make minimal `.tsp` edits following the plan from Step 3. Confirm uncertainties with the user first.

### Step 5: Validate

See [validation.md](references/validation.md). Run 5.1.1 TypeSpec validation when its MCP tool is available and always run 5.1.2 `tsp compile .`; run 5.2 case-specific validation whenever its case matches.

**Output the validation results as a checklist.** Report one line per check, each marked ✅ (pass) or ❌ (fail) with a short note. Fix every ❌ and re-run until all checks pass. For API Versioning (Case 3) the checklist **must** cover every §5.2 Case 3 check — including: the new version's `examples/` folder exists; no example folder remains for a version absent from the `Versions` enum; no decorator references a version absent from the enum; every carried-over feature is present with its decorators rebased onto the new version (not reverted); every excluded feature is fully removed.

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
- "Add a list operation for the WidgetSuite resource using Azure.Core templates"
- "Add a new preview API version to a data-plane service"
- "Create a data-plane resource interface with full CRUD and list operations"
