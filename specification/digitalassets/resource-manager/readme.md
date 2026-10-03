# digitalassets

> see https://aka.ms/autorest
> This is the AutoRest configuration file for DigitalAssets.

## Configuration

Required if any services under this folder are RPaaS.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-09-01-preview
```

### Tag: package-2025-09-01-preview

These settings apply only when `--tag=package-2025-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-09-01-preview'
input-file:
  - Microsoft.DigitalAssets/DigitalAssets/preview/2025-09-01-preview/openapi.json
```