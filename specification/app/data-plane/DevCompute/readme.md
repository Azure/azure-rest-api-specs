# DevCompute Data Plane API

> see https://aka.ms/autorest

This is the AutoRest configuration file for the DevCompute Data Plane API.

## Configuration

### Basic Information

```yaml
openapi-type: data-plane
tag: package-2026-09-01
```

### Suppression

```yaml
directive:
  - suppress: XmsEnumValidation
    from: devcompute.json
    where: $.definitions.AzureDataPlaneOauth2Flow.properties.type
    reason: The OAuth2 flow type is defined by TypeSpec. Adding x-ms-enum with an OpenAPI extension is prohibited by the no-openapi-client-extensions rule because it changes SDK generation semantics.
```

### Tag: package-2026-09-01

These settings apply only when `--tag=package-2026-09-01` is specified on the command line.

```yaml $(tag) == 'package-2026-09-01'
input-file:
  - stable/2026-09-01/devcompute.json
```

### Tag: package-2026-08-01-preview

These settings apply only when `--tag=package-2026-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-08-01-preview'
input-file:
  - preview/2026-08-01-preview/devcompute.json
```