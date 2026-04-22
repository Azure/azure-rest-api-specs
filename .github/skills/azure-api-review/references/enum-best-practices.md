<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-04-15
     Derived from:
       - Azure REST API Guidelines (vNext) — Enums
       - ARM Wiki: api_contracts/guidelines/api_best_practices_and_design_choices.md (RPC-BestPractice-10, RPC-BestPractice-12)
       - ARM Wiki: api_contracts/guidelines/openapi.md (OAPI015)
     The upstream documents always take precedence if there is a conflict. -->

# Enum Best Practices for Azure APIs

Azure APIs should use extensible enums to allow new values to be added
without breaking existing clients. Booleans should be avoided in favor
of enums for better versioning.

**Authoritative references:**

- [Azure REST API Guidelines -- Enums & SDKs](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#enums--sdks-client-libraries)
- [Azure Resource Provider Contract -- Resource API Reference](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/resource-api-reference.md)
- [TypeSpec Azure -- no-enum rule](https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-enum)

---

## Extensible Enums (Required)

Every enum **MUST** be modeled as extensible to avoid breaking changes when new values are added.

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
  (e.g., `enabled` and `appendMode`), consider combining them into a
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
