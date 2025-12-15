# JSON Formatting with Prettier Guide

## Overview

This document provides instructions for using Prettier to format JSON files in the Azure Stack HCI API examples. Prettier ensures consistent formatting across all example files, improving readability and maintainability.

## Prerequisites

- Node.js and npm installed
- Azure REST API Specs repository cloned
- Navigate to the specification directory: `specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI`

## Prettier Commands

### Format Source JSON Examples for Specific API Version

To format source JSON examples for a specific API version, use the following command:

```bash
npx prettier --write .\examples\{API_VERSION}\*.json
```

Replace `{API_VERSION}` with your target API version. Examples:

```bash
# Format source examples for 2024-11-01-preview
npx prettier --write .\examples\2024-11-01-preview\*.json

# Format source examples for 2025-09-22-preview
npx prettier --write .\examples\2025-09-22-preview\*.json

# Format source examples for 2025-10-01
npx prettier --write .\examples\2025-10-01\*.json
```

### Format All Source Examples

To format all source JSON examples across all API versions:

```bash
npx prettier --write .\examples\*\*.json
```

## When to Run Prettier

### 1. After Creating New Examples

Run prettier on source files after creating new example files to ensure consistent formatting:

```bash
# Create your example files in examples/{API_VERSION}/, then format them
npx prettier --write .\examples\{API_VERSION}\*.json
```

### 2. Before TypeSpec Compilation

Include prettier formatting as part of your development workflow, before compilation:

```bash
# 1. Format source JSON examples
npx prettier --write .\examples\{API_VERSION}\*.json

# 2. Compile TypeSpec (copies formatted files to preview/{API_VERSION}/examples/)
tsp compile .

# 3. Run model validation
npx oav validate-example preview/{API_VERSION}/hci.json
```

### 3. Before Committing Changes

Always format your source JSON files before committing to ensure consistency:

```bash
npx prettier --write .\examples\{API_VERSION}\*.json
```

## Prettier Configuration

Prettier will use the default configuration for JSON files, which includes:
- 2-space indentation
- Double quotes for strings
- Trailing commas where valid
- Consistent object and array formatting

## Integration with Development Workflow

### Complete Development Workflow

```bash
# 1. Make changes to TypeSpec files or example files in examples/{API_VERSION}/
# 2. Format source JSON examples
npx prettier --write .\examples\{API_VERSION}\*.json

# 3. Compile TypeSpec (copies formatted source files to preview/{API_VERSION}/examples/)
tsp compile .

# 4. Run model validation
npx oav validate-example preview/{API_VERSION}/hci.json

# 5. If validation passes, commit your changes
```

### Quick Format Check

To check if source files need formatting without modifying them:

```bash
npx prettier --check .\examples\{API_VERSION}\*.json
```

This command will return a non-zero exit code if any files need formatting.

## File Structure Impact

**Important:** Format the source files in the `examples/{API_VERSION}/` directory before compilation. The `tsp compile .` command copies these formatted files to the target directory used by validation.

### Source vs Target Files

- **Source Files:** `examples/{API_VERSION}/*.json` (where you edit and format)
- **Target Files:** `preview/{API_VERSION}/examples/*.json` (copied from source during compilation, used by validation)

### Correct Formatting and Compilation Order

```
1. Edit source files: examples/{API_VERSION}/*.json
2. Format source files: npx prettier --write .\examples\{API_VERSION}\*.json
3. Compile TypeSpec: tsp compile . (copies formatted files to preview/{API_VERSION}/examples/)
4. Run validation: npx oav validate-example preview/{API_VERSION}/hci.json
```

## Best Practices

1. **Format Before Compilation**: Always format source files before `tsp compile .` to ensure formatted files are copied to the target directory
2. **Version-Specific Formatting**: Use specific API version paths when working on a particular version
3. **Batch Formatting**: Use wildcard patterns to format multiple files efficiently
4. **Pre-Commit Formatting**: Include formatting as part of your pre-commit process
5. **Consistent Workflow**: Integrate prettier into your standard development workflow before TypeSpec compilation and validation

## Common Commands Summary

```bash
# Most common: Format source files before compilation
npx prettier --write .\examples\{API_VERSION}\*.json
tsp compile .

# Format all source examples across versions
npx prettier --write .\examples\*\*.json

# Check formatting without changing files
npx prettier --check .\examples\{API_VERSION}\*.json

# Complete workflow with validation
npx prettier --write .\examples\{API_VERSION}\*.json
tsp compile .
npx oav validate-example preview/{API_VERSION}/hci.json
```

## Troubleshooting

### Prettier Not Found

If you get "npx: prettier not found", install prettier globally:

```bash
npm install -g prettier
```

Or use it locally in the project:

```bash
npm install prettier --save-dev
npx prettier --write .\preview\{API_VERSION}\examples\*.json
```

### Permission Issues

On Windows, if you encounter permission issues, try running the command from an elevated PowerShell or Command Prompt.

### Path Issues

Ensure you're running the command from the correct directory:
`specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI`

## Contact

For questions about JSON formatting or prettier configuration, refer to the [Prettier documentation](https://prettier.io/) or reach out to the API development team.