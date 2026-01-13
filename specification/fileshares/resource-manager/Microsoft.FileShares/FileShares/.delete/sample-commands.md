# FileShares TypeSpec Sample Commands

## Format TypeSpec Files

```bash
npx tsp format specification\fileshares\resource-manager\Microsoft.FileShares\FileShares\*.tsp
```

## Validate TypeSpec Files

```bash
npx tsv specification\fileshares\resource-manager\Microsoft.FileShares\FileShares
```

Alternative path format:

```bash
npm exec --no -- tsv specification/fileshares/resource-manager/Microsoft.FileShares/FileShares
```

## Compile TypeSpec to OpenAPI

```bash
npx tsp compile specification\fileshares\resource-manager\Microsoft.FileShares\FileShares\main.tsp
```

Alternative (compile using tspconfig.yaml):

```bash
npx tsp compile specification\fileshares\resource-manager\Microsoft.FileShares\FileShares
```

## Generate Examples from OpenAPI

```bash
oav generate-examples specification\fileshares\resource-manager\Microsoft.FileShares\preview\2025-06-01-preview\fileshares.json
```

## Validate Examples

```bash
oav validate-example specification\fileshares\resource-manager\Microsoft.FileShares\preview\2025-06-01-preview\fileshares.json
```

## Format Example JSON Files with Prettier

```bash
npx prettier --write specification\fileshares\resource-manager\Microsoft.FileShares\FileShares\examples\**\*.json
```

Format specific example:

```bash
npx prettier --write specification\fileshares\resource-manager\Microsoft.FileShares\FileShares\examples\2025-06-01-preview\FileShare_Create.json
```

## Full Workflow

```bash
# 1. Format TypeSpec files
npx tsp format specification\fileshares\resource-manager\Microsoft.FileShares\FileShares\*.tsp

# 2. Validate TypeSpec
npx tsv specification\fileshares\resource-manager\Microsoft.FileShares\FileShares

# 3. Compile TypeSpec to OpenAPI
npx tsp compile specification\fileshares\resource-manager\Microsoft.FileShares\FileShares

# 4. Validate generated examples
oav validate-example specification\fileshares\resource-manager\Microsoft.FileShares\preview\2025-06-01-preview\fileshares.json

# 5. Format example files
npx prettier --write specification\fileshares\resource-manager\Microsoft.FileShares\FileShares\examples\**\*.json
```

## Notes

- Run commands from the root of the `azure-rest-api-specs` repository
- Ensure all dependencies are installed: `npm ci`
- The `tspconfig.yaml` file in the FileShares folder controls compilation settings
- Examples are stored in: `specification\fileshares\resource-manager\Microsoft.FileShares\FileShares\examples\`
- Generated OpenAPI specs go to: `specification\fileshares\resource-manager\Microsoft.FileShares\preview\2025-06-01-preview\`
