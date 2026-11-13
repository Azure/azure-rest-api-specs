# Microsoft.Cdn TypeSpec versioning SOP

How to add a new **stable** or **preview** API version to the Microsoft.Cdn TypeSpec project in this folder.

This follows the TypeSpec Azure guidance for ARM services whose features sometimes stay in preview
([single active preview](https://azure.github.io/typespec-azure/docs/howtos/versioning/01-about-versioning/),
[perpetual preview](https://azure.github.io/typespec-azure/docs/howtos/versioning/uncommon-scenarios/02-perpetual-preview/)),
adapted because we release one api-version per PR.

## The model

The `Versions` enum in `main.tsp` holds every supported stable version plus **one** active preview, always named `preview`:

```tsp
enum Versions {
  v2025_06_01: "2025-06-01",
  v2025_09_01_preview: "2025-09-01-preview", // restore point, see below; not an active preview
  v2025_12_01: "2025-12-01",
  v2026_07_01: "2026-07-01",
  v2026_10_01: "2026-10-01",

  @previewVersion
  preview: "2026-11-01-preview", // only the value changes when a new preview is released
}
```

Rules:

- **GA is opt-in.** A feature is in a stable version only if it is decorated with that stable version, e.g.
  `@added(Versions.v2026_10_01)`. Everything not yet GA uses `Versions.preview`.
- **New preview = change the `preview` value.** Never add a second preview member. Every `Versions.preview`
  decorator follows automatically.
- **Leaving the enum does not retire a version.** When a preview is replaced, its `preview/<version>/openapi.json`
  stays in the repo untouched and the service keeps serving it. Do not edit or delete it. TypeSpec Validation allows
  older-preview swagger to stay in place. Retiring an api-version is a separate decision.
- **`v2025_09_01_preview` is a restore point**, not an active preview. Features that only ever shipped in
  2025-09-01-preview (KeyGroups, deployment versions, web agents, knowledge sources, profile agents, embedded AFD WAF
  policy, ...) still exist in TypeSpec as `@added(Versions.v2025_09_01_preview) @removed(Versions.v2025_12_01)`. To
  bring one back, append `@added(Versions.preview)` to its stack.
- **TypeSpec is not an archive.** It describes the versions we actively generate. Replaced previews live on as their
  OpenAPI files; git and PR history record how they evolved.

## service.yaml: re-add versions that leave the enum

`service.yaml` lists every api-version of the service and is replacing the version list in `readme.md`. The
`@azure-tools/typespec-autorest` emitter rewrites the `source: typespec` entries on every compile and **silently
deletes the entry of any version that is no longer in the `Versions` enum**, even though its OpenAPI is still
published. Tracked in [Azure/typespec-azure#5605](https://github.com/Azure/typespec-azure/issues/5605).

Until that is fixed, after every `tsp compile .`:

1. Run `git diff service.yaml`. It should only ever **add** versions.
2. If a version disappeared, add it back by hand with `source: swagger`:

   ```yaml
   - version: 2026-08-01-preview
     source: swagger
     swagger-files:
       - preview/2026-08-01-preview/openapi.json
   ```

   The emitter keeps `source: swagger` entries on later compiles.

3. Do not hand-edit `source: typespec` entries; the emitter owns them and rewrites any change.

This happens to the old preview on **every** stable and preview release, because the `preview` value moves to a new
date. CI does not catch it.

## Stable release

Example: releasing `2026-10-01` while `preview` is `2026-08-01-preview`, with the next preview planned as
`2026-11-01-preview`.

### Before you start

- Agree on: features going GA, new GA-only features, features leaving stable, and the next preview date (must be
  later than the stable). It can be a placeholder; it is only published by the next preview PR.
- Removing anything from stable is a breaking change: get Breaking Change Review Board approval
  (https://aka.ms/AzBreakingChangesPolicy) early.
- Branch from the latest Azure `main`. Rebase onto any in-flight preview PR that must merge first.

### Commits

Keep these five commits separate. The next preview PR reverts commit 4 (the strip), so nothing else may be in it.
Example **sources** (`examples/<version>/`) are inputs, not generated output: commit them before the strip. Only
the generated output waits until after the strip, because compiling before it would also generate the placeholder
preview.

**Commit 1: add the stable version (TypeSpec only)**

1. In `main.tsp`, add the stable version **before** `preview`, and set `preview` to the next preview date:
   ```tsp
   v2026_10_01: "2026-10-01",
   @previewVersion
   preview: "2026-11-01-preview",
   ```
2. **Features going GA:** change their `Versions.preview` decorators to the stable version, e.g.
   `@added(Versions.preview)` to `@added(Versions.v2026_10_01)`. Same for `@madeOptional`, `@renamedFrom`,
   `@typeChangedFrom`, `@returnTypeChangedFrom` and `@removed`.
3. **Features leaving stable** (GA in the previous stable but going back to preview): add
   `@removed(Versions.v2026_10_01)` and `@added(Versions.preview)` to the end of their decorator stack.
4. Everything else already uses `Versions.preview` and moves to the next preview automatically.
5. `tsp compile .`, then discard the generated output (`git checkout -- . ; git clean -fd -- .`). Commit.

**Commit 2: new GA-only features (TypeSpec only)**

6. Add features that go straight to GA with `@added(Versions.v2026_10_01)`. They need no preview decorator: later
   versions keep everything added earlier. Kept separate so the commit 4 revert never touches them.
7. Compile, discard output, commit.

**Commit 3: examples for the stable (example sources only)**

8. Create `examples/2026-10-01/` from `examples/<previous stable>/`: update `api-version` (including
   `api-version=` in async operation header URLs) in every file, add examples for new GA features, and change or
   remove examples that use anything not in the new version.

   How the emitter uses this folder: it groups the files by `operationId`, attaches them to the operations that exist
   in that version, and copies only those to `stable/<version>/examples/`. Files for operations that don't exist in
   the version are **silently ignored** (no warning), so copying the whole folder is safe; removing them is optional
   tidiness. The filter is per operation only: an example for an operation that does exist is always published, so
   it must not use preview-only properties or enum values (e.g. an `AfdUrlSigning` action in `Rules_Create`).

9. Delete `examples/<old preview>/` (e.g. `examples/2026-08-01-preview/`). Its copy under
   `preview/<old preview>/examples/` stays.
10. Run `npx prettier --check` on the new and changed example files. Compile, then check the published examples
    against the new version's schema and discard the output:
    - `npx oav validate-example stable/2026-10-01/openapi.json` (from the project folder) reports no errors. This
      catches examples that use something the version doesn't have.
    - Optional: if `stable/2026-10-01/examples/` has fewer files than `examples/2026-10-01/`, the difference is
      examples for operations not in this version (ignored by the emitter).

    Commit.

**Commit 4: strip the preview (TypeSpec only; reverted by the next preview PR)**

11. Delete the `preview` member from the enum and run `tsp compile .`. Every error is a decorator that references
    `Versions.preview`; the error list is the complete checklist. Fix each one:

| Decorator                                                                                                    | Action                                                                                                                                   |
| ------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------- |
| `@added(Versions.preview)` is the item's only `@added`                                                       | Delete the item, plus any `client.tsp` / `back-compatible.tsp` statements that reference it (including the `#suppress` lines above them) |
| `@added(Versions.preview)` at the end of a stack, e.g. after `@removed(v2025_12_01)` or `@removed(<stable>)` | Delete **only that decorator**; the item still exists in an earlier version                                                              |
| `@removed(Versions.preview)`                                                                                 | Delete the decorator                                                                                                                     |
| `@renamedFrom(Versions.preview, "old")`                                                                      | Rename the item back to `old`, delete the decorator                                                                                      |
| `@typeChangedFrom` / `@returnTypeChangedFrom(Versions.preview, T)`                                           | Change the type back to `T`, delete the decorator                                                                                        |
| `@madeOptional(Versions.preview)`                                                                            | Make the item required again, delete the decorator                                                                                       |

12. Compile until clean, discard output. Commit with the title
    `Strip preview content for 2026-10-01 (revert to restore)`.

**Commit 5: generated files**

13. `tsp compile .` creates `stable/2026-10-01/openapi.json` and its `examples/` copy.
14. **service.yaml:** re-add the old preview as `source: swagger` (see above).
15. `readme.md`: add a `package-2026-10` tag and make it the default.
16. Commit, then validate (see [Validation](#validation)):
    - Diff of the previous stable's `openapi.json` vs the new one shows exactly the agreed GA / new / removed list.
    - `git diff <commit 3> <commit 4> -- '*.tsp'` shows exactly what stays in preview.
    - TypeSpec Validation passes.

### Pull request

- Describe the GA, new and removed features, and paste the **commit 4 (strip) SHA** with "revert to restore preview
  content". Record it **after the final push**; rebasing changes it. After a squash merge the original commits stay
  available: `gh api repos/Azure/azure-rest-api-specs/pulls/<PR>/commits`.
- Until the next preview PR merges, `main` has no `preview` member. Customers keep using the previous preview. Any
  preview-only change must start from the next preview PR.

## Preview release

### First preview after a stable (`main` has no `preview` member)

1. Branch from the latest Azure `main`.
2. Restore the preview content by reverting the last stable PR's strip commit:
   ```
   git fetch upstream pull/<stable PR>/head
   gh api repos/Azure/azure-rest-api-specs/pulls/<stable PR>/commits --jq '.[] | "\(.sha) \(.commit.message | split("\n")[0])"'
   git revert --no-commit <strip commit SHA>
   ```
   Resolve conflicts with changes made in `main` since. Commit.
3. If the real preview date differs from the placeholder, change only the `preview` value.
4. Add new features with `@added(Versions.preview)`. To restore a 2025-09-01-preview-only feature, append
   `@added(Versions.preview)` to its decorator stack. Commit.
5. Create `examples/<new preview>/` from the latest stable's examples plus examples for preview features (take
   restored ones from `preview/<old preview>/examples/`). Update `api-version`.
6. `tsp compile .` creates `preview/<new preview>/openapi.json`. Check `git diff service.yaml` only adds versions.
7. `readme.md`: add a `package-preview-YYYY-MM` tag.
8. Commit, validate, open the PR.

### Preview after a preview (`main` already has a `preview` member)

1. Branch from the latest Azure `main`.
2. Change the `preview` value to the new date.
3. `git mv examples/<old preview> examples/<new preview>` and update `api-version` in every file. The old preview's
   copy under `preview/<old preview>/examples/` stays.
4. Add new features with `@added(Versions.preview)`.
5. `tsp compile .`, then **re-add the old preview to service.yaml** as `source: swagger` (see above).
6. `readme.md`: add a `package-preview-YYYY-MM` tag.
7. Commit, validate, open the PR.

## Alternative: stable and next preview in one PR

Two new api-versions in one PR are allowed if every SDK emitter is pinned to the older (stable) version; the
`MultipleNewApiVersions` TypeSpec Validation rule enforces this. It removes the strip and revert entirely:

1. Do stable commits 1 to 3, **skip commit 4 (the strip)**, and keep `preview` set to the real next preview date.
2. Add examples for both versions, generate both, fix `service.yaml`, add both `readme.md` tags.
3. In `tspconfig.yaml`, set `api-version: "2026-10-01"` on `@azure-tools/typespec-python`,
   `@azure-tools/typespec-java`, `@azure-tools/typespec-ts`, `@azure-tools/typespec-go` and
   `@azure-typespec/http-client-csharp-mgmt`.
4. Release the stable SDKs.
5. **Follow-up PR:** move those `api-version` values to the preview version (or remove them) so the preview SDKs can be
   released.

## Validation

Run from the repo root after `pnpm install`:

| Check                      | Command                                                                   | Notes                                                                                               |
| -------------------------- | ------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| Compile                    | `npx tsp compile .` (in this folder)                                      | Add `--warn-as-error` once example folders exist                                                    |
| TypeSpec Validation (CI)   | `npx tsv specification/cdn/resource-manager/Microsoft.Cdn/Cdn`            | Needs a clean git tree: commit first; any uncommitted change is reported as a failure               |
| Format                     | `npx tsp format "**/*.tsp"` (in this folder)                              |                                                                                                     |
| Existing swagger unchanged | `git status -- stable preview` after compiling                            | Only the new version's folder may appear                                                            |
| Examples match the schema  | `npx oav validate-example stable/<version>/openapi.json` (in this folder) | Checks only the examples the emitter published; files for operations not in the version are ignored |

## References

- [Single active preview](https://azure.github.io/typespec-azure/docs/howtos/versioning/01-about-versioning/)
- [Managing a single active preview when some features always remain in preview](https://azure.github.io/typespec-azure/docs/howtos/versioning/uncommon-scenarios/02-perpetual-preview/)
- [Converting existing specs to single active preview](https://azure.github.io/typespec-azure/docs/howtos/versioning/uncommon-scenarios/01-converting-specs/)
- [Adding a preview version when the last version was preview](https://azure.github.io/typespec-azure/docs/howtos/versioning/02-preview-after-preview/)
- [x-ms-examples example files](https://azure.github.io/typespec-azure/docs/migrate-swagger/faq/x-ms-examples/): examples are matched to operations by `operationId`
- [Azure/typespec-azure#5605](https://github.com/Azure/typespec-azure/issues/5605): service.yaml drops versions removed from the enum
- [Azure/azure-rest-api-specs#45601](https://github.com/Azure/azure-rest-api-specs/pull/45601): `MultipleNewApiVersions` rule
- [Azure breaking changes policy](https://aka.ms/AzBreakingChangesPolicy)
