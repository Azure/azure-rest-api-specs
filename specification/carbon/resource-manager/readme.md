# Carbon

> see https://aka.ms/autorest
> This is the AutoRest configuration file for Carbon.

## Configuration

These are the global settings for the Carbon.

``` yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-04-01
```

### Tag: package-2026-05-01-preview

These settings apply only when `--tag=package-2026-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2026-05-01-preview'
input-file:
- Microsoft.Carbon/preview/2026-05-01-preview/main.json
```


### Tag: package-2025-04-01

These settings apply only when `--tag=package-2025-04-01` is specified on the command line.

``` yaml $(tag) == 'package-2025-04-01'
input-file:
- Microsoft.Carbon/stable/2025-04-01/main.json
```
