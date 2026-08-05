# Contributing to the VoiceLive TypeSpec

This folder (`VoiceLive/`) uses the **label-based (`v1`) versioning** pattern, like
Azure AI Foundry. `v1` is the evergreen GA contract that only grows; preview surface
is staged on the build-time-only `virtual-public-preview` channel and gated at runtime
by the `VoiceLive-Features` header. For the design and rationale, see
[docs/versioning.md](docs/versioning.md).

> **The `Versions` enum is permanently just `PuPr` and `v1`.** No date-stamped version is
> ever added to it. The dated Swagger snapshots under `stable/2025-10-01`, `stable/2026-04-10`,
> `stable/2026-07-15`, `preview/2026-01-01-preview`, and `preview/2026-06-01-preview` are
> **frozen historical artifacts** from the previous date-based model — they are kept for
> API-view/diff reference only and are never regenerated from this source.

## Decorator cheat sheet

`PuPr` (`virtual-public-preview`) is the **base version**, so undecorated surface already
lands in **both** `PuPr` (preview channel) and `v1` (GA). The only versioning decorator you
normally need here is **`@removed(Versions.v1)`**, which fences surface out of GA.

| Goal | How |
| --- | --- |
| **Add a GA feature** | Add a new **optional** field/model. No decorator needed. |
| **Add a preview-only feature** | `@removed(Versions.v1)` (keeps it out of `v1`). |
| **Promote preview → GA** | Delete the `@removed(Versions.v1)` line. No version bump. |
| **Breaking change** | Not allowed on `v1` — requires a new major (`v2`). See below. |

⛔ **Never** use `@added(Versions.v1)` for a normal GA addition — surface added at `v1` is
absent from `PuPr`, so the preview channel would be missing a GA field, breaking the
"preview ⊇ v1" invariant. Reserve it only for surface you deliberately want GA-only and
hidden from preview.

```tsp
// Preview-only model — @removed(Versions.v1) fences it out of v1.
@removed(Versions.v1)
model MyNewPreviewModel {
  ...
}

// Preview-only field on an otherwise-GA model.
model MySession {
  /** Experimental knob, preview only. */
  @removed(Versions.v1)
  experimental_option?: string;
}
```

For a value that exists in **both** channels but with a **different shape** in preview
(e.g. an extra enum member that is preview-only), use `@typeChangedFrom(Versions.v1, <preview type>)`
— the declared type is what `v1` gets; the argument type is what `PuPr` gets.

## What's backward-compatible

Only **backward-compatible** changes may flow into `v1`. Per the
[Azure Breaking Change Policy](https://aka.ms/AzBreakingChangesPolicy):

- ✅ **Allowed:** add an **optional** field/model, add a value to an **extensible** enum
  (`modelAsString: true` / an extensible `union`), add an optional header/query parameter,
  relax a validation constraint.
- ⛔ **Breaking (needs `v2`):** remove or rename anything, make optional↔required, change a
  field's type/format/units, add a value to a closed enum, change defaults or error `code`
  values, or remove a `Versions` enum member.

> Adding a **required** field to `v1` after GA is breaking — model it as optional instead.

## Breaking changes

A breaking change can't touch `v1`; it requires a new major (`v2`) and is **break-glass only**
— broad impact across SDKs, tooling, and consumers. Requires approval from the
[Azure Breaking Change Reviewers](mailto:azbreakchangereview@microsoft.com) and Azure API
Stewardship Board review **before** release. When you must mint `v2`, fence both shapes
(`@removed(Versions.v2)` on the old, `@added(Versions.v2)` on the new).

## Compiling and sending a PR

```pwsh
# from this folder
npm ci
npx tsv .
```

Fix any linter errors (`@azure-tools/typespec-azure-rulesets/data-plane`); treat versioning
and breaking-change diagnostics as blocking. The spec emits **OpenAPI 3.x** via
`@typespec/openapi3` (the Foundry pattern — this lets VoiceLive consume the OpenAI GA Realtime
TypeSpec, whose models use `oneOf`). Compilation regenerates:

- `openapi3/v1/VoiceLive.json` — the **GA** contract. Confirm it is **purely additive** vs.
  the previous GA and that preview-only surface (anything marked `@removed(Versions.v1)`) is
  **absent**.
- `openapi3/virtual-public-preview/VoiceLive.json` — the **preview** channel; it must be a
  strict **superset** of `v1` and contain the new preview surface.

`git add` all changed files (including the regenerated OpenAPI) and re-run `npx tsv .` —
there should be no remaining diffs before you open the PR.
