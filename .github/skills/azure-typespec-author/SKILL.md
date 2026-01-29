---
name: azure-typespec-author
description: "Use this skill when authoring or modifying Azure TypeSpec API specifications in the azure-rest-api-specs repository. Triggers for any TypeSpec related tasks, including: adding new API versions (preview or stable), creating or modifying ARM resources or data-plane services, defining models/enums/unions, adding operations to resources or interfaces, updating TypeSpec definitions for Azure services, or fixing TypeSpec compilation errors. Keywords: TypeSpec, tsp, ARM, resource-manager, data-plane, API version, preview version, stable version, Azure resource, Azure service, resource provider."
---

# Azure TypeSpec Author

## Operating Principles (non-negotiable)

1. **Do not edit any files until you have required inputs and have retrieved solution** Use the `azsdk_typespec_consult ` tool.
2. Make **minimal, scoped edits** to satisfy the request. Avoid refactors unless explicitly asked.
3. After edits, **validate** (compile / lint / emitter checks if available) and report results.
4. Always provide **references** (titles/sections/links) from retrieved context that justify the recommended approach.

## Workflow

When encountering a TypeSpec authoring cases, follow this workflow (must follow exactly):

### Step 1 — Intake & Clarification (no file edits)

- Follow the `intake-arm.md` to gather all required inputs and confirm with the user.

### Step 2 — Retrieve Solution

Call the `azure-sdk-mcp/azsdk_typespec_consult` tool:

- Provide the best available arguments derived from the intake:
  - plane
  - apiVersion / versions
  - intent
  - resource/interface/operation names
  - key constraints / keywords
- Use user request (verbatim) as parameter `request`
- Read the relative code (.tsp) for this request, and put it as `additionalInformation` parameter

### Step 3 — Apply Changes (edits)

Only after a grounded plan is produced:

- Make the minimal changes required in the relevant `.tsp` files
- Prefer following the official template/pattern from RETRIEVED_CONTEXT even if the repo has older patterns

### Step 4 — Validate

- Run `azure-sdk-mcp/azsdk_run_typespec_validation` to run validation
- If validation fails, fix forward with minimal changes

### Step 5 — Summarize

Return:

- Files changed (list)
- What changed and why (brief)
- Validation results (pass/fail + key output)
- References from RETRIEVED_CONTEXT used to justify important decisions

### Step 6 - Next steps

- Follow `next-steps-arm.md` to identify and suggest any relevant next steps based on the completed case.

---
