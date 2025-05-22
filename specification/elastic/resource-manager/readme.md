# elastic

> see https://aka.ms/autorest

This is the AutoRest configuration file for elastic.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the elastic.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-01-15-preview
```

### Tag: package-2021-09-01-preview

These settings apply only when `--tag=package-2021-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-09-01-preview'
input-file:
  - Microsoft.Elastic/preview/2021-09-01-preview/elastic.json
```

### Tag: package-2021-10-01-preview

These settings apply only when `--tag=package-2021-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01-preview'
input-file:
  - Microsoft.Elastic/preview/2021-10-01-preview/elastic.json
```

### Tag: package-2020-07-01-preview

These settings apply only when `--tag=package-2020-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-07-01-preview'
input-file:
  - Microsoft.Elastic/preview/2020-07-01-preview/elastic.json
```

### Tag: package-2020-07-01

These settings apply only when `--tag=package-2020-07-01` is specified on the command line.

```yaml $(tag) == 'package-2020-07-01'
input-file:
  - Microsoft.Elastic/stable/2020-07-01/elastic.json
```

### Tag: package-2022-05-05-preview

These settings apply only when `--tag=package-2022-05-05-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-05-05-preview'
input-file:
  - Microsoft.Elastic/preview/2022-05-05-preview/elastic.json
```

### Tag: package-2022-07-01-preview

These settings apply only when `--tag=package-2022-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-07-01-preview'
input-file:
  - Microsoft.Elastic/preview/2022-07-01-preview/elastic.json
```

### Tag: package-2022-09-01-preview

These settings apply only when `--tag=package-2022-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-09-01-preview'
input-file:
  - Microsoft.Elastic/preview/2022-09-01-preview/elastic.json
```

### Tag: package-2023-02-01-preview

These settings apply only when `--tag=package-2023-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-02-01-preview'
input-file:
  - Microsoft.Elastic/preview/2023-02-01-preview/elastic.json
```

### Tag: package-2023-05-01-preview

These settings apply only when `--tag=package-2023-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-05-01-preview'
input-file:
  - Microsoft.Elastic/preview/2023-05-01-preview/elastic.json
```

### Tag: package-2023-06-01

These settings apply only when `--tag=package-2023-06-01` is specified on the command line.

```yaml $(tag) == 'package-2023-06-01'
input-file:
  - Microsoft.Elastic/stable/2023-06-01/elastic.json
```

### Tag: package-2023-06-15-preview

These settings apply only when `--tag=package-2023-06-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-06-15-preview'
input-file:
  - Microsoft.Elastic/preview/2023-06-15-preview/elastic.json
```

### Tag: package-2023-07-01-preview

These settings apply only when `--tag=package-2023-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-07-01-preview'
input-file:
  - Microsoft.Elastic/preview/2023-07-01-preview/elastic.json
```

### Tag: package-2023-10-01-preview

These settings apply only when `--tag=package-2023-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-10-01-preview'
input-file:
  - Microsoft.Elastic/preview/2023-10-01-preview/elastic.json
```

### Tag: package-2023-11-01-preview

These settings apply only when `--tag=package-2023-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-11-01-preview'
input-file:
  - Microsoft.Elastic/preview/2023-11-01-preview/elastic.json
```

### Tag: package-2024-01-01-preview

These settings apply only when `--tag=package-2024-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-01-01-preview'
input-file:
  - Microsoft.Elastic/preview/2024-01-01-preview/elastic.json
suppressions:
  - code: ResourceNameRestriction
    from: elastic.json
    reason: Addition of Pattern restriction will cause a breaking change as there is no restriction in previous api versions.
```

### Tag: package-2024-03-01

These settings apply only when `--tag=package-2024-03-01` is specified on the command line.

```yaml $(tag) == 'package-2024-03-01'
input-file:
  - Microsoft.Elastic/stable/2024-03-01/elastic.json
suppressions:
  - code: ResourceNameRestriction
    from: elastic.json
    reason: Addition of Pattern restriction will cause a breaking change as there is no restriction in previous api versions.
```

### Tag: package-2024-05-01-preview

These settings apply only when `--tag=package-2024-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-01-preview'
input-file:
  - Microsoft.Elastic/preview/2024-05-01-preview/elastic.json
```

### Tag: package-2024-06-15-preview

These settings apply only when `--tag=package-2024-06-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-06-15-preview'
input-file:
  - Microsoft.Elastic/preview/2024-06-15-preview/elastic.json
```

### Tag: package-2024-10-01-preview

These settings apply only when `--tag=package-2024-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-10-01-preview'
input-file:
  - Microsoft.Elastic/preview/2024-10-01-preview/elastic.json
```

### Tag: package-2025-01-15-preview

These settings apply only when `--tag=package-2025-01-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-01-15-preview'
input-file:
  - Microsoft.Elastic/preview/2025-01-15-preview/elastic.json
```

---
# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_elastic']
  - repo: azure-powershell
```

## Suppression
```
directive:
  - suppress: SECRET_PROPERTY
    from:
      - Microsoft.Elastic/preview/2020-07-01-preview/elastic.json
    where:
      - $.definitions.VMIngestionDetailsResponse.properties.ingestionKey
    reason: Secrets are OK to return in a POST response.
  - suppress: SECRET_PROPERTY
    from:
      - Microsoft.Elastic/preview/2021-09-01-preview/elastic.json
    where:
      - $.definitions.VMIngestionDetailsResponse.properties.ingestionKey
    reason: Secrets are OK to return in a POST response.
  - suppress: SECRET_PROPERTY
    from:
      - Microsoft.Elastic/preview/2021-10-01-preview/elastic.json
    where:
      - $.definitions.VMIngestionDetailsResponse.properties.ingestionKey
    reason: Secrets are OK to return in a POST response.
  - suppress: SECRET_PROPERTY
    from:
      - Microsoft.Elastic/stable/2020-07-01/elastic.json
    where:
      - $.definitions.VMIngestionDetailsResponse.properties.ingestionKey
    reason: Secrets are OK to return in a POST response.
  - suppress: SECRET_PROPERTY
    from:
      - Microsoft.Elastic/stable/2022-07-01/elastic.json
    where:
      - $.definitions.VMIngestionDetailsResponse.properties.ingestionKey
    reason: Secrets are OK to return in a POST response.
  - suppress: SECRET_PROPERTY
    from:
      - Microsoft.Elastic/stable/2022-05-05/elastic.json
    where:
      - $.definitions.VMIngestionDetailsResponse.properties.ingestionKey
    reason: Secrets are OK to return in a POST response.
  - suppress: ResourceNameRestriction
    from:
      - Microsoft.Elastic/preview/2024-01-01/elastic.json
    where:
      - $.definitions.parameters.MonitorNameParameter
    reason: Addition of Pattern restriction will cause a breaking change as there is no restriction in previous api versions

```

## Az

See configuration in [readme.az.md](./readme.az.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)
