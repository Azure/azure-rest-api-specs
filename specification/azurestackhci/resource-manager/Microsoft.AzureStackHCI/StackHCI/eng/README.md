# Engineering Documentation Index

Quick reference guide for Azure Stack HCI TypeSpec repository documentation.

## Document Index

| Document | Use When | Keywords |
|----------|----------|----------|
| [development-workflow.md](./development-workflow.md) | Fixing prettier errors, running validation, formatting JSON | `prettier`, `validation`, `oav`, `format`, `json`, `workflow`, `compile` |
| [repo-understanding.md](./repo-understanding.md) | Understanding repo structure, private vs public differences, syncing repos | `structure`, `private`, `public`, `sync`, `files`, `comparison`, `swagger` |
| [typespec-style-guide.md](./typespec-style-guide.md) | Writing TypeSpec code, naming conventions, documentation style | `style`, `naming`, `PascalCase`, `models.tsp`, `@doc`, `jsdoc`, `imports` |
| [version-creator.md](./version-creator.md) | Creating new API versions, version bumps | `version`, `create`, `new`, `preview`, `stable`, `skeleton`, `readme.md` |

## Quick Task → Document Mapping

### Formatting & Validation Issues
- **"prettier is failing"** → [development-workflow.md](./development-workflow.md)
- **"validation errors"** → [development-workflow.md](./development-workflow.md)
- **"oav validate-example"** → [development-workflow.md](./development-workflow.md)
- **"json formatting"** → [development-workflow.md](./development-workflow.md)

### Repository & Structure Questions
- **"private vs public"** → [repo-understanding.md](./repo-understanding.md)
- **"what files are different"** → [repo-understanding.md](./repo-understanding.md)
- **"sync with public repo"** → [repo-understanding.md](./repo-understanding.md)
- **"private preview features"** → [repo-understanding.md](./repo-understanding.md)
- **"file structure"** → [repo-understanding.md](./repo-understanding.md)

### Code Style & Conventions
- **"how to write TypeSpec"** → [typespec-style-guide.md](./typespec-style-guide.md)
- **"naming conventions"** → [typespec-style-guide.md](./typespec-style-guide.md)
- **"where to put models"** → [typespec-style-guide.md](./typespec-style-guide.md)
- **"@doc vs jsdoc"** → [typespec-style-guide.md](./typespec-style-guide.md)
- **"imports/using statements"** → [typespec-style-guide.md](./typespec-style-guide.md)

### Version Management
- **"create new version"** → [version-creator.md](./version-creator.md)
- **"bump api version"** → [version-creator.md](./version-creator.md)
- **"new preview version"** → [version-creator.md](./version-creator.md)
- **"update readme.md tags"** → [version-creator.md](./version-creator.md)

## Scripts

| Script | Purpose |
|--------|---------|
| [convert-doc-to-jsdoc.ps1](./convert-doc-to-jsdoc.ps1) | Convert `@doc` decorators to `/** */` JSDoc comments |

## Version-Specific Fix Documentation

Files matching `model-validation-fixes-*.md` contain fixes for specific API versions:
- `model-validation-fixes-2024-11-01-preview.md`
- `model-validation-fixes-2025-09-22-preview.md`

## Common Commands Quick Reference

```bash
# Format JSON examples
npx prettier --write .\examples\{API_VERSION}\*.json

# Compile TypeSpec
tsp compile .

# Run model validation
npx oav validate-example preview/{API_VERSION}/hci.json

# Complete workflow
npx prettier --write .\examples\{API_VERSION}\*.json && tsp compile . && npx oav validate-example preview/{API_VERSION}/hci.json
```

## Current API Versions (Private Repo)

- **Stable**: `v2026_02_01` (2026-02-01)
- **Preview**: `v2026_03_15_preview` (2026-03-15-preview)
