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
example, `tn-legitimate-deviation.tsp` documents _why_ its list is unpaged and
_why_ its configuration has no delete. That is what a competent spec author
would write, and it is exactly what the reviewer must learn to read. The same is
true in the other direction: `notification-routing.tsp` and
`unpaged-search-rationale.tsp` contain confident rationales that do **not** cure
their defects. In-world prose is evidence to evaluate, not a clearance signal.

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
three at once — see "The true-negative denominator is 6, not 8" in the README.

| Apparent problem                 | Why it is not one                                                               |
| -------------------------------- | ------------------------------------------------------------------------------- |
| `POST /text:analyze`             | Genuine computation. Not addressable, not retained. Not CRUD in disguise.       |
| `listSupportedLanguages` unpaged | Collection is fixed by the service, 42 entries, documented never to exceed 200. |
| `Configuration` singleton        | Exactly one per account, by design.                                             |
| `AnalysisMode` closed union      | The wire protocol admits exactly two values; a third needs a new request shape. |
| No `delete` on `Configuration`   | It cannot be absent, only reset. `:reset` is the delete-equivalent.             |

Guards against: `DP-MODEL-01` fired on a legitimate action, `DP-PAGE-01` fired
on a bounded collection, `DP-MODEL-04` fired on a documented asymmetry, and an
extensibility finding on a justified closed union.

### `typespec-data-plane/tn-linter-owned.tsp`

Class 3, linter-owned. Every defect is already caught mechanically by a shipped
`@azure-tools/typespec-azure-core` rule at 🔒 Linted status in
[`data-plane-linter-rule-coverage.md`](../../../azure-api-review/references/data-plane-linter-rule-coverage.md).
CI already reports them; a second report is noise.

| Seeded defect                        | Owning rule                       |
| ------------------------------------ | --------------------------------- |
| `enum` instead of `union`            | `no-enum`                         |
| `string \| null` property            | `no-nullable`                     |
| `@format` decorator                  | `no-format`                       |
| `unknown`-typed property             | `no-unknown`                      |
| generic `numeric` type               | `no-generic-numeric`              |
| missing `@doc` on model and property | `documentation-required`          |
| `snake_case` declaration name        | `casing-style`                    |
| raw array request body               | `request-body-problem`            |
| explicit `@route` on a standard op   | `no-explicit-routes-resource-ops` |

Guards against: duplicating CI. An earlier version omitted delete and defended
that omission with a paragraph; the agent invented a `DP-MODEL-04` finding in 2
of 3 trials. This version exposes a conventional delete operation and uses
ordinary one-line docs, so the fixture tests the interlock without the
prose-length tell or an adjacent lifecycle question.

### `typespec-data-plane/tn-runtime-behavioral.tsp`

Class 4, runtime-behavioral. Every `@doc` describes service runtime behavior:
sort ordering and its stability, retention windows, page-size behavior,
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

### `version-pairs/stable-additive-property/`

Class 6, additive stable evolution. The 2026-01-01 version adds an optional
`summary` property and an `Archived` member to an open union. Both carry
`@added(Versions.v2026_01_01)`; no existing surface changes.

The pair uses only ordinary one-line `@doc` text. It guards against inventing
breaking-change or decorator findings on the most common stable-to-stable
shape, and against treating terse documentation as suspicious. Both files are
linter-clean without depending on the interlock.

### `version-pairs/tn-standard-mandated-route/`
Class 7, the linter→agent handoff. Every route carries a `/v2` prefix, applied
at namespace level, and it is **identical in both versions** — this PR does not
introduce it. The namespace `@doc` states that `/v2/` is fixed by the OCI
Distribution Specification.

Guards against: any `DP-VERSION-04` finding, at any severity. Two independent
reasons each suffice — the route is pre-existing, so the "fix" would be a
breaking change; and an external protocol dictates the shape.

**This is the only fixture that tests the premise `DP-VERSION-04` rests on.**
The lint rule for this guideline was withdrawn because all 254 corpus sites
were unfixable; the agent's claim to it is *solely* that it can tell a new route
from a pre-existing one. Paired with `new-route-version-segment/` in
`eval-versioning.yaml`: an agent passing the positive while failing this one is
not making the distinction, it is flagging every `/v2/` it sees — the withdrawn
lint rule, reimplemented at higher cost. **Neither stimulus has ever been
executed.**

### `typespec-data-plane/tn-genuine-booleans.tsp`

Class 8, a **regression guard for a confirmed reviewer false positive**. Two
genuine booleans on a writable configuration resource: `enabled` and
`retainOnDisable`. Each `@doc` states the binary semantics outright.

Independent adjudication found the reviewer wrong and the fixture right when it
flagged `enabled` on `tn-legitimate-deviation`, and found the mechanism — two of
our own files disagreed on that exact token. `DP-NAME-03` blesses `enabled` by
name; `enum-best-practices.md` used `enabled` as its worked example of a boolean
to replace, having inherited an ARM posture unscoped. The 2/3 nondeterminism was
the signature of an agent genuinely torn, not of misreading.

The provoking property was **kept**, not removed, per the standing rule that a
false positive on a correct fixture is a measurement worth keeping. Consumed by
`tn-genuine-booleans-not-modes`.

### `typespec-data-plane/tn-error-prose-no-codes.tsp`

Class 8, a **regression guard for a provocation deleted from another fixture**.
The `create` operation documents distinct failure conditions in prose — unknown
queue rejected with 400, unauthorized caller receiving 403 without learning
whether the queue exists, 413 on oversized payload, 429 on rate limit — while
using the standard `Azure.Core` error envelope, whose `code` is `code: string`
by construction.

`tn-runtime-behavioral` once carried that paragraph and drew `DP-ERR-01` 3/3.
The rule was re-scoped and the paragraph deleted, which made that fixture pass
without ever showing the reviewer would now stay silent. This fixture restores
the provocation so the claim is tested.

Asserts no **bracketed** `DP-ERR-01`. A Questions bullet is correct and scores
full marks — that trigger is capped at Question severity. Consumed by
`tn-error-prose-without-codes`.

## Positive fixtures — findings are expected
The original fixtures are mostly dense capability probes. The two rationale
fixtures are deliberately sparse: each has one supported design finding amid
otherwise conventional surface.

`version-pairs/new-route-version-segment/` extends that pattern to versioning,
and is deliberately the hardest positive in the corpus. Its `/v2/` route carries
a fluent justification — the evaluation engine is versioned independently, so
callers pin the engine they tested against — that is *plausible but invalid*: it
describes an internal design preference, not conformance to a protocol the
service does not control. `DP-VERSION-04` grants an exception only for the
latter. The fixture therefore tests whether the reviewer **evaluates** a stated
rationale or merely **detects** one, which is the failure mode the corpus review
identified when it found that a defensive paragraph was, in practice, a reliable
signal of a true negative. Here it is attached to a real defect.

| Fixture                                            | Seeded                                                                                                                                                                                                                                         | Consumed by                        |
| -------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------- |
| `typespec-data-plane/crud-in-disguise.tsp`         | `DP-MODEL-01` ×3 — a PATCH, a DELETE, and a LIST all expressed as POST actions                                                                                                                                                                 | `eval-resource-modeling.yaml`      |
| `typespec-data-plane/resource-modeling-smell.tsp`  | `DP-MODEL-02` (identity and lifecycle but no addressable path), `DP-MODEL-01` ×4, `DP-MODEL-04` (no update path at all)                                                                                                                        | `eval-resource-modeling.yaml`      |
| `typespec-data-plane/error-design.tsp`             | `DP-ERR-05` (bespoke envelope), `DP-ERR-01` trigger 2 (one `InvalidRequest` code for many distinct failures), `DP-ERR-02` (no `target`), `DP-ERR-04` (no `innererror`), `DP-ERR-03` (unactionable messages, one leaking a stack trace)                | `eval-error-design.yaml`           |
| `typespec-data-plane/lro-and-paging.tsp`           | `DP-LRO-01` (status monitor with no `error`, no result path), `DP-LRO-03` (cancel exists but `Canceled` unreachable), `DP-LRO-04` (`@pollingOperation` points at the model), `DP-PAGE-01/02/03`                                                | `eval-lro-and-paging.yaml`         |
| `typespec-data-plane/naming-clarity.tsp`           | `DP-NAME-01` ×4 (abbreviations, numeric suffixes), `DP-NAME-02` ×2 (unit-less), `DP-NAME-03` (mode as boolean), `DP-NAME-04` ×4 (three spellings of "created" in one service)                                                                  | `eval-naming-and-docs.yaml`        |
| `typespec-data-plane/doc-quality.tsp`              | `DP-DOC-01` ×3 (tautologies), `DP-DOC-02` (undocumented union members), `DP-DOC-03` ×2 (undocumented filter grammar, unstated exclusivity invariant), `DP-NAME-02` ×2                                                                          | `eval-naming-and-docs.yaml`        |
| `typespec-data-plane/visibility-and-secrets.tsp`   | `DP-VIS-02` ×2 (readable credential, no `@secret`), `DP-VIS-03` ×2 (secret reachable from list), `DP-VIS-01` (write-only non-secret), `DP-VIS-05` ×2 (server-assigned but writable), `DP-VIS-06` (optional _and_ nullable)                     | `eval-visibility-and-secrets.yaml` |
| `typespec-data-plane/notification-routing.tsp`     | Exactly one `DP-VIS-01`: a durable, non-secret `routingLabel` is accepted on writes but never returned. Five multi-line docs include a confident caller-ownership rationale. A count grader rejects any second finding before `### Questions`. | `eval-visibility-and-secrets.yaml` |
| `typespec-data-plane/unpaged-search-rationale.tsp` | Exactly one `DP-PAGE-01`: an unbounded search result has no paging contract. Five multi-line docs include a snapshot-consistency and common-case rationale that does not make large result sets enumerable.                                    | `eval-lro-and-paging.yaml`         |
| `version-pairs/stable-removed-property/`           | `DP-VERSION-01` ×4 (type `int32`→`float64`, property removed, open union closed and a member dropped, optional request property made required) and `DP-VERSION-03` (no `@added`/`@removed`/`@renamedFrom` anywhere)                            | `eval-versioning.yaml`             |
| `version-pairs/new-route-version-segment/`         | Exactly one `DP-VERSION-04`: the 2026-01-01 version adds `evaluate` at `/v2/flags:evaluate`, carrying `@added`, with no counterpart in 2025-01-01. Its `@doc` offers a confident but invalid rationale — see below.                            | `eval-versioning.yaml`             |

## Compilation

Every fixture **must** `tsp compile` cleanly (errors; warnings are discussed
below). The `compile-fixtures` job in
[`.github/workflows/data-plane-review-alignment.yaml`](../../../../workflows/data-plane-review-alignment.yaml)
enforces this.

`typespec-data-plane/tspconfig.yaml` enables the
`@azure-tools/typespec-azure-rulesets/data-plane` ruleset, so compiling a
fixture applies the same linter the real specs get. Without it, `tsp compile`
checks only the language and the corpus looks far cleaner than it is: with the
ruleset switched on, `tn-legitimate-deviation.tsp` alone went from apparently
fine to 15 warnings.

**True-negative fixtures must be linter-clean.** A TN whose cleanliness depends
on the reviewer correctly consulting the interlock is measuring the interlock,
not the reviewer's judgment. `tn-clean-service`, `tn-legitimate-deviation`,
`tn-runtime-behavioral`, and both files in `stable-additive-property` are
therefore at zero warnings.
`tn-linter-owned.tsp` is the deliberate exception: its whole purpose is to seed
linter-owned defects and assert the agent stays silent about them.

Positive fixtures may warn. They exist to carry seeded design defects, and the
warnings are mostly `use-standard-operations` on deliberately non-standard
shapes. The two sparse rationale fixtures are themselves at zero warnings: both
defects require semantic judgment that the linter does not perform.

This section previously claimed non-compilation was intentional for fixtures
seeding structural defects. That was wrong, and it hid a real bug: all 15
fixtures carried `@useDependency(Azure.Core.Versions.v1_0_Preview_2)`, and
`Azure.Core.Versions` no longer exists in `@azure-tools/typespec-azure-core`
(the string `v1_0_Preview` appears nowhere in 0.70.0, and zero specs under
`specification/` reference it). **Not one fixture had ever compiled.** The eval
harness never compiles fixtures, so nothing surfaced it.

A fixture that does not compile cannot be trusted to mean what it says, and a
true negative that is silently invalid measures nothing. Seeded defects are
_design_ defects — CRUD-in-disguise, a missing `target`, an unreachable terminal
state — and every one of them is expressible in TypeSpec that compiles.

No fixture is under `specification/`, and none is a real service.

## Enforcement

`checkFixtureLabelLeakage` in
[`.github/workflows/src/data-plane-review-alignment.js`](../../../../workflows/src/data-plane-review-alignment.js)
fails the build if any fixture reintroduces a label, a rule ID, a `VIOLATION`
or `BREAKING` annotation, or a statement about expected reviewer behavior.
Provenance belongs in this file, not in the fixture.
