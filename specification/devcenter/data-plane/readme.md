# devcenter

> see https://aka.ms/autorest

This is the AutoRest configuration file for devcenter.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the devcenter.

``` yaml
openapi-type: data-plane
azure-arm: false
tag: package-2024-09-01-preview
```

### Tag: package-2024-09-01-preview

These settings apply only when `--tag=package-2024-09-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-09-01-preview'
input-file:
  - Microsoft.DevCenter/preview/2024-09-01-preview/devcenter.json

directive:
  - suppress: HostParametersValidation
    reason: Requires URL format for endpoint params, which violates R2003 and causes problems with codegen.
  - suppress: OperationIdNounVerb
    reason: DevBoxes and Environments are operations with multiple models.
```

### Tag: package-2024-08-01-preview

These settings apply only when `--tag=package-2024-08-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-08-01-preview'
input-file:
  - Microsoft.DevCenter/preview/2024-08-01-preview/devcenter.json

directive:
  - suppress: HostParametersValidation
    reason: Requires URL format for endpoint params, which violates R2003 and causes problems with codegen.
  - suppress: OperationIdNounVerb
    reason: DevBoxes and Environments are operations with multiple models.
```

### Tag: package-preview-2024-05

These settings apply only when `--tag=package-2024-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-01-preview'
input-file:
  - Microsoft.DevCenter/preview/2024-05-01-preview/devcenter.json

directive:
  - suppress: HostParametersValidation
    reason: Requires URL format for endpoint params, which violates R2003 and causes problems with codegen
  - suppress: OperationIdNounVerb
    reason: DevBoxes and Environments are operations with multiple models.
```

### Tag: 2024-02-01

These settings apply only when `--tag=package-2024-02-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-02-01'
input-file:
  - Microsoft.DevCenter/stable/2024-02-01/devcenter.json

directive:
  - suppress: HostParametersValidation
    reason: Requires URL format for endpoint params, which violates R2003 and causes problems with codegen
  - suppress: OperationIdNounVerb
    reason: DevBoxes and Environments are operations with multiple models.
  - suppress: AvoidAnonymousTypes
    reason: This rule is irrelevant for data-plane TypeSpec specs.
```

### Tag: package-2023-10-01-preview

These settings apply only when `--tag=package-2023-10-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-10-01-preview'
input-file:
  - Microsoft.DevCenter/preview/2023-10-01-preview/devbox.json
  - Microsoft.DevCenter/preview/2023-10-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2023-10-01-preview/environments.json

directive:
  - suppress: HostParametersValidation
    reason: Requires URL format for endpoint params, which violates R2003 and causes problems with codegen
```

### Tag: package-2023-09-01-preview

These settings apply only when `--tag=package-2023-09-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-09-01-preview'
input-file:
  - Microsoft.DevCenter/preview/2023-09-01-preview/devbox.json
  - Microsoft.DevCenter/preview/2023-09-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2023-09-01-preview/environments.json

directive:
  - suppress: HostParametersValidation
    reason: Requires URL format for endpoint params, which violates R2003 and causes problems with codegen
```

### Tag: package-2023-07-01-preview

These settings apply only when `--tag=package-2023-07-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-07-01-preview'
input-file:
  - Microsoft.DevCenter/preview/2023-07-01-preview/devbox.json
  - Microsoft.DevCenter/preview/2023-07-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2023-07-01-preview/environments.json

directive:
  - suppress: HostParametersValidation
    reason: Requires URL format for endpoint params, which violates R2003 and causes problems with codegen
```

### Tag: 2023-04-01

These settings apply only when `--tag=package-2023-04-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-04-01'
input-file:
  - Microsoft.DevCenter/stable/2023-04-01/devcenter.json

directive:
  - suppress: HostParametersValidation
    reason: Requires URL format for endpoint params, which violates R2003 and causes problems with codegen
  - suppress: OperationIdNounVerb
    reason: DevBoxes and Environments are operations with multiple models.
  - suppress: AvoidAnonymousTypes
    reason: This rule is irrelevant for data-plane TypeSpec specs.
```

### Tag: 2023-01-01-preview

These settings apply only when `--tag=package-2023-01-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-01-01-preview'
input-file:
  - Microsoft.DevCenter/preview/2023-01-01-preview/devbox.json
  - Microsoft.DevCenter/preview/2023-01-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2023-01-01-preview/environments.json

directive:
  - suppress: HostParametersValidation
    reason: Requires URL format for endpoint params, which violates R2003 and causes problems with codegen
```

### Tag: package-preview-2022-11

These settings apply only when `--tag=package-preview-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-11'
input-file:
  - Microsoft.DevCenter/preview/2022-11-11-preview/devbox.json
  - Microsoft.DevCenter/preview/2022-11-11-preview/devcenter.json
  - Microsoft.DevCenter/preview/2022-11-11-preview/environments.json

directive:
  - suppress: HostParametersValidation
    reason: Requires URL format for endpoint params, which violates R2003 and causes problems with codegen
```
