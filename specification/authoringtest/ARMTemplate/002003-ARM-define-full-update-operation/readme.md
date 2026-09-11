# Widget

> see https://aka.ms/autorest

This is the AutoRest configuration file for Widget.

## Configuration

### Basic Information

This is a TypeSpec project used for evaluate testing.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2021-11-01
```

### Tag: package-2021-11-01

These settings apply only when `--tag=package-2021-11-01` is specified on the command line.

```yaml $(tag) == 'package-2021-11-01'
input-file:
  - stable/2021-11-01/widget.json
suppressions:
  - code: PathContainsResourceType
  - code: PathResourceProviderMatchNamespace
```

### Tag: package-2021-10-01-preview

These settings apply only when `--tag=package-2021-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01-preview'
input-file:
  - preview/2021-10-01-preview/widget.json
suppressions:
  - code: PathContainsResourceType
  - code: PathResourceProviderMatchNamespace
```

---
