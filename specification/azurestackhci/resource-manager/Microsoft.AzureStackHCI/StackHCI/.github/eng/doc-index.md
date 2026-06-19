# Engineering Documentation Index

Quick reference guide for Azure Stack HCI TypeSpec repository documentation.

## Document Index

| Document | Use When | Keywords |
|----------|----------|----------|
| [workflow.md](./workflow.md) | Fixing prettier errors, running validation, formatting JSON | `prettier`, `validation`, `oav`, `format`, `json`, `workflow`, `compile` |
| [style-guide.md](./style-guide.md) | Writing TypeSpec code, naming conventions, documentation style | `style`, `naming`, `PascalCase`, `models.tsp`, `@doc`, `jsdoc`, `imports` |
| [version-creator.md](./version-creator.md) | Creating new API versions, version bumps | `version`, `create`, `new`, `preview`, `stable`, `skeleton`, `readme.md` |

## Quick Task → Document Mapping

### Formatting & Validation Issues
- **"prettier is failing"** → [workflow.md](./workflow.md)
- **"validation errors"** → [workflow.md](./workflow.md)
- **"oav validate-example"** → [workflow.md](./workflow.md)
- **"json formatting"** → [workflow.md](./workflow.md)

### Code Style & Conventions
- **"how to write TypeSpec"** → [style-guide.md](./style-guide.md)
- **"naming conventions"** → [style-guide.md](./style-guide.md)
- **"where to put models"** → [style-guide.md](./style-guide.md)
- **"@doc vs jsdoc"** → [style-guide.md](./style-guide.md)
- **"imports/using statements"** → [style-guide.md](./style-guide.md)

### Version Management
- **"create new version"** → [version-creator.md](./version-creator.md)
- **"bump api version"** → [version-creator.md](./version-creator.md)
- **"new preview version"** → [version-creator.md](./version-creator.md)
- **"update readme.md tags"** → [version-creator.md](./version-creator.md)

## Scripts

| Script | Purpose |
|--------|---------|
| [convert-doc-to-jsdoc.ps1](./convert-doc-to-jsdoc.ps1) | Convert `@doc` decorators to `/** */` JSDoc comments |

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

## Current API Versions

- Stable and preview versions are defined in `main.tsp` under `enum Versions`.
