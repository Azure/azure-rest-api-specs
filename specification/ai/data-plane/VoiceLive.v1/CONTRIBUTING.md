# Contributing to the VoiceLive TypeSpec

This folder (`VoiceLive.v1/`) uses the **label-based (`v1`) versioning** pattern, like Azure AI Foundry. `v1` is the evergreen GA contract that only grows; preview surface is staged on the build-time-only `virtual-public-preview` channel and gated at runtime by the `VoiceLive-Features` header. For the design and rationale, see [docs/versioning.md](docs/versioning.md).

> **Date-stamped versions live elsewhere.** The dated contracts (`2025-10-01`, `2026-04-10`, …) are a **separate project** in the sibling [`VoiceLive/`](../VoiceLive/) folder. This project's `Versions` enum is permanently just `PuPr` and `v1`; edits here never touch the dated versions.

## Decorator cheat sheet

`PuPr` is the base version, so undecorated surface already lands in **both** `PuPr` (preview channel) and `v1` (GA). The only decorator you need here is **`@removed(Versions.v1)`**, which fences surface out of GA.

| Goal | How |
| --- | --- |
| **Add a GA feature** | Add a new **optional** field/model/operation. No decorator needed. |
| **Add a preview-only feature** | `@removed(Versions.v1)` (keeps it out of `stable/v1`). |
| **Promote preview → GA** | Delete the `@removed(Versions.v1)` line. No version bump. |
| **Breaking change** | Not allowed on `v1` — requires a new major (`v2`). See below. |

⛔ **Never** use `@added(Versions.v1)` for a normal GA addition — it would be absent from `PuPr`, breaking the "preview ⊇ v1" invariant. Reserve it only for surface you deliberately want GA-only and hidden from preview.

```tsp
// Preview-only model — @removed(Versions.v1) fences it out of v1.
@removed(Versions.v1)
model MyNewPreviewModel { ... }
```

## What's backward-compatible

Only **backward-compatible** changes may flow into `stable/v1`. Per the [Azure Breaking Change Policy](https://aka.ms/AzBreakingChangesPolicy):

- ✅ **Allowed:** add an **optional** field/model/operation, add a value to an **extensible** enum (`modelAsString: true`), add an optional header/query parameter, relax a validation constraint.
- ⛔ **Breaking (needs `v2`):** remove or rename anything, make optional↔required, change a field's type/format/units, add a value to a closed enum, change defaults or error `code` values, or remove a `Versions` enum member.

> Adding a **required** field to `v1` after GA is breaking — model it as optional instead.

## Breaking changes

A breaking change can't touch `v1`; it requires a new major (`v2`) and is **break-glass only** — broad impact across SDKs, tooling, and consumers. Requires approval from the [Azure Breaking Change Reviewers](mailto:azbreakchangereview@microsoft.com) and Azure API Stewardship Board review **before** release.

## Compiling and sending a PR

```pwsh
# from this folder
npm ci
npx tsv .
```

Fix any linter errors (`@azure-tools/typespec-azure-rulesets/data-plane`); treat versioning and breaking-change diagnostics as blocking. `npx tsv .` also regenerates the Swagger under `stable/` and `preview/`. Confirm:

- `stable/v1/VoiceLive.json` is **purely additive**; preview-only surface is **absent**.
- `preview/virtual-public-preview/VoiceLive.json` contains the new preview surface.

`git add` all changed files (including the generated Swagger) and re-run `npx tsv .` — there should be no remaining diffs before you open the PR.
