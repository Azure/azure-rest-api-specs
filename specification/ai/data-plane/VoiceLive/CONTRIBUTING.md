# Contributing to the VoiceLive TypeSpec

VoiceLive uses the **label-based (`v1`) versioning** pattern, the same approach as Azure AI Foundry. `v1` is the evergreen GA contract that only grows; preview surface is staged on the build-time-only `virtual-public-preview` channel and gated at runtime by the `VoiceLive-Features` header. For the full design and rationale, see [docs/versioning.md](docs/versioning.md).

## Versioning rules

Only **backward-compatible** changes may flow into `stable/v1` (and any frozen dated version). Per the [Azure Breaking Change Policy](https://aka.ms/AzBreakingChangesPolicy):

- ✅ **Allowed on `v1`:** add a new **optional** field/model/operation, add a value to an **extensible** enum (`modelAsString: true`), add an optional header or query parameter, relax a validation constraint.
- ⛔ **Breaking (requires a new major):** remove or rename anything, make an optional field required (or vice versa), change a field's type/format/units, add a value to a closed enum, change defaults or error `code` values.
- ⛔ **Never** edit a frozen dated version (`stable/2026-04-10`, etc.) or remove a member from the `Versions` enum — old versions and majors are immutable.

> Required fields can only be introduced in the first version of a contract. Adding a required field to `v1` after GA is breaking — model it as optional instead.

## Adding a GA feature

Add the surface directly to `v1` with the `@added` decorator. Keep new fields **optional**.

```tsp
@added(Versions.v1)
newOptionalField?: string;
```

## Adding a preview feature

Mark all preview surface (routes and models) with **both** `@added` for the preview version **and** `@removed(Versions.v1)`. If you omit the `@removed` decorator, the preview surface will incorrectly appear in the GA `v1` swagger (`stable/v1/VoiceLive.json`).

```tsp
@added(Versions.PuPr)
@removed(Versions.v1)
model MyNewPreviewModel {
  ...
}
```

## Promoting preview → GA

Delete the `@removed(Versions.v1)` line (keep `@added(Versions.PuPr)`). The feature then flows into `stable/v1` as a normal optional field, the header gate is dropped, and **no version bump is required**.

## Breaking changes

A breaking change cannot touch `v1`; it requires a new major (`v2`) and is **break-glass only** — a new major has broad implications across SDKs, tooling, and downstream consumers. Breaking changes require approval from the [Azure Breaking Change Reviewers](mailto:azbreakchangereview@microsoft.com) and Azure API Stewardship Board review **before** release.

## Compiling and sending a PR

Before sending a PR for changes in this folder:

```pwsh
# from this folder
npm ci
npx tsv .
```

Fix any errors reported by the linter (`@azure-tools/typespec-azure-rulesets/data-plane`); treat versioning and breaking-change diagnostics as blocking. `npx tsv .` also regenerates the Swagger under `stable/`, `preview/`, and validates formatting. Review the generated diffs and confirm:

- `stable/v1/VoiceLive.json` is **purely additive** vs the previous build; preview-only surface is **absent** here.
- `preview/virtual-public-preview/VoiceLive.json` contains the new preview surface.
- Frozen dated versions show **no diff**.

`git add` all changed files (including the generated Swagger) and re-run `npx tsv .` — there should be no remaining diffs before you open the PR.
