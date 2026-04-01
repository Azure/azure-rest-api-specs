---
agent: api-reviewer
description: "Review local API specification changes for Azure guideline compliance. Validates directory structure, TypeSpec, RPC rules, and OpenAPI conventions."
---

# Review Local API Specification Changes

Review my local changes for compliance with Azure REST API Guidelines.

${input:scope:How should the review be scoped? Enter a folder path (e.g., specification/app or C:\repos\specs\specification\app), or type "all" to review all local changes.}

## Instructions

1. **Detect local changes.** Run `git status` and `git diff --name-only` in the workspace to identify all changed, added, or untracked specification files. Classify each file by type (ARM OpenAPI, data-plane OpenAPI, TypeSpec, example, tspconfig, readme).

2. **Determine scope.** The engineer provided: `${input:scope}`
   - If the value is `all` → review all changed specification files across the repository.
   - Otherwise → treat the value as a folder path (relative or absolute). Normalize it to a workspace-relative path. If the path does not exist or contains no specification files, ask for a corrected path.

3. **Recursively discover files.** Scan the target directory (or all changed paths) to locate every specification artifact:
   - `*.tsp` files — TypeSpec source
   - `*.json` files under `resource-manager/` or `data-plane/` — OpenAPI specs
   - `*.json` files under `examples/` — example files
   - `tspconfig.yaml` — TypeSpec configuration
   - `readme.md` — AutoRest configuration

   Present a file inventory grouped by service before proceeding.

4. **Validate directory structure** against the [Azure specification directory structure guidelines](../../documentation/directory-structure.md):
   - Organization folder under `specification/<organization>/`
   - ARM specs under `resource-manager/<RPNS>/<service>/`, data-plane under `data-plane/<service>/`
   - Resource Provider Namespace folder exists and uses PascalCase
   - No specs placed directly in `resource-manager/` without `<RPNS>/<service>` nesting
   - Generated OpenAPI in `stable/<YYYY-MM-DD>/` or `preview/<YYYY-MM-DD-preview>/` folders
   - Required files present for TypeSpec projects: `main.tsp`, `tspconfig.yaml`, `readme.md`, `examples/`
   - No `package.json` in TypeSpec project directories
   - ARM TypeSpec service folders end with `.Management`

   Flag any structural violations with expected vs. actual paths.

5. **Load the applicable rule sets** from the instruction files:
   - `.github/instructions/openapi-review.instructions.md` — for all OpenAPI JSON
   - `.github/instructions/armapi-review.instructions.md` — additionally for ARM resource-manager JSON
   - `.github/instructions/typespec-review.instructions.md` — for TypeSpec `.tsp` files and `tspconfig.yaml`

6. **Run the full review checklist** from each loaded instruction file against every discovered specification file. Be exhaustive — check every operation, model, property, and parameter. Pay particular attention to:
   - **TypeSpec compliance**: `@service`, `@server`, `@useAuth`, `@versioned` decorators; doc comments; `union` vs `enum`; ARM resource base types; `Operations` interface.
   - **RPC compliance**: ARM resource paths; tracked resource CRUD completeness (GET, PUT, PATCH, DELETE, ListByRG, ListBySub); PUT/PATCH/DELETE response codes; `x-ms-azure-resource`; operations API endpoint.
   - **Naming**: camelCase properties, PascalCase models, `{Resource}_{Verb}` operationIds.
   - **Security**: security definitions, no secrets in GET responses, `x-ms-secret` annotations.

7. **Compare with previous API version for breaking changes.** If a prior `stable/` or `preview/` folder exists locally, compare the new version against it. Check for: removed properties, removed operations, type changes, narrowed enums, optional-to-required transitions, renamed paths. Classify issues as **New** (introduced in current changes) vs. **Existing** (present in prior version). If no previous version exists, classify all issues as **New**.

8. **Report findings** in the standard structured format:

   ```
   ## API Review: <service-name>/<api-version>

   **Previous version:** <previous-version> (or "None — new service")

   ### Directory Structure Issues
   1. **[<Rule>]** <expected-path> vs. <actual-path> — <description and fix>

   ### Blocking Issues — New (must fix)
   1. **[NEW]** **[<Rule ID>]** `<file-path>` — line <N>
      **Issue:** <description>
      **Fix:** <exact code or JSON to apply>

   ### Blocking Issues — Existing (pre-existing, should fix)
   1. **[EXISTING]** **[<Rule ID>]** `<file-path>` — line <N>
      **Issue:** <description>
      **Previous version:** Also present in `<previous-version-file-path>`
      **Fix:** <exact code or JSON to apply>

   ### Warnings — New / Existing
   ...

   ### Breaking Change Analysis
   ...

   ### Summary
   - Files reviewed: <count>
   - Directory structure violations: <count>
   - New blocking issues: <count>
   - Existing blocking issues: <count>
   - New warnings: <count>
   - Existing warnings: <count>
   ```

   This review is **read-only** — do not modify any files. If I want fixes applied, I will ask you to switch to fix mode.