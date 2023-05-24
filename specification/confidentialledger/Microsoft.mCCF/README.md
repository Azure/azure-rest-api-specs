# Microsoft.mCCF

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.mCCF governance data-plane.

## Configuration

Default to building latest tag.

```yaml
openapi-type: data-plane
tag: 0.0.1-preview
```

### Tag: 0.0.1-preview

These settings apply only when `--tag=0.0.1-preview` is specified on the command line.

```yaml $(tag) == '0.0.1-preview'
openapi-type: data-plane
input-file:
  - ../data-plane/Microsoft.ManagedCcf/preview/0.0.1-preview/openapi.json
```