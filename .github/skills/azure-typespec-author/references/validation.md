# Validation

After applying changes (Step 4), run through all sub-steps below in order.

| Sub-step | Action               | When                       |
| -------- | -------------------- | -------------------------- |
| 5.1      | TypeSpec Validation  | Always                     |
| 5.2      | Example Verification | API Version Evolution only |

### Step 5.1: TypeSpec Validation

1. Invoke `azure-sdk-mcp:azsdk_run_typespec_validation` with the TypeSpec project root path.
2. Run `tsp compile` for the typespec project.

- **Pass** → proceed to Step 5.2.
- **Fail** → fix with minimal, scoped changes, then re-run. Repeat until resolved.

> Never skip this step, even for trivial changes.

### Step 5.2: Example Verification

> Applies only for API Version Evolution tasks

Verify that the example folder set up in Step 3 (copied from the latest version's `examples/` into `{TypeSpec project root}/{version-status}/{target-version}/examples/`) exists and contains example files.

1. **Folder exists** — confirm `{TypeSpec project root}/{version-status}/{target-version}/examples/` was created. If missing, copy all `.json` files from the latest version's `examples/` folder.
2. **Files exist** — confirm the folder contains at least one `.json` example file. If empty, copy examples from the latest version's `examples/` folder.
3. **api-version updated** — each example file must use the correct `api-version` value matching the target version (e.g. `2024-02-01-preview`, not the source version).
