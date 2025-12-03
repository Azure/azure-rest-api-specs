# Model Validation Guide for Azure Stack HCI API

## Overview

This document provides instructions for running model validation for the Azure Stack HCI API. This guide helps multiple API developers understand the validation process and common issue patterns.

## Prerequisites

- Node.js and npm installed
- Azure REST API Specs repository cloned
- Navigate to the specification directory: `specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI`

## Validation Commands

### 1. TypeSpec Compilation

Before running model validation, always compile the TypeSpec files:

```bash
tsp compile .
```

This command:
- Compiles TypeSpec files to OpenAPI schema
- Generates the preview/{API_VERSION}/hci.json file
- Reports any TypeSpec compilation errors

### 2. Model Validation

Run the model validation command:

```bash
npx oav validate-example preview/{API_VERSION}/hci.json
```

Replace `{API_VERSION}` with your target API version (e.g., `2024-11-01-preview`).

This command validates all examples in the `preview/{API_VERSION}/examples/` folder against the generated OpenAPI schema.

## File Compilation Process

**Important:** Understanding the file compilation process is crucial for successful validation.

### Source vs Target Files

1. **Source Files (where you edit):**
   - `examples/{API_VERSION}/*.json` - Example files you create and modify
   - `private-preview/*.tsp` - TypeSpec model definitions
   - `main.tsp` - Main TypeSpec entry point

2. **Target Files (what validation uses):**
   - `preview/{API_VERSION}/hci.json` - Generated OpenAPI schema
   - `preview/{API_VERSION}/examples/*.json` - Copied example files

### Compilation Flow

```
[Source] examples/2024-11-01-preview/*.json
    ↓ (tsp compile .)
[Target] preview/2024-11-01-preview/examples/*.json
    ↓ (validation reads from)
[Validation] npx oav validate-example preview/2024-11-01-preview/hci.json
```

**Key Point:** You edit source files in `examples/{API_VERSION}/`, but validation runs against the target files in `preview/{API_VERSION}/examples/` that are copied during compilation.

## Common Issue Types and Solutions

### Missing Required Properties

**Description:** Required properties are not included in example files.

**Solution:** Add missing required properties to example files. Check the TypeSpec model definitions to identify required properties.

### Discriminator Value Not Found

**Description:** Discriminated union types don't have concrete model classes defined.

**Solution:** 
1. Define concrete discriminated model classes in TypeSpec files
2. Ensure each discriminated type extends the base discriminated model
3. Example pattern:

```typescript
model ConcreteTypeProperties extends BaseDiscriminatedProperties {
  typeProperty: UnionType.SpecificValue;
}
```

### Additional Properties Not Allowed

**Description:** Example files contain properties that don't belong to the specific resource type.

**Solution:** Remove properties that aren't defined in the TypeSpec model for that resource type. Verify property sets match the model definitions.

### Wrong Operation ID References

**Description:** Example files reference incorrect operation IDs.

**Solution:** Ensure example files reference the correct operation IDs for their respective resource types.

## Validation Workflow

1. **Identify Issues**: Run validation command and review error output
2. **Categorize Errors**: Group errors by type (missing properties, discriminator issues, etc.)
3. **Fix TypeSpec Models**: Update TypeSpec files to define missing models or properties
4. **Fix Example Files**: Update or create example JSON files as needed
5. **⚠️ CRITICAL: Recompile**: **ALWAYS** run `tsp compile .` after ANY changes to regenerate OpenAPI schema and copy updated examples
6. **Validate Again**: Run validation command to confirm fixes
7. **Iterate**: Repeat until validation passes without errors

### ⚠️ IMPORTANT: TypeSpec Compilation Requirement

**You MUST run `tsp compile .` after every change to example files or TypeSpec models.**

The compilation process:
1. Compiles TypeSpec files into OpenAPI schema: `preview/{API_VERSION}/hci.json`
2. Copies source example files: `examples/{API_VERSION}/*.json` → `preview/{API_VERSION}/examples/*.json`
3. Validation then reads from the target files in `preview/{API_VERSION}/`

**Common mistake:**
- Edit source files in `examples/{API_VERSION}/` ✅
- Run validation ❌ (without recompilation)
- Get same errors because validation reads old copies in `preview/{API_VERSION}/examples/`

**Correct workflow:**
- Edit source files in `examples/{API_VERSION}/` ✅
- Run `tsp compile .` (copies files to `preview/{API_VERSION}/examples/`) ✅
- Run validation against `preview/{API_VERSION}/hci.json` ✅
- See updated results ✅

## Best Practices

1. **Consistent Property Sets**: Ensure example files include all required properties for their resource type
2. **Proper Discriminated Types**: Always define concrete classes for discriminated union types
3. **Correct Operation References**: Use the appropriate operation IDs in example files
4. **Resource Type Alignment**: Don't mix properties from different resource types in examples
5. **Regular Validation**: Run validation frequently during development to catch issues early

## Success Criteria

Model validation is successful when the command output shows:
```
Validation completes without errors.
```

## Troubleshooting

If validation continues to fail after fixes:
1. Ensure TypeSpec compilation was successful
2. Check that the OpenAPI schema was regenerated
3. Verify example file paths are correct
4. Review discriminator mappings in the generated schema
5. Compare working examples with problematic ones to identify patterns

## Version-Specific Issues

For specific issues encountered in particular API versions, refer to the corresponding version-specific documentation files in this directory (e.g., `model-validation-fixes-{API_VERSION}.md`).

## Contact

For questions or additional support with model validation, refer to the Azure REST API Specs repository documentation or reach out to the API development team.