<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-07-24
     Derived from:
       - Azure REST API Guidelines (vNext) -- naming, documentation
         https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md
     The upstream document always takes precedence if there is a conflict.
     SCOPE NOTE: casing is linter-owned (`casing-style`, and the landing
     header/query/json casing rules). This file covers CLARITY only. -->

# Data-Plane Naming Clarity and Documentation Quality

Applies to data-plane TypeSpec.

> **Authoritative upstream:** [clear and consistent naming](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#rest-clear-naming),
> [units in duration names](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#json-durations-use-fixed-time-intervals),
> [string constraints](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#json-specify-string-constraints),
> [action names are verbs](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#actions-action-name-is-verb),
> and
> [document extensible enums](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#json-document-extensible-enums)
> in the Azure REST API Guidelines. Clarity and documentation-quality judgments
> below are reviewer synthesis; the upstream Guidelines take precedence.

The mechanical half of naming -- casing of properties, models, headers, query
parameters, JSON fields -- is owned by `@azure-tools/typespec-azure-core/casing-style`
and the batch of casing rules tracked in
[`data-plane-linter-rule-coverage.md`](data-plane-linter-rule-coverage.md).
**The agent does not report casing.** ARM URL-grammar naming rules in
[`naming-conventions.md`](naming-conventions.md) `NAME-*` are a different plane
and do not apply.

What is left is the part a linter cannot see: `cfg`, `data1`, and `flag` are all
perfectly `camelCase`. Same for `@doc("The name.")`, which satisfies
`documentation-required` and tells a reader nothing.

---

## Naming clarity

### DP-NAME-01: Opaque and abbreviated names

- **Rule ID:** `DP-NAME-01`
- **Severity:** Warning

Upstream anchor: the Azure REST API Guidelines say
:white*check_mark: **DO** \_focus heavily on clear & consistent naming*
([`rest-clear-naming`](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)).
That `DO` is a direction of travel, not a testable predicate — it cannot tell
you whether `cfg` specifically is too opaque. **The rule below is this skill's
synthesis of what that direction means in practice, so its strength is the
`Severity` field above, not the upstream verb.** Do not escalate to Blocking on
the strength of the upstream `DO`.

Names should be understandable without reading the implementation. Flag:

- Non-obvious abbreviations: `cfg`, `desc`, `attr`, `res`, `ctx`, `mgr`, `svc`,
  `tmp`, `val`, `num`.
- Numeric suffixes standing in for meaning: `data1`, `value2`, `optionsB`.
- Internal jargon or team-specific codenames leaking into the public surface.
- Names whose meaning depends on the `@doc` to be intelligible at all.

Accepted abbreviations that are Azure-wide idiom -- `id`, `url`, `uri`, `etag`,
`sku`, `ip`, `dns`, `api` -- are fine. Do not flag those.

### DP-NAME-02: Unit-less numeric properties

- **Rule ID:** `DP-NAME-02`
- **Severity:** Warning

A numeric property **MUST** convey its unit, in the name or unambiguously in the
`@doc`. `timeout: int32` is a bug waiting to happen; `timeoutInSeconds: int32`
is not. Same for sizes (`maxSizeInBytes`), intervals, and durations. Prefer a
duration type where one exists.

### DP-NAME-03: Boolean where a union belongs

- **Rule ID:** `DP-NAME-03`
- **Severity:** Suggestion

A `boolean` that encodes a mode narrows the design: a third state cannot be
expressed in the property itself. Raise it as a question when the property name
suggests a mode rather than a genuine yes/no (`isFullScan`, `useV2`,
`enableAdvanced`).

**Genuine booleans -- `enabled`, `isDeleted` -- are fine. Do not flag every
boolean; that is a noise generator.** This sentence sits here, immediately after
the trigger, on purpose: it is the guardrail, and a guardrail two paragraphs
downstream of its trigger does not work. It was moved here after an expansion
pushed it to the end of the section and a false positive on `enabled` followed.

> **`enum-best-practices.md` says something stronger, and it is ARM-scoped.**
> That file's "Prefer Enums Over Booleans" section derives from ARM Wiki
> guidance and reads as a blanket preference. **On the data plane this rule
> wins.** Do not raise a boolean finding merely because a boolean exists.

**Be accurate about the harm, which is smaller than it first appears.** This
rule previously said that adding a third state is a breaking change. That is not
how Azure services have actually evolved. The observed path is **additive**: the
boolean is kept, and a richer type is added beside it — Language's
`loggingOptOut?: boolean` still ships alongside
`redactionPolicies?: BaseRedactionPolicy[]`, and its `RedactionPolicyKind` union
(`noMask`, `characterMask`, `entityMask`, `syntheticReplacement`) was introduced
without removing the flag. There is no case in the corpus of a boolean being
replaced by a union.

Nor is the enum form what Azure actually ships for customer-writable
enablement. No customer-writable data-plane configuration property in the corpus
uses a multi-state enum in place of `enabled: boolean`; every 3+-member
enablement union found is **read-only** (`ProviderAvailability`,
`EnablementStatus`, `DevBoxTunnelStatus`). Where both exist, Azure splits them —
`managedOps.tsp` pairs a writable `DesiredEnablementState {Enable, Disable}`
with a read-only `EnablementState {Enabled, InProgress, Failed, Disabled}`.

So the cost of guessing wrong is a slightly wider surface later, not a break.
That is why this is a **Suggestion** and is phrased as a question — never a
design demand, and never a claim that the spec will have to break compatibility.

### DP-NAME-04: Cross-service and intra-service consistency

- **Rule ID:** `DP-NAME-04`
- **Severity:** Warning

The same concept **MUST** carry the same name everywhere. Flag:

- Two models in one service using different names for the same thing
  (`createdAt` in one, `creationTime` in another, `created` in a third).
- Divergence from Azure-wide idiom: `createdAt`/`updatedAt` (not `creationDate`),
  `nextLink`, `value`, `etag`, `tags`, `location`, `properties`, `name`, `id`.
- The service name, resource type, or version repeated redundantly inside a
  property name (`widgetWidgetName`, `widgetApiVersion`).

The graph pass in [`think-in-graphs.md`](think-in-graphs.md) is how these are
found -- they are invisible when reading a single file.

### DP-NAME-05: Verb-shaped names on non-actions

- **Rule ID:** `DP-NAME-05`
- **Severity:** Suggestion

Model and property names are nouns; operations that are actions are verbs. A
model named `ProcessWidget` or a property named `computeResult` usually signals
a modeling problem rather than a naming problem -- follow the thread to
[`data-plane-resource-modeling.md`](data-plane-resource-modeling.md) `DP-MODEL-01`
before writing a naming finding.

---

## Documentation quality

`documentation-required` enforces that a `@doc` **exists**. Everything below is
about whether it says anything.

### DP-DOC-01: Tautological documentation

- **Rule ID:** `DP-DOC-01`
- **Severity:** Warning

Flag `@doc` values that restate the member name with spaces and an article:

| Member    | Tautology        | What is missing                                           |
| --------- | ---------------- | --------------------------------------------------------- |
| `name`    | `"The name."`    | Name of what? Mutable? Unique in what scope? Constraints? |
| `timeout` | `"The timeout."` | Units, default, what happens on expiry.                   |
| `status`  | `"The status."`  | Which states, which are terminal.                         |
| `filter`  | `"The filter."`  | Syntax, which fields are filterable, an example.          |

The test: does the `@doc` contain information not derivable from the name and
the type? If not, flag it.

### DP-DOC-02: Undocumented union members

- **Rule ID:** `DP-DOC-02`
- **Severity:** Warning

Every member of an extensible union **MUST** be documented. The name of a state
rarely conveys its semantics -- what distinguishes `Failed` from `Canceled`,
which values are terminal, which the service can transition between. This is one
of the most consistently under-documented parts of Azure specs and one of the
most consequential for SDK consumers.

### DP-DOC-03: Undocumented constraints and defaults

- **Rule ID:** `DP-DOC-03`
- **Severity:** Suggestion

Where a property has a constraint that is not expressible in the type -- a
uniqueness scope, a mutually-exclusive relationship with another property, a
value that is only meaningful when another property is set, a service-assigned
default -- the `@doc` **SHOULD** state it. Cross-property invariants are
invisible to every mechanical check.

### DP-DOC-04: Operation documentation

- **Rule ID:** `DP-DOC-04`
- **Severity:** Suggestion

An operation's `@doc` **SHOULD** state what it does, notable side effects, and
which failure conditions a caller should expect (naming error codes -- see
[`data-plane-error-design.md`](data-plane-error-design.md) `DP-ERR-01`).
`@doc("Gets a widget.")` on a `get` operation is acceptable and should not be
flagged; the operation name genuinely carries the meaning there. Reserve
`DP-DOC-01` for cases where real information is absent.

---

## Calibration

Doc and naming findings are the easiest to over-produce and the fastest route to
being ignored. Two guardrails:

1. **Never emit a naming or doc finding at Blocking severity** unless it is a
   secret leak or a factually wrong statement in the docs.
2. **Group them.** One finding listing five tautological `@doc` values with line
   references beats five findings. The eval suite counts findings, and so do
   reviewers.
