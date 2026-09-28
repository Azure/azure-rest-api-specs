# Azure Container Apps Sandbox

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Azure Container Apps Sandbox data plane API.

## Configuration

### Basic Information

```yaml
openapi-type: data-plane
tag: package-2026-09-01-preview
```

### Tag: package-2026-09-01-preview

These settings apply only when `--tag=package-2026-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-09-01-preview'
input-file:
  - preview/2026-09-01-preview/containerappssandbox.json
```
