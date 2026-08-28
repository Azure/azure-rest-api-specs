# Validation

Run all sub-steps in order after applying changes.

| Sub-step | Action                                        | When                       |
| -------- | --------------------------------------------- | -------------------------- |
| 5.1      | `azure-sdk-mcp:azsdk_run_typespec_validation` | Always                     |
| 5.2      | `tsp compile .`                               | Always                     |
| 5.3      | Example verification                          | API version evolution only |

### 5.1: TypeSpec Validation

Invoke `azure-sdk-mcp:azsdk_run_typespec_validation` with the project root. On failure → fix → re-run. Limit to 3 retry attempts; if still failing after 3 retries, stop and report the remaining errors to the user.

### 5.2: Compile

Run `tsp compile .` from the project root. Verify `.json` output under the directory specified by the `@azure-tools/typespec-autorest` entry in the project's tspconfig.yaml. Fix compile errors if any.

> 5.1 checks for errors/warnings; 5.2 generates the OpenAPI output. Both are required.

### 5.3: Example Verification

Verify `{project-root}/{version-status}/{target-version}/examples/` exists with `.json` files using the correct `api-version`. If missing, copy from the previous version's examples and update `api-version`. Skip example verification for XML-based specs, as the tooling does not support examples for XML specifications.

Verify that any example folder for an API version that no longer exists in the `Versions` enum has been deleted. For each folder under `{project-root}/{version-status}/`, check that the folder name matches an entry in the `Versions` enum. If a folder exists for a removed version, delete it.
