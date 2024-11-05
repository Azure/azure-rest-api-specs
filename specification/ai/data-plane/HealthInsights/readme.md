# Cognitive Services Health Insights SDK

> see https://aka.ms/autorest

Configuration for generating Health Insights SDK.

The current release is `package-2024-04-01`.

```yaml
tag: package-2024-04-01
add-credentials: true
openapi-type: data-plane
```

# Releases

### Release 2023-03-01-preview


These settings apply only when `--tag=2023-03-01-preview` is specified on the command line.

```yaml $(tag) == '2023-03-01-preview'
input-file:
  - preview/2023-03-01-preview/openapi.json
```

### Release 2023-09-01-preview


These settings apply only when `--tag=2023-09-01-preview` is specified on the command line.

```yaml $(tag) == '2023-09-01-preview'
input-file:
  - preview/2023-09-01-preview/openapi.json
```

```yaml
directive:
  - suppress: AvoidAnonymousTypes
    reason: The spec is auto-generated. Tracking issue to fix is https://github.com/Azure/typespec-azure-pr/issues/3349
```

### Release package-2024-04-01


These settings apply only when `--tag=package-2024-04-01` is specified on the command line.

```yaml $(tag) == 'package-2024-04-01'
input-file:
  - stable/2024-04-01/openapi.json
```

```yaml
directive:
  - suppress: AvoidAnonymousTypes
    reason: The spec is auto-generated. Tracking issue to fix is https://github.com/Azure/typespec-azure-pr/issues/3349
```