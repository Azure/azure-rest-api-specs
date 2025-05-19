# Model Inference API

> see https://aka.ms/autorest

This is the AutoRest configuration file for Model Inference API.

The current release is `2025-05-01`.

```yaml
tag: 2025-05-01
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

### Release 2025-04-01

These settings apply only when `--tag=2025-04-01` is specified on the command line.

```yaml $(tag) == '2025-04-01'
input-file:
  - stable/2025-04-01/openapi.json
suppressions:
  - code: IntegerTypeMustHaveFormat
    from: openapi.json
    reason: OpenAI compatible API, which uses unixTimeStamp
```

### Release 2025-05-01

These settings apply only when `--tag=2025-05-01` is specified on the command line.

```yaml $(tag) == '2025-05-01'
input-file:
  - stable/2025-05-01/openapi.json
suppressions:
  - code: IntegerTypeMustHaveFormat
    from: openapi.json
    reason: OpenAI compatible API, which uses unixTimeStamp
  - code: PropertyType
    from: openapi.json
    reason: External API shape is defined in OpenAPI 3.0 as oneOf. 2.0 doesn't support union.
  - code: EnumInsteadOfBoolean
    from: openapi.json
    reason: OpenAI compatible API, which uses boolean.
```

### Release 2025-05-15-preview

These settings apply only when `--tag=2025-05-15-preview` is specified on the command line.

```yaml $(tag) == '2025-05-15-preview'
input-file:
  - preview/2025-05-15-preview/openapi.json
suppressions:
  - code: IntegerTypeMustHaveFormat
    from: openapi.json
    reason: OpenAI compatible API, which uses unixTimeStamp
  - code: PropertyType
    from: openapi.json
    reason: External API shape is defined in OpenAPI 3.0 as oneOf. 2.0 doesn't support union.
  - code: EnumInsteadOfBoolean
    from: openapi.json
    reason: OpenAI compatible API, which uses boolean.
```

