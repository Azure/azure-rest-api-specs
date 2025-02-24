# Model Inference API

> see https://aka.ms/autorest

This is the AutoRest configuration file for Model Inference API.

The current release is `2024-05-01-preview`.

```yaml
tag: 2024-05-01-preview
openapi-type: data-plane
```

# Releases

### Release 2024-05-01-preview

These settings apply only when `--tag=2024-05-01-preview` is specified on the command line.

```yaml $(tag) == '2024-05-01-preview'
input-file:
  - preview/2024-05-01-preview/openapi.json
suppressions:
  - code: IntegerTypeMustHaveFormat
    from: openapi.json
    reason: OpenAI compatible API, which uses unixTimeStamp
```
