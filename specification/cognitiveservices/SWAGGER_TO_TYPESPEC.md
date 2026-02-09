# Cognitive Services Swagger to TypeSpec Conversion

This document provides a comprehensive guide for converting the Cognitive Services control plane API definitions from Swagger (OpenAPI v2) to TypeSpec.

## Overview

The Cognitive Services API uses Swagger for its control plane (ARM) API definitions. This conversion process will transform those Swagger definitions into TypeSpec, which is now the required format for all new ARM services in Azure.

**Location:** `specification/cognitiveservices/resource-manager/`

**Current State:**
- Swagger files: `Microsoft.CognitiveServices/preview/` and `Microsoft.CognitiveServices/stable/`
- AutoRest configuration: `readme.md`

**Target State:**
- TypeSpec project: `Microsoft.CognitiveServices/CognitiveServices.Management/`
- Generated Swagger from TypeSpec compilation

## Prerequisites

Before starting the conversion, ensure you have:

1. **Node.js** (v18 or later) with npm
2. **Git** for version control
3. A local clone of `Azure/azure-rest-api-specs` repository
4. Basic understanding of TypeSpec syntax (optional, but helpful)

## Quick Start

### Using the Automated Scripts

Two conversion scripts are provided for convenience:

#### Bash (Linux/macOS/WSL)
```bash
cd specification/cognitiveservices
./convert-to-typespec.sh
```

#### PowerShell (Windows)
```powershell
cd specification\cognitiveservices
.\convert-to-typespec.ps1
```

These scripts will:
1. Install required npm dependencies
2. Run the TypeSpec conversion tool
3. Generate the TypeSpec project structure
4. Display next steps for review and validation

## Manual Conversion Process

If you prefer to run the conversion manually or need to customize the process:

### Step 1: Install Dependencies

From the repository root:
```bash
npm ci
```

This installs all required TypeSpec tools, including `@azure-tools/typespec-client-generator-cli` (tsp-client).

### Step 2: Run the Conversion

```bash
npx tsp-client convert \
  --swagger-readme specification/cognitiveservices/resource-manager/readme.md \
  --arm
```

**Options explained:**
- `--swagger-readme`: Path to the AutoRest configuration file (readme.md)
- `--arm`: Indicates this is an Azure Resource Manager (control plane) specification

**Optional flags:**
- `--output-dir <path>`: Specify a different output directory (default is auto-determined)
- `--fully-compatible`: Generate TypeSpec that's fully compatible with the original Swagger (not recommended; prefer idiomatic TypeSpec)
- `--no-prompt`: Skip interactive prompts (useful for CI/CD)
- `--debug`: Enable debug logging for troubleshooting

### Step 3: Review the Generated Files

The conversion creates a new TypeSpec project at:
```
specification/cognitiveservices/resource-manager/Microsoft.CognitiveServices/CognitiveServices.Management/
├── main.tsp              # Main service definition
├── models.tsp            # Model definitions
├── operations.tsp        # Operations (may be split across files)
├── tspconfig.yaml        # TypeSpec configuration
└── examples/             # Example files
```

## Post-Conversion Validation

After conversion, you MUST review and fix the generated TypeSpec to ensure quality and compliance.

### 1. Verify Service Definition

Check `main.tsp` for the service definition:

```typescript
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@service({
  title: "Microsoft Cognitive Services Management API",
})
@armProviderNamespace
@versioned(Versions)
namespace Microsoft.CognitiveServices;

/** API versions */
enum Versions {
  /** 2025-10-01-preview version */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_10_01_preview: "2025-10-01-preview",
}
```

### 2. Add Security Definition

Ensure authentication is specified (add if missing):

```typescript
@useAuth(AzureAuth)
```

This should appear once, typically above the namespace declaration or in main.tsp.

### 3. Review and Document All Types

The converter may not add complete documentation. Add JSDoc-style comments to:

- All models
- All properties
- All operations
- All parameters
- All enum/union values

Example:
```typescript
/** Represents a Cognitive Services account. */
model Account extends TrackedResource {
  /** The account properties. */
  properties?: AccountProperties;
}
```

### 4. Fix Enums

Azure best practice is to use `union` types instead of `enum`:

**Before (enum):**
```typescript
enum SkuName {
  Free,
  Standard,
  Premium,
}
```

**After (union):**
```typescript
/** SKU names for Cognitive Services accounts. */
union SkuName {
  string,
  
  /** Free tier */
  Free: "F0",
  
  /** Standard tier */
  Standard: "S0",
  
  /** Premium tier */
  Premium: "P0",
}
```

### 5. Compile and Test

Compile the TypeSpec to generate OpenAPI:

```bash
cd specification/cognitiveservices/resource-manager/Microsoft.CognitiveServices/CognitiveServices.Management
tsp compile .
```

This will generate OpenAPI files in the `preview/` and `stable/` directories.

**Fix any compilation errors before proceeding.**

### 6. Compare Generated vs Original Swagger

Compare the newly generated OpenAPI with the original Swagger files:

```bash
# Example using diff
diff -u \
  Microsoft.CognitiveServices/preview/2025-10-01-preview/cognitiveservices.json \
  CognitiveServices.Management/preview/2025-10-01-preview/cognitiveservices.json
```

Ensure:
- All operations are present
- All models are correctly defined
- No breaking changes are introduced
- Schema validation passes

## Common Issues and Solutions

### Issue: Missing or Incorrect Versioning

**Problem:** Compilation error about missing `@useDependency`

**Solution:** Add `@useDependency` decorators to the version enum:
```typescript
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_10_01_preview: "2025-10-01-preview",
}
```

### Issue: Camel Case Warnings

**Problem:** Linter warnings about property naming

**Solution:** Ensure all properties use camelCase:
- `resourceGroupName` ✓
- `ResourceGroupName` ✗
- `resource_group_name` ✗

### Issue: Missing Security Definition

**Problem:** Operations lack authentication information

**Solution:** Add `@useAuth(AzureAuth)` in main.tsp

### Issue: Incomplete Documentation

**Problem:** Models, operations, or properties lack descriptions

**Solution:** Add JSDoc-style comments (`/** ... */`) above each element

## Commands Reference

### Installation
```bash
npm ci                          # Install dependencies
```

### Conversion
```bash
npx tsp-client convert --swagger-readme <path> --arm    # Convert to TypeSpec
```

### Compilation
```bash
tsp compile .                   # Compile TypeSpec to OpenAPI
tsp compile . --watch           # Watch mode for continuous compilation
```

### Validation
```bash
tsp format **/*.tsp             # Format TypeSpec files
tsp compile . --no-emit         # Validate without generating files
```

## Resources

### Documentation
- [TypeSpec Language Documentation](https://typespec.io/docs/)
- [Azure TypeSpec Guidelines](https://azure.github.io/typespec-azure/docs/intro/)
- [TypeSpec for ARM](https://azure.github.io/typespec-azure/docs/libraries/azure-resource-manager/reference)
- [Getting Started with TypeSpec](../../documentation/Getting-started-with-TypeSpec-specifications.md)

### Templates and Examples
- Widget Example (ARM): `specification/widget/resource-manager/`
- Contoso Example (ARM): `specification/contosowidgetmanager/Contoso.Management/`

### Migration Guides
- [TypeSpec Project Instructions](/.github/instructions/typespec-project.instructions.md)
- [ARM Migration Instructions](/.github/instructions/mgmt-migration.instructions.md)
- [TypeSpec Structure Guidelines](../../documentation/typespec-structure-guidelines.md)

## Next Steps After Conversion

1. **Review and Fix**: Go through the migration checklist above
2. **Compile**: Ensure TypeSpec compiles without errors
3. **Validate**: Compare generated OpenAPI with original Swagger
4. **Test**: Run any existing tests to ensure compatibility
5. **Document**: Update documentation to reflect TypeSpec usage
6. **Create PR**: Submit the TypeSpec project for review
7. **Deprecate Swagger**: Plan to deprecate direct Swagger maintenance

## Support

For questions or issues:
1. Check [TypeSpec documentation](https://typespec.io/docs/)
2. Review [Azure TypeSpec guidelines](https://azure.github.io/typespec-azure/docs/intro/)
3. Consult the widget reference implementation
4. Open an issue in the repository

## Notes

- **Conversion is one-time**: After migration to TypeSpec, maintain only TypeSpec files
- **Generated files are read-only**: Never manually edit generated OpenAPI files
- **Follow Azure conventions**: Use ARM templates and patterns
- **Test thoroughly**: Ensure no breaking changes are introduced
- **Document changes**: Keep clear records of the migration process
