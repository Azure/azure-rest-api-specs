---
applyTo: "specification/**/*.tsp"
---

<!-- Upstream alignment: 2026-04-15
     This date is for maintainers of this file only -- it records when
     rules were last verified against upstream docs. No action is needed
     by spec authors or PR reviewers. The upstream documents always take
     precedence if there is a conflict.

     Rules derived from:
       - Azure Resource Provider Contract (RPC) v1.0
         https://github.com/cloud-and-ai-microsoft/resource-provider-contract/tree/master/v1.0
       - Azure REST API Guidelines (vNext)
         https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md
       - TypeSpec Azure library docs
         https://azure.github.io/typespec-azure/docs/intro/
     If an upstream document changes a rule, update this file to match.
     When in doubt, the upstream document takes precedence. -->

# TypeSpec Specification Review Instructions

This file contains **review-specific** rules for TypeSpec (`.tsp`) API
specification files. It supplements the foundational TypeSpec project
rules in
[typespec-project.instructions.md](typespec-project.instructions.md),
which is the source of truth for project structure, naming, versioning,
documentation, and ARM resource patterns. Apply **both** files when
reviewing PRs that add or modify TypeSpec projects.

Flag every violation clearly with the file path, **exact line number**
(e.g., `line 42` or `line 10-15` for ranges), the specific rule, and a
concrete suggestion for how to fix it. Vague references like "near end
of file" or "around line 50" are not acceptable -- always resolve the
actual line number by reading the file content. Respond in markdown
format.

### Rule Citation Format (REQUIRED for posted PR comments)

Every rule ID cited in a posted PR comment **MUST** be accompanied by a
markdown hyperlink to the rule's authoritative location in this
repository. A bare rule ID without a link is **not acceptable** --
authors must be able to one-click navigate to the exact section that
defines the rule.

**Format.** Use a markdown link whose visible text is the rule ID and
whose target is a permanent GitHub URL (use the `main` branch ref)
anchored to the section that defines the rule:

```
[<RULE-ID>](https://github.com/Azure/azure-rest-api-specs/blob/main/<path-to-rule-file>#<section-anchor>)
```

**Where to link.** Pick the most specific source for the rule:

- TypeSpec-specific rules → link to the corresponding section in
  `.github/instructions/typespec-review.instructions.md` or
  `.github/instructions/typespec-project.instructions.md`.
- ARM RPC rules (e.g., `RPC-Put-V1-12`, `RPC-Async-V1-06`) → link to
  `.github/instructions/arm-api-review.instructions.md`.
- Generic OpenAPI rules (e.g., `OAPI020`, `OAPI034`, `WHATIF-001`) →
  link to `.github/instructions/openapi-review.instructions.md` or to
  the dedicated reference file under
  `.github/skills/azure-api-review/references/*.md`.

**Multiple rule IDs.** When a finding cites more than one rule ID, each
ID **MUST** be its own hyperlink (e.g., `[OAPI034](...) / [RPC-Put-V1-12](...)`).

**Anchor resolution.** GitHub auto-generates section anchors by
lowercasing the heading, replacing spaces with `-`, and stripping
punctuation. When in doubt, open the rendered file on GitHub and copy
the link from the heading's anchor icon.

### Reviewer-Posted Parity

<a id="reviewer-posted-parity"></a>

See the canonical contract in [`.github/skills/azure-api-review/references/reviewer-posted-parity.md`](../skills/azure-api-review/references/reviewer-posted-parity.md). The hard rules, post-post verification procedure, and worked examples live there; this section is a pointer so the three instruction files cannot drift.

---

## 1. Project Structure & File Organization

> See [typespec-project.instructions.md](typespec-project.instructions.md)
> for the canonical directory layout, required files, and ARM resource
> requirements.

---

## 2. Namespace, Service, Versioning & Model Rules

> **Source of truth:**
> [typespec-project.instructions.md](typespec-project.instructions.md)
> §2-§5 defines the rules for namespace/service declarations,
> versioning, model/type definitions (naming, documentation, enums,
> visibility), and ARM resource patterns.
>
> The review-specific additions below cover enforcement details not in
> the project instructions.

### 2.1 Breaking Changes Across Versions

> **Linter coverage:** Breaking changes between API versions are
> partially detected by the `oad` (OpenAPI diff) CI check and the
> `@azure-tools/typespec-azure-core` breaking-change rules. The agent
> should check CI results before flagging these — if CI already caught
> the same breaking change, do not duplicate the finding. The rules
> below cover cases the linters may miss (e.g., semantic type changes
> that pass syntactic checks).

- **DO NOT** remove properties, operations, or models between API
  versions without using `@removed` with the correct version reference.
- **DO NOT** change property types between versions without using
  `@typeChangedFrom`.
- Adding `required` to a previously optional property is a breaking
  change -- flag it.

### 2.2 Type Constraints (Review Enforcement)

- String properties with well-known formats **SHOULD** use appropriate
  scalar types: `url`, `utcDateTime`, `duration`, `uuid`.
  - **ARM caveat for `uuid`:** the TypeSpec `uuid` scalar emits `"format": "uuid"` in the generated Swagger, which on ARM control-plane specs triggers the required `GuidUsage` LintDiff rule (`R3017`). **Default position: do NOT use the `uuid` scalar on ARM control-plane TypeSpec.** Acceptable only for Microsoft Entra / AAD identifiers customers already see as GUIDs (`tenantId`, `clientId`, `principalId`, `objectId`, body-surfaced `subscriptionId`); for everything else (opaque platform-assigned IDs, resource-internal IDs, names), keep `string` and convey the format via the description and an optional `@pattern`. When `uuid` IS justified, the author MUST add a `GuidUsage` suppression in `readme.md` whose `where:` clause targets the `format` leaf of the shared `Azure.Core.uuid` definition in the generated Swagger -- not the per-property path -- and the `reason:` MUST enumerate every relying property by name and record reviewer sign-off. See [`.github/skills/azure-api-review/references/guid-and-uuid-on-arm.md`](../skills/azure-api-review/references/guid-and-uuid-on-arm.md) for the full decision tree, the exact suppression form (Form A for TypeSpec-generated OpenAPI), and the acceptable/unacceptable property lists.
- Datetime properties **MUST** use `utcDateTime` (not `string`).
  (Also enforced by: `@azure-tools/typespec-azure-resource-manager/no-string-datetime`)
- Integer properties **SHOULD** specify bit width: `int32`, `int64`.
- Integer properties with known valid ranges **SHOULD** use `@minValue`
  and `@maxValue` decorators.
- String properties used as resource name path parameters **SHOULD**
  include a `@pattern` decorator with a maximum length limit, character
  set, and prevention of leading special characters.
  Example: `@pattern("^(?![.-])[A-Za-z0-9_.-]{1,128}$")`
  (Also enforced by: `@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern`)
- Properties representing UTC timestamps **SHOULD** include a `Utc`
  suffix in the name (e.g., `lastModifiedTimeUtc`).
- Properties named `<something>Id` **MUST** be specific about what kind
  of ID they hold (`armResourceIdentifier`, or a documented format). For
  GUID-valued IDs, see the ARM caveat above and
  [`.github/skills/azure-api-review/references/guid-and-uuid-on-arm.md`](../skills/azure-api-review/references/guid-and-uuid-on-arm.md)
  before choosing `uuid`.
- Array properties **MUST** have their element type defined.
- **AVOID** using `unknown` type.

### 2.3 Visibility & Mutability (Review Enforcement)

> **Full rule definitions:** See
> [`.github/skills/azure-api-review/references/property-mutability.md`](../skills/azure-api-review/references/property-mutability.md)
> for OAPI027, OAPI020, OAPI029 with format-specific examples.

- Properties used only in responses **MUST NOT** be marked as required
  in request contexts.
- If a property is read-only, it **MUST** always be read-only (OAPI020).
- If a property is immutable, it **MUST** always be immutable (OAPI029).

### 2.4 Enums & Provisioning State (Review Enforcement)

> **Full rule definitions:** See
> [`.github/skills/azure-api-review/references/enum-best-practices.md`](../skills/azure-api-review/references/enum-best-practices.md)
> and
> [`.github/skills/azure-api-review/references/provisioning-state.md`](../skills/azure-api-review/references/provisioning-state.md).

- The `string` base type **SHOULD** be included in unions to make them
  extensible.
  (Also enforced by: `@azure-tools/typespec-azure-core/no-enum`)
- `provisioningState` **SHOULD** extend
  `Azure.ResourceManager.ResourceProvisioningState` for terminal states.

### 2.5 ARM Resource Definitions (Review Enforcement)

> **Full rule definition:** See
> [`.github/skills/azure-api-review/references/tracked-resource-lifecycle.md`](../skills/azure-api-review/references/tracked-resource-lifecycle.md).

- **DO NOT** use private/custom decorators or manual resource base types
  when standard ARM base types exist.
- Nested resources **MUST** define a list operation under their parent.
- **DO NOT** embed nested resource data inline in the parent resource
  model.

### 2.6 ARM POST Actions

- ARM resource POST actions **MUST** use `ArmResourceActionAsync` or
  `ArmResourceActionSync` templates.
- When a POST action does **not** require a request body, use `void` --
  not `{}`. Using `{}` triggers the `no-empty-model` lint warning.

### 2.7 Data-Plane Operations

- Data-plane services **SHOULD** use `Azure.Core` operation templates
  (`ResourceRead`, `ResourceCreateOrReplace`, `ResourceDelete`,
  `ResourceList`).
- Long-running operations **MUST** use LRO templates from `Azure.Core`.
- All operations **MUST** include error responses using
  `Azure.Core.Foundations.ErrorResponse` or the ARM error equivalents.

### 2.8 Client Customizations (Review Enforcement)

> **See also:** [`.github/skills/azure-api-review/references/naming-conventions.md`](../skills/azure-api-review/references/naming-conventions.md) for comprehensive naming and Azure terminology rules.

- `@@clientName` target values **MUST** follow TypeSpec conventions:
  PascalCase for interfaces/classes, camelCase for
  operations/properties.
- Language emitter configurations (Go, Python, JavaScript, C#)
  **SHOULD** be present in `tspconfig.yaml` if SDK generation is
  expected.

---

## 3. Secret Detection in TypeSpec (SEC-SECRET-DETECT)

> **Full rule definition:** See [`.github/skills/azure-api-review/references/secret-detection.md`](../skills/azure-api-review/references/secret-detection.md) for the complete detection signals, keyword list, and format-specific fix guidance.

- Reviewers **MUST** inspect every `string` property for secret indicators.
- Flag as **blocking** (`SEC-SECRET-DETECT`) if property name, doc comment, example values, or `#suppress` directives for `secret-prop` suggest a secret but `@secret` is missing.
- **Fix:** Add `@secret` to the property and remove any `#suppress` directive for `secret-prop`.

---

## 4. Suppressions (Review Enforcement)

### 4.1 Warning Suppression Policy

- **AVOID** suppressing warnings. Every suppression needs justification.
- If a suppression is present, verify it has a clear reason documented:
  ```tsp
  #suppress "@azure-tools/typespec-azure-core/no-enum" "Justified: this enum is closed and will never change"
  ```
- Suppressions of **errors** are not allowed — errors must be fixed.
  (Also enforced by: CI pipeline — error suppressions cause CI failures)
- Flag any unexplained or blanket suppressions.
- Suppression reasons **MUST NOT** contain placeholder text such as `FIXME`, `TODO`, or `TBD`. These indicate the author deferred the justification and never returned to it.
- Suppression reasons **MUST NOT** justify by reference to another resource's pattern (e.g., "Matching AiGateway pattern"). Each suppression must stand on its own with a technical justification for **why** the rule does not apply to this specific case.
- Suppression reasons **MUST** be factually accurate. If the reason claims "existing API design" or "would break the service contract" but the PR itself changes the relevant path or model, flag the inconsistency.

---

## 5. Common Anti-Patterns

Flag these issues when found:

- **Resource with zero writable properties** -- a tracked ARM resource whose `properties` bag contains only `@visibility(Lifecycle.Read)` properties (no customer-configurable fields) is highly unusual. It means PUT creates an empty `properties: {}` and PATCH can only update `tags`. Flag this for design review: either the service is too early for a public API, or properties are missing from the spec. If intentional, require a doc comment on the Properties model explaining why.
- **Default values flowing into PATCH** -- when a property has a TypeSpec default value (e.g., `ipAllocationMethod?: IPAllocationMethod = IPAllocationMethod.Static`), that default flows into the PATCH update model. ARM rule RPC-Patch-V1-10 prohibits defaults in PATCH bodies because with JSON Merge Patch, omitting a field should leave it unchanged, but a schema default resets it. Remove the TypeSpec default and apply it server-side instead.
- **Namespace collision across TypeSpec projects** -- two separate TypeSpec projects under the same RP namespace (e.g., both use `Microsoft.Network`) will produce conflicting `/providers/Microsoft.Network/operations` endpoints. Resource types sharing an RP namespace **MUST** be in the same TypeSpec project, or use distinct RP namespaces.
- **`| null` on new properties** -- new properties added in this PR **MUST NOT** use `| null` (nullable union) for backward compatibility, because backward compatibility does not apply to new additions. Only existing properties that were previously non-nullable may need `| null` when the service must return null for them in certain scenarios.
- **Bearer tokens in request bodies** -- passing OAuth access tokens, bearer tokens, or refresh tokens in ARM request bodies is not an acceptable pattern, even with `@secret`. Use managed identity, Key Vault references, or RBAC-controlled mechanisms instead.
- **Duplicate namespace declarations** across multiple `.tsp` files without proper imports.
- **Missing `using` statements** — if decorators from a library are used, the library must be imported and `using` must be declared.
- **Inline anonymous models** — prefer named model definitions for reusability and clarity.
- **Overly broad `@visibility("none")`** — verify the intent is correct; this hides properties from all contexts.
- **Circular references** without `@visibility` to break the cycle.
- **Hardcoded API version strings** instead of using the versioning enum.
- **Missing examples** — every operation should have corresponding example files.
- **Low-quality example values** — example files with filler values like `"aaaaaaa"`, `"string"`, or repeated characters are published in public Azure docs and SDK samples. See [`.github/skills/azure-api-review/references/example-quality.md`](../skills/azure-api-review/references/example-quality.md) for the full `EX-DESCRIPTIVE-VALUES` rule. Auto-generated examples **SHOULD** be hand-edited to replace filler values before submitting.
- **Manual swagger alongside TypeSpec** — once a service has transitioned to TypeSpec, new manually authored swagger files **MUST NOT** be added to the same package tag. All new API versions must use TypeSpec, with generated swagger from `tsp compile .`.
- **`@operationId` overrides** — avoid using `@operationId` decorators in TypeSpec. Instead, restructure interfaces and operation names so the generated operationId naturally follows the ARM `{ResourceType}_{Verb}` pattern. `@operationId` overrides create tech debt that must eventually be cleaned up.
- **URI properties** — properties that hold URLs or SAS URIs **MUST** use the TypeSpec `url` scalar type (which generates `"format": "uri"` in swagger) rather than plain `string`.
- **Duplicate `@added` decorators** — a symbol should only be introduced once with `@added`. Multiple `@added(...)` decorators on the same property suggest a copy-paste error; keep only the earliest version.
- **`Record<unknown>` / `Record<string>` for typed data** — avoid using `Record<>` (which generates `additionalProperties`) when the shape of the data is known. Define a dedicated model with typed properties instead.
- **Doc comment copy-paste errors** — verify that doc comments accurately describe the element they annotate (e.g., a `WorkspaceUpdate` model should not be documented as "Describes an experiment update").
- **Spelling/typo errors in doc comments and descriptions** — flag common misspellings (e.g., `payed` → `paid`, `consoto` → `contoso`) as they propagate into generated SDKs and documentation.
- **Deprecated operations missing description text** -- the TypeSpec `#deprecated` directive does not always surface in generated swagger JSON. For deprecated operations, also include deprecation notice in the `@doc` description (e.g., "This operation is deprecated and will be removed in a future version. Use resetSmbPassword instead.") so it appears in generated SDKs and documentation.
- **Key Vault URI properties** -- properties referencing an Azure Key Vault should use `armResourceIdentifier` with type `Microsoft.KeyVault/vaults` (generating `format: arm-id`), not a `url`/`string` with a vault URI. ARM resource IDs are the standard way to reference Azure resources, enabling linked access checks and RBAC integration.
- **Enum values with underscores or ALL_CAPS** -- union/enum member values **MUST** use PascalCase (e.g., `InProgress`, not `In_Progress` or `IN_PROGRESS`). Underscores and all-caps violate Azure naming conventions and look inconsistent in generated SDKs.
- **Polymorphic-format properties** — a single property that accepts multiple formats (e.g., both an integer `5` and a percentage string `"20%"`) creates ambiguity and error-prone client code. Model these as separate properties (e.g., `maxConcurrency: int32` and `maxConcurrencyPercent: string`) or use a discriminated union model.
- **`@added` version misalignment** — when using `@added(Versions.vXXXX)` to gate a new feature, verify that the feature does not inadvertently alter descriptions or schemas of earlier API versions. If the feature is for version `2025-08-01`, it must not affect the generated OpenAPI for `2025-06-01`.
- **`@flattenProperty` on new APIs** — do not add new `@flattenProperty` decorators. Flattening creates SDK-breaking issues and is discouraged for new resource types and properties. Existing flattened properties may remain for backward compatibility.
- **Spread-only model types as full models** — a model type used only for spreading (`...`) into other types **SHOULD** be declared as an `alias` instead. Using `model` for types that are only spread generates unnecessary types in the output. See [TypeSpec alias documentation](https://typespec.io/docs/language-basics/alias) (TypeSpec-BestPractice-01).
- **Empty model literal `{}` as POST action body** -- when an `ArmResourceActionAsync` or `ArmResourceActionSync` POST action does not need a request body, use `void` instead of `{}`. An empty model literal triggers the `no-empty-model` lint rule, and suppressing it is the wrong fix. Use `void` and remove the suppression.
- **`@extension(...)` in TypeSpec source** -- never add `@extension(...)` decorators to TypeSpec source for any reason. This includes `@extension("x-ms-identifiers", ...)`, `@extension("x-ms-mutability", ...)`, and any other OpenAPI extension. `@extension` bypasses TypeSpec's type system and emitter conventions. Use the appropriate built-in decorator instead: `@identifiers` / `@key` for `x-ms-identifiers`, `@visibility` for mutability, `@secret` for secret data, etc. (see TSP-ARRAY-IDENTIFIERS for the `x-ms-identifiers` case).

---

## 6. ARM TypeSpec Additional Rules

### 6.1 `@segment` Casing for Resource Types (TSP-SEGMENT-CASE)

- The `@segment` decorator value for ARM resource types **MUST** use camelCase (e.g., `@segment("connectorGateways")`, `@segment("virtualMachines")`).
- All-lowercase segment values (e.g., `@segment("connectorgateways")`) violate ARM path naming conventions and produce incorrect permanent resource type paths.
- Once a resource type path is published (even in preview), changing it is a breaking change — catch casing issues before first publication.
- (Not currently enforced by linters — manual review required)

### 6.2 PATCH Operation Naming (TSP-PATCH-NAME)

- ARM PATCH operations **SHOULD** be named `update` (not `patch`) so the generated `operationId` follows the ARM convention `{ResourceType}_Update` rather than `{ResourceType}_Patch`.
- Example: `update is ArmTagsPatchSync<MyResource>;` instead of `patch is ArmTagsPatchSync<MyResource>;`.

### 6.3 Use `armResourceIdentifier` for Resource References (TSP-ARM-RESOURCE-ID)

- When a TypeSpec property references another ARM resource, use the `armResourceIdentifier` scalar type with a type constraint:
  ```tsp
  sourceVaultId?: armResourceIdentifier<[{ type: "Microsoft.RecoveryServices/vaults" }]>;
  ```
- Do not use plain `string` for ARM resource ID properties — `armResourceIdentifier` enables ARM validation and rich SDK typing.

### 6.4 Numeric Properties Must Use Numeric Types (TSP-NUMERIC-TYPE)

- Properties whose names or doc comments clearly indicate numeric values (e.g., `numberOfCores`, `ram`, `vCpu`, `diskSizeGB`) **SHOULD** use `int32`, `int64`, or `float64` — not `string`.
- If backward compatibility forces a string type for a numeric value, the doc comment **MUST** document the expected format and units.

### 6.5 Array Identifiers — `x-ms-identifiers` (TSP-ARRAY-IDENTIFIERS)

The `missing-x-ms-identifiers` linter rule fires on array-typed properties whose item models do not declare which property uniquely identifies an item. **Do not silence this rule with `@extension("x-ms-identifiers", [])`.** `@extension` is forbidden in TypeSpec source for any reason (see Section 5 anti-patterns).

Use one of the following built-in TypeSpec decorators instead:

- **Preferred — `@key` on the identity property of the item type.** The emitter automatically derives `x-ms-identifiers` from `@key`. Use this when the item model has a single, natural identity property:

  ```tsp
  model MoveRequest {
    @key moveId: string;
    from: string;
    to: string;
  }

  model MoveCollection {
    moves?: MoveRequest[];
  }
  ```

- **Alternative — `@identifiers(#["<propertyName>", ...])` on the array property.** Use this when the identity property cannot be marked with `@key` on the item type (e.g., the item type is shared and `@key` would conflict, or identity is composed of multiple properties):

  ```tsp
  @identifiers(#["moveId"])
  moves?: MoveRequest[];
  ```

- **Items genuinely have no identifier — `@identifiers(#[])` on the array property.** For arrays whose items are ordered result records, primitive values, or otherwise have no stable identity field, declare the empty identifier list explicitly. This satisfies the linter without a suppression and documents the design intent:

  ```tsp
  @identifiers(#[])
  testResults?: TestResultRecord[];
  ```

**Forbidden patterns:**

- `@extension("x-ms-identifiers", [])` — never add `@extension` in TypeSpec source for any reason. Replace with `@identifiers(#[])` (or `@key` on the item type).
- `#suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "..."` — suppression is **only** acceptable as a last resort when neither `@key` nor `@identifiers` is technically feasible (extremely rare). The suppression reason must still meet Section 4.1 rules (real technical justification, no `FIXME`/`TODO`/`TBD`, no "matching another resource"). For brand-new operations and models, suppression is never the right fix — use `@identifiers` or `@key`.

When reviewing a new `missing-x-ms-identifiers` suppression, propose `@identifiers` or `@key` as the fix. **Never** suggest `@extension("x-ms-identifiers", ...)`.

---

## 7. `tspconfig.yaml` Additional Validation

### 7.1 `emit` List Consistency (TSP-CONFIG-EMIT)

- If emitter-specific options are configured under `options:` (e.g., for `@azure-tools/typespec-python`, `@azure-tools/typespec-java`), the corresponding emitters **SHOULD** also be listed under `emit:`.
- Options configured for emitters not in the `emit` list create confusion about what the config actually drives.

### 7.2 `service-dir` Correctness (TSP-CONFIG-SERVICE-DIR)

- Each language emitter's `service-dir` override (if present) **MUST** point to the correct SDK directory for this service.
- A `service-dir` copied from another service (e.g., `sdk/machinelearning` when the project is for `guestconfiguration`) will cause SDK generation to write to the wrong location.

### 7.3 Duplicate Example Directories (TSP-CONFIG-EXAMPLES)

- With TypeSpec, examples may exist in both `{project-root}/examples/` (source) and `{version}/examples/` (generated output). Verify these are not independently maintained duplicates that can drift — there should be a single source of truth.

---

## 8. TypeSpec Conversion Reviews

### 8.1 Horizontal Conversion Only

- When a PR converts an existing OpenAPI specification to TypeSpec, the conversion **MUST** be horizontal -- no API changes are allowed during the conversion.
- The generated OpenAPI output from the TypeSpec source **MUST** be functionally identical to the original OpenAPI specification.
- If the PR introduces both a TypeSpec conversion and API changes (new properties, new operations, version bump), flag it -- these should be separate PRs.

### 8.2 Validation

- The conversion should be validated using `tsp-client compare` (or equivalent diff tool) to confirm the generated OpenAPI matches the original.
- Common post-conversion issues to watch for: `date-time` format inconsistencies, property name casing drift, and missing `x-ms-*` extensions.

### 8.3 SDK Generation Cutover

- When converting to TypeSpec, the PR **MUST** also disable OpenAPI-based SDK generation by removing language entries from `swagger-to-sdk` in `readme.md` and deleting `readme.{language}.md` files that are no longer needed.
- Verify that `tspconfig.yaml` includes the correct emitter configuration for all target languages.

---

## 9. TypeSpec Adoption Requirements

### 9.1 TypeSpec Mandate (TSP-REQUIRED-V1)

- TypeSpec with the Azure TypeSpec libraries (`@azure-tools/typespec-azure-core`, `@azure-tools/typespec-azure-resource-manager`, and related packages) is **required** for all new API versions, both control plane and data plane. The full rule definition is in [`openapi-review.instructions.md` §2A](./openapi-review.instructions.md) (rule ID `TSP-REQUIRED-V1`).
- Brownfield services were required to complete migration to TypeSpec by March 30, 2026.
- Updates to handwritten OpenAPI inside **existing** API version directories remain permitted; only new API versions must use TypeSpec.
- A deterministic CI check to block non-compliant PRs is in development (PR [#42823](https://github.com/Azure/azure-rest-api-specs/pull/42823)). Until that check ships, this rule is enforced by the ARM API Reviewer agent.

---

## TypeSpec Review Checklist Summary

When reviewing TypeSpec files, verify:

- ✅ Correct directory placement (ARM under `resource-manager/<resource-provider-namespace>/<Service>`, data-plane under `data-plane/<Service>`)
- ✅ Required files present: `main.tsp`, `tspconfig.yaml`, `readme.md`, `examples/`
- ✅ No `package.json` in the TypeSpec project directory
- ✅ `@service`, `@server`, `@useAuth` decorators present and correct
- ✅ `@versioned` with proper `Versions` enum in `main.tsp`
- ✅ All types declared under the main namespace
- ✅ Model names PascalCase, property names camelCase, operation names camelCase
- ✅ Every element has a `/** ... */` doc comment
- ✅ Doc comments are accurate (no copy-paste errors from other models)
- ✅ `union` used instead of `enum` for extensible Azure enums
- ✅ Visibility decorators use `Lifecycle` class values
- ✅ ARM resources extend correct base types (`TrackedResource`, `ProxyResource`, etc.)
- ✅ All CRUD operations present for ARM tracked resources
- ✅ ARM POST actions use `void` (not `{}`) when no request body is needed -- no `no-empty-model` suppressions
- ✅ `Operations` interface defined for ARM resource providers
- ✅ `@armProviderNamespace` applied correctly
- ✅ `@segment` values use camelCase for resource type path segments (TSP-SEGMENT-CASE)
- ✅ PATCH operations named `update` not `patch` (TSP-PATCH-NAME)
- ✅ ARM resource ID properties use `armResourceIdentifier` not `string` (TSP-ARM-RESOURCE-ID)
- ✅ No `@operationId` overrides — restructure interfaces instead
- ✅ URI properties use `url` scalar type, not plain `string`
- ✅ Array-typed properties declare item identity via `@key` (on item type) or `@identifiers` (on array property); use `@identifiers(#[])` when items have no identifier (TSP-ARRAY-IDENTIFIERS)
- ✅ No `@extension(...)` decorators in TypeSpec source — never `@extension("x-ms-identifiers", ...)`, `@extension("x-ms-mutability", ...)`, etc.
- ✅ Standard ARM base types used (no custom/private resource decorators)
- ✅ Client customizations only in `client.tsp`
- ✅ `tspconfig.yaml` references correct linter ruleset
- ✅ `tspconfig.yaml` `emit` list matches configured emitter options (TSP-CONFIG-EMIT)
- ✅ `tspconfig.yaml` `service-dir` values point to the correct service directories (TSP-CONFIG-SERVICE-DIR)
- ✅ No unexplained suppressions; no FIXME/TODO/TBD in suppression reasons
- ✅ Suppression reasons are factually accurate and technically justified
- ✅ No duplicate `@added` decorators on the same symbol
- ✅ `@added` version targeting is correct — features don't leak into earlier API version outputs
- ✅ TypeSpec conversion PRs: no API changes (horizontal only); generated OpenAPI matches original
- ✅ TypeSpec conversion PRs: `swagger-to-sdk` entries removed; `readme.{language}.md` files deleted
- ✅ New API versions use TypeSpec source (TSP-REQUIRED-V1) — updates to existing handwritten OpenAPI remain permitted
- ✅ No polymorphic-format properties — use separate typed properties or discriminated unions
- ✅ Numeric properties use numeric types, not string (TSP-NUMERIC-TYPE)
- ✅ No `Record<>` usage when typed models can be defined
- ✅ Every string property inspected for secret indicators (SEC-SECRET-DETECT): flag if property name, doc comment, or examples suggest a secret but `@secret` is missing
- ✅ No `#suppress` directives silencing `secret-prop` lint rules — apply `@secret` instead
- ✅ Integer properties have `@minValue`/`@maxValue` when range is known
- ✅ Datetime properties use `utcDateTime` scalar, not `string`
- ✅ Preview versions annotated with `@Azure.Core.previewVersion` decorator
- ✅ `provisioningState` extends `ResourceProvisioningState` for terminal states
- ✅ UTC timestamp properties have `Utc` suffix in name
- ✅ `<something>Id` properties specify what kind of ID (uuid, armResourceIdentifier, or documented format)
- ✅ No "ARM" in client-facing property names or descriptions -- use "Azure" instead
- ✅ No "AAD" in descriptions -- use "Microsoft Entra ID"
- ✅ No `| null` on newly added properties (backward compatibility does not apply to new additions)
- ✅ No default values on properties that flow into PATCH models (RPC-Patch-V1-10)
- ✅ No bearer/OAuth tokens passed in ARM request bodies -- use managed identity or Key Vault
- ✅ Generated OpenAPI files match `tsp compile .` output
- ✅ Example files present for all operations, with realistic descriptive values (EX-DESCRIPTIVE-VALUES)
