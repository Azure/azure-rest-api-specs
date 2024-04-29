# Speech Ingestion SDK

> see https://aka.ms/autorest

Configuration for Speech Ingestion.

The current release is `release_0_2_preview`.

``` yaml
tag: release_0_2_preview
add-credentials: true
openapi-type: data-plane
```

# Releases

## Speech Ingestion v0.2-preview

These settings apply only when `--tag=release_0_2_preview` is specified on the command line.

```yaml $(tag) == 'release_0_2_preview'
input-file:
  - preview/v0.2-preview/ingestion.json
```