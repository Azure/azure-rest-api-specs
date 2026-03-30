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
- Integer properties **SHOULD** specify bit width: `int32`, `int64`.
- Array properties **MUST** have their element type defined.
- **AVOID** using `unknown` type — use a concrete type or a well-defined model.

---

## 5. ARM Resource Definitions (TypeSpec)

### 5.1 Resource Base Types

- ARM tracked resources **MUST** extend `TrackedResource<TProperties>` from `@azure-tools/typespec-azure-resource-manager`.
- ARM proxy resources **MUST** extend `ProxyResource<TProperties>`.
- Extension resources **MUST** extend `ExtensionResource<TProperties>`.
- **DO NOT** manually define `id`, `name`, `type`, `location`, `tags`, or `systemData` — these come from the base types.

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

## 8. Suppressions

### 8.1 Warning Suppression Policy

- **AVOID** suppressing warnings. Every suppression needs justification.
- If a suppression is present, verify it has a clear reason documented:
  ```tsp
  #suppress "@azure-tools/typespec-azure-core/no-enum" "Justified: this enum is closed and will never change"
  ```
- Suppressions of **errors** are not allowed — errors must be fixed.
- Flag any unexplained or blanket suppressions.

---

## 9. Common Anti-Patterns

Flag these issues when found:

- **Duplicate namespace declarations** across multiple `.tsp` files without proper imports.
- **Missing `using` statements** — if decorators from a library are used, the library must be imported and `using` must be declared.
- **Inline anonymous models** — prefer named model definitions for reusability and clarity.
- **Overly broad `@visibility("none")`** — verify the intent is correct; this hides properties from all contexts.
- **Circular references** without `@visibility` to break the cycle.
- **Hardcoded API version strings** instead of using the versioning enum.
- **Missing examples** — every operation should have corresponding example files.

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
- ✅ `union` used instead of `enum` for extensible Azure enums
- ✅ Visibility decorators use `Lifecycle` class values
- ✅ ARM resources extend correct base types (`TrackedResource`, `ProxyResource`, etc.)
- ✅ All CRUD operations present for ARM tracked resources
- ✅ `Operations` interface defined for ARM resource providers
- ✅ `@armProviderNamespace` applied correctly
- ✅ Client customizations only in `client.tsp`
- ✅ `tspconfig.yaml` references correct linter ruleset
- ✅ No unexplained suppressions
- ✅ No breaking changes between API versions
- ✅ Generated OpenAPI files match `tsp compile .` output
- ✅ Example files present for all operations
