# Widget

> see https://aka.ms/autorest
> This is the AutoRest configuration file for Widget.

## Configuration

Required if any services under this folder are RPaaS.

```yaml
openapi-type: arm
openapi-subtype: rpaas
```

### Tag: package-2021-11-01

These settings apply only when `--tag=package-2021-11-01` is specified on the command line.

```yaml $(tag) == 'package-2021-11-01'
input-file:
  - Microsoft.Contoso/stable/2021-11-01/contoso.json
```

### Tag: package-2021-10-01-preview

These settings apply only when `--tag=package-2021-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01-preview'
input-file:
  - Microsoft.Contoso/preview/2021-10-01-preview/contoso.json
```
