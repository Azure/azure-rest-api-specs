# Contoso.WidgetManager

## Configuration

Minimal file to test the getDefaultTag function.

### Basic Information

```yaml
openapi-type: data-plane
tag: package-2022-12-01
```

### Tag: package-2022-12-01

These settings apply only when `--tag=package-2022-12-01` is specified on the command line.

```yaml $(tag) == 'package-2022-12-01'
input-file:
  - Azure.Contoso.WidgetManager/stable/2022-12-01/widgets.json
```

### Tag: package-2022-11-01-preview

These settings apply only when `--tag=package-2022-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-11-01-preview'
input-file:
  - Azure.Contoso.WidgetManager/preview/2022-11-01-preview/widgets.json
```
