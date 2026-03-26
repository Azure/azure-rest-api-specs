# API Version Creator Guide

## Overview

This document provides step-by-step instructions for creating a new API version in the Azure Stack HCI TypeSpec project. Follow these steps to properly create and configure a new preview or stable API version.

## Prerequisites

- Node.js and npm installed
- TypeSpec compiler installed (`npm install -g @typespec/compiler`)
- Azure REST API Specs repository cloned
- Navigate to: `specification/azurestackhci/resource-manager/Microsoft.AzureStackHCI/StackHCI`

## Creating a New Preview Version

### Step 1: Update main.tsp with New Version

Add the new API version to the `Versions` enum in [`main.tsp`](../main.tsp), replacing the previous preview version:

```typespec
enum Versions {
  /**
   * The 2026-02-01 API version.
   */
  v2026_02_01: "2026-02-01",

  /**
   * The 2026-04-01-preview API version.
   */
  v2026_04_01_preview: "2026-04-01-preview",
}
```

**Important:** Remove the previous preview version from the enum when replacing it (e.g., remove `v2026_03_01_preview` when adding `v2026_04_01_preview`).

### Step 2: Update Version References in TSP Files

Search and replace all references to the old preview version with the new one across all `.tsp` files:

```powershell
# PowerShell command to find and replace version references in all tsp files
Get-ChildItem -Path . -Filter "*.tsp" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    if ($content -match "v2026_03_01_preview") {
        $content = $content -replace "v2026_03_01_preview", "v2026_04_01_preview"
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Updated: $($_.Name)"
    }
}
```

Common files that may need updates:
- Resource definition files (e.g., `Cluster.tsp`, `DeploymentSetting.tsp`, etc.)
- Model files (`models.tsp`, `commonModels.tsp`)
- Any file using `@added` or `@removed` decorators with the version

### Step 3: Rename Examples Directory

Rename the examples directory from the old preview version to the new one:

```powershell
# Rename the examples directory
Rename-Item -Path "examples\2026-03-01-preview" -NewName "2026-04-01-preview"
```

### Step 4: Update API Version in Example Files

Update the `api-version` query parameter in all example JSON files:

```powershell
# PowerShell script to update api-version in all example files
Get-ChildItem -Path "examples\2026-04-01-preview" -Filter "*.json" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $content = $content -replace "2026-03-01-preview", "2026-04-01-preview"
    Set-Content -Path $_.FullName -Value $content -NoNewline
}
```

### Step 5: Update readme.md

Update the [`readme.md`](../readme.md) file to add the new API version:

1. **Update the default tag** at the top of the file:
   ```yaml
   tag: package-preview-2026-04-01-preview
   ```

2. **Add a new tag section** for the new version (add it before the old preview version tag):
   ```markdown
   ### Tag: package-preview-2026-04-01-preview

   These settings apply only when `--tag=package-preview-2026-04-01-preview` is specified on the command line.

   ```yaml $(tag) == 'package-preview-2026-04-01-preview'
   input-file:
     - preview/2026-04-01-preview/hci.json
   ```
   ```

**Note:** Keep the old preview version tag section - do not remove it.

### Step 6: Format Examples with Prettier (Optional)

Format all JSON example files before compilation:

```bash
npx prettier --write .\examples\2026-04-01-preview\*.json
```

### Step 7: Compile TypeSpec

Run the TypeSpec compiler to generate the OpenAPI specification:

```bash
tsp compile .
```

This will:
- Generate the OpenAPI spec in `preview/2026-04-01-preview/hci.json`
- Copy examples to `preview/2026-04-01-preview/examples/`

### Step 8: Verify Generated Output

Check that the new version was created correctly and no other changes occurred in the preview folder:

```powershell
# Verify new preview folder exists
Test-Path "preview\2026-04-01-preview"

# Check git status to ensure only expected changes
# IMPORTANT: Only the new preview folder should show as untracked
# No deletions or modifications should appear in the preview/ folder
git status preview

# Expected output:
# Untracked files:
#   preview/2026-04-01-preview/
```

**Critical:** The `git status preview` command should only show the new version as untracked. **Do NOT delete any existing preview versions** in the `preview/` folder - they are committed to git history and should be preserved.

### Step 9: Run Validation

Validate the generated OpenAPI specification:

```bash
npx oav validate-example preview/2026-04-01-preview/hci.json
```

### Step 10: Commit Skeleton Version

After verification, commit all changes as the skeleton version:

```powershell
# Add all changes
git add -A

# Commit with skeleton version message
git commit -m "Create skeleton version 2026-04-01-preview"
```

This creates a baseline commit for the new version. Future feature commits will be added on top of this skeleton.

## Creating a New Stable Version

For stable versions, follow similar steps but:

1. Add the version without `-preview` suffix:
   ```typespec
   v2026_04_01: "2026-04-01",
   ```

2. Place examples in `examples/2026-04-01/`

3. Generated output goes to `stable/2026-04-01/`

## Version Naming Conventions

| Type | Format | Example |
|------|--------|---------|
| Stable | `vYYYY_MM_DD` | `v2026_02_01` |
| Preview | `vYYYY_MM_DD_preview` | `v2026_04_01_preview` |

## Important Notes

### Preserve Existing Preview Versions

**Do NOT delete existing preview versions in the `preview/` folder.** The TypeSpec compiler only generates versions defined in the `Versions` enum. Old preview versions in the `preview/` folder are already committed to git history and should remain untouched.

When you run `git status preview`, you should see:
- ✅ New version folder as **untracked** (e.g., `preview/2026-04-01-preview/`)
- ❌ NO deletions of old preview versions
- ❌ NO modifications to existing preview versions

### Source vs Generated Files

| Location | Type | Should Modify |
|----------|------|---------------|
| `readme.md` | AutoRest configuration | Yes - update default tag and add new tag section |
| `examples/{version}/` | Source examples | Yes - rename and update |
| `preview/{version}/` | Generated output | No - only add new versions |
| `stable/{version}/` | Generated output | No - only add new versions |
| `*.tsp` files | Source TypeSpec | Yes - update version references |

## Common Issues and Solutions

### Issue: Old preview version deleted in git status

**Cause:** The old preview folder was manually deleted.

**Solution:** Restore it using `git restore preview/{old-version}`. The TypeSpec compiler doesn't regenerate old versions - they are already committed to history.

### Issue: Examples not copied during compilation

**Solution:** Verify the examples directory name matches the API version string exactly (e.g., `2026-04-01-preview`).

### Issue: Validation errors after version update

**Solution:** Run prettier on example files and ensure all JSON files have the correct `api-version` parameter value.

## Quick Reference Commands

```powershell
# Complete workflow for creating new preview version
$oldVersion = "2026-03-01-preview"
$newVersion = "2026-04-01-preview"
$oldVersionVar = "v2026_03_01_preview"
$newVersionVar = "v2026_04_01_preview"
$oldTag = "package-preview-2026-03-01-preview"
$newTag = "package-preview-2026-04-01-preview"

# 1. Update main.tsp Versions enum manually (remove old, add new)

# 2. Replace version references in tsp files
Get-ChildItem -Path . -Filter "*.tsp" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    if ($content -match $oldVersionVar) {
        $content = $content -replace $oldVersionVar, $newVersionVar
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Updated: $($_.Name)"
    }
}

# 3. Rename examples directory
Rename-Item -Path "examples\$oldVersion" -NewName $newVersion

# 4. Update api-version in examples
Get-ChildItem -Path "examples\$newVersion" -Filter "*.json" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $content = $content -replace $oldVersion, $newVersion
    Set-Content -Path $_.FullName -Value $content -NoNewline
}

# 5. Update readme.md - update default tag and add new tag section
# Edit readme.md manually:
#   - Change: tag: package-preview-2026-03-01-preview
#   - To:     tag: package-preview-2026-04-01-preview
#   - Add new tag section for 2026-04-01-preview before the 2026-03-01-preview section

# 6. Format (optional) and compile
npx prettier --write ".\examples\$newVersion\*.json"
tsp compile .

# 7. Verify - should only show new version as untracked, no deletions
git status preview

# 8. Commit skeleton version
git add -A
git commit -m "Create skeleton version $newVersion"
```

## Contact

For questions about version management, refer to the TypeSpec documentation or reach out to the API development team.
