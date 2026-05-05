# TypeSpec Style Guide for Azure Stack HCI

This document outlines the coding standards and best practices for TypeSpec files in the Azure Stack HCI specification.

## File Organization

### File Naming Convention

- **All TypeSpec files MUST use PascalCase** (e.g., `Cluster.tsp`, `EdgeMachine.tsp`, `DevicePool.tsp`)
- Resource-specific files should be named after the resource (e.g., `Cluster.tsp`, `Extension.tsp`)
- Files containing multiple related resources use plural form (e.g., `Operations.tsp`)

### File Structure Pattern

Each resource TypeSpec file should follow this structure:

```typespec
// 1. Imports (external libraries first, then local imports)
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

// 2. Using statements (only include what is actually used)
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

// 3. Namespace declaration (no @armProviderNamespace - already in main.tsp)
namespace Microsoft.AzureStackHCI;

// 4. Resource model definition
/**
 * Resource description.
 */
@parentResource(ParentResource)  // if applicable
@added(Versions.v2026_03_01_preview)  // if version-specific
model MyResource is Azure.ResourceManager.TrackedResource<MyResourceProperties> {
  ...ResourceNameParameter<...>;
}

// 5. Interface with operations
@armResourceOperations
interface MyResources {
  /**
   * Operation description.
   */
  get is ArmResourceRead<MyResource>;
  // ... other operations
}

// 6. Augmentation decorators (@@doc, etc.)
@@doc(MyResource.name, "Description of the name parameter");
```

## Models Centralization

### Rule: Models go in `models.tsp`

- **All model/union definitions MUST be placed in `models.tsp`**
- Resource definitions (e.g., `model Cluster is TrackedResource<...>`) stay in their respective files
- Properties models (e.g., `ClusterProperties`) go in `models.tsp`

### Section Comments

When adding models to `models.tsp`, group related models under section comments:

```typespec
////////////////////////////////////////////////////////////////
////////////////////// My Feature Models //////////////////////
////////////////////////////////////////////////////////////////

model MyFeatureProperties {
  // ...
}

model MyFeatureRequest {
  // ...
}
```

## Documentation Style

### Rule: Use JSDoc-style comments (`/** */`)

**DO use JSDoc comments:**
```typespec
/**
 * Description of the model.
 */
model MyModel {
  /**
   * Description of the property.
   */
  myProperty?: string;
}
```

**DO NOT use @doc decorator for new code:**
```typespec
// Avoid this pattern
@doc("Description")
model MyModel {
  @doc("Property description")
  myProperty?: string;
}
```

### Conversion Script

If you encounter files with `@doc` decorators, use the conversion script:

```powershell
# Dry run to see what would change
.\eng\convert-doc-to-jsdoc.ps1 -Path "." -DryRun

# Apply changes
.\eng\convert-doc-to-jsdoc.ps1 -Path "."
```

## Imports and Using Statements

### Rule: Only import/use what you need

**Required imports for most resource files:**
```typespec
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
```

**Common using statements:**
| Statement | When to use |
|-----------|-------------|
| `using TypeSpec.Rest;` | Always needed for ARM resources |
| `using Azure.ResourceManager;` | Always needed for ARM resources |
| `using TypeSpec.Versioning;` | When using `@added`, `@removed`, `Versions.*` |
| `using TypeSpec.Http;` | When using `@patch`, `@get`, `@post`, etc. |
| `using Azure.Core;` | When using `armResourceIdentifier` |
| `using Azure.ClientGenerator.Core;` | When using `@@clientName` |

### Rule: No redundant @armProviderNamespace

The `@armProviderNamespace` decorator is declared once in `main.tsp`. Individual resource files should only declare:

```typespec
namespace Microsoft.AzureStackHCI;
```

## Versioning

### Adding to a new API version

Use `@added` decorator to indicate version availability:

```typespec
@added(Versions.v2026_03_01_preview)
model NewFeature {
  // ...
}
```

### Version-specific changes

For properties or models added in specific versions:

```typespec
model ExistingModel {
  existingProperty: string;

  @added(Versions.v2026_03_01_preview)
  newProperty?: string;
}
```

## Code Review Checklist

When reviewing TypeSpec changes, verify:

- [ ] File name uses PascalCase except: client.tsp,  back-compatible.tsp and models.tsp
- [ ] Models are defined in `models.tsp` (not in resource files)
- [ ] Documentation uses `/** */` style (not `@doc`)
- [ ] No unused imports or using statements
- [ ] No redundant `@armProviderNamespace` declaration
- [ ] Section comments used when adding groups of models
- [ ] Proper versioning decorators applied
- [ ] Compilation succeeds (`npx tsp compile .`)

## Running Compilation

Always verify changes compile successfully:

```bash
npx tsp compile .
```

## Tools

| Script | Purpose |
|--------|---------|
| `eng/convert-doc-to-jsdoc.ps1` | Convert `@doc` decorators to `/** */` comments |
| `eng/version-creator.md` | Instructions for creating new API versions |
