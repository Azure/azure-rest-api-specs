# Validation

After applying changes (Step 4), run through all sub-steps below in order.

| Sub-step | Action                             | When                       |
| -------- | ---------------------------------- | -------------------------- |
| 5.1      | TypeSpec Validation (error checks) | Always                     |
| 5.2      | `tsp compile .` (generate swagger) | Always                     |
| 5.3      | Example Verification               | API Version Evolution only |

> Steps 5.1 and 5.2 serve different purposes. Step 5.1 validates for errors/warnings. Step 5.2 compiles and generates the OpenAPI `.json` output files. Both must be executed.

### Step 5.1: TypeSpec Validation

Invoke `azure-sdk-mcp:azsdk_run_typespec_validation` with the TypeSpec project root path.

- **Pass** → proceed to Step 5.2.
- **Fail** → fix with minimal, scoped changes, then re-run. Repeat until resolved.

> Never skip this step, even for trivial changes.

### Step 5.2: Compile successfully

> This step is separate from Step 5.1. Validation alone does not produce output files — you must also run `tsp compile .` to generate the OpenAPI swagger.

Run `tsp compile .` from the TypeSpec project root path. After compilation succeeds, verify that the swagger `.json` file has been generated under `{TypeSpec project root}/{version-status}/{target-version}/` (e.g. `preview/2025-01-01-preview/widget.json`). Fix any compile errors if they occur.

### Step 5.3: Example Verification

> Applies only for API Version Evolution tasks

Verify that the example folder set up in Step 3 (copied from the latest version's `examples/` into `{TypeSpec project root}/{version-status}/{target-version}/examples/`) exists and contains example files.

1. **Folder exists** — confirm `{TypeSpec project root}/{version-status}/{target-version}/examples/` was created. If missing, copy all `.json` files from the latest version's `examples/` folder.
2. **Files exist** — confirm the folder contains at least one `.json` example file. If empty, copy examples from the latest version's `examples/` folder.
3. **api-version updated** — each example file must use the correct `api-version` value matching the target version (e.g. `2024-02-01-preview`, not the source version).
