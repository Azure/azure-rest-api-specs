# portal

> see https://aka.ms/autorest

This is the AutoRest configuration file for portal.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the portal.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-08-01-preview
```

### Tag: package-2025-08-01-preview

These settings apply only when `--tag=package-2025-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-08-01-preview'
input-file:
  - Microsoft.PortalServices/copilotSettings/preview/2025-08-01-preview/copilotSettings.json
  - Microsoft.PortalServices/copilotConnectors/preview/2025-05-15-preview/copilotConnectors.json
  - Microsoft.PortalServices/azurecoreexperiencesassistant/preview/2024-09-01-preview/azurecoreexperiencesassistant.json
  - Microsoft.PortalServices/dashboards/preview/2024-09-01-preview/dashboards.json
  - Microsoft.PortalServices/extensions/preview/2024-10-01-preview/extensions.json
  - Microsoft.PortalServices/settings/preview/2025-04-01-preview/settings.json
suppressions:
  - code: EvenSegmentedPathForPutOperation
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: XmsPageableForListCalls
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TopLevelResourcesListBySubscription
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      so subscription list operation is not valid. This is a false positive.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TenantLevelAPIsNotAllowed
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      and has received exception sign-off approval by PAS team and ARM team.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: EvenSegmentedPathForPutOperation
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: XmsPageableForListCalls
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: TopLevelResourcesListBySubscription
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @tenantResource,
      so subscription list operation is not valid. This is a false positive.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: TenantLevelAPIsNotAllowed
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @tenantResource.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
```

### Tag: package-2025-05-15-preview

These settings apply only when `--tag=package-2025-05-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-05-15-preview'
input-file:
  - Microsoft.PortalServices/copilotConnectors/preview/2025-05-15-preview/copilotConnectors.json
  - Microsoft.PortalServices/azurecoreexperiencesassistant/preview/2024-09-01-preview/azurecoreexperiencesassistant.json
  - Microsoft.PortalServices/copilotSettings/preview/2024-09-01-preview/copilotSettings.json
  - Microsoft.PortalServices/dashboards/preview/2024-09-01-preview/dashboards.json
  - Microsoft.PortalServices/extensions/preview/2024-10-01-preview/extensions.json
  - Microsoft.PortalServices/settings/preview/2025-04-01-preview/settings.json
suppressions:
  - code: EvenSegmentedPathForPutOperation
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: XmsPageableForListCalls
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TopLevelResourcesListBySubscription
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      so subscription list operation is not valid. This is a false positive.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TenantLevelAPIsNotAllowed
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      and has received exception sign-off approval by PAS team and ARM team.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: EvenSegmentedPathForPutOperation
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: XmsPageableForListCalls
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: TopLevelResourcesListBySubscription
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @tenantResource,
      so subscription list operation is not valid. This is a false positive.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: TenantLevelAPIsNotAllowed
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @tenantResource.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
```

### Tag: package-2025-04-01-preview

These settings apply only when `--tag=package-2025-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-04-01-preview'
input-file:
  - Microsoft.PortalServices/azurecoreexperiencesassistant/preview/2024-09-01-preview/azurecoreexperiencesassistant.json
  - Microsoft.PortalServices/copilotSettings/preview/2024-09-01-preview/copilotSettings.json
  - Microsoft.PortalServices/dashboards/preview/2024-09-01-preview/dashboards.json
  - Microsoft.PortalServices/extensions/preview/2024-10-01-preview/extensions.json
  - Microsoft.PortalServices/settings/preview/2025-04-01-preview/settings.json
suppressions:
  - code: EvenSegmentedPathForPutOperation
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: XmsPageableForListCalls
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TopLevelResourcesListBySubscription
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      so subscription list operation is not valid. This is a false positive.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TenantLevelAPIsNotAllowed
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      and has received exception sign-off approval by PAS team and ARM team.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: EvenSegmentedPathForPutOperation
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: XmsPageableForListCalls
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: TopLevelResourcesListBySubscription
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @tenantResource,
      so subscription list operation is not valid. This is a false positive.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: TenantLevelAPIsNotAllowed
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @tenantResource.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
```

### Tag: package-2024-10-01-preview

These settings apply only when `--tag=package-2024-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-10-01-preview'
input-file:
  - Microsoft.PortalServices/azurecoreexperiencesassistant/preview/2024-09-01-preview/azurecoreexperiencesassistant.json
  - Microsoft.PortalServices/copilotSettings/preview/2024-09-01-preview/copilotSettings.json
  - Microsoft.PortalServices/dashboards/preview/2024-09-01-preview/dashboards.json
  - Microsoft.PortalServices/extensions/preview/2024-10-01-preview/extensions.json
  - Microsoft.PortalServices/settings/preview/2024-09-01-preview/settings.json
suppressions:
  - code: EvenSegmentedPathForPutOperation
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: XmsPageableForListCalls
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TopLevelResourcesListBySubscription
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      so subscription list operation is not valid. This is a false positive.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TenantLevelAPIsNotAllowed
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      and has received exception sign-off approval by PAS team and ARM team.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: EvenSegmentedPathForPutOperation
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: XmsPageableForListCalls
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: TopLevelResourcesListBySubscription
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @tenantResource,
      so subscription list operation is not valid. This is a false positive.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: TenantLevelAPIsNotAllowed
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @tenantResource.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
```

### Tag: package-2024-09-01-preview

These settings apply only when `--tag=package-2024-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-09-01-preview'
input-file:
  - Microsoft.PortalServices/azurecoreexperiencesassistant/preview/2024-09-01-preview/azurecoreexperiencesassistant.json
  - Microsoft.PortalServices/copilotSettings/preview/2024-09-01-preview/copilotSettings.json
  - Microsoft.PortalServices/dashboards/preview/2024-09-01-preview/dashboards.json
  - Microsoft.PortalServices/extensions/preview/2023-01-01-preview/extensions.json
  - Microsoft.PortalServices/settings/preview/2024-09-01-preview/settings.json
suppressions:
  - code: EvenSegmentedPathForPutOperation
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: XmsPageableForListCalls
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TopLevelResourcesListBySubscription
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      so subscription list operation is not valid. This is a false positive.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TenantLevelAPIsNotAllowed
    reason: >
      The resource type copilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      and has received exception sign-off approval by PAS team and ARM team.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: EvenSegmentedPathForPutOperation
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: XmsPageableForListCalls
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: TopLevelResourcesListBySubscription
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @tenantResource,
      so subscription list operation is not valid. This is a false positive.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
  - code: TenantLevelAPIsNotAllowed
    reason: >
      The resource type settings in the Microsoft.PortalServices resource provider is @tenantResource.
    from:
      - settings.json
    where: $.paths["/providers/Microsoft.PortalServices/settings/default"]
```

### Tag: package-2024-08-01-preview

These settings apply only when `--tag=package-2024-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-08-01-preview'
input-file:
  - Microsoft.PortalServices/azurecoreexperiencesassistant/preview/2024-08-01-preview/azurecoreexperiencesassistant.json
  - Microsoft.PortalServices/copilotSettings/preview/2024-08-01-preview/copilotSettings.json
  - Microsoft.PortalServices/dashboards/preview/2024-08-01-preview/dashboards.json
  - Microsoft.PortalServices/extensions/preview/2023-01-01-preview/extensions.json
suppressions:
  - code: EvenSegmentedPathForPutOperation
    reason: >
      The resource type CopilotSettings in the Microsoft.PortalServices resource provider is @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: XmsPageableForListCalls
    reason: >
      The resource type CopilotSettings in the Microsoft.PortalServices resource provider @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TopLevelResourcesListBySubscription
    reason: >
      The resource type CopilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      so subscription list operation is not valid. This is a false positive.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TenantLevelAPIsNotAllowed
    reason: >
      The resource type CopilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      and has received exception sign-off approval by PAS team and ARM team.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
```

### Tag: package-2024-07-01-preview

These settings apply only when `--tag=package-2024-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-07-01-preview'
input-file:
  - Microsoft.PortalServices/azurecoreexperiencesassistant/preview/2024-07-01-preview/azurecoreexperiencesassistant.json
  - Microsoft.PortalServices/copilotSettings/preview/2024-07-01-preview/copilotSettings.json
  - Microsoft.PortalServices/dashboards/preview/2024-07-01-preview/dashboards.json
  - Microsoft.PortalServices/extensions/preview/2023-01-01-preview/extensions.json
suppressions:
  - code: EvenSegmentedPathForPutOperation
    reason: >
      The resource type CopilotSettings in the Microsoft.PortalServices resource provider is @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: XmsPageableForListCalls
    reason: >
      The resource type CopilotSettings in the Microsoft.PortalServices resource provider @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TopLevelResourcesListBySubscription
    reason: >
      The resource type CopilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      so subscription list operation is not valid. This is a false positive.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TenantLevelAPIsNotAllowed
    reason: >
      The resource type CopilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      and has received exception sign-off approval by PAS team and ARM team.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
```

### Tag: package-2024-04-01-preview

These settings apply only when `--tag=package-2024-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-04-01-preview'
input-file:
  - Microsoft.PortalServices/copilotSettings/preview/2024-04-01-preview/copilotSettings.json
  - Microsoft.PortalServices/dashboards/preview/2024-04-01-preview/dashboards.json
  - Microsoft.PortalServices/extensions/preview/2023-01-01-preview/extensions.json
suppressions:
  - code: EvenSegmentedPathForPutOperation
    reason: >
      The resource type CopilotSettings in the Microsoft.PortalServices resource provider is @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: XmsPageableForListCalls
    reason: >
      The resource type CopilotSettings in the Microsoft.PortalServices resource provider @singleton
      (OpenAPI path ends with /default). This is a false positive. Related issue:https://github.com/Azure/azure-openapi-validator/issues/646.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TopLevelResourcesListBySubscription
    reason: >
      The resource type CopilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      so subscription list operation is not valid. This is a false positive.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
  - code: TenantLevelAPIsNotAllowed
    reason: >
      The resource type CopilotSettings in the Microsoft.PortalServices resource provider is @tenantResource,
      and has received exception sign-off approval by PAS team and ARM team.
    from:
      - copilotSettings.json
    where: $.paths["/providers/Microsoft.PortalServices/copilotSettings/default"]
```

### Tag: package-2024-03-01-preview

These settings apply only when `--tag=package-2024-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-03-01-preview'
input-file:
  - Microsoft.PortalServices/dashboards/preview/2024-01-01-preview/dashboards.json
  - Microsoft.PortalServices/extensions/preview/2023-01-01-preview/extensions.json
```

### Tag: package-2024-01-01-preview

These settings apply only when `--tag=package-2024-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-01-01-preview'
input-file:
  - Microsoft.PortalServices/dashboards/preview/2024-01-01-preview/dashboards.json
```

### Tag: package-2023-10-01-preview

These settings apply only when `--tag=package-2023-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-10-01-preview'
input-file:
  - Microsoft.PortalServices/dashboards/preview/2023-10-01-preview/dashboards.json
```

### Tag: package-2023-08-01-preview

These settings apply only when `--tag=package-2023-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-08-01-preview'
input-file:
  - Microsoft.PortalServices/dashboards/preview/2023-08-01-preview/dashboards.json
```

### Tag: package-2023-01-01-preview

These settings apply only when `--tag=package-2023-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-01-01-preview'
input-file:
  - Microsoft.PortalServices/extensions/preview/2023-01-01-preview/extensions.json
```

### Tag: package-2022-04-01-preview

These settings apply only when `--tag=package-2022-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-04-01-preview'
input-file:
  - Microsoft.PortalServices/extensions/preview/2022-04-01-preview/extensions.json
```

---

# Code Generation
