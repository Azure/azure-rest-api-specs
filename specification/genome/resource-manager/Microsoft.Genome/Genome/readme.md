# Microsoft Genome

> see https://aka.ms/autorest

This directory contains the Microsoft Genome service specification, implemented using **TypeSpec** and configured for AutoRest SDK generation.

## Project Structure

```
genome/
├── readme.md                              # This file - AutoRest configuration
└── resource-manager/
    └── Microsoft.Genome/
        └── preview/
            └── 2021-08-01-preview/
                ├── main.tsp              # TypeSpec specification
                ├── models.tsp            # TypeSpec models
                ├── client.tsp            # SDK client customizations
                ├── tspconfig.yaml        # TypeSpec configuration
                ├── readme.md             # TypeSpec development guide
                ├── genome.json           # Generated OpenAPI (from TypeSpec)
                └── examples/             # API examples
                    └── 2021-08-01-preview/
```

## Development

This service is built using **TypeSpec** (not hand-written OpenAPI). To work on the specification:

1. **Navigate to the TypeSpec directory**:
   ```bash
   cd resource-manager/Microsoft.Genome/preview/2021-08-01-preview/
   ```

2. **Follow the TypeSpec development guide**:
   - See `readme.md` in the TypeSpec directory for detailed instructions
   - Compilation: `npx tsp compile .`
   - Prerequisites: Node.js, repository dependencies (`npm ci` from repo root)

3. **Generated output**:
   - The `genome.json` file is **generated** from TypeSpec
   - Do not edit `genome.json` directly - edit the `.tsp` files instead

## Getting Started (SDK Generation)

To build the SDKs for Genome using the generated OpenAPI specification:

>1. **Install AutoRest** via `npm` (`npm install -g autorest`)

2. **Generate SDKs**:
   ```bash
   autorest readme.md
   ```

3. **Get help**:
   ```bash
   autorest --help
   ```

For other installation options see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Genome service.

``` yaml
openapi-type: arm
tag: package-preview-2021-08
```

### Tag: package-preview-2021-08

These settings apply only when `--tag=package-preview-2021-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-08'
input-file:
- preview/2021-08-01-preview/genome.json
```

---

## Validation

Since this RP has no unique default package, iterate over all of them for validation:

``` yaml $(validation)
batch:
  - tag: package-preview-2021-08
```

## Suppression

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: preview/2021-08-01-preview/genome.json
    where: $.definitions.GenomeAccountProperties.properties.networkAcls
    reason: Property 'networkAcls' follows existing Azure ARM naming conventions for network access control lists
```
