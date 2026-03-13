# Validation

After applying changes (Step 4), run through all sub-steps below in order.

| Sub-step | Action                     | When            |
| -------- | -------------------------- | --------------- |
| 5.1      | TypeSpec Validation        | Always          |
| 5.2      | Output Path Verification   | Always          |
| 5.3      | Example Verification       | Always          |
| 5.4      | Breaking Change Check      | Stable API only |

### Step 5.1: TypeSpec Validation

Invoke `azure-sdk-mcp:azsdk_run_typespec_validation` with the project root path.

- **Pass** → proceed to Step 5.2.
- **Fail** → fix with minimal, scoped changes, then re-run. Repeat until resolved.

> Never skip this step, even for trivial changes.

### Step 5.2: Output Path Verification

Verify that the generated OpenAPI spec files exist and are under the correct api-version folder:

1. Locate all generated `openapi.json` (or equivalent swagger JSON) files under the spec root.
   - If **no generated swagger files are found**, run `tsp compile .` under the TypeSpec project root to produce them, then search again.
   - If files are still missing after compilation → investigate `tspconfig.yaml` emitter configuration and fix, then re-compile.
2. Confirm each file resides in a folder matching the **current working API version** from Step 1.
   - Expected path pattern: `{spec-root}/{stability}/{api-version}/openapi.json`
     - `{stability}` is `preview` or `stable`, matching the version suffix.
     - `{api-version}` is the full version string (e.g., `2024-06-01-preview`).

If misplaced files are found → check `tspconfig.yaml` emitter output settings and fix, then re-run Step 5.1.

### Step 5.3: Example Verification

Verify that files under `examples/` are consistent with the current API version:

1. Each operation should have a corresponding example file.
2. Example payloads should reflect the latest schema (property names, types, required fields).
3. The `api-version` query parameter should match the working version from Step 1.

If examples are missing or outdated → **restart from Step 2** to update them.

### Step 5.4: Breaking Change Check

> Applies only when adding a stable API version. Skip otherwise.

Compare changes against the **latest published stable version** and flag:

| Type                          | Example                                      |
| ----------------------------- | -------------------------------------------- |
| Removed or renamed property   | `provisioningState` → `status`               |
| Changed property type         | `string` → `int32`                           |
| Changed required ↔ optional   | optional `location` becomes required         |
| Removed resource or operation | `DELETE /widgets/{id}` no longer exists      |
| Changed response status code  | `200 OK` → `202 Accepted`                   |
| Removed enum member           | `"Running"` removed from `ProvisioningState` |

If breaking changes are detected:
1. List each with before/after comparison.
2. Require explicit user confirmation before proceeding.
