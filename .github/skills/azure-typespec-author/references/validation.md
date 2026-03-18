# Validation

After applying changes (Step 4), run through all sub-steps below in order.

| Sub-step | Action                | When                       |
| -------- | --------------------- | -------------------------- |
| 5.1      | TypeSpec Validation   | Always                     |
| 5.2      | Example Verification  | API Version Evolution only |
| 5.3      | Breaking Change Check | Stable API only            |

### Step 5.1: TypeSpec Validation

Invoke `azure-sdk-mcp:azsdk_run_typespec_validation` with the project root path.

- **Pass** → proceed to Step 5.2.
- **Fail** → fix with minimal, scoped changes, then re-run. Repeat until resolved.

> Never skip this step, even for trivial changes.

### Step 5.2: Example Verification

> Applies only for API Version Evolution Tasks

Verify that files under `examples/` are consistent with the current API version:

1. Each operation should have a corresponding example file.
2. Example payloads should reflect the latest schema (property names, types, required fields).
3. The `api-version` query parameter should match the working version from Step 1.

If examples are missing or outdated → **restart from Step 2** to update them.

### Step 5.3: Breaking Change Check

> Applies only when adding a stable API version. Skip otherwise.

Compare changes against the **latest published stable version** and flag:

| Type                          | Example                                      |
| ----------------------------- | -------------------------------------------- |
| Removed or renamed property   | `provisioningState` → `status`               |
| Changed property type         | `string` → `int32`                           |
| Changed required ↔ optional   | optional `location` becomes required         |
| Removed resource or operation | `DELETE /widgets/{id}` no longer exists      |
| Changed response status code  | `200 OK` → `202 Accepted`                    |
| Removed enum member           | `"Running"` removed from `ProvisioningState` |

If breaking changes are detected:

1. List each with before/after comparison.
2. Require explicit user confirmation before proceeding.
