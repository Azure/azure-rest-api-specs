---
name: azure-typespec-author
license: MIT
metadata:
  version: "1.0.0"
description: "Authors Azure TypeSpec API specifications. MUST BE USED for all .tsp changes except naming-only client.tsp SDK overrides handled by azsdk-common-typespec-naming. WHEN: versions, resources, operations, models, properties, decorators, visibility, constraints, breaking changes, LRO for ARM or data-plane. DO NOT USE FOR: naming-only client.tsp overrides, SDK generation/releases, single MCP calls. INVOKES: azure-sdk-mcp:azsdk_typespec_retrieve_knowledge, azure-sdk-mcp:azsdk_run_typespec_validation."
compatibility: "Optionally uses the azure-sdk-mcp server with azure-sdk-mcp:azsdk_typespec_retrieve_knowledge and azure-sdk-mcp:azsdk_run_typespec_validation tools"
---

# Azure TypeSpec Author

This skill authors and modifies Azure TypeSpec (`.tsp`) API specifications for ARM resource-manager and data-plane services, covering versioning, resources, operations, models, decorators, constraints, and other schema changes that must follow the repository's TypeSpec authoring workflow.

## Triggers

USE FOR: TypeSpec/tsp changes except naming-only client.tsp SDK overrides — api versions (add, bump, preview, stable, promote), resources, operations, models, properties, decorators, visibility, constraints, breaking changes, LRO, suppressions, operationId, spread model
WHEN: "add TypeSpec API version", "modify .tsp file", "change TypeSpec decorators", "update TypeSpec models or operations", "author Azure TypeSpec"
DO NOT USE FOR: naming-only client.tsp SDK overrides, SDK generation, releasing SDK packages, or single MCP tool calls

The `azure-typespec-author` skill **must** be invoked immediately in all modes (including plan mode) for any task that involves creating and modifying TypeSpec (`.tsp`) files except naming-only `client.tsp` SDK overrides. **This skill MUST be used regardless of how simple the task appears** — there are no "simple" TypeSpec source edits. Even trivial-seeming changes (adding a single enum value, one property, one operation) require the full workflow because versioning decorators, validation, and compliance checks are mandatory.

For naming-only `client.tsp` requests, invoke `azsdk-common-typespec-naming` directly; it applies authorized SDK overrides through scoped direct edits, not the customization tool. Other SDK customizations remain with the existing customization workflow. This exception does not bypass naming guidance.

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

Install `azsdk-common-typespec-naming` alongside this skill. Invoke it by name for naming guidance; do not copy its rules into this skill. If unavailable, report the naming coverage gap rather than inventing a replacement.

## Rules

- **Do NOT skip this skill for "simple" declaration tasks** — there are no simple TypeSpec source edits. A single property addition can require `@added` decorators, version gating, and validation. The only `.tsp` exception is a naming-only `client.tsp` SDK override routed directly to `azsdk-common-typespec-naming`.
- **Always follow the full source-authoring workflow** — even seemingly simple changes (e.g. adding a default value) can require complex versioning decorator changes. Never skip required steps.
- **Mandatory for ordinary `.tsp` edits** — even a single `?` change can be breaking. Do not invoke this skill for the naming-only `client.tsp` exception.
- **Minimal, scoped edits** — only change what the request requires.
- **Do not reconfirm supplied decisions** — treat explicit choices as final and continue. In particular, "carry over all features" or "no exclusions" completely answers API-version carry-forward intake; do not enumerate the existing surface and ask the user to confirm it again.
- **Keep source and client plans separate** — Step 3 plans ordinary TypeSpec source changes. Step 4 offers an explicit opt-out from the [client configuration workflow](references/client-configuration.md), which is recommended and included by default for SDK-visible changes. The authoring skill owns declaration edits; the naming skill owns `client.tsp` edits through its apply workflow.
- **Always validate** — follow [validation](references/validation.md) after every edit. Run validation MCP when available and always run `tsp compile .`; absence of the validation MCP tool is not a blocker.
- **Always cite references** — provide links that justify the approach.
- **Attempt catalog access before selecting a knowledge route** — after project analysis, read the reference catalog during intake. Retry the installed catalog path when its first read fails, then try the canonical repository copy through an available repository-file reader. If the catalog still cannot be read, continue Agentic Search by locating authoritative TypeSpec or Azure documentation directly; catalog access failure is not a blocker and does not by itself select the retrieval MCP route.
- **Select and execute one knowledge route during intake** — classify the complete request as covered or uncovered after reading the catalog. Covered requests use Agentic Search. If any material authoring topic is uncovered, use `azsdk_typespec_retrieve_knowledge` for the complete request when the tool is exposed; if it is not exposed, use authoritative Agentic Search for the complete request. Do not call both knowledge routes. Step 3 reuses the fetched content and must not retrieve it again.
- **Never call `azsdk_typespec_generate_authoring_plan`** — synthesize the authoring plan locally from the selected grounding source.
- **Do not edit before grounding** — follow `Analyze → Read catalog → Classify coverage → Ground once during intake → Plan source locally → Plan client configuration unless opted out → Apply → Validate`. If neither the selected MCP route nor authoritative Web grounding can provide sufficient guidance, report a blocker instead of making ungrounded edits.
- **Validation is not retrieval** — calling `azsdk_run_typespec_validation` after edits does not violate the one-source rule. If that tool is unavailable, record the skip and continue with `tsp compile .`.
- **Preserve dependency setup** — never delete `node_modules`, `packages`,
  restored tools, or fixture links during validation cleanup, even if they were
  installed or restored in the current turn. They are environment setup, not
  compiler output.
- **Follow both plans exactly** — source changes in Step 5 must follow the
  TypeSpec source plan from Step 3; client configuration changes must follow the
  separate plan from Step 4. Do not improvise from unrelated project patterns.

## Steps

> Analyze → Intake → Plan TypeSpec source → Client configuration unless opted out → Apply → Validate → Output reference links

- [ ] Step 1 — Analyze project
- [ ] Step 2 — Intake
- [ ] Step 3 — Build TypeSpec source plan
- [ ] Step 4 — Build client configuration plan unless opted out
- [ ] Step 5 — Apply changes
- [ ] Step 6 — Validate
- [ ] Step 7 — Output reference links

### Step 1: Analyze Project

See [analyze-project.md](references/analyze-project.md).

### Step 2: Intake

See [intake.md](references/intake.md).

### Step 3: Build TypeSpec Source Plan Locally

See [authoring-plan.md](references/authoring-plan.md).

### Step 4: Client Configuration Unless Opted Out

See [client-configuration.md](references/client-configuration.md). Invoke
`azsdk-common-typespec-naming` for SDK-visible changes unless the user explicitly
opts out. Skip this step without prompting for unrelated or documentation-only
requests that cannot affect the generated client surface. Do not pause source
authoring to confirm the recommended default, and do not invoke the naming skill
when the user opts out.

### Step 5: Apply Changes

Make minimal `.tsp` declaration edits following the source plan from Step 3. If
Step 4 produced a client configuration plan, use
`azsdk-common-typespec-naming` in apply mode; it directly edits scoped naming
overrides and necessary imports/loading without calling the customization tool.
Do not bypass that workflow. Resolve missing material source decisions during
intake before applying changes; do not reconfirm decisions already supplied.

### Step 6: Validate

See [validation.md](references/validation.md). Run 6.1.1 TypeSpec validation when its MCP tool is available and always run 6.1.2 `tsp compile .`; run 6.1.3 client configuration checks when Step 4 produced a client configuration plan and 6.2 case-specific validation whenever its case matches.

**Output the validation results as a checklist.** Report one line per executed check, each marked ✅ (pass) or ❌ (fail) with a short note. Record unavailable validation MCP and opted-out or inapplicable client configuration checks as skipped, not passed. Fix every ❌ and re-run until all checks pass, subject to the retry limit in the validation reference; report a blocker if errors remain. For API Versioning (Case 3) the checklist **must** cover every §6.2 Case 3 check — including: the new version's `examples/` folder exists; no example folder remains for a version absent from the `Versions` enum; no decorator references a version absent from the enum; every carried-over feature is present with its decorators rebased onto the new version (not reverted); every excluded feature is fully removed.

### Step 7: Output Reference Links

Output all referenced document URLs from the source plan in Step 3 and any client configuration plan in Step 4. This gives the user direct links to the documentation that informed the changes.

## Reference Files

| File                                                                  | Purpose                                       |
| --------------------------------------------------------------------- | --------------------------------------------- |
| [analyze-project.md](references/analyze-project.md)                   | Step 1: project analysis                      |
| [intake.md](references/intake.md)                                     | Step 2: general + case-specific intake        |
| [authoring-plan.md](references/authoring-plan.md)                     | Step 3: build TypeSpec source plan locally    |
| [client-configuration.md](references/client-configuration.md)         | Step 4: client configuration unless opted out |
| [agentic-search.md](references/agentic-search.md)                     | Procedure: fetch URLs → extract guidance      |
| [reference-document-links.md](references/reference-document-links.md) | Catalog of external guide URLs                |
| [validation.md](references/validation.md)                             | Step 6: validate → compile → verify           |

## Examples

- "Add a new preview API version 2026-01-01-preview for widget resource manager"
- "Add an ARM resource named Asset with CRUD operations"
- "Add a new property to the Widget model"
- "Add a list operation for the WidgetSuite resource using Azure.Core templates"
- "Add a new preview API version to a data-plane service"
- "Create a data-plane resource interface with full CRUD and list operations"
