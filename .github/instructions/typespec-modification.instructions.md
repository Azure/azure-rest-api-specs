---
applyTo:
  - "specification/**/*.tsp"
  - "specification/**/tspconfig.yaml"
  - "specification/**/readme.md"
---

# Copilot Instructions for Modifying TypeSpec Specifications

These instructions apply when modifying **existing** TypeSpec API specifications in this repository — for example, adding a new API version, updating models or operations in an existing version, or adjusting emitter configuration. For creating new TypeSpec projects or converting from Swagger, see `typespec-project.instructions.md`.

## Overview

This repository (`Azure/azure-rest-api-specs`) hosts Azure REST API specifications authored in TypeSpec. Each TypeSpec project compiles into OpenAPI (Swagger) JSON files, which in turn generate SDKs for multiple languages. Changes to `.tsp` files, `tspconfig.yaml`, or `readme.md` must follow specific conventions to pass CI validation and produce correct SDK output.

## Prerequisites

Before modifying a TypeSpec specification:

1. Install [Node.js](https://nodejs.org/en/download) (LTS 18+)
2. From the repository root, install dependencies:
   ```bash
   npm ci
   ```
3. **DO NOT** modify `package.json` or `package-lock.json` at the repository root
4. **DO NOT** add `package.json` or `package-lock.json` files in your project directory

## Project Structure

TypeSpec projects follow a strict directory layout. The location determines whether the project is ARM (control-plane) or data-plane:

```
specification/
└── <orgName>/
    ├── cspell.yaml
    ├── resource-manager/
    │   └── <RPNamespace>/
    │       └── <ServiceName>/
    │           ├── main.tsp              # Service namespace and versioning
    │           ├── models.tsp            # Resource models and properties
    │           ├── employee.tsp          # Additional resource definitions (example)
    │           ├── client.tsp            # SDK client customizations (optional)
    │           ├── tspconfig.yaml        # Emitter and linter configuration
    │           ├── readme.md             # AutoRest readme with version tags
    │           ├── suppressions.yaml     # CI check suppressions (optional)
    │           ├── examples/             # TypeSpec examples by API version
    │           │   └── <api-version>/
    │           │       └── *.json
    │           ├── stable/               # Generated OpenAPI (do not edit manually)
    │           │   └── <api-version>/
    │           │       └── *.json
    │           └── preview/              # Generated OpenAPI (do not edit manually)
    │               └── <api-version>/
    │                   └── *.json
    └── data-plane/
        └── <ServiceName>/               # Same structure without RPNamespace level
```

Use `specification/widget/` as a canonical reference for both ARM and data-plane layouts.

### Key Rules

- Folder names directly under `specification/` **MUST** be lowercase
- Service folder names **MUST** be PascalCase (e.g., `Widget`, `NetApp`)
- ARM package folders **MUST** end with `.Management` when using the v1 structure (e.g., `Storage.Management`)
- TypeSpec files **MUST** only import from the same service folder — cross-service imports are forbidden
- Import paths **MUST** be relative (`./`, `../`) or package references

## Adding a New API Version

Adding a new API version is the most common modification. Follow these steps:

### Step 1: Update the Versions Enum

In `main.tsp`, add a new entry to the `Versions` enum. The enum member name follows the pattern `v<YYYY>_<MM>_<DD>` (with optional `_preview` suffix). The string value uses the format `YYYY-MM-DD` (with optional `-preview` suffix).

For ARM specs, include the `@armCommonTypesVersion` decorator. For preview versions, add the `@previewVersion` decorator.

```tsp
/** The available API versions. */
enum Versions {
  /** 2024-01-01 version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_01_01: "2024-01-01",

  /** 2025-03-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @previewVersion
  v2025_03_01_preview: "2025-03-01-preview",
}
```

The GA version date **MUST** be later than any preceding preview version date.

### Step 2: Use Versioning Decorators

When adding or removing features across versions, use the versioning decorators from `@typespec/versioning`:

```tsp
import "@typespec/versioning";

using TypeSpec.Versioning;
```

| Decorator | Purpose | Example |
|-----------|---------|---------|
| `@added(Versions.vXXXX)` | Mark a type/property as added in a version | New property, new model, new operation |
| `@removed(Versions.vXXXX)` | Mark a type/property as removed in a version | Deprecated resource or operation |
| `@renamedFrom(Versions.vXXXX, "oldName")` | Track a rename across versions | Property or model renamed |
| `@previewVersion` | Mark a version enum member as preview | Preview API versions |

Example:

```tsp
model WidgetProperties {
  /** Widget display name */
  displayName: string;

  /** Widget priority level, added in 2025-03-01-preview */
  @added(Versions.v2025_03_01_preview)
  priority?: int32;
}
```

### Step 3: Add Examples for the New Version

Create example files under `examples/<api-version>/` for each operation. Include both `MaximumSet` and `MinimumSet` variants when applicable:

```
examples/
└── 2025-03-01-preview/
    ├── Widgets_Get_MaximumSet_Gen.json
    ├── Widgets_Get_MinimumSet_Gen.json
    ├── Widgets_CreateOrUpdate_MaximumSet_Gen.json
    └── ...
```

### Step 4: Compile and Regenerate Output

Compile the TypeSpec project to regenerate the OpenAPI output files in `stable/` and `preview/` directories:

```bash
cd specification/<orgName>/resource-manager/<RPNamespace>/<ServiceName>
npx tsp compile .
```

The generated OpenAPI files **MUST** be committed alongside the TypeSpec changes. CI validation checks that the committed swagger files match what `tsp compile` would produce.

### Step 5: Update readme.md

Add a new tag section for the new API version. The default `tag` in the YAML configuration block should point to the latest stable version (or latest preview if no stable version exists). Then add a new `### Tag:` heading with a conditional YAML block referencing the generated OpenAPI file.

See `specification/widget/resource-manager/Microsoft.Widget/Widget/readme.md` for a complete example of the readme format with multiple version tags.

## Modifying an Existing API Version

When modifying an existing version in-place (fixing bugs, adding properties):

1. **Edit the `.tsp` files** — models, operations, or properties as needed
2. **Update examples** under `examples/<api-version>/` to reflect the changes
3. **Run `tsp compile .`** to regenerate the OpenAPI output
4. **Commit both** the TypeSpec source changes and the regenerated OpenAPI files
5. **DO NOT** manually edit files under `stable/` or `preview/` — they are generated output

### Avoid Breaking Changes

Azure services **MUST NOT** introduce breaking changes within a released API version. Breaking changes include:

- Removing or renaming properties, operations, or parameters
- Changing property types (e.g., `boolean` → `string`)
- Removing enum/union values
- Making an optional property required
- Changing the URL path format

If a breaking change is necessary, introduce it in a new API version using `@added` / `@removed` decorators.

## TypeSpec Coding Conventions

### Documentation

Every model, property, operation, parameter, enum, and union **MUST** have a doc comment:

```tsp
/** The color of a widget. */
union WidgetColor {
  string,

  /** Red widget color */
  Red: "Red",

  /** Green widget color */
  Green: "Green",
}
```

Use the `/** */` doc comment format (not `//` or `/* */`).

### Enums and Unions

**DO** use `union` instead of `enum` for Azure service extensible enumerations. This generates extensible enums in SDKs that can accept new values without breaking:

```tsp
/** The widget status. */
union WidgetStatus {
  string,

  /** Widget is active */
  Active: "Active",

  /** Widget is inactive */
  Inactive: "Inactive",
}
```

### Naming

- Property names: `camelCase`
- Model and union names: `PascalCase`
- Operation names: `camelCase`
- Enum/union member names: `PascalCase`
- String values in enums/unions: preserve as-is (do not change casing of string values)

### Client Customizations

SDK-specific customizations (client naming, alternate types, etc.) **MUST** go in a `client.tsp` file. Do not import `@azure-tools/typespec-client-generator-core` in other files:

```tsp
// client.tsp
import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(MyResource, "MyResourceClient", "javascript");
```

### Suppressing Warnings

- **Avoid** suppressing warnings whenever possible — fix the underlying issue instead
- If a suppression is necessary, use the `#suppress` directive with a clear reason:
  ```tsp
  #suppress "@azure-tools/typespec-azure-core/no-enum" "legacy design"
  ```

### Visibility

Use the `Lifecycle` class for visibility decorators:

```tsp
/** The provisioning state (read-only). */
@visibility(Lifecycle.Read)
provisioningState?: ProvisioningState;
```

## Configuration Files

### tspconfig.yaml

This file controls emitter output and linting. When modifying it:

- **DO NOT** remove existing language emitter configurations — this will break SDK generation
- **DO** use the widget templates as a reference:
  - ARM: `specification/widget/resource-manager/Microsoft.Widget/Widget/tspconfig.yaml`
  - Data-plane: `specification/widget/data-plane/WidgetAnalytics/tspconfig.yaml`
- The `linter.extends` field **MUST** include the correct ruleset:
  - ARM specs: `@azure-tools/typespec-azure-rulesets/resource-manager`
  - Data-plane specs: `@azure-tools/typespec-azure-rulesets/data-plane`
- See `language-emitter.instructions.md` for adding new language emitters

### readme.md

The `readme.md` file in a TypeSpec project serves as the AutoRest configuration. It is used by downstream tools (doc generation, Swagger APIView) and **MUST**:

- Set the default `tag` to the latest stable version (or latest preview if no stable exists)
- Include a `### Tag:` section for every API version with its `input-file` list
- Reference the generated OpenAPI files under `stable/` or `preview/`
- Set `openapi-type: arm` for ARM specs

### cspell.yaml

If your changes introduce new terms that fail spell check, add them to the service-level `specification/<orgName>/cspell.yaml`:

```yaml
import:
  - ../../cspell.yaml
words:
  - myterm
  - anotherterm
```

Words are case-insensitive and should be sorted alphabetically.

### suppressions.yaml

To suppress specific CI check failures for legacy swagger files that are not yet migrated to TypeSpec, use a `suppressions.yaml` in the service folder:

```yaml
- tool: TypeSpecRequirement
  path: ./preview/2023-01-01-preview/*.json
  reason: Brownfield service not ready to migrate
```

## Local Validation

Always validate changes locally before pushing. This catches errors early and avoids CI failures.

### TypeSpec Compilation

```bash
cd specification/<orgName>/resource-manager/<RPNamespace>/<ServiceName>
npx tsp compile .
```

The `--warn-as-error` flag is used in CI, so aim to resolve all warnings. If `client.tsp` exists, it is also compiled with `--no-emit` to verify it is valid.

### TypeSpec Formatting

Format all TypeSpec files before committing:

```bash
npx tsp format **/*.tsp
```

CI checks that no files change after running the formatter. Also format `tspconfig.yaml`:

```bash
npx prettier --write tspconfig.yaml
```

### Full Local Validation

The CI pipeline runs a comprehensive set of checks via the TypeSpec validation tool. The individual checks are:

1. **Folder Structure** — correct directory layout and naming conventions
2. **npm Prefix** — npm commands run with the correct prefix
3. **Emit Autorest** — `@azure-tools/typespec-autorest` is in the `emit` array
4. **Flavor Azure** — client emitters set `flavor: azure`
5. **Linter Ruleset** — correct linter ruleset is configured (data-plane vs resource-manager)
6. **Compile** — `tsp compile .` succeeds and generated files match committed files
7. **Format** — TypeSpec and prettier formatting is applied
8. **SDK Config Validation** — emitter options follow naming and structure conventions

For more information on CI checks, see [ci-fix.md](../../documentation/ci-fix.md) and the [TypeSpec Validation wiki](https://github.com/Azure/azure-rest-api-specs/wiki/TypeSpec-Validation).

### Prettier for Generated JSON

If you regenerate OpenAPI output files, format them:

```bash
npx prettier --write **/*.json
```

## CI Checks Reference

The following CI checks run on PRs that modify TypeSpec specifications:

| Check | What It Validates |
|-------|-------------------|
| `TypeSpec Validation` | Compilation, formatting, folder structure, emitter config |
| `Swagger LintDiff` | Linting rules on generated OpenAPI diff |
| `Swagger BreakingChange` | No breaking changes within the same API version |
| `BreakingChange(Cross-Version)` | No breaking changes across API versions |
| `Swagger PrettierCheck` | JSON formatting of generated OpenAPI files |
| `Swagger ModelValidation` | Example files validate against the OpenAPI schema |
| `Swagger SemanticValidation` | OpenAPI semantic correctness |
| `SDK Validation - {Language}` | SDK generation for each configured language |
| `Spell Check` | Spelling in documentation and identifiers |

For troubleshooting CI failures, see [ci-fix.md](../../documentation/ci-fix.md).

## For AI Agents

When modifying TypeSpec specifications:

1. **Read existing code first** — understand the project structure, naming patterns, and versioning conventions before making changes
2. **Identify the service type** — check if the project is ARM (resource-manager) or data-plane, as different rules and rulesets apply
3. **Preserve existing patterns** — match the coding style, documentation format, and naming conventions already in use
4. **Run `tsp compile .` after changes** — always compile and commit the regenerated OpenAPI output
5. **Run `tsp format **/*.tsp` after changes** — ensure TypeSpec files pass formatting checks
6. **Update examples** — when adding or modifying operations/models, update the corresponding example files
7. **Update readme.md** — when adding a new API version, add the corresponding tag section
8. **Cross-reference the widget project** — use `specification/widget/` as the canonical reference for structure and configuration

### Critical Don'ts

- ❌ Don't manually edit files under `stable/` or `preview/` — they are generated by `tsp compile`
- ❌ Don't remove language emitter configs from `tspconfig.yaml` without explicit instruction
- ❌ Don't introduce breaking changes within a released API version
- ❌ Don't add `package.json` or `package-lock.json` to the project directory
- ❌ Don't modify the root `package.json` or `package-lock.json`
- ❌ Don't import from other service folders — only same-folder relative imports are allowed
- ❌ Don't use `enum` for Azure extensible enumerations — use `union` instead
- ❌ Don't skip compiling the spec — CI verifies committed output matches compiled output
- ❌ Don't import `@azure-tools/typespec-client-generator-core` outside of `client.tsp`
- ❌ Don't add multiple `tspconfig.yaml` files for one service

### Critical Do's

- ✅ Do add `/** */` doc comments on all models, properties, operations, parameters, enums, and unions
- ✅ Do use versioning decorators (`@added`, `@removed`) when adding features across API versions
- ✅ Do run `tsp compile .` and commit the generated OpenAPI output
- ✅ Do run `tsp format **/*.tsp` before committing TypeSpec files
- ✅ Do add examples for every new API version under `examples/<api-version>/`
- ✅ Do update `readme.md` with new tag sections when adding API versions
- ✅ Do use `union` with a `string` base for extensible enumerations
- ✅ Do put client customizations in `client.tsp`
- ✅ Do use the correct linter ruleset (resource-manager vs data-plane)
- ✅ Do consult [ci-fix.md](../../documentation/ci-fix.md) when CI checks fail

## Related Files

- TypeSpec project creation: `.github/instructions/typespec-project.instructions.md`
- Language emitter configuration: `.github/instructions/language-emitter.instructions.md`
- ARM OpenAPI review rules: `.github/instructions/armapi-review.instructions.md`
- OpenAPI review rules: `.github/instructions/openapi-review.instructions.md`
- CI troubleshooting: `documentation/ci-fix.md`
- TypeSpec Validation wiki: https://github.com/Azure/azure-rest-api-specs/wiki/TypeSpec-Validation
- TypeSpec documentation: https://typespec.io/docs/
- Azure TypeSpec libraries: https://azure.github.io/typespec-azure/docs/intro/
- Azure REST API Guidelines: https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md
