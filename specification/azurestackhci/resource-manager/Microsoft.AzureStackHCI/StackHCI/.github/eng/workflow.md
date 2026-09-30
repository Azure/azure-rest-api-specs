# Development Workflow Guide for Azure Stack HCI API

## Overview

This document provides a comprehensive guide for developing, formatting, and validating Azure Stack HCI API specifications. It covers the complete workflow from TypeSpec development through JSON formatting and model validation.

## Prerequisites

- Node.js and npm installed
- Azure REST API Specs repository cloned
- Navigate to the specification directory: `specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI`

---

## Complete Development Workflow

The recommended workflow for API development follows this sequence:

```
1. Edit TypeSpec files (models, properties, etc.)
2. Identify and update all affected source example files
3. Format JSON source files with Prettier
4. Compile TypeSpec (generates schema and copies examples)
5. Run model validation
6. Fix any issues and repeat
7. Final verification and cleanup
```

### Step 2 Detail: Updating Examples When Adding New Properties

When you add a new property or model in TypeSpec, you must find and update every example file that includes the parent model. Here's how:

1. **Identify which examples use the model.** Search for the parent model's property name in example files:
   ```bash
   # e.g., adding "disks" to the "Storage" model — find examples that have "storage":
   grep -rl "\"storage\"" examples/{API_VERSION}/*.json
   ```

2. **Determine request vs. response placement.** If the new property or its child model uses `@visibility(Lifecycle.Read)` (read-only), add it **only to response bodies** (200/201), not the request body. If the property is writable, add it to both.

3. **Handle PUT examples carefully.** PUT examples typically have three sections containing the same model:
   - **Request body** — the input payload (shallower indentation)
   - **200 response body** — returned on update
   - **201 response body** — returned on create
   
   The 200 and 201 bodies are usually identical. For read-only properties, only the response bodies should include them.

4. **Don't forget non-deployment examples.** A model like `HciStorageProfile` may appear in `ListEdgeDevices.json` (reported properties), not just `PutDeploymentSettings*.json`. Search broadly.

### Quick Reference Commands

```bash
# Complete workflow for a specific API version
npx prettier --write .\examples\{API_VERSION}\*.json
npx tsp format *
tsp compile .
npx oav validate-example preview/{API_VERSION}/hci.json
```

Replace `{API_VERSION}` with your target API version (e.g., `2024-11-01-preview`, `2025-09-22-preview`).

---

## File Structure

### Source vs Target Files

Understanding the file structure is crucial for successful development:

| Type | Location | Purpose |
|------|----------|---------|
| **Source Examples** | `examples/{API_VERSION}/*.json` | Where you edit and format |
| **Source TypeSpec** | `*.tsp` | TypeSpec model definitions |
| **Target Schema** | `preview/{API_VERSION}/hci.json` | Generated OpenAPI schema |
| **Target Examples** | `preview/{API_VERSION}/examples/*.json` | Copied from source during compilation |

### Compilation Flow

```
[Source] examples/{API_VERSION}/*.json
    ↓ (npx tsp format *)
[Formatted] *.tsp files
    ↓ (tsp compile .)
[Target] preview/{API_VERSION}/examples/*.json
    ↓ (validation reads from)
[Validation] npx oav validate-example preview/{API_VERSION}/hci.json
```

**Key Point:** You edit source files in `examples/{API_VERSION}/`, but validation runs against the target files in `preview/{API_VERSION}/examples/` that are copied during compilation.

---

## Part 1: JSON Formatting with Prettier

### Why Format JSON Files?

Prettier ensures consistent formatting across all example files, improving readability and maintainability.

### Prettier Commands

#### Format Source JSON Examples for Specific API Version

```bash
npx prettier --write .\examples\{API_VERSION}\*.json
```

Examples:
```bash
# Format source examples for 2024-11-01-preview
npx prettier --write .\examples\2024-11-01-preview\*.json

# Format source examples for 2025-09-22-preview
npx prettier --write .\examples\2025-09-22-preview\*.json

# Format source examples for 2025-10-01
npx prettier --write .\examples\2025-10-01\*.json
```

#### Format All Source Examples

```bash
npx prettier --write .\examples\*\*.json
```

#### Check Formatting Without Modifying Files

```bash
npx prettier --check .\examples\{API_VERSION}\*.json
```

This command returns a non-zero exit code if any files need formatting.

### When to Run Prettier

1. **After Creating New Examples** - Format new example files before compilation
2. **Before TypeSpec Compilation** - Ensure formatted files are copied to target
3. **Before Committing Changes** - Maintain consistency across the repository

### Prettier Configuration

Prettier uses default JSON configuration:
- 2-space indentation
- Double quotes for strings
- Trailing commas where valid
- Consistent object and array formatting

---

## Part 2: TypeSpec Compilation

### Compilation Command

```bash
tsp compile .
```

This command:
- Compiles TypeSpec files to OpenAPI schema
- Generates the `preview/{API_VERSION}/hci.json` file
- Copies formatted source examples to `preview/{API_VERSION}/examples/`
- Reports any TypeSpec compilation errors

### ⚠️ CRITICAL: Compilation Requirement

**You MUST run `tsp compile .` after every change to example files or TypeSpec models.**

**Common mistake:**
- Edit source files in `examples/{API_VERSION}/` ✅
- Run validation ❌ (without recompilation)
- Get same errors because validation reads old copies in `preview/{API_VERSION}/examples/`

**Correct workflow:**
- Edit source files in `examples/{API_VERSION}/` ✅
- Run `tsp compile .` (copies files to `preview/{API_VERSION}/examples/`) ✅
- Run validation against `preview/{API_VERSION}/hci.json` ✅
- See updated results ✅

---

## Part 3: Model Validation

### Validation Command

```bash
npx oav validate-example preview/{API_VERSION}/hci.json
```

This command validates all examples in the `preview/{API_VERSION}/examples/` folder against the generated OpenAPI schema.

### Common Issue Types and Solutions

#### Missing Required Properties

**Description:** Required properties are not included in example files.

**Solution:** Add missing required properties to example files. Check the TypeSpec model definitions to identify required properties.

#### Discriminator Value Not Found

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

#### Read-Only Properties in Request Body (`READONLY_PROPERTY_NOT_ALLOWED_IN_REQUEST`)

**Description:** Properties decorated with `@visibility(Lifecycle.Read)` (which generates `"readOnly": true` in the OpenAPI schema) appear in the request body of a PUT/PATCH example.

**Solution:**
- Include read-only properties **only in response bodies** (200/201), not in the request body.
- If the parent property (e.g., `disks`) contains a model whose fields are all read-only, omit the entire property from the request body.
- Be careful when the 200 and 201 response bodies in a PUT example are structurally identical — text-based find-and-replace tools may match both responses but miss the request body (which has different indentation). Verify each section independently.

**Example:** A `Disk` model with `@visibility(Lifecycle.Read)` on `id`, `size`, `type`:
```json
// ❌ Request body — do NOT include read-only properties
"storage": {
  "configurationMode": "Express",
  "disks": [ { "id": "disk-1", "size": "1024GB" } ]  // WRONG
}

// ✅ Response body (200/201) — read-only properties belong here
"storage": {
  "configurationMode": "Express",
  "disks": [ { "id": "disk-1", "size": "1024GB", "type": "SSD" } ]
}
```

---

#### Additional Properties Not Allowed

**Description:** Example files contain properties that don't belong to the specific resource type.

**Solution:** Remove properties that aren't defined in the TypeSpec model for that resource type.

#### Wrong Operation ID References

**Description:** Example files reference incorrect operation IDs.

**Solution:** Ensure example files reference the correct operation IDs for their respective resource types.

---

## Part 4: Deleting Files

### ⚠️ CRITICAL: Delete Scenario - Source AND Target Files

**When deleting example files, you MUST delete both source AND target files.**

**Why This Matters:**
- TypeSpec compilation copies source files to target but does NOT remove deleted source files from target
- Validation reads from `preview/{API_VERSION}/examples/`, not `examples/{API_VERSION}/`
- If you only delete source files, validation continues to validate old files still present in target directory

### Correct Delete Workflow

```bash
# Delete both source AND target
del "examples/{API_VERSION}/problematic-file.json"
del "preview/{API_VERSION}/examples/problematic-file.json"

# Then recompile and validate
tsp compile .
npx oav validate-example preview/{API_VERSION}/hci.json
```

**Common Delete Mistake:**
- Delete source file only ✅
- Run `tsp compile .` ✅
- Run validation ❌ Still fails because old file exists in `preview/{API_VERSION}/examples/`

---

## Troubleshooting

### Prettier Not Found

```bash
# Install prettier globally
npm install -g prettier

# Or use it locally
npm install prettier --save-dev
npx prettier --write .\examples\{API_VERSION}\*.json
```

### Permission Issues (Windows)

Run commands from an elevated PowerShell or Command Prompt.

### Path Issues

Ensure you're running commands from the correct directory:
`specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI`

### Validation Continues to Fail

1. Ensure TypeSpec compilation was successful
2. Check that the OpenAPI schema was regenerated
3. **Verify you deleted BOTH source AND target example files**
4. Verify example file paths are correct
5. Review discriminator mappings in the generated schema
6. Compare working examples with problematic ones
7. List files in `preview/{API_VERSION}/examples/` to confirm deleted files are gone

---

## Best Practices

1. **Format Before Compilation**: Always format source files (`npx prettier` for JSON, `npx tsp format *` for TypeSpec) before `tsp compile .`
2. **Version-Specific Formatting**: Use specific API version paths when working on a particular version
3. **Consistent Property Sets**: Ensure example files include all required properties
4. **Proper Discriminated Types**: Always define concrete classes for discriminated union types
5. **Regular Validation**: Run validation frequently during development
6. **Pre-Commit Checks**: Include formatting and validation in your pre-commit process
7. **Final verification and cleanup**: Re-run formatting, compilation, and validation, then confirm no stale example files remain in `preview/{API_VERSION}/examples/`.
8. **Read-Only Awareness in Examples**: When a model or its properties use `@visibility(Lifecycle.Read)`, remember to include those properties only in response bodies of example files, never in request bodies.

---

## Success Criteria

Development is successful when:
1. `npx prettier --check` shows "All matched files use Prettier code style!"
2. `tsp compile .` completes without errors
3. `npx oav validate-example` completes without errors

---

## Common Commands Summary

```bash
# Format source examples for specific version
npx prettier --write .\examples\{API_VERSION}\*.json

# Format all source examples
npx prettier --write .\examples\*\*.json

# Check formatting without modifying
npx prettier --check .\examples\{API_VERSION}\*.json

# Format TypeSpec files
npx tsp format *

# Compile TypeSpec
tsp compile .

# Run model validation
npx oav validate-example preview/{API_VERSION}/hci.json

# Complete workflow
npx prettier --write .\examples\{API_VERSION}\*.json && npx tsp format * && tsp compile . && npx oav validate-example preview/{API_VERSION}/hci.json
```

---

## Contact

For questions about JSON formatting, model validation, or the development workflow, refer to the [Prettier documentation](https://prettier.io/) or reach out to the API development team.
