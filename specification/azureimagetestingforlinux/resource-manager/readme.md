# azureimagetestingforlinux

> see https://aka.ms/autorest
> This is the AutoRest configuration file for azureimagetestingforlinux.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
> To see additional help and options, run:
> `autorest --help`

## For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

## Configuration

### Basic Information

These are the global settings for the azureimagetestingforlinux.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-04-01-preview
```

### Tag: package-2023-08-01-preview

These settings apply only when `--tag=package-2023-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-08-01-preview'
input-file:
  - Microsoft.AzureImageTestingForLinux/preview/2023-08-01-preview/azureimagetestingforlinux.json
suppressions:
  - code: AvoidAdditionalProperties
    from: azureimagetestingforlinux.json
    where: $.definitions.JobTemplateProperties.properties.customParameters
    reason: AdditionalProperties is required for our user-defined customParameters field. We need this 
      extensible and flexible due to a dependency on external service, and handle validation on the backend.
  - code: AvoidAdditionalProperties
    from: azureimagetestingforlinux.json
    where: $.definitions.TestResultProperties.properties.extraFields
    reason: extraFields requires a Record<string> for backward compatibility. We need this extensible and 
      flexible due to a dependency on external service, and handle validation on the backend.
  - code: TrackedResourceUpdate
    from: azureimagetestingforlinux.json
    where: $.definitions.JobTemplateUpdate
    reason: TrackedResourceUpdate model needs to extend base resource for ARM compliance. Used to make the 
      PATCH model valid.
  - code: EmptyModel
    from: azureimagetestingforlinux.json
    where: $.definitions.JobTemplateUpdate
    reason: TrackedResourceUpdate and JobTemplateUpdate models require inheritance pattern for ARM resource 
      structure. Used to make the PATCH model valid.
```

### Tag: package-2025-04-01-preview

These settings apply only when `--tag=package-2025-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-04-01-preview'
input-file:
  - Microsoft.AzureImageTestingForLinux/preview/2025-04-01-preview/azureimagetestingforlinux.json
suppressions:
  - code: AvoidAdditionalProperties
    from: azureimagetestingforlinux.json
    where: $.definitions.JobTemplateProperties.properties.customParameters
    reason: AdditionalProperties is required for our user-defined customParameters field. We need this 
      extensible and flexible due to a dependency on external service, and handle validation on the backend.
  - code: AvoidAdditionalProperties
    from: azureimagetestingforlinux.json
    where: $.definitions.TestResultProperties.properties.extraFields
    reason: extraFields requires a Record<string> for backward compatibility. We need this extensible and 
      flexible due to a dependency on external service, and handle validation on the backend.
  - code: TrackedResourceUpdate
    from: azureimagetestingforlinux.json
    where: $.definitions.JobTemplateUpdate
    reason: TrackedResourceUpdate model needs to extend base resource for ARM compliance. Used to make the 
      PATCH model valid.
  - code: EmptyModel
    from: azureimagetestingforlinux.json
    where: $.definitions.JobTemplateUpdate
    reason: TrackedResourceUpdate and JobTemplateUpdate models require inheritance pattern for ARM resource 
      structure. Used to make the PATCH model valid.
```

---
