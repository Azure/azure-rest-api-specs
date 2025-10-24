# Contoso.WidgetManager

## Configuration

### Basic Information

```yaml
openapi-type: data-plane
tag: package-2022-12-01
```

### Tag: package-2022-12-01

These settings apply only when `--tag=package-2022-12-01` is specified on the command line.

```yaml $(tag) == 'package-2022-12-01'
input-file:
  - data-plane/swagger.json
```

```yaml $(tag) == 'package-2022-12-01-preview'
input-file:
  - data-plane/swagger-preview.json
```