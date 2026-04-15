# Build Authoring Plan

> Prerequisite: Steps 1 (Analyze Project) and 2 (Intake) must be complete.

## General (All Cases)

Use **one or both** tools to build an authoring plan grounded in documentation:

1. **MCP Tool** — call `azsdk_typespec_generate_authoring_plan` with:
   - `request`: user request (verbatim)
   - `additionalInformation`: all context from Steps 1–2
   - `typeSpecProjectRootPath`: project root path

2. **Agentic Search** — run [agentic search](agentic-search.md) with URLs from [reference-document-links.md](reference-document-links.md) and a query from the user's request. Synthesize extracted content into a concrete plan.

---

## Case-Specific Authoring Plan

### Case 3 — API Version Evolution

> **Must** use Agentic Search (option 2 above) to build the plan — do not run the MCP tool.

1. Only one preview version allowed; decorate with `@previewVersion`.
2. Copy `.json` files from latest version's `examples/` into new version's `examples/`. Update `api-version` in each file.
3. Update `readme.md`.
