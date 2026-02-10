# Bar

> see https://aka.ms/autorest

This is the AutoRest configuration file for Bar.

## Configuration

### Basic Information

```yaml
openapi-type: data-plane
tag: package-2025-03-01
```

### Tag: package-2025-03-01

These settings apply only when `--tag=package-2025-03-01` is specified on the command line.

```yaml $(tag) == 'package-2025-03-01'
input-file:
  - stable/2025-03-01/bar.json
  - stable/2025-03-01/baz.json
```

### Tag: package-2025-01-01

These settings apply only when `--tag=package-2025-01-01` is specified on the command line.

```yaml $(tag) == 'package-2025-01-01'
input-file:
  - stable/2025-01-01/bar.json
  - stable/2025-01-01/baz.json
```

### Tag: package-2025-04-01-preview

These settings apply only when `--tag=package-2025-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-04-01-preview'
input-file:
  - preview/2025-04-01-preview/bar.json
  - preview/2025-04-01-preview/baz.json
```

### Tag: package-2025-02-01-preview

These settings apply only when `--tag=package-2025-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-02-01-preview'
input-file:
  - preview/2025-02-01-preview/bar.json
  - preview/2025-02-01-preview/baz.json
```