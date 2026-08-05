<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-04-15
     Derived from:
       - Azure REST API Guidelines (vNext) — Enums
       - ARM Wiki: api_contracts/guidelines/api_best_practices_and_design_choices.md (RPC-BestPractice-10, RPC-BestPractice-12)
       - ARM Wiki: api_contracts/guidelines/openapi.md (OAPI015)
     The upstream documents always take precedence if there is a conflict. -->

# Enum Best Practices for Azure APIs

Azure APIs should use extensible enums to allow new values to be added
without breaking existing clients. **On ARM**, booleans should generally be
avoided in favor of enums for better versioning; **on the data plane** that
preference is narrower — see the scope note on "Prefer Enums Over Booleans"
below, and `DP-NAME-03` for the data-plane rule.

**Authoritative references:**

- [Azure REST API Guidelines -- Enums & SDKs](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#enums--sdks-client-libraries)
- [Azure Resource Provider Contract -- Resource API Reference](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/resource-api-reference.md)
- [TypeSpec Azure -- no-enum rule](https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-enum)

---

## Extensible Enums (Strongly Recommended)

The Azure REST API Guidelines state this as a `SHOULD` with an explicit
exception, quoted verbatim:

> :ballot_box_with_check: **YOU SHOULD** use extensible enumerations **unless
> you are positive that the symbol set will NEVER change over time.**

So: model every enum as extensible **unless the specification states a
rationale for a genuinely fixed value set** — for example, a set the wire
protocol or an external standard fixes, where adding a value would require a
new request shape rather than a new member.

**For reviewers:** a closed enum accompanied by a documented rationale is the
Guideline's own exception being exercised, not a violation — **provided the
rationale answers the condition the exception states**, which is whether the
symbol set will _never_ change. A structural reason meets it ("a third value
would require a different request shape, so the set cannot grow"); an assurance
does not ("we have no plans to add more"), nor does an argument about a
different subject. If it is doubtful, ask a question or raise a Suggestion.
**Never raise this Blocking, and never write that the Guidelines forbid a closed
enum** — they do not. See "Normative strength and documented rationale" in
[`SKILL.md`](../SKILL.md).

A closed enum with **no** stated rationale is a normal Warning-level finding.

_(Note: `@azure-tools/typespec-azure-core/no-enum` enforces the TypeSpec
`enum`-vs-`union` distinction mechanically. For data-plane specs that rule is
🔒 Linted — CI reports it, the reviewer does not.)_

### OpenAPI JSON

Use `x-ms-enum` with `modelAsString: true`:

```json
"status": {
  "type": "string",
  "enum": ["Enabled", "Disabled"],
  "x-ms-enum": {
    "name": "ServiceStatus",
    "modelAsString": true
  }
}
```

- Every enum **MUST** have `x-ms-enum` with a unique `name` property.
  (Also enforced by: `XmsEnumValidation` R2018, `UniqueXmsEnumName` R4005)
- `modelAsString: true` **SHOULD** be set unless the set of values will provably never change.
- Enum `name` values **MUST** be unique across the entire specification.
  (Also enforced by: `UniqueXmsEnumName` linter rule R4005)
- Enum values **MUST NOT** be empty strings.
  (Also enforced by: `EnumMustNotHaveEmptyValue` linter rule R3029)
- Enum values **SHOULD** use PascalCase.
- `default` values for enum properties **MUST** be one of the defined enum values.
  (Also enforced by: `DefaultMustBeInEnum` linter rule R2027)
- **DO NOT** remove existing enum values -- this is a breaking change.
- The **first member** of an enum **SHOULD** be the default or initial state value.
- Enum values **MUST** be semantically distinct.
  Do not define overlapping or synonymous values
  (e.g., `InProgress` and `Running` in the same enum).
  (Also enforced by: `EnumUniqueValue` linter rule R3024)
- Enum properties **MUST** declare the `type` field (typically `"type": "string"`).
  (Also enforced by: `EnumMustHaveType` linter rule R3015)
- Enum values **MUST** match the declared type of the property.
  (Also enforced by: `EnumMustRespectType` linter rule R4040)

### TypeSpec

Use `union` instead of `enum` (the `@azure-tools/typespec-azure-core/no-enum` rule enforces this):

```tsp
/** The status of the service. */
union ServiceStatus {
  string,

  /** The service is enabled. */
  Enabled: "Enabled",

  /** The service is disabled. */
  Disabled: "Disabled",
}
```

- Include the `string` base type to make the union extensible.
- Every union member **MUST** have a doc comment.
- Union member values **MUST** use PascalCase (not `ALL_CAPS`, not `snake_case`).
- Union member values **MUST NOT** use underscores (e.g., `In_Progress` is incorrect; use `InProgress`).

---

## Prefer Enums Over Booleans

> **Scope: this section is ARM-derived.** It restates ARM Wiki
> RPC-BestPractice-10/12 and OAPI015 (see the header), where the posture on
> booleans is materially more aggressive than on the data plane. **ARM reviewers
> apply it as written.**
>
> **Data-plane reviewers must not apply it as a blanket rule.** The data-plane
> position is
> [`data-plane-naming-and-docs.md`](data-plane-naming-and-docs.md) `DP-NAME-03`,
> which flags a boolean only when the property name suggests a **mode** rather
> than a genuine yes/no, and which explicitly blesses `enabled` and `isDeleted`.
> Where this section and `DP-NAME-03` disagree on a data-plane spec,
> **`DP-NAME-03` wins.**
>
> This is the same anti-inheritance trap as `guid-and-uuid-on-arm.md`: guidance
> that is correct for ARM and wrong when inherited unscoped. It was found the
> expensive way — this file used `enabled` as its worked example of a boolean to
> replace, while `DP-NAME-03` named `enabled` as the archetype of a boolean to
> leave alone. A data-plane reviewer reading both raised a false positive on
> `enabled` in 2 of 3 trials on identical input: not a misreading, but a genuine
> split between two of our own instructions.

Booleans do not version well -- what starts as a two-state switch often needs additional states, leading to breaking changes.

**Recommendations:**

- Use extensible string enums instead of boolean types.
- When converting a boolean concept to an enum, use meaningful state names
  (e.g., `"NetworkOperationStatus": ["InProgress", "Succeeded", "Failed"]`)
  not `"True"` / `"False"`.
- Boolean property names **SHOULD** indicate a state:
  `backupsEnabled`, `isEncryptionEnabled` --
  not bare nouns like `backups` or `encryption`.
- When multiple related two-state properties exist
  (e.g., `rewriteEnabled` and `appendMode`), consider combining them into a
  single multi-state enum (e.g., `usageMode: [Disabled, Rewrite, Append]`).
- Enum values replacing booleans **MUST** carry semantic meaning beyond
  `True`/`False`. Distribute meaning across both the property name and
  enum values (e.g., `addressOverlap: [Allowed, Disallowed]` rather
  than `allowAddressOverlap: [True, False]`).

---

## Actively Review String Properties for Enum Candidates

**Actively examine every `string` property.** If the property name or
description suggests it takes values from a limited or well-known set
(e.g., "status", "mode", "tier", "kind", "protocol", "algorithm",
"action", "state", "type", "category", "level"), **flag it** and
recommend modeling it as an extensible enum.

If a string property's description lists its valid values
(e.g., "Possible values are: Enabled, Disabled"), it **MUST** be
declared as an enum, not a plain string.
