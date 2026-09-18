# Validation

> Prerequisite: Step 4 (Apply Changes) must be complete.

Run **5.1 General Validation** for every case; run **5.2 Case-Specific Validation** only when the case identified in [intake.md](intake.md) §2.1 matches.

| Sub-step | Action                                        | When                    |
| -------- | --------------------------------------------- | ----------------------- |
| 5.1.1    | `azure-sdk-mcp:azsdk_run_typespec_validation` | Always                  |
| 5.1.2    | `tsp compile .`                               | Always                  |
| 5.2      | Case-specific validation                      | Case matches (see §5.2) |

---

## 5.1 General Validation (All Cases)

### 5.1.1: TypeSpec Validation

Invoke `azure-sdk-mcp:azsdk_run_typespec_validation` with the project root. On failure → fix → re-run. Limit to 3 retry attempts; if still failing after 3 retries, stop and report the remaining errors to the user.

### 5.1.2: Compile

Run `tsp compile .` from the project root. Verify `.json` output under the directory specified by the `@azure-tools/typespec-autorest` entry in the project's tspconfig.yaml. Fix compile errors if any.

> 5.1.1 checks for errors/warnings; 5.1.2 generates the OpenAPI output. Both are required.

---

## 5.2 Case-Specific Validation

Run the sub-section matching the case identified in [intake.md](intake.md) §2.1. If no case matches, skip this step — 5.1 is sufficient.

### Case 3 — API Versioning (ARM / Data-plane)

Run after 5.1. Perform each check below and **report the result as a checklist** — one line per check marked ✅ (pass) or ❌ (fail) with a short note. If any check fails, fix the code and re-run 5.1, then continue.

1. **Example verification.** Verify the new version's examples folder exists — mirroring the existing versions' examples layout observed in Step 1 (e.g. `{project-root}/examples/{target-version}/`) — with `.json` files using the correct `api-version`. If missing, copy from the latest retained version's examples and update `api-version`. Skip for XML-based specs, as the tooling does not support examples for XML specifications. Also verify that any example folder for an API version that no longer exists in the `Versions` enum has been deleted: for each versioned example folder, check that its version matches an entry in the `Versions` enum, and delete any folder for a removed version.
2. **Enumerate versions.** List every entry in the `Versions` enum (e.g. `v2025_05_04_preview`).
3. **Preview versioning rules.** If the new version is a preview, verify it is the final `Versions` enum value and is decorated with `@previewVersion`; verify no other version has `@previewVersion`; and verify every change from the latest stable version uses the appropriate versioning decorator with the preview version as its argument.
4. **No dangling version references.** Every version identifier used in a versioning decorator argument (`@added`, `@removed`, `@renamedFrom`, `@typeChangedFrom`, `@madeOptional`, `@returnTypeChangedFrom`, etc.) across all `.tsp` files **must** exist in the `Versions` enum. If a decorator references a version that is no longer in the enum (because a previous version was superseded/renamed rather than kept), rebase that decorator to the correct current version or remove it — do not leave the stale reference.
5. **Superseded version fully removed.** If a previous version was superseded/renamed (its enum entry no longer present), confirm there are **no** remaining occurrences of that old version identifier anywhere in the `.tsp` files, and that its example folder has been deleted (per check 1).
6. **Carried-over vs. excluded features.** Confirm every feature the user chose to carry over is present in the new version **with its versioning decorators rebased onto the new version, not reverted** — e.g. a renamed property must keep its `@renamedFrom`/`@removed`/`@added` scaffolding retargeted to the new version (do not delete the decorators and restore the old shape, which would break the retained released version). Confirm every feature the user chose to exclude is not reintroduced (including any transitional decorator scaffolding — e.g. a property whose added default value was excluded must end up as a plain optional property, not a decorator-bridged rename).
7. **Re-validate.** Re-run 5.1.1 and 5.1.2 and confirm both pass.
