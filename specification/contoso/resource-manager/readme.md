# contoso

> see https://aka.ms/autorest

This is the AutoRest configuration file for contoso.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the contoso.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2023-12-01-preview
```

### Tag: package-2020-01-01-preview
These settings apply only when `--tag=package-2020-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-01-01-preview'
input-file:
  - Microsoft.Contoso/preview/2020-01-01-preview/tower.json
  - Microsoft.Contoso/preview/2020-01-01-preview/extensionclusters.json
  - Microsoft.Contoso/preview/2020-01-01-preview/recipe.json
```

### Tag: package-2021-04-01-preview

These settings apply only when `--tag=package-2021-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-04-01-preview'
input-file:
  - Microsoft.Contoso/preview/2021-04-01-preview/cnab.json
```

### Tag: package-2021-10-01-preview

These settings apply only when `--tag=package-2021-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01-preview'
input-file:
  - Microsoft.Contoso/preview/2021-10-01-preview/openapi.json
```

### Tag: package-2022-10-01-preview

These settings apply only when `--tag=package-2022-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-10-01-preview'
input-file:
  - Microsoft.Contoso/preview/2022-10-01-preview/openapi.json
```

### Tag: package-2023-10-01-preview

These settings apply only when `--tag=package-2023-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-10-01-preview'
input-file:
  - Microsoft.Contoso/preview/2023-10-01-preview/openapi.json
```

### Tag: package-2023-11-01-preview

These settings apply only when `--tag=package-2023-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-11-01-preview'
input-file:
  - Microsoft.Contoso/preview/2023-11-01-preview/openapi.json
```

### Tag: package-2023-12-01-preview

These settings apply only when `--tag=package-2023-12-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-12-01-preview'
input-file:
  - Microsoft.Contoso/preview/2020-01-01-preview/tower.json
  - Microsoft.Contoso/preview/2020-01-01-preview/extensionclusters.json
  - Microsoft.Contoso/preview/2020-01-01-preview/recipe.json
  - Microsoft.Contoso/preview/2021-04-01-preview/cnab.json
  - Microsoft.Contoso/preview/2023-12-01-preview/openapi.json
```

### Tag: package-package-canonical

These settings apply only when `--tag=package-canonical` is specified on the command line.

```yaml $(tag) == 'package-canonical'
input-file:
  - Microsoft.Contoso/canonical/openapi.json

suppressions:
  - code: APIVersionPattern
    from: openapi.json
    reason: Canonical version should be valid
```

## Suppression

``` yaml
directive:
  - suppress: RequiredReadOnlySystemData
    from: cnab.json
    reason: This is an RPaaS Bridge type
  - suppress: XMS_EXAMPLE_NOTFOUND_ERROR
    from: openapi.json
    reason: No existing examples
  - suppress: BodyTopLevelProperties
    from: openapi.json
  - suppress: MISSING_APIS_IN_DEFAULT_TAG
    from: openapi.json
    reason: Add canonical swagger for testing
```

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)