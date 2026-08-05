# VoiceLive Versioning Design: the `v1` (label-based) Pattern

> Status: Active
> Applies to: `specification/ai/data-plane/VoiceLive`
> Pattern source: [Azure AI Foundry data-plane spec](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/ai-foundry/data-plane/Foundry)
> Origin: [PR #44108 — Migrate VoiceLive to label-based versioning](https://github.com/Azure/azure-rest-api-specs/pull/44108)

## 1. Summary

VoiceLive adopts Foundry's **evergreen `v1` pattern**: one rolling GA label (`v1`), a
build-time-only virtual preview channel (`virtual-public-preview`) to author/fence preview
surface, and a per-feature opt-in header (`VoiceLive-Features`) that enables preview behavior
on `v1`. Clients pick the contract with `api-version` and flip preview with the header — never
`api-version=virtual-public-preview`. Additive features need no new dated version.

> **One project, two channels.** The `Versions` enum here is permanently just `PuPr`
> (`virtual-public-preview`) and `v1`. Only `openapi3/v1/` and `openapi3/virtual-public-preview/`
> are (re)generated from this source. The date-stamped Swagger snapshots (`2025-10-01`,
> `2026-04-10`, `2026-07-15`, and the `*-preview` snapshots) are **frozen historical artifacts**
> from the old date-based model — retained for API-view/diff reference, never regenerated.

## 2. Time-based vs label-based

| Aspect | Time-based (`2026-04-10`) | Label-based (`v1`) |
| --- | --- | --- |
| Version string | Immutable snapshot | Rolling pointer to current GA |
| Add optional feature | Mint a new dated version | Rewrite same `v1` output in place |
| Client action for new features | Re-pin to new date | None — follows the label |
| Versions over time | Grows every release | Stays one (`v1`); `v2` only if breaking |

Stability lives on **change discipline** — only additive changes touch `v1` — not on the
version string.

## 3. Principles

1. **`v1` is evergreen** — regenerated and overwritten each build; the label is stable, its
   contents grow.
2. **Stability is scoped to `v1`** — only backward-compatible changes there (new optional
   fields/messages/enum values; never remove, retype, or make optional→required). The
   evergreen preview channel carries no such promise and may change freely.
3. **One build-time-only preview channel** — `virtual-public-preview` (`PuPr`) authors/fences
   preview surface; clients never send it as `api-version`.
4. **Per-feature opt-in** — preview is enabled on `v1` via the `VoiceLive-Features` header,
   not a separate version.
5. **Breaking = new major (`v2`)**, never minor; old majors stay frozen and are never deleted.

## 4. Client usage

Two independent axes: **`api-version` selects the contract; `VoiceLive-Features` opts into
preview within it.** Clients never send `api-version=virtual-public-preview` — preview rides
on `v1`.

| Goal | Connect with | Header |
| --- | --- | --- |
| Frozen dated version¹ | `?api-version=2026-07-15` | — |
| Evergreen GA | `?api-version=v1` | — |
| Preview feature on GA | `?api-version=v1` | `VoiceLive-Features: BargeIn=V1Preview` |

¹ Served by the frozen historical Swagger snapshots; shown for completeness.

Enable **multiple** features by comma-separating keys on the same header (as Foundry does):

```http
GET /voice-live/realtime?api-version=v1
VoiceLive-Features: BargeIn=V1Preview, Transcription=V1Preview, CustomVoice=V1Preview
```

`api-version` stays `v1`; order is irrelevant; omitting a key leaves that feature at its GA
default. A **preview-only** capability requires the header; a GA capability with optional
preview behavior takes it only when creating/updating a preview-enabled resource.

## 5. Handling changes (virtual version + `v1`)

We follow the same TypeSpec authoring pattern as Azure AI Foundry, deliberately tracking
Foundry's `@added`/`@removed` versioning mechanics so VoiceLive stays aligned if those
mechanics evolve. The virtual channel is the staging area; `v1` is the live evergreen GA that
only grows. Four change types:

- **Add a GA feature** — just add the new **optional** surface; no decorator needed. `PuPr` is
  the **default (base) version**, so undecorated surface already lands in **both** `PuPr` and
  `v1`, keeping `virtual-public-preview` a strict superset of `v1`. **Never** use
  `@added(Versions.v1)` for a normal GA addition — surface added at `v1` is absent from `PuPr`,
  breaking the superset invariant; reserve it only for deliberately GA-only, preview-hidden
  surface.
- **Add a preview feature** — incubate on the virtual channel, fenced from GA with
  `@removed(Versions.v1)` (appears in `virtual-public-preview`, behind the header; absent from
  `v1`). Since `PuPr` is the base version, no `@added` is needed.
- **Promote preview → GA** — delete the `@removed(Versions.v1)` line; it now flows into `v1` as
  a normal optional field, header gate dropped. No version bump.
- **Breaking change** — can't touch `v1`; mint `v2` and fence both shapes
  (`@removed(Versions.v2)` old / `@added(Versions.v2)` new).

Rule of thumb: `PuPr` is the default/base version. **plain optional field** = additive GA
(lands in both `PuPr` and `v1`) · `@removed(v1)` = previewing (preview-only) · drop
`@removed(v1)` = GA it · `@added(v1)` = GA-only, hidden from preview (avoid unless intentional)
· breaking → new `v2`. For a value whose **shape** differs between channels, use
`@typeChangedFrom(Versions.v1, <preview type>)` — the declared type is `v1`'s, the argument is
`PuPr`'s.

**Preview surface is unconstrained.** The only contract that must stay backward-compatible is
`v1`. The evergreen `virtual-public-preview` channel carries no compatibility promise — as long
as `v1` isn't broken, preview features can be freely added, deleted, retyped, or broken between
builds, with no `v2` and no version bump.

## 6. Relationship to the frozen dated snapshots

The dated Swagger snapshots (`2025-10-01`, `2026-04-10`, `2026-07-15`, and the `*-preview`
snapshots) are the frozen output of the previous date-based model. They are compiled from
nothing anymore — the current source only produces `v1` and `virtual-public-preview`. Customers
migrate **per-client, opt-in** by switching `api-version` from a date to `v1` when ready —
nothing breaks because `v1` is authored as a backward-compatible **superset** of the latest
dated GA contract (`2026-07-15`). New additive GA changes go only into `v1` (as plain optional
fields); the frozen snapshots are never regenerated.

## 7. Limitations to notice

| # | Limitation | What it means |
| --- | --- | --- |
| 1 | **Additive-only preview** | The single `virtual-public-preview` channel sits before `v1`, so it can only incubate features added on top of GA — not a breaking `v2` reshape, which would need a second channel before `v2`. |
| 2 | **All-or-nothing per feature** | A capability is either preview (header-gated) or GA; there's no "beta within GA" tier. Graduated rollout is a runtime concern, not in the contract. |
| 3 | **Preview isn't a frozen snapshot** | The evergreen preview can change shape or disappear between builds with no version pin; stability only begins once the feature lands in `v1`. |
| 4 | **Header is a coarse signal** | GA `v1` looks identical with or without opt-in, so version-string-based tooling (diffing, SDK surface, docs) won't see preview behavior unless it models the header. |
| 5 | **Old majors still accumulate** | A true breaking change still mints a new major served alongside `v1` — "one version per major," not "one forever." |

> [!WARNING]
> ### Minting a new major is the big hammer — break-glass only
>
> Creating a `v2` should be **extremely rare**. As with other Azure AI Foundry services, a new
> major version carries **broad implications across the ecosystem** — client libraries, SDKs,
> tooling, and downstream consumers all require updates.
>
> Reach for it only when there is genuinely **no backward-compatible path**. Otherwise, keep
> changes **additive on `v1`** or **fenced on the preview channel**.
