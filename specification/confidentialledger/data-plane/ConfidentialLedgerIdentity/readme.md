# Confidential Ledger Identity service

> see https://aka.ms/autorest

This is the AutoRest configuration file for Confidential Ledger.

## Configuration

### Basic Information

This is a TypeSpec project so we only want the readme for the default tag and point to the outputted swagger file.
This is used for some tools such as doc generation and swagger apiview generation it isn't used for SDK code gen as we
use the native TypeSpec code generation configured in the tspconfig.yaml file.

```yaml
openapi-type: data-plane
tag: package-2024-12-09-preview
```

### Tag: package-2022-05-13-identity

These settings apply only when `--tag=package-2022-05-13-identity` is specified on the command line.

```yaml $(tag) == 'package-2022-05-13-identity'
input-file:
  - stable/2022-05-13/identityservice.json
directive:
  - suppress: HostParametersValidation
    reason: Existing API, change would potentially be breaking.
```

### Tag: package-2024-12-09-preview

These settings apply only when `--tag=package-2024-12-09-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-12-09-preview'
input-file:
  - preview/2024-12-09-preview/identityservice.json
directive:
  - suppress: HostParametersValidation
    reason: Existing API, change would potentially be breaking.
```
