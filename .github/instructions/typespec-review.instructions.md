---
applyTo: "specification/**/*.tsp"
---

# TypeSpec Specification Review Instructions

This file contains review rules for TypeSpec (`.tsp`) API specification files in the azure-rest-api-specs repository. Apply these rules when reviewing PRs that add or modify TypeSpec projects.

Flag every violation clearly with the file path, line number or code reference, the specific rule, and a concrete suggestion for how to fix it. Respond in markdown format.

---

## 1. Project Structure & File Organization

### 1.1 Directory Placement

- ARM TypeSpec projects **MUST** be placed under:
  ```
  specification/<organization>/resource-manager/<RPNS>/<ServiceName>/
  ```
- Data-plane TypeSpec projects **MUST** be placed under:
  ```
  specification/<organization>/data-plane/<ServiceName>/
  ```
- ARM TypeSpec folder names **SHOULD** end with `.Management` (e.g., `Contoso.Management`).
- **DO NOT** place TypeSpec projects directly under `resource-manager/` without the `<RPNS>/<ServiceName>` nesting.

### 1.2 Required Files

Every TypeSpec project **MUST** contain:
- `main.tsp` — main entry point
- `tspconfig.yaml` — TypeSpec compilation configuration
- `readme.md` — AutoRest readme with YAML blocks for SDK generation
- `examples/` directory — with example JSON files organized by `<api-version>` subdirectories

A TypeSpec project **MUST NOT** contain:
- `package.json` or `package-lock.json` (use the repo-root one)
- Multiple `tspconfig.yaml` files for the same service

### 1.3 Generated Files

- Generated OpenAPI files under `stable/` and `preview/` **MUST NOT** be hand-edited. They are produced by `tsp compile .`.
- If a PR modifies both `.tsp` files and generated `.json` files, verify the generated files match what `tsp compile .` would produce.
- Stable API versions go under `stable/<YYYY-MM-DD>/`.
- Preview API versions go under `preview/<YYYY-MM-DD-preview>/`.

---

## 2. Namespace & Service Declarations

### 2.1 `@service` Decorator

- Every TypeSpec project **MUST** have a `@service` decorator in `main.tsp` defining the service title.
- The service title **MUST** be descriptive and match the Azure service name.

### 2.2 `@server` Decorator

- Data-plane services **MUST** define a `@server` decorator with the correct endpoint pattern.
- **DO** use the built-in `url` type for endpoint parameters:
  ```tsp
  @server("{endpoint}/widget", "Contoso Widget APIs", { endpoint: url })
  ```

### 2.3 Namespace Conventions

- All models, enums, unions, and operations **MUST** be declared under the main namespace in `main.tsp`.
- **DO NOT** declare types outside of a namespace.
- **AVOID** adding new namespaces beyond the main service namespace.
- The namespace **MUST** follow the pattern: `<Organization>.<ServiceName>` (e.g., `Azure.Compute`, `Microsoft.Storage`).

### 2.4 `@useAuth` Security Decorator

- Every service **MUST** have a security definition via `@useAuth`.
- `@useAuth` **MUST** be defined exactly ONCE in the specification, above the `@server` definition.
- ARM services use Azure AD OAuth2. Data-plane services may use OAuth2, API keys, or both.

---

## 3. Versioning

### 3.1 Version Enum

- API versions **MUST** be declared as a `Versions` enum under the main namespace in `main.tsp`:
  ```tsp
  @versioned(Versions)
  namespace Contoso.WidgetManager;

  /** Service API versions */
  enum Versions {
    /** The 2024-01-01 API version */
    v2024_01_01: "2024-01-01",
  }
  ```
- The `@versioned` decorator **MUST** be applied to the namespace and reference the versions enum.
- Every enum member **MUST** have a doc comment.
- Version string values **MUST** follow the `YYYY-MM-DD` or `YYYY-MM-DD-preview` format.

### 3.2 Versioning Decorators

- When using `@added`, `@removed`, or `@typeChangedFrom`, the file **MUST** import `@typespec/versioning`:
  ```tsp
  import "@typespec/versioning";
  using TypeSpec.Versioning;
  ```
- `@useDependency` **MUST** be applied to each API version entry when referencing types from versioned namespaces (e.g., `Azure.Core`, `Azure.ResourceManager`).

### 3.3 Breaking Changes Across Versions

- **DO NOT** remove properties, operations, or models between API versions without using `@removed` with the correct version reference.
- **DO NOT** change property types between versions without using `@typeChangedFrom`.
- Adding `required` to a previously optional property is a breaking change — flag it.

---

## 4. Model & Type Definitions

### 4.1 Naming Conventions

- Model names **MUST** use PascalCase (e.g., `VirtualMachine`, `StorageAccount`).
- Property names **MUST** use camelCase (e.g., `resourceId`, `provisioningState`).
- Operation names **MUST** use camelCase (e.g., `createOrUpdate`, `listByResourceGroup`).
- Enum/union member names **SHOULD** use PascalCase for values (e.g., `Succeeded`, `Failed`).
- **DO NOT** uppercase acronyms in property names — use `resourceId` not `resourceID`.

### 4.2 Documentation

- Every model, property, operation, parameter, enum, union, and alias **MUST** have a doc comment using `/** ... */` format.
- Doc comments **MUST NOT** simply repeat the element name.
- Doc comments **SHOULD** start with a capital letter and end with a period.
- PUT operation doc comments **MUST NOT** imply non-idempotent behavior (e.g., "Creates a new..." or "This will create a new version"). Use idempotent language: "Creates or updates..." or "Creates or replaces...".
- Specify units for quantifiable properties (e.g., `"The timeout in seconds."`).

### 4.3 Enums vs. Unions

- **DO** use `union` instead of `enum` to define Azure extensible enums. This follows the Azure convention for forward-compatible enum types:
  ```tsp
  /** The provisioning state of the resource. */
  union ProvisioningState {
    string,
    /** Resource has been created. */
    Succeeded: "Succeeded",
    /** Resource creation failed. */
    Failed: "Failed",
    /** Resource creation was canceled. */
    Canceled: "Canceled",
  }
  ```
- Every enum/union member **MUST** have a doc comment.
- The `string` base type **SHOULD** be included in unions to make them extensible.

### 4.4 Visibility & Mutability

- Read-only properties **MUST** be annotated with `@visibility(Lifecycle.Read)`.
- Create-only properties (immutable after creation) **MUST** use `@visibility(Lifecycle.Create, Lifecycle.Read)`.
- Properties used only in responses **MUST NOT** be marked as required in request contexts.
- Use the `Lifecycle` class values for visibility decorators (`Lifecycle.Create`, `Lifecycle.Read`, `Lifecycle.Update`).

### 4.5 Type Constraints

- String properties with well-known formats **SHOULD** use appropriate scalar types: `url`, `utcDateTime`, `duration`, `uuid`.
- Datetime properties **MUST** use `utcDateTime` (not `string`) to generate proper `format: date-time` in swagger and enable SDK datetime type generation.
- Integer properties **SHOULD** specify bit width: `int32`, `int64`.
- Integer properties with known valid ranges **SHOULD** use `@minValue` and `@maxValue` decorators (e.g., percentages: `@minValue(0) @maxValue(100)`, port numbers: `@minValue(1) @maxValue(65535)`).
- String properties used as resource name path parameters **SHOULD** include a `@pattern` decorator with:
  - A maximum length limit (e.g., `{1,128}`) to prevent excessively long names.
  - Prevention of leading special characters (e.g., `^(?![.-])`) — names should not start with `.` or `-`.
  - Allowed character set matching the service's actual validation.
  - Example: `@pattern("^(?![.-])[A-Za-z0-9_.-]{1,128}$")`
- Array properties **MUST** have their element type defined.
- **AVOID** using `unknown` type — use a concrete type or a well-defined model.

---

## 5. ARM Resource Definitions (TypeSpec)

### 5.1 Resource Base Types

- ARM tracked resources **MUST** extend `TrackedResource<TProperties>` from `@azure-tools/typespec-azure-resource-manager`.
- ARM proxy resources **MUST** extend `ProxyResource<TProperties>`.
- Extension resources **MUST** extend `ExtensionResource<TProperties>`.
- **DO NOT** manually define `id`, `name`, `type`, `location`, `tags`, or `systemData` — these come from the base types.
- **DO NOT** use private/custom decorators or manual resource base types when standard ARM base types (`TrackedResource`, `ProxyResource`, `ExtensionResource`) exist for the resource pattern.

### 5.2 CRUD Operations

- ARM tracked resources **MUST** define all standard operations using the ARM operation templates:
  - `get` — `ArmResourceRead<Resource>`
  - `createOrUpdate` — `ArmResourceCreateOrReplaceAsync<Resource>` (or sync variant)
  - `update` — `ArmResourcePatchAsync<Resource, ResourceProperties>` (or `ArmTagsPatchAsync`)
  - `delete` — `ArmResourceDeleteAsync<Resource>` (or sync variant)
  - `listByResourceGroup` — `ArmResourceListByParent<Resource>`
  - `listBySubscription` — `ArmListBySubscription<Resource>`
- If any of these operations are missing for a tracked resource, flag it.

### 5.3 Nested Resources

- Nested resources **MUST** define a list operation under their parent.
- **DO NOT** embed nested resource data inline in the parent resource model — use resource ID references.

### 5.4 Operations Interface

- Every ARM resource provider **MUST** expose an `Operations` interface:
  ```tsp
  interface Operations extends Azure.ResourceManager.Operations {}
  ```

### 5.5 `@armProviderNamespace` Decorator

- ARM TypeSpec projects **MUST** have `@armProviderNamespace` applied to the main namespace.
- The namespace value **MUST** match the resource provider path (e.g., `Microsoft.Compute`).

---

## 6. Data-Plane Operations (TypeSpec)

### 6.1 Operation Templates

- Data-plane services **SHOULD** use `Azure.Core` operation templates:
  - `ResourceRead<Resource>`
  - `ResourceCreateOrReplace<Resource>`
  - `ResourceDelete<Resource>`
  - `ResourceList<Resource>`
- Long-running operations **MUST** use the appropriate LRO templates from `Azure.Core`.

### 6.2 Error Handling

- All operations **MUST** include error responses using `Azure.Core.Foundations.ErrorResponse` or the ARM error equivalents.
- **DO NOT** define custom error types when standard Azure error types exist.

---

## 7. Client Customizations

### 7.1 `client.tsp` File

- Client-level customizations (renames, access changes, client structure) **MUST** be placed in a `client.tsp` file.
- **DO NOT** import or use `@azure-tools/typespec-client-generator-core` in files other than `client.tsp`.
- `@@clientName` target values **MUST** follow TypeSpec conventions: PascalCase for interfaces/classes, camelCase for operations/properties.

### 7.2 `tspconfig.yaml` Validation

- The `tspconfig.yaml` **MUST** reference the correct linter ruleset:
  - ARM: `@azure-tools/typespec-azure-rulesets/resource-manager`
  - Data-plane: `@azure-tools/typespec-azure-rulesets/data-plane`
- Language emitter configurations (Go, Python, JavaScript, C#) **SHOULD** be present if SDK generation is expected.
- **DO NOT** add custom `package.json` files — use the repo-root dependencies.

---

## 8. Secret Detection in TypeSpec (SEC-SECRET-DETECT)

- Reviewers **MUST** inspect every `string` property to determine whether it could contain a secret, credential, or sensitive token.
- Infer secret usage from **any** of the following signals:
  1. **Property name** contains or matches (case-insensitive): `key`, `token`, `secret`, `password`, `credential`, `connectionString`, `accessKey`, `sharedKey`, `masterKey`, `apiKey`, `sas`, `signature`, `cert`, `certificate`, `privateKey`, `passphrase`, `accountKey`, `ingestionKey`, `instrumentationKey`, `encryptionKey`, `symmetricKey`, `primaryKey`, `secondaryKey`, `clientSecret`.
  2. **Doc comment or description** mentions authentication, authorization, signing, bearer, opaque credential, API token, SaaS token, ingestion key, shared access signature, or connection string.
  3. **Example values** resemble tokens, base64-encoded blobs, or long random strings.
  4. **`#suppress` directives** referencing `secret-prop` or similar secret-related lint rules that are being silenced rather than addressed.
- If any signal is present and the property lacks `@secret`, flag it as a **blocking security issue**:
  - **Rule ID:** `SEC-SECRET-DETECT`
  - **Severity:** Blocking
  - **Fix:** Add `@secret` to the property and remove any `#suppress` directive for `secret-prop`.
- When flagging, explain which signal(s) triggered the detection.

---

## 9. Suppressions

### 9.1 Warning Suppression Policy

- **AVOID** suppressing warnings. Every suppression needs justification.
- If a suppression is present, verify it has a clear reason documented:
  ```tsp
  #suppress "@azure-tools/typespec-azure-core/no-enum" "Justified: this enum is closed and will never change"
  ```
- Suppressions of **errors** are not allowed — errors must be fixed.
- Flag any unexplained or blanket suppressions.
- Suppression reasons **MUST NOT** contain placeholder text such as `FIXME`, `TODO`, or `TBD`. These indicate the author deferred the justification and never returned to it.
- Suppression reasons **MUST NOT** justify by reference to another resource's pattern (e.g., "Matching AiGateway pattern"). Each suppression must stand on its own with a technical justification for **why** the rule does not apply to this specific case.
- Suppression reasons **MUST** be factually accurate. If the reason claims "existing API design" or "would break the service contract" but the PR itself changes the relevant path or model, flag the inconsistency.

---

## 10. Common Anti-Patterns

Flag these issues when found:

- **Duplicate namespace declarations** across multiple `.tsp` files without proper imports.
- **Missing `using` statements** — if decorators from a library are used, the library must be imported and `using` must be declared.
- **Inline anonymous models** — prefer named model definitions for reusability and clarity.
- **Overly broad `@visibility("none")`** — verify the intent is correct; this hides properties from all contexts.
- **Circular references** without `@visibility` to break the cycle.
- **Hardcoded API version strings** instead of using the versioning enum.
- **Missing examples** — every operation should have corresponding example files.
- **Manual swagger alongside TypeSpec** — once a service has transitioned to TypeSpec, new manually authored swagger files **MUST NOT** be added to the same package tag. All new API versions must use TypeSpec, with generated swagger from `tsp compile .`.
- **`@operationId` overrides** — avoid using `@operationId` decorators in TypeSpec. Instead, restructure interfaces and operation names so the generated operationId naturally follows the ARM `{ResourceType}_{Verb}` pattern. `@operationId` overrides create tech debt that must eventually be cleaned up.
- **URI properties** — properties that hold URLs or SAS URIs **MUST** use the TypeSpec `url` scalar type (which generates `"format": "uri"` in swagger) rather than plain `string`.
- **Duplicate `@added` decorators** — a symbol should only be introduced once with `@added`. Multiple `@added(...)` decorators on the same property suggest a copy-paste error; keep only the earliest version.
- **`Record<unknown>` / `Record<string>` for typed data** — avoid using `Record<>` (which generates `additionalProperties`) when the shape of the data is known. Define a dedicated model with typed properties instead.
- **Doc comment copy-paste errors** — verify that doc comments accurately describe the element they annotate (e.g., a `WorkspaceUpdate` model should not be documented as "Describes an experiment update").
- **Spelling/typo errors in doc comments and descriptions** — flag common misspellings (e.g., `payed` → `paid`, `consoto` → `contoso`, `endpoin` → `endpoint`) as they propagate into generated SDKs and documentation.
- **Polymorphic-format properties** — a single property that accepts multiple formats (e.g., both an integer `5` and a percentage string `"20%"`) creates ambiguity and error-prone client code. Model these as separate properties (e.g., `maxConcurrency: int32` and `maxConcurrencyPercent: string`) or use a discriminated union model.
- **`@added` version misalignment** — when using `@added(Versions.vXXXX)` to gate a new feature, verify that the feature does not inadvertently alter descriptions or schemas of earlier API versions. If the feature is for version `2025-08-01`, it must not affect the generated OpenAPI for `2025-06-01`.
- **`@flattenProperty` on new APIs** — do not add new `@flattenProperty` decorators. Flattening creates SDK-breaking issues and is discouraged for new resource types and properties. Existing flattened properties may remain for backward compatibility.

---

## 11. ARM TypeSpec Additional Rules

### 11.1 `@segment` Casing for Resource Types (TSP-SEGMENT-CASE)

- The `@segment` decorator value for ARM resource types **MUST** use camelCase (e.g., `@segment("connectorGateways")`, `@segment("virtualMachines")`).
- All-lowercase segment values (e.g., `@segment("connectorgateways")`) violate ARM path naming conventions and produce incorrect permanent resource type paths.
- Once a resource type path is published (even in preview), changing it is a breaking change — catch casing issues before first publication.

### 11.2 PATCH Operation Naming (TSP-PATCH-NAME)

- ARM PATCH operations **SHOULD** be named `update` (not `patch`) so the generated `operationId` follows the ARM convention `{ResourceType}_Update` rather than `{ResourceType}_Patch`.
- Example: `update is ArmTagsPatchSync<MyResource>;` instead of `patch is ArmTagsPatchSync<MyResource>;`.

### 11.3 Use `armResourceIdentifier` for Resource References (TSP-ARM-RESOURCE-ID)

- When a TypeSpec property references another ARM resource, use the `armResourceIdentifier` scalar type with a type constraint:
  ```tsp
  sourceVaultId?: armResourceIdentifier<[{ type: "Microsoft.RecoveryServices/vaults" }]>;
  ```
- Do not use plain `string` for ARM resource ID properties — `armResourceIdentifier` enables ARM validation and rich SDK typing.

### 11.4 Numeric Properties Must Use Numeric Types (TSP-NUMERIC-TYPE)

- Properties whose names or doc comments clearly indicate numeric values (e.g., `numberOfCores`, `ram`, `vCpu`, `diskSizeGB`) **SHOULD** use `int32`, `int64`, or `float64` — not `string`.
- If backward compatibility forces a string type for a numeric value, the doc comment **MUST** document the expected format and units.

---

## 12. `tspconfig.yaml` Additional Validation

### 12.1 `emit` List Consistency (TSP-CONFIG-EMIT)

- If emitter-specific options are configured under `options:` (e.g., for `@azure-tools/typespec-python`, `@azure-tools/typespec-java`), the corresponding emitters **SHOULD** also be listed under `emit:`.
- Options configured for emitters not in the `emit` list create confusion about what the config actually drives.

### 12.2 `service-dir` Correctness (TSP-CONFIG-SERVICE-DIR)

- Each language emitter's `service-dir` override (if present) **MUST** point to the correct SDK directory for this service.
- A `service-dir` copied from another service (e.g., `sdk/machinelearning` when the project is for `guestconfiguration`) will cause SDK generation to write to the wrong location.

### 12.3 Duplicate Example Directories (TSP-CONFIG-EXAMPLES)

- With TypeSpec, examples may exist in both `{project-root}/examples/` (source) and `{version}/examples/` (generated output). Verify these are not independently maintained duplicates that can drift — there should be a single source of truth.

---

## TypeSpec Review Checklist Summary

When reviewing TypeSpec files, verify:

- ✅ Correct directory placement (ARM under `resource-manager/<RPNS>/<Service>`, data-plane under `data-plane/<Service>`)
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
- ✅ `Operations` interface defined for ARM resource providers
- ✅ `@armProviderNamespace` applied correctly
- ✅ `@segment` values use camelCase for resource type path segments (TSP-SEGMENT-CASE)
- ✅ PATCH operations named `update` not `patch` (TSP-PATCH-NAME)
- ✅ ARM resource ID properties use `armResourceIdentifier` not `string` (TSP-ARM-RESOURCE-ID)
- ✅ No `@operationId` overrides — restructure interfaces instead
- ✅ URI properties use `url` scalar type, not plain `string`
- ✅ Standard ARM base types used (no custom/private resource decorators)
- ✅ Client customizations only in `client.tsp`
- ✅ `tspconfig.yaml` references correct linter ruleset
- ✅ `tspconfig.yaml` `emit` list matches configured emitter options (TSP-CONFIG-EMIT)
- ✅ `tspconfig.yaml` `service-dir` values point to the correct service directories (TSP-CONFIG-SERVICE-DIR)
- ✅ No unexplained suppressions; no FIXME/TODO/TBD in suppression reasons
- ✅ Suppression reasons are factually accurate and technically justified
- ✅ No duplicate `@added` decorators on the same symbol
- ✅ `@added` version targeting is correct — features don't leak into earlier API version outputs
- ✅ No polymorphic-format properties — use separate typed properties or discriminated unions
- ✅ Numeric properties use numeric types, not string (TSP-NUMERIC-TYPE)
- ✅ No `Record<>` usage when typed models can be defined
- ✅ Every string property inspected for secret indicators (SEC-SECRET-DETECT): flag if property name, doc comment, or examples suggest a secret but `@secret` is missing
- ✅ No `#suppress` directives silencing `secret-prop` lint rules — apply `@secret` instead
- ✅ Integer properties have `@minValue`/`@maxValue` when range is known
- ✅ Datetime properties use `utcDateTime` scalar, not `string`
- ✅ No breaking changes between API versions
- ✅ Generated OpenAPI files match `tsp compile .` output
- ✅ Example files present for all operations
