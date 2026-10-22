# Initial readiness inventory

Snapshot: **2026-10-22**. Refresh before execution; publication and defaults change.

- Implementation source: [Azure/typespec-azure at `726862b`](https://github.com/Azure/typespec-azure/tree/726862b537be9fdb24d7e6a4ca868eb9104025dd).
- Spec source: [Azure/azure-rest-api-specs at `8fba483`](https://github.com/Azure/azure-rest-api-specs/tree/8fba48337fa3552e44b30eb7281b8049a6ce289b).
- [PR #47343](https://github.com/Azure/azure-rest-api-specs/pull/47343)
  is merged. The repository wrapper still only extends upstream profiles; it
  has no migration enablement overrides.
- Spec `main` installs compiler `1.17.0` and Azure core, ARM, TCGC, and upstream
  rulesets `0.73.0`. The upstream ruleset is installed under
  `@azure-tools/typespec-azure-rulesets-original`; the original public name
  resolves to the private repository workspace.

## Counts and readiness

There are **52 merged PRs with the migration title prefix**, not 52 production
rules: 32 target the migration feature branch, while 20 promotions to `main`
produce **19 current unique rule IDs**. `list-response-envelope` consolidates
two migrations. Count the current consolidated rule once. Earlier
`list-response-value-array` work is not another current rule.

Of the 19, **18 are opt-in** and one is already enabled. Their readiness on spec
`main` is:

| Category                                           | Count | Meaning                                                                         |
| -------------------------------------------------- | ----: | ------------------------------------------------------------------------------- |
| Stable implementation and central opt-in path      |     9 | Available to start baseline/rollout work now; not yet repository-wide validated |
| Stable implementation, profile-composition blocker |     1 | `use-create-for-put` is disabled again by the later `client-sdk` profile        |
| Requires newer package behavior                    |     8 | Seven new IDs plus the expanded `list-response-envelope` behavior               |
| Already enabled                                    |     1 | `no-unnamed-types`; its latest migration extension still needs newer packages   |

Thus **18 follow-up candidates**, **9 straightforward stable-package starting
points**, and **no claim that any of those nine has completed a full spec scan**.
Once package and composition prerequisites are met, the same suppression
workflow applies, but merging an implementation does not establish that every
diagnostic can safely be suppressed.

## Rule inventory

Use the defining-package prefixes below; the wrapper is not the rule owner:

- **ARM**: `@azure-tools/typespec-azure-resource-manager/`
- **Core**: `@azure-tools/typespec-azure-core/`
- **TCGC**: `@azure-tools/typespec-client-generator-core/`

All PR numbers link to `Azure/typespec-azure`.

| Package | Rule suffix                         | Migration PR(s)                                                                                                      | Readiness on spec `main`                                             |
| ------- | ----------------------------------- | -------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| ARM     | `no-tenant-level-apis`              | [5420](https://github.com/Azure/typespec-azure/pull/5420)                                                            | Stable opt-in                                                        |
| ARM     | `list-operation-missing-pageable`   | [5379](https://github.com/Azure/typespec-azure/pull/5379)                                                            | Stable opt-in                                                        |
| ARM     | `use-model-request-body`            | [5361](https://github.com/Azure/typespec-azure/pull/5361)                                                            | Stable opt-in                                                        |
| ARM     | `no-query-in-collection`            | [5318](https://github.com/Azure/typespec-azure/pull/5318)                                                            | Stable opt-in                                                        |
| ARM     | `no-query-in-post`                  | [5281](https://github.com/Azure/typespec-azure/pull/5281)                                                            | Stable opt-in                                                        |
| ARM     | `use-application-json-content-type` | [5302](https://github.com/Azure/typespec-azure/pull/5302)                                                            | Stable opt-in                                                        |
| ARM     | `no-query-in-point-op`              | [5273](https://github.com/Azure/typespec-azure/pull/5273)                                                            | Stable opt-in                                                        |
| Core    | `no-boolean`                        | [5265](https://github.com/Azure/typespec-azure/pull/5265)                                                            | Stable opt-in; ARM and data-plane                                    |
| TCGC    | `get-operation-name`                | [5364](https://github.com/Azure/typespec-azure/pull/5364)                                                            | Stable opt-in; SDK naming                                            |
| TCGC    | `use-create-for-put`                | [5457](https://github.com/Azure/typespec-azure/pull/5457)                                                            | Stable, but ARM-only composition blocked                             |
| ARM     | `list-response-envelope`            | [5358](https://github.com/Azure/typespec-azure/pull/5358), [5582](https://github.com/Azure/typespec-azure/pull/5582) | ID exists in stable; complete migrated behavior requires next        |
| ARM     | `resource-missing-read`             | [5654](https://github.com/Azure/typespec-azure/pull/5654)                                                            | New ID requires next                                                 |
| ARM     | `scope-path-segment-casing`         | [5681](https://github.com/Azure/typespec-azure/pull/5681)                                                            | New ID requires next                                                 |
| ARM     | `use-scope-for-extension-routing`   | [5684](https://github.com/Azure/typespec-azure/pull/5684)                                                            | New ID requires next                                                 |
| ARM     | `use-standard-response-codes`       | [5556](https://github.com/Azure/typespec-azure/pull/5556)                                                            | New ID requires next                                                 |
| ARM     | `use-resource-path-for-put`         | [5550](https://github.com/Azure/typespec-azure/pull/5550)                                                            | New ID requires next                                                 |
| ARM     | `no-tags-on-proxy-resource`         | [5502](https://github.com/Azure/typespec-azure/pull/5502)                                                            | New ID requires next                                                 |
| Core    | `no-redundant-summary`              | [5507](https://github.com/Azure/typespec-azure/pull/5507)                                                            | New ID requires next; ARM and data-plane                             |
| Core    | `no-unnamed-types`                  | [5522](https://github.com/Azure/typespec-azure/pull/5522)                                                            | Already on in ARM/data-plane; expanded parameter checks require next |

Published `next` packages inspected:

| Package                 | Stable   | Next           |
| ----------------------- | -------- | -------------- |
| Azure core              | `0.73.0` | `0.74.0-dev.4` |
| Azure resource manager  | `0.73.0` | `0.74.0-dev.7` |
| Client generator core   | `0.73.0` | `0.74.0-dev.7` |
| Upstream Azure rulesets | `0.73.0` | `0.74.0-dev.9` |

All 19 current implementations are published in those next packages. This
does not prove that a target branch installs them. For example, changing only
the upstream rulesets alias can leave required core/ARM/TCGC exports unavailable.

## Verified mechanism, not a completed service rollout

The checked-out spec tree discovers **612 TypeSpec projects** using
`pnpm exec tsv --all --dry-run specification`. This is all discovered projects,
not the affected population for every candidate rule.

A synthetic compiler smoke test using the installed stable packages and the
repository data-plane wrapper established:

| Step                                                        | Observed result                                 |
| ----------------------------------------------------------- | ----------------------------------------------- |
| Inherit existing wrapper defaults                           | No `no-boolean` diagnostic                      |
| Add a final `no-boolean: true` opt-in                       | One diagnostic on the existing boolean property |
| Compile with warnings as errors                             | The selected diagnostic has error severity      |
| Add an inline suppression on that property                  | Selected diagnostic disappears                  |
| Compare emitted OpenAPI before opt-in and after suppression | Byte-for-byte identical                         |
| Add another, unsuppressed boolean property                  | One new diagnostic remains                      |

This proves the suppression mechanism preserves the tested output and does not
disable future violations. It is **not** a production service experiment, actual
central-policy rollout, or six-shard validation. No production suppressions or
enablement overrides were added during this investigation.

The existing wrapper build and four
`eng/tools/typespec-validation/test/repository-rulesets.test.ts` cases passed.
They cover all three inherited profiles and individual opt-in behavior.

## PR #45589: reproduced incompatibility

[PR #45589](https://github.com/Azure/azure-rest-api-specs/pull/45589) was still open
at inspected head `f008f86e0b709c7e066cf87843bf5d424492552f`.
Its parser was executed unchanged against the failing Ubuntu next shard
`119571834442` from [TSV-All run 39701589959](https://github.com/Azure/azure-rest-api-specs/actions/runs/39701589959).

It reported **one parsed log, zero folders, zero failures, zero eligible** even
though that log contains failed projects. Its `Validating` group regex does not
match current `pass`/`fail`/`skip` headings. Do not use it as-is or interpret its
empty report as a clean population.

Even after repairing log compatibility, the pipeline would need logs from a
candidate revision **with the selected rule enabled**. Harvesting default green
CI cannot discover violations of disabled rules.

## Recommended first production rollout

Start with one of the stable ARM rules such as `no-query-in-post`, after measuring
its actual diagnostic population; prefer a small, understandable exception set.
The `no-boolean` smoke test was chosen for deterministic proof, not as evidence
that it has the smallest production impact. Keep the first rollout to one rule,
central enablement plus justified existing-contract suppressions, and full target
ref validation. Leave next-only rules and the SDK profile-composition blocker
for explicit prerequisite work.
