<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-08-13
     Verified against:
       - @azure-tools/typespec-azure-core 0.71.0
       - @azure-tools/typespec-azure-rulesets 0.71.0 (data-plane ruleset)
       - Azure REST API Guidelines (vNext)
         https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md
     The pinned version above MUST match the `@azure-tools/typespec-azure-core`
     version in the repository root `package.json`. The
     `data-plane-review-alignment` CI check enforces this: when the package is
     bumped, the check fails until a maintainer re-verifies this table and
     updates the version and date above.
     The upstream documents always take precedence if there is a conflict. -->

# Data-Plane Linter Rule Coverage Map

This reference tells the **Data-Plane API Reviewer** agent which Azure REST API
Guidelines statements are already enforced mechanically, so the agent does not
duplicate a finding the author will already see from CI.

It is the data-plane counterpart to
[`linter-rule-coverage.md`](linter-rule-coverage.md), which maps the
`@microsoft.azure/openapi-validator` (LintDiff) rules used on the ARM control
plane. The two files are keyed on different rule sets and must not be merged.

**Authoritative sources:**

- [`@azure-tools/typespec-azure-core` linter rules](https://azure.github.io/typespec-azure/docs/libraries/azure-core/reference/linter/)
- [`@azure-tools/typespec-azure-rulesets` data-plane ruleset](https://azure.github.io/typespec-azure/docs/libraries/azure-rulesets/)
- [Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)

---

## Status vocabulary

| Status        | Meaning                                                                                                          | Agent behavior                                                                                                                                                                 |
| ------------- | ---------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 🔒 Linted     | Rule is registered in `typespec-azure-core` **and** enabled by the `azure-rulesets/data-plane` ruleset.          | **Never report.** The author already sees it. If the corresponding CI check has already failed, the agent may add at most one sentence of _why it matters_ -- never a finding. |
| ⏳ Landing    | Rule is merged upstream but is **not yet running** in this repo, because the pinned package version predates it. | **Agent owns it.** Report normally. Flips to 🔒 when the version bump lands.                                                                                                   |
| 📋 Planned    | Rule is designed / in flight but not merged upstream.                                                            | **Agent owns it.** Report normally.                                                                                                                                            |
| 🤖 Agent-only | No mechanical rule is possible or planned -- the statement requires judgment.                                    | **Agent owns it permanently.** This is the reviewer's core value.                                                                                                              |
| 🚷 Not a rule | Proposed as a lint rule, measured against the spec corpus, and **deliberately rejected**. Not a defect.          | **Never report.** See the "🚷 Not a rule" section below for the measurement behind each.                                                                                       |
| 🚫 Runtime    | The guideline statement constrains runtime service behavior and is not observable in a `.tsp` file.              | **Never report.** Not a gap; out of scope. See [scope boundary](#out-of-scope-runtime-behavioral-statements).                                                                  |
| ❓ Unresolved | Named in the ruleset but no rule with that name is registered by the pinned `typespec-azure-core` version.       | **Agent owns it** until a maintainer confirms which rule (if any) it resolves to.                                                                                              |

**No row means no coverage claim.** If the agent is about to report something in
an area with no row in this file, it MUST NOT assert that a linter does or does
not cover it. Downgrade the finding to a question for the author, or drop it.
This mirrors the rule already established for the ARM surface in
[`downstream-ci-impact.md`](downstream-ci-impact.md) ("If `linter-rule-coverage.md`
is missing a row for the affected rule, **do not invent one**").

---

## 🔒 Linted -- enabled by `@azure-tools/typespec-azure-rulesets/data-plane`

Every rule below is enabled for any data-plane project whose `tspconfig.yaml`
extends `@azure-tools/typespec-azure-rulesets/data-plane`. The agent is
**silent** on all of them.

| Rule (`@azure-tools/typespec-azure-core/...`)                        | What it enforces                                                                                                                                                                                   | Guidelines area         |
| -------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| `operation-missing-api-version`                                      | Every operation carries an api-version parameter.                                                                                                                                                  | Versioning              |
| `auth-required`                                                      | The service declares authentication.                                                                                                                                                               | Security                |
| `casing-style`                                                       | Declaration casing.                                                                                                                                                                                | Naming                  |
| `no-case-mismatch`                                                   | No two types differing only by casing.                                                                                                                                                             | Naming                  |
| `use-standard-names`                                                 | Recommended operation names.                                                                                                                                                                       | Naming / operations     |
| `use-standard-operations`                                            | Operations use `Azure.Core` signatures.                                                                                                                                                            | Resource operations     |
| `no-explicit-routes-resource-ops`                                    | No `@route` on standard resource operation signatures.                                                                                                                                             | URLs                    |
| `no-route-parameter-name-mismatch`                                   | Consistent path parameter names across the same path.                                                                                                                                              | URLs                    |
| `no-rpc-path-params`                                                 | `RpcOperation` does not take path parameters.                                                                                                                                                      | URLs                    |
| `no-query-explode` / `no-header-explode`                             | Query/header parameters serialize without `explode: true`.                                                                                                                                         | URLs / headers          |
| `no-enum`                                                            | `union`, not `enum`.                                                                                                                                                                               | Enums & SDKs            |
| `no-closed-literal-union`                                            | Literal unions include the base scalar (open enum).                                                                                                                                                | Enums & SDKs            |
| `no-unnamed-types`                                                   | Models, unions, enums, and scalars are declared rather than anonymous inline expressions.                                                                                                          | SDK surface             |
| `no-string-discriminator`                                            | Discriminator property is an extensible union.                                                                                                                                                     | Polymorphism            |
| `no-multiple-discriminator`                                          | At most one discriminator per model.                                                                                                                                                               | Polymorphism            |
| `spread-discriminated-model`                                         | Discriminated models are not spread into compositions.                                                                                                                                             | Polymorphism            |
| `composition-over-inheritance`                                       | Discriminator, or composition via spread / `is`.                                                                                                                                                   | Polymorphism            |
| `no-nullable`                                                        | `?` for optional, not nullable unions.                                                                                                                                                             | JSON / property design  |
| `no-unknown`                                                         | No `unknown`-typed properties.                                                                                                                                                                     | JSON / property design  |
| `no-generic-numeric`                                                 | Specific numeric types, not generic ones.                                                                                                                                                          | JSON / property design  |
| `no-offsetdatetime`                                                  | `utcDateTime` unless an offset is genuinely required.                                                                                                                                              | JSON / property design  |
| `known-encoding`                                                     | Only supported encodings.                                                                                                                                                                          | JSON / property design  |
| `no-format`                                                          | No `@format` decorator.                                                                                                                                                                            | JSON / property design  |
| `bad-record-type`                                                    | No ill-formed `Record<>` definitions.                                                                                                                                                              | JSON / property design  |
| `key-visibility-required`                                            | Key properties declare a `Lifecycle` visibility.                                                                                                                                                   | Property visibility     |
| `documentation-required`                                             | `@doc` **present** on models, enums, operations.                                                                                                                                                   | Documentation           |
| `friendly-name`                                                      | `@friendlyName` used as intended.                                                                                                                                                                  | Naming                  |
| `no-error-status-codes`                                              | Use the Guidelines error response, not ad-hoc error status codes.                                                                                                                                  | Errors                  |
| `response-schema-problem`                                            | No multiple non-error response schemas on one operation.                                                                                                                                           | Operations              |
| `no-response-body`                                                   | Response body set correctly for the response type.                                                                                                                                                 | Operations              |
| `request-body-problem`                                               | Request body is not a raw array.                                                                                                                                                                   | Operations              |
| `rpc-operation-request-body`                                         | RPC body shape problems.                                                                                                                                                                           | Operations              |
| `long-running-polling-operation-required`                            | LROs have a linked polling operation.                                                                                                                                                              | Long-running operations |
| `polling-operation-no-status-monitor`                                | The linked polling operation returns a valid status monitor -- a `status` property or one marked `@lroStatus`, of Enum/Union type, carrying terminal success and failure values.                   | Long-running operations |
| `lro-status-missing`                                                 | A custom status union declares terminal success and failure states -- either the literal `Succeeded`/`Failed` values or variants marked `@lroSucceeded`/`@lroFailed`. Fires at **error** severity. | Long-running operations |
| `byos`                                                               | Bring-Your-Own-Storage pattern.                                                                                                                                                                    | Storage                 |
| `require-versioned`                                                  | Service uses the versioning library.                                                                                                                                                               | Versioning              |
| `no-openapi`                                                         | No `@typespec/openapi` / `typespec-autorest` decorators.                                                                                                                                           | Authoring hygiene       |
| `no-openapi-client-extensions`                                       | Client-altering OpenAPI extensions use first-class TypeSpec constructs rather than raw `@extension`.                                                                                               | Authoring hygiene       |
| `no-rest-library-interfaces`                                         | No `TypeSpec.Rest.Resource` interfaces.                                                                                                                                                            | Authoring hygiene       |
| `no-private-usage` / `no-legacy-usage`                               | No `Private` / `Legacy` namespace usage.                                                                                                                                                           | Authoring hygiene       |
| `@azure-tools/typespec-client-generator-core/require-client-suffix`  | Client naming.                                                                                                                                                                                     | SDK surface             |
| `@azure-tools/typespec-client-generator-core/property-name-conflict` | Property name collisions in generated clients.                                                                                                                                                     | SDK surface             |

### Rules the agent owns despite appearing linted

Three cases where the naive reading of "there is a rule for that" is wrong. Each
of these is a place a reviewer would otherwise wrongly stay silent.

| Rule                      | Ruleset state                                                | Why the agent still owns something                                                                                                                                                                                                                                                    |
| ------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `non-breaking-versioning` | **Explicitly disabled** (`false`) in the data-plane ruleset. | Backward-compatibility across versions is **not** linted on data-plane. The agent owns breaking-change judgment entirely -- removed properties, narrowed unions, tightened optionality, changed types in a **stable** version. This is the single largest 🔒-looking-but-🤖 area.     |
| `documentation-required`  | Enabled.                                                     | It enforces that `@doc` **exists**, not that it says anything. `@doc("The name.")` passes. Doc **quality** is 🤖 Agent-only -- see [`data-plane-naming-and-docs.md`](data-plane-naming-and-docs.md).                                                                                  |
| `casing-style`            | Enabled.                                                     | It checks declaration casing. It does not judge whether a correctly cased name is **clear**. `cfg`, `data1`, `flag2` all pass. Naming clarity is 🤖 Agent-only.                                                                                                                       |
| `use-standard-operations` | Enabled.                                                     | It forces operations through `Azure.Core` templates, which makes several Guidelines statements true-by-construction. It does **not** decide whether the resource being operated on should exist, or whether a POST action is a CRUD operation in disguise. Modeling is 🤖 Agent-only. |

### ❓ Unresolved names

These names are enabled by the `data-plane` ruleset in `typespec-azure-rulesets`
0.71.0 but no rule with that exact name is registered by `typespec-azure-core`
0.71.0. Until a maintainer confirms what they resolve to, treat the underlying
concern as **agent-owned**.

| Name                          | Concern it appears to cover                                       |
| ----------------------------- | ----------------------------------------------------------------- |
| `use-extensible-enum`         | Extensible-union modeling (overlaps `no-enum`).                   |
| `no-fixed-enum-discriminator` | Discriminator extensibility (overlaps `no-string-discriminator`). |

---

## 🚷 Not a rule -- measured and deliberately rejected

Each entry below was **proposed as a lint rule and rejected on evidence**, not
overlooked. The measurement is recorded so a future reader does not re-propose
it, and so the distinction between "nobody thought about this" and "this was
assessed and declined" stays legible.

The bar is [Mark Cowlishaw's published criteria for when to write a linting
rule](https://azure.github.io/typespec-azure/docs/howtos/contributing/when-to-write-a-linting-rule/).
The threshold that decided both cases: a pattern present in **more than ~20% of
the corpus is a convention, not a violation**, and a rule whose findings are all
unfixable is noise regardless of whether the underlying guideline is correct.

| Rejected rule                                      | Measurement                                                                                                                           | Agent behavior                                                                                                              |
| -------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `api-version-date-format` / `use-date-api-version` | Non-date api-version formats are used by **24/93 data-plane projects (25.8%)** and **10/38 services (26.3%)**. Both over the 20% bar. | **Silent. No rule, no agent guidance.** See below.                                                                          |
| `no-version-in-route`                              | Fires on **254 corpus sites, every one unfixable** -- renaming a published route is a breaking change.                                | **Agent owns it**, narrowly -- see `DP-VERSION-04` in [`data-plane-resource-modeling.md`](data-plane-resource-modeling.md). |

### `api-version-date-format` -- the agent stays silent

Real non-date formats in the corpus include keyvault `7.5`/`7.6`, maps
`1.0`/`1.1`, machinelearningservices `1.0.0`, ai/Face `v1.2`, monitor `v1`,
schemaregistry `2021-10`, and translation `3.0`.

At 26% of services this is a **convention, not a requirement**, so it is not a
defect and there is nothing to report. This is the one 🚷 case where the
rejection also extinguishes the agent's interest: `YYYY-MM-DD` remains the
right default for a new API and belongs in authoring guidance, but a reviewer
that flags a service for shipping `7.6` is asserting a requirement that does not
exist. **Do not raise it, at any severity, including as a question.**

### `no-version-in-route` -- rejected as a rule, kept as judgment

This is the first genuine **linter -> agent handoff**, and the reasoning
generalizes.

The guideline itself is undisputed. What failed was the _mechanical_ rule: all
254 sites are unfixable, because the version segment is either mandated by an
external standard (ACR's `/v2/` comes from the OCI Distribution Spec, Purview's
`/atlas/v2/` from Apache Atlas compatibility) or already shipped (ML's
`/data/v1.0/`, where renaming breaks every published SDK).

**The agent can make a distinction the linter cannot.** A linter sees one
compiled program with no notion of what is new, so ACR's existing `/v2/` and a
brand-new service's `/v3/` are indistinguishable to it. The agent reads the PR
diff, so it can separate a route being _introduced_ -- actionable, and worth
blocking -- from one it is merely re-reading.

That premise is **assumed, not demonstrated**; see the caveat in
[`DP-VERSION-04`](data-plane-resource-modeling.md).

---

## 📋 Planned -- designed, not merged

| Rule                      | What it will enforce         |
| ------------------------- | ---------------------------- |
| `header-name-casing`      | Header name casing.          |
| `query-param-name-casing` | Query parameter name casing. |
| `json-field-name-casing`  | JSON body field name casing. |

---

## 🤖 Agent-only -- the reviewer's actual job

No mechanical rule exists or is planned. These are the areas the agent is for.

| Area                                                                                 | Reference                                                                                 |
| ------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------- |
| Resource modeling, addressability, action-vs-resource, `actions-no-actions-for-crud` | [`data-plane-resource-modeling.md`](data-plane-resource-modeling.md)                      |
| Error-code craftsmanship (stable codes, `target`, actionable messages)               | [`data-plane-error-design.md`](data-plane-error-design.md)                                |
| Naming clarity and doc quality beyond mere presence                                  | [`data-plane-naming-and-docs.md`](data-plane-naming-and-docs.md)                          |
| LRO status-monitor semantics and paging shape consistency                            | [`data-plane-lro-and-paging.md`](data-plane-lro-and-paging.md)                            |
| Visibility lifecycle consistency, write-only properties, secrets                     | [`data-plane-visibility-and-secrets.md`](data-plane-visibility-and-secrets.md)            |
| Breaking changes vs. the previous stable version                                     | [`data-plane-resource-modeling.md`](data-plane-resource-modeling.md) (versioning section) |
| Version segments in newly-added routes (`DP-VERSION-04`)                             | [`data-plane-resource-modeling.md`](data-plane-resource-modeling.md) (versioning section) |
| Grey-area design trade-offs                                                          | [`data-plane-design-decisions.md`](data-plane-design-decisions.md)                        |
| Secret detection                                                                     | [`secret-detection.md`](secret-detection.md) (cross-cutting)                              |
| Allowlist-vs-denylist `pattern` constraints                                          | [`pattern-validation.md`](pattern-validation.md) (cross-cutting)                          |

---

## 🚫 Out of scope -- runtime-behavioral statements

A large share of the Azure REST API Guidelines constrains what the **service
does at runtime**, not what the specification says. None of it is observable in
a `.tsp` file. The agent MUST NOT synthesize a static finding from these, and
MUST NOT report them as gaps.

- Request-validation semantics -- what the service actually rejects, and with
  which status code.
- Sort ordering and ordering stability across pages.
- Page-size behavior, and whether the service honors a requested page size.
- Retention windows, TTL, and expiry behavior for jobs and operation statuses.
- Status-code choices conditional on runtime state (for example, "return 403
  rather than 404 unless the distinction leaks existence").
- Idempotency guarantees and de-duplication behavior.
- `Retry-After` values and throttling / rate-limit behavior.
- Actual authorization enforcement and scope checking.
- Value preservation -- array ordering, data types, and casing round-tripping
  (see [`field-ownership.md`](field-ownership.md), which documents these as
  OAPI024/OAPI025/OAPI026 for the ARM plane; they are equally unobservable here).

---

## Suppressions

Data-plane suppressions are inline `#suppress` directives in `.tsp` source, not
`readme.md` directives. The `readme.md` framework in
[`suppression-review-criteria.md`](suppression-review-criteria.md) does not
apply; the review rules in
[`typespec-review.instructions.md` §4](../../../instructions/typespec-review.instructions.md)
do.

Additional data-plane criteria for the agent:

1. A `#suppress` of any 🔒 rule in this file **requires** a technical
   justification specific to the suppressed construct. "Matching an existing
   pattern" and "will fix later" are not justifications.
2. Suppressing `auth-required` is **blocking** -- it is a security rule.
3. Suppressing `no-enum`, `no-closed-literal-union`, or `no-string-discriminator`
   in a **stable** version is blocking unless the value set is provably closed
   forever, because it bakes a breaking change into the SDK surface.
4. A suppression added in the same PR that introduces the construct is a design
   signal, not a debt signal -- ask whether the design should change instead.

---

## Maintenance

Three mechanisms keep this file honest. The first is convention; the second and
third are enforcement.

1. **Version-pinned header.** The header comment records the exact
   `@azure-tools/typespec-azure-core` version this table was verified against,
   following the convention already used by
   [`linter-rule-coverage.md`](linter-rule-coverage.md).
2. **`data-plane-review-alignment` CI check.** It reads the pinned
   `@azure-tools/typespec-azure-core` version from the repository root
   `package.json` and fails if it differs from the version recorded in this
   file's header. Every linter bump therefore forces a human to re-verify this
   table before the bump can merge. This is the only moment at which the table
   can silently go stale, so it is the only moment that needs a gate. The same
   check also asserts that the model the reviewer runs in production equals the
   model its true-negative eval suite measures.
3. **Eval coupling.** When a rule moves ⏳ -> 🔒, the same PR MUST add a
   true-negative eval stimulus asserting the agent no longer reports it. The
   interlock is then regression-tested rather than merely documented.

The softer mechanism used elsewhere in this skill -- `(Also enforced by: ...)`
annotations plus "the review agent should check CI results before flagging"
([`SKILL.md`](../SKILL.md), Maintenance section) -- remains valid but is manual
and unenforced. Items 2 and 3 are the upgrade.
