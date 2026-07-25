# Fixture manifest (maintainers)

Provenance for every fixture in this directory: what it seeds, what it guards
against, and which eval stimuli consume it.

**This file exists because the fixtures themselves must not say any of it.**
The `.tsp` files used to carry header comments like
`FIXTURE (TRUE NEGATIVE -- class 2: legitimate deviation)` and inline
`// VIOLATION (DP-MODEL-01): ...` annotations. The agent under evaluation reads
the fixture. A true negative that announces "the correct review output is
silence" measures instruction-following rather than false-positive resistance,
and a positive fixture that names `DP-MODEL-01` on the offending line hands the
agent the exact string the `output-contains` grader is looking for. Both were
present, and both inflated results in the direction that made the reviewer look
good.

**Rule for anyone adding or editing a fixture:** the file must read like a spec
a real service author wrote. No labels, no rule IDs, no "seeded", no statement
about what the reviewer should or should not report. In-world `@doc` text that
a real author would plausibly have written is fine and often load-bearing — for
example, `tn-legitimate-deviation.tsp` documents *why* its list is unpaged and
*why* its configuration has no delete. That is what a competent spec author
would write, and it is exactly what the reviewer must learn to read. It is not
leakage.

A regression check enforces this; see "Enforcement" at the end.

## True negatives — correct output is silence

Consumed by `vally/eval-true-negatives.yaml`. Names are prefixed `tn-` so the
false-positive metric in `run-evals.ps1` can find them; the prefix is invisible
to the agent, which only ever sees the neutral `dest` path.

### `typespec-data-plane/tn-clean-service.tsp`

Class 1, clean spec. A fully compliant `Azure.Core` data-plane service:
standard operations, an extensible union with documented members, `@key` with
`@visibility(Lifecycle.Read)`, substantive `@doc` throughout, a parent/child
resource relationship, paged lists via `ResourceList`.

Guards against: inventing findings on a spec with none.

### `typespec-data-plane/tn-legitimate-deviation.tsp`

Class 2, legitimate deviation. Everything here looks like a violation and is
correct. Consumed by **three** stimuli, so a flaw in this one file affects all
three at once — see "The true-negative denominator is 5, not 7" in the README.

| Apparent problem                          | Why it is not one                                                             |
| ----------------------------------------- | ----------------------------------------------------------------------------- |
| `POST /text:analyze`                      | Genuine computation. Not addressable, not retained. Not CRUD in disguise.      |
| `listSupportedLanguages` unpaged          | Collection is fixed by the service, 42 entries, documented never to exceed 200. |
| `Configuration` singleton                 | Exactly one per account, by design.                                           |
| `AnalysisMode` closed union               | The wire protocol admits exactly two values; a third needs a new request shape. |
| No `delete` on `Configuration`            | It cannot be absent, only reset. `:reset` is the delete-equivalent.            |

Guards against: `DP-MODEL-01` fired on a legitimate action, `DP-PAGE-01` fired
on a bounded collection, `DP-MODEL-04` fired on a documented asymmetry, and an
extensibility finding on a justified closed union.

### `typespec-data-plane/tn-linter-owned.tsp`

Class 3, linter-owned. Every defect is already caught mechanically by a shipped
`@azure-tools/typespec-azure-core` rule at 🔒 Linted status in
[`data-plane-linter-rule-coverage.md`](../../../azure-api-review/references/data-plane-linter-rule-coverage.md).
CI already reports them; a second report is noise.

| Seeded defect                          | Owning rule                       |
| -------------------------------------- | --------------------------------- |
| `enum` instead of `union`              | `no-enum`                         |
| `string \| null` property              | `no-nullable`                     |
| `@format` decorator                    | `no-format`                       |
| `unknown`-typed property               | `no-unknown`                      |
| generic `numeric` type                 | `no-generic-numeric`              |
| missing `@doc` on model and property   | `documentation-required`          |
| `snake_case` declaration name          | `casing-style`                    |
| raw array request body                 | `request-body-problem`            |
| explicit `@route` on a standard op     | `no-explicit-routes-resource-ops` |

Guards against: duplicating CI. **This is the only class with a confirmed real
false positive** — in the first run the agent invented a `DP-MODEL-04` "missing
delete" finding here in 2 of 3 trials — and it is non-deterministic, which is
the worst profile: it passes review and fails in production.

### `typespec-data-plane/tn-runtime-behavioral.tsp`

Class 4, runtime-behavioral. Every `@doc` describes service runtime behaviour:
sort ordering and its stability, retention windows, page-size behaviour,
validation semantics, conditional status codes, idempotency, `Retry-After`
values, throttling, value preservation. None is statically checkable from a
`.tsp`; all are 🚫 Runtime in the coverage map.

Guards against: manufacturing findings out of prose the reviewer cannot verify.

### `version-pairs/preview-narrowed-union/`

Class 5, the preview carve-out. `preview-2026-02-01-preview.tsp` removes
`armOverrides` and drops the `Adaptive` union member relative to
`preview-2026-01-01-preview.tsp`. Both versions are preview, so neither change
violates anything: preview carries no backward-compatibility guarantee, and
trialling then withdrawing a shape is what preview is for.

Guards against: a blocking breaking-change finding on a preview-to-preview
change. A note that consumers must migrate is acceptable at suggestion
severity.

## Positive fixtures — findings are expected

One fixture per review area, each seeded densely.

| Fixture                                        | Seeded                                                                                                                                    | Consumed by                    |
| ---------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------ |
| `typespec-data-plane/crud-in-disguise.tsp`     | `DP-MODEL-01` ×3 — a PATCH, a DELETE, and a LIST all expressed as POST actions                                                            | `eval-resource-modeling.yaml`  |
| `typespec-data-plane/resource-modeling-smell.tsp` | `DP-MODEL-02` (identity and lifecycle but no addressable path), `DP-MODEL-01` ×4, `DP-MODEL-04` (no update path at all)                 | `eval-resource-modeling.yaml`  |
| `typespec-data-plane/error-design.tsp`         | `DP-ERR-05` (bespoke envelope), `DP-ERR-01` (undocumented bare-string `code`), `DP-ERR-02` (no `target`), `DP-ERR-04` (no `innererror`), `DP-ERR-03` (one code for many distinct failures) | `eval-error-design.yaml`       |
| `typespec-data-plane/lro-and-paging.tsp`       | `DP-LRO-01` (status monitor with no `error`, no result path), `DP-LRO-03` (cancel exists but `Canceled` unreachable), `DP-LRO-04` (`@pollingOperation` points at the model), `DP-PAGE-01/02/03` | `eval-lro-and-paging.yaml`     |
| `typespec-data-plane/naming-clarity.tsp`       | `DP-NAME-01` ×4 (abbreviations, numeric suffixes), `DP-NAME-02` ×2 (unit-less), `DP-NAME-03` (mode as boolean), `DP-NAME-04` ×4 (three spellings of "created" in one service) | `eval-naming-and-docs.yaml`    |
| `typespec-data-plane/doc-quality.tsp`          | `DP-DOC-01` ×3 (tautologies), `DP-DOC-02` (undocumented union members), `DP-DOC-03` ×2 (undocumented filter grammar, unstated exclusivity invariant), `DP-NAME-02` ×2 | `eval-naming-and-docs.yaml`    |
| `typespec-data-plane/visibility-and-secrets.tsp` | `DP-VIS-02` ×2 (readable credential, no `@secret`), `DP-VIS-03` ×2 (secret reachable from list), `DP-VIS-01` (write-only non-secret), `DP-VIS-05` ×2 (server-assigned but writable), `DP-VIS-06` (optional *and* nullable) | `eval-visibility-and-secrets.yaml` |
| `version-pairs/stable-removed-property/`       | `DP-VERSION-01` ×4 (type `int32`→`float64`, property removed, open union closed and a member dropped, optional request property made required) and `DP-VERSION-03` (no `@added`/`@removed`/`@renamedFrom` anywhere) | `eval-versioning.yaml`         |

## Not compiled

No fixture is under `specification/`, none is a real service, and none is
compiled by CI. Several would not `tsp compile` cleanly — that is intentional
for the ones seeding structural defects.

## Enforcement

`checkFixtureLabelLeakage` in
[`.github/workflows/src/data-plane-review-alignment.js`](../../../../workflows/src/data-plane-review-alignment.js)
fails the build if any fixture reintroduces a label, a rule ID, a `VIOLATION`
or `BREAKING` annotation, or a statement about expected reviewer behaviour.
Provenance belongs in this file, not in the fixture.
