# Validation

> Prerequisite: Step 5 (Apply Changes) must be complete.

Run **6.1 General Validation** for every case; run **6.2 Case-Specific Validation** only when the case identified in [intake.md](intake.md) §2.1 matches.

| Sub-step | Action                                        | When                                        |
| -------- | --------------------------------------------- | ------------------------------------------- |
| 6.1.1    | `azure-sdk-mcp:azsdk_run_typespec_validation` | When the tool is available                  |
| 6.1.2    | `tsp compile .`                               | Always after edits                          |
| 6.1.3    | Client configuration checks                   | Step 4 produced a client configuration plan |
| 6.2      | Case-specific validation                      | Case matches (see §6.2)                     |

---

## 6.1 General Validation (All Cases)

### 6.1.1: TypeSpec Validation

When `azure-sdk-mcp:azsdk_run_typespec_validation` is available, invoke it with the
project root. On validation errors → fix → re-run. Limit to 3 retry attempts; if it
still reports errors after 3 retries, stop and report the remaining errors to the
user.

If the tool is not exposed in the current environment, record that 6.1.1 was skipped
because validation MCP was unavailable and continue directly to 6.1.2. Do not treat
validation errors, authentication failures, timeouts, or other invocation failures as
tool unavailability.

### 6.1.2: Compile

Run `tsp compile .` from the project root. Verify `.json` output under the directory specified by the `@azure-tools/typespec-autorest` entry in the project's tspconfig.yaml. Fix compile errors if any.

> 6.1.1 checks for errors/warnings when validation MCP is available; 6.1.2 generates
> the OpenAPI output and is always required after edits.

Clean only outputs created by the current validation run and only when they did
not exist beforehand. Do not remove project dependencies or environment setup
such as `node_modules`, `packages`, restored tools, or fixture links.

### 6.1.3: Client Configuration

Run when Step 4 produced a client configuration plan. If the user opted out or
client configuration was inapplicable, report the client configuration check as
skipped without making a naming claim.

For naming customizations applied through the naming skill's scoped direct edits:

1. Inspect the resulting diff read-only. Verify the planned target and
   language-scoped `@@clientName`, unchanged wire names and other-language
   overrides, and that the generation entrypoint loads `client.tsp`.
2. Ensure 6.1.1, when available, and 6.1.2 ran after the final source and
   client configuration edits; re-run them if either file changed afterward.
   These checks prove the TypeSpec configuration is valid and compiles; they do
   not prove the emitted SDK API name.
3. Report the generated name as unverified unless generated API evidence was
   supplied or SDK generation was run by a separate authorized workflow.

Use the decisions and verification guidance from
`azsdk-common-typespec-naming`. Report profiles, exceptions, blockers, and
unassessed targets. Naming guidance is independent of linting; installed
linters remain part of normal validation.

---

## 6.2 Case-Specific Validation

Run the sub-section matching the case identified in [intake.md](intake.md) §2.1. If no case matches, skip this step — 6.1 is sufficient.

### Case 3 — API Versioning (ARM / Data-plane)

Run after 6.1. Perform each check below and **report the result as a checklist** — one line per executed check marked ✅ (pass) or ❌ (fail) with a short note. Record skipped checks explicitly, not as passes. If any check fails, fix the code and re-run 6.1, then continue.

1. **Example verification.** Verify the new version's examples folder exists — mirroring the existing versions' examples layout observed in Step 1 (e.g. `{project-root}/examples/{target-version}/`) — with `.json` files using the correct `api-version`. If missing, copy from the latest retained version's examples and update `api-version`. Skip for XML-based specs, as the tooling does not support examples for XML specifications. Also verify that any example folder for an API version that no longer exists in the `Versions` enum has been deleted: for each versioned example folder, check that its version matches an entry in the `Versions` enum, and delete any folder for a removed version.
2. **Enumerate versions.** List every entry in the `Versions` enum (e.g. `v2025_05_04_preview`).
3. **Preview versioning rules.** If the new version is a preview, verify it is the final `Versions` enum value and is decorated with `@previewVersion`; verify no other version has `@previewVersion`; and verify every change from the latest stable version uses the appropriate versioning decorator with the preview version as its argument. For preview after preview, compare against the pre-edit enum: the previous preview's member and wire value must be absent, not merely have their `@previewVersion` decorator removed. Its example folder must also be absent.
4. **No dangling version references.** Every version identifier used in a versioning decorator argument (`@added`, `@removed`, `@renamedFrom`, `@typeChangedFrom`, `@madeOptional`, `@returnTypeChangedFrom`, etc.) across all `.tsp` files **must** exist in the `Versions` enum. If a decorator references a version that is no longer in the enum (because a previous version was superseded/renamed rather than kept), rebase that decorator to the correct current version or remove it — do not leave the stale reference.
5. **Superseded version fully removed.** If a previous version was superseded/renamed (its enum entry no longer present), confirm there are **no** remaining occurrences of that old version identifier anywhere in the `.tsp` files, and that its example folder has been deleted (per check 1).
6. **Carried-over vs. excluded features.** Confirm every feature the user chose to carry over is present in the new version **with its versioning decorators rebased onto the new version, not reverted** — e.g. a renamed property must keep its `@renamedFrom`/`@removed`/`@added` scaffolding retargeted to the new version (do not delete the decorators and restore the old shape, which would break the retained released version). Confirm every feature the user chose to exclude is not reintroduced (including any transitional decorator scaffolding — e.g. a property whose added default value was excluded must end up as a plain optional property, not a decorator-bridged rename). Inspect the complete affected declarations, not just the absence of the default: no renamed old-property companion or bridge decorators may remain for that excluded transition.
7. **Re-validate.** After any corrective edits, re-run 6.1.1 when available and always re-run 6.1.2. Report a skipped MCP check explicitly; every executed check must pass.
