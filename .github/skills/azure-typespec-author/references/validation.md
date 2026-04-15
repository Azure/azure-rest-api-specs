# Validation

Run all sub-steps in order after applying changes.

| Sub-step | Action | When |
| -------- | ------ | ---- |
| 5.1 | `azsdk_run_typespec_validation` | Always |
| 5.2 | `tsp compile .` | Always |
| 5.3 | Example verification | API version evolution only |

### 5.1: TypeSpec Validation

Invoke `azsdk_run_typespec_validation` with the project root. On failure → fix → re-run until resolved.

### 5.2: Compile

Run `tsp compile .` from the project root. Verify `.json` output under `{project-root}/{version-status}/{target-version}/`. Fix compile errors if any.

> 5.1 checks for errors/warnings; 5.2 generates the OpenAPI output. Both are required.

### 5.3: Example Verification

Verify `{project-root}/{version-status}/{target-version}/examples/` exists with `.json` files using the correct `api-version`. If missing, copy from the previous version's examples and update `api-version`.
