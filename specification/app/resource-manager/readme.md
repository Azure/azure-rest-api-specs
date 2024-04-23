# app

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.App service.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the app.

``` yaml
openapi-type: arm
tag: package-2024-03
```


### Tag: package-2024-03

These settings apply only when `--tag=package-2024-03` is specified on the command line.

```yaml $(tag) == 'package-2024-03'
input-file:
  - Microsoft.App/stable/2024-03-01/AuthConfigs.json
  - Microsoft.App/stable/2024-03-01/AvailableWorkloadProfiles.json
  - Microsoft.App/stable/2024-03-01/BillingMeters.json
  - Microsoft.App/stable/2024-03-01/CommonDefinitions.json
  - Microsoft.App/stable/2024-03-01/ConnectedEnvironments.json
  - Microsoft.App/stable/2024-03-01/ConnectedEnvironmentsCertificates.json
  - Microsoft.App/stable/2024-03-01/ConnectedEnvironmentsDaprComponents.json
  - Microsoft.App/stable/2024-03-01/ConnectedEnvironmentsStorages.json
  - Microsoft.App/stable/2024-03-01/ContainerApps.json
  - Microsoft.App/stable/2024-03-01/ContainerAppsRevisions.json
  - Microsoft.App/stable/2024-03-01/Diagnostics.json
  - Microsoft.App/stable/2024-03-01/Global.json
  - Microsoft.App/stable/2024-03-01/Jobs.json
  - Microsoft.App/stable/2024-03-01/ManagedEnvironments.json
  - Microsoft.App/stable/2024-03-01/ManagedEnvironmentsDaprComponents.json
  - Microsoft.App/stable/2024-03-01/ManagedEnvironmentsStorages.json
  - Microsoft.App/stable/2024-03-01/SourceControls.json
  - Microsoft.App/stable/2024-03-01/Subscriptions.json
  - Microsoft.App/stable/2024-03-01/Usages.json
```
### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-11'
input-file:
  - Microsoft.App/preview/2023-11-02-preview/AppResiliency.json
  - Microsoft.App/preview/2023-11-02-preview/AuthConfigs.json
  - Microsoft.App/preview/2023-11-02-preview/AvailableWorkloadProfiles.json
  - Microsoft.App/preview/2023-11-02-preview/BillingMeters.json
  - Microsoft.App/preview/2023-11-02-preview/Builders.json
  - Microsoft.App/preview/2023-11-02-preview/Builds.json
  - Microsoft.App/preview/2023-11-02-preview/CommonDefinitions.json
  - Microsoft.App/preview/2023-11-02-preview/ConnectedEnvironments.json
  - Microsoft.App/preview/2023-11-02-preview/ConnectedEnvironmentsCertificates.json
  - Microsoft.App/preview/2023-11-02-preview/ConnectedEnvironmentsDaprComponents.json
  - Microsoft.App/preview/2023-11-02-preview/ConnectedEnvironmentsStorages.json
  - Microsoft.App/preview/2023-11-02-preview/ContainerApps.json
  - Microsoft.App/preview/2023-11-02-preview/ContainerAppsRevisions.json
  - Microsoft.App/preview/2023-11-02-preview/Diagnostics.json
  - Microsoft.App/preview/2023-11-02-preview/Global.json
  - Microsoft.App/preview/2023-11-02-preview/Jobs.json
  - Microsoft.App/preview/2023-11-02-preview/ManagedEnvironments.json
  - Microsoft.App/preview/2023-11-02-preview/ManagedEnvironmentsDaprComponentResiliencyPolicies.json
  - Microsoft.App/preview/2023-11-02-preview/ManagedEnvironmentsDaprComponents.json
  - Microsoft.App/preview/2023-11-02-preview/ManagedEnvironmentsDaprSubscriptions.json
  - Microsoft.App/preview/2023-11-02-preview/ManagedEnvironmentsStorages.json
  - Microsoft.App/preview/2023-11-02-preview/SourceControls.json
  - Microsoft.App/preview/2023-11-02-preview/Subscriptions.json
  - Microsoft.App/preview/2023-11-02-preview/Usages.json
  - Microsoft.App/preview/2023-11-02-preview/JavaComponents.json
  - Microsoft.App/preview/2023-11-02-preview/DotNetComponents.json
```

### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-08'
input-file:
  - Microsoft.App/preview/2023-08-01-preview/AppResiliency.json
  - Microsoft.App/preview/2023-08-01-preview/AuthConfigs.json
  - Microsoft.App/preview/2023-08-01-preview/AvailableWorkloadProfiles.json
  - Microsoft.App/preview/2023-08-01-preview/BillingMeters.json
  - Microsoft.App/preview/2023-08-01-preview/Builders.json
  - Microsoft.App/preview/2023-08-01-preview/Builds.json
  - Microsoft.App/preview/2023-08-01-preview/CommonDefinitions.json
  - Microsoft.App/preview/2023-08-01-preview/ConnectedEnvironments.json
  - Microsoft.App/preview/2023-08-01-preview/ConnectedEnvironmentsCertificates.json
  - Microsoft.App/preview/2023-08-01-preview/ConnectedEnvironmentsDaprComponents.json
  - Microsoft.App/preview/2023-08-01-preview/ConnectedEnvironmentsStorages.json
  - Microsoft.App/preview/2023-08-01-preview/ContainerApps.json
  - Microsoft.App/preview/2023-08-01-preview/ContainerAppsRevisions.json
  - Microsoft.App/preview/2023-08-01-preview/Diagnostics.json
  - Microsoft.App/preview/2023-08-01-preview/Global.json
  - Microsoft.App/preview/2023-08-01-preview/Jobs.json
  - Microsoft.App/preview/2023-08-01-preview/ManagedEnvironments.json
  - Microsoft.App/preview/2023-08-01-preview/ManagedEnvironmentsDaprComponents.json
  - Microsoft.App/preview/2023-08-01-preview/ManagedEnvironmentsDaprComponentResiliencyPolicies.json
  - Microsoft.App/preview/2023-08-01-preview/ManagedEnvironmentsDaprSubscriptions.json
  - Microsoft.App/preview/2023-08-01-preview/ManagedEnvironmentsStorages.json
  - Microsoft.App/preview/2023-08-01-preview/SourceControls.json
  - Microsoft.App/preview/2023-08-01-preview/Subscriptions.json
  - Microsoft.App/preview/2023-08-01-preview/Usages.json
directive:
  - suppress: OperationIdNounVerb
    from: Builds.json
    reason: |
      The linting thinks that 'Builder' in 'Builds_ListByBuilderResource' is a noun, while it
      is really the parent.
  - suppress: LroErrorContent
    from: Builds.json
    reason: |
      We are not using the common error response for these new resources to promote consistency 
      with the rest of the Microsoft.App RP, as it also doesn't use the common-types error.
  - suppress: LroErrorContent
    from: Builders.json
    reason: |
      We are not using the common error response for these new resources to promote consistency 
      with the rest of the Microsoft.App RP, as it also doesn't use the common-types error.
```

### Tag: package-preview-2023-05

These settings apply only when `--tag=package-preview-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-05'
input-file:
  - Microsoft.App/preview/2023-05-02-preview/AuthConfigs.json
  - Microsoft.App/preview/2023-05-02-preview/AvailableWorkloadProfiles.json
  - Microsoft.App/preview/2023-05-02-preview/BillingMeters.json
  - Microsoft.App/preview/2023-05-02-preview/CommonDefinitions.json
  - Microsoft.App/preview/2023-05-02-preview/ConnectedEnvironments.json
  - Microsoft.App/preview/2023-05-02-preview/ConnectedEnvironmentsCertificates.json
  - Microsoft.App/preview/2023-05-02-preview/ConnectedEnvironmentsDaprComponents.json
  - Microsoft.App/preview/2023-05-02-preview/ConnectedEnvironmentsStorages.json
  - Microsoft.App/preview/2023-05-02-preview/ContainerApps.json
  - Microsoft.App/preview/2023-05-02-preview/ContainerAppsRevisions.json
  - Microsoft.App/preview/2023-05-02-preview/Diagnostics.json
  - Microsoft.App/preview/2023-05-02-preview/Global.json
  - Microsoft.App/preview/2023-05-02-preview/Jobs.json
  - Microsoft.App/preview/2023-05-02-preview/ManagedEnvironments.json
  - Microsoft.App/preview/2023-05-02-preview/ManagedEnvironmentsDaprComponents.json
  - Microsoft.App/preview/2023-05-02-preview/ManagedEnvironmentsStorages.json
  - Microsoft.App/preview/2023-05-02-preview/SourceControls.json
  - Microsoft.App/preview/2023-05-02-preview/Subscriptions.json
  - Microsoft.App/preview/2023-05-02-preview/Usages.json
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-2023-05'
input-file:
  - Microsoft.App/stable/2023-05-01/AuthConfigs.json
  - Microsoft.App/stable/2023-05-01/AvailableWorkloadProfiles.json
  - Microsoft.App/stable/2023-05-01/BillingMeters.json
  - Microsoft.App/stable/2023-05-01/CommonDefinitions.json
  - Microsoft.App/stable/2023-05-01/ConnectedEnvironments.json
  - Microsoft.App/stable/2023-05-01/ConnectedEnvironmentsCertificates.json
  - Microsoft.App/stable/2023-05-01/ConnectedEnvironmentsDaprComponents.json
  - Microsoft.App/stable/2023-05-01/ConnectedEnvironmentsStorages.json
  - Microsoft.App/stable/2023-05-01/ContainerApps.json
  - Microsoft.App/stable/2023-05-01/ContainerAppsRevisions.json
  - Microsoft.App/stable/2023-05-01/Diagnostics.json
  - Microsoft.App/stable/2023-05-01/Global.json
  - Microsoft.App/stable/2023-05-01/Jobs.json
  - Microsoft.App/stable/2023-05-01/ManagedEnvironments.json
  - Microsoft.App/stable/2023-05-01/ManagedEnvironmentsDaprComponents.json
  - Microsoft.App/stable/2023-05-01/ManagedEnvironmentsStorages.json
  - Microsoft.App/stable/2023-05-01/SourceControls.json
```

### Tag: package-preview-2023-04

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-04'
input-file:
  - Microsoft.App/preview/2023-04-01-preview/AuthConfigs.json
  - Microsoft.App/preview/2023-04-01-preview/AvailableWorkloadProfiles.json
  - Microsoft.App/preview/2023-04-01-preview/BillingMeters.json
  - Microsoft.App/preview/2023-04-01-preview/CommonDefinitions.json
  - Microsoft.App/preview/2023-04-01-preview/ConnectedEnvironments.json
  - Microsoft.App/preview/2023-04-01-preview/ConnectedEnvironmentsCertificates.json
  - Microsoft.App/preview/2023-04-01-preview/ConnectedEnvironmentsDaprComponents.json
  - Microsoft.App/preview/2023-04-01-preview/ConnectedEnvironmentsStorages.json
  - Microsoft.App/preview/2023-04-01-preview/ContainerApps.json
  - Microsoft.App/preview/2023-04-01-preview/ContainerAppsRevisions.json
  - Microsoft.App/preview/2023-04-01-preview/Diagnostics.json
  - Microsoft.App/preview/2023-04-01-preview/Global.json
  - Microsoft.App/preview/2023-04-01-preview/Jobs.json
  - Microsoft.App/preview/2023-04-01-preview/ManagedEnvironments.json
  - Microsoft.App/preview/2023-04-01-preview/ManagedEnvironmentsDaprComponents.json
  - Microsoft.App/preview/2023-04-01-preview/ManagedEnvironmentsStorages.json
  - Microsoft.App/preview/2023-04-01-preview/SourceControls.json
```

### Tag: package-preview-2022-11

These settings apply only when `--tag=package-preview-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-11'
input-file:
  - Microsoft.App/preview/2022-11-01-preview/AuthConfigs.json
  - Microsoft.App/preview/2022-11-01-preview/AvailableWorkloadProfiles.json
  - Microsoft.App/preview/2022-11-01-preview/BillingMeters.json
  - Microsoft.App/preview/2022-11-01-preview/CommonDefinitions.json
  - Microsoft.App/preview/2022-11-01-preview/ConnectedEnvironments.json
  - Microsoft.App/preview/2022-11-01-preview/ConnectedEnvironmentsCertificates.json
  - Microsoft.App/preview/2022-11-01-preview/ConnectedEnvironmentsDaprComponents.json
  - Microsoft.App/preview/2022-11-01-preview/ConnectedEnvironmentsStorages.json
  - Microsoft.App/preview/2022-11-01-preview/ContainerApps.json
  - Microsoft.App/preview/2022-11-01-preview/Jobs.json
  - Microsoft.App/preview/2022-11-01-preview/ContainerAppsRevisions.json
  - Microsoft.App/preview/2022-11-01-preview/Diagnostics.json
  - Microsoft.App/preview/2022-11-01-preview/Global.json
  - Microsoft.App/preview/2022-11-01-preview/ManagedEnvironments.json
  - Microsoft.App/preview/2022-11-01-preview/ManagedEnvironmentsDaprComponents.json
  - Microsoft.App/preview/2022-11-01-preview/ManagedEnvironmentsStorages.json
  - Microsoft.App/preview/2022-11-01-preview/SourceControls.json
```

### Tag: package-2022-10

These settings apply only when `--tag=package-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-2022-10'
input-file:
  - Microsoft.App/stable/2022-10-01/AuthConfigs.json
  - Microsoft.App/stable/2022-10-01/AvailableWorkloadProfiles.json
  - Microsoft.App/stable/2022-10-01/BillingMeters.json
  - Microsoft.App/stable/2022-10-01/CommonDefinitions.json
  - Microsoft.App/stable/2022-10-01/ConnectedEnvironments.json
  - Microsoft.App/stable/2022-10-01/ConnectedEnvironmentsCertificates.json
  - Microsoft.App/stable/2022-10-01/ConnectedEnvironmentsDaprComponents.json
  - Microsoft.App/stable/2022-10-01/ConnectedEnvironmentsStorages.json
  - Microsoft.App/stable/2022-10-01/ContainerApps.json
  - Microsoft.App/stable/2022-10-01/ContainerAppsRevisions.json
  - Microsoft.App/stable/2022-10-01/Diagnostics.json
  - Microsoft.App/stable/2022-10-01/Global.json
  - Microsoft.App/stable/2022-10-01/ManagedEnvironments.json
  - Microsoft.App/stable/2022-10-01/ManagedEnvironmentsDaprComponents.json
  - Microsoft.App/stable/2022-10-01/ManagedEnvironmentsStorages.json
  - Microsoft.App/stable/2022-10-01/SourceControls.json
```

### Tag: package-preview-2022-06

These settings apply only when `--tag=package-preview-2022-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-06'
input-file:
  - Microsoft.App/preview/2022-06-01-preview/AuthConfigs.json
  - Microsoft.App/preview/2022-06-01-preview/CommonDefinitions.json
  - Microsoft.App/preview/2022-06-01-preview/ContainerApps.json
  - Microsoft.App/preview/2022-06-01-preview/ContainerAppsRevisions.json
  - Microsoft.App/preview/2022-06-01-preview/ManagedEnvironmentsDaprComponents.json
  - Microsoft.App/preview/2022-06-01-preview/Diagnostics.json
  - Microsoft.App/preview/2022-06-01-preview/Global.json
  - Microsoft.App/preview/2022-06-01-preview/ManagedEnvironments.json
  - Microsoft.App/preview/2022-06-01-preview/ManagedEnvironmentsStorages.json
  - Microsoft.App/preview/2022-06-01-preview/SourceControls.json
  - Microsoft.App/preview/2022-06-01-preview/ConnectedEnvironments.json
  - Microsoft.App/preview/2022-06-01-preview/ConnectedEnvironmentsCertificates.json
  - Microsoft.App/preview/2022-06-01-preview/ConnectedEnvironmentsDaprComponents.json
  - Microsoft.App/preview/2022-06-01-preview/ConnectedEnvironmentsStorages.json
  - Microsoft.App/preview/2022-06-01-preview/AvailableWorkloadProfiles.json
  - Microsoft.App/preview/2022-06-01-preview/BillingMeters.json
directive:
- suppress: R3018
  from: AuthConfigs.json
  reason: Use of boolean type is required
- suppress: R3016
  from: AuthConfigs.json
  reason: Use disableWWWAuthenticate to align with AuthSettingV2
```

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-2022-03'
input-file:
  - Microsoft.App/stable/2022-03-01/AuthConfigs.json
  - Microsoft.App/stable/2022-03-01/CommonDefinitions.json
  - Microsoft.App/stable/2022-03-01/ContainerApps.json
  - Microsoft.App/stable/2022-03-01/ContainerAppsRevisions.json
  - Microsoft.App/stable/2022-03-01/DaprComponents.json
  - Microsoft.App/stable/2022-03-01/Global.json
  - Microsoft.App/stable/2022-03-01/ManagedEnvironments.json
  - Microsoft.App/stable/2022-03-01/ManagedEnvironmentsStorages.json
  - Microsoft.App/stable/2022-03-01/SourceControls.json
directive:
- suppress: R3018
  from: AuthConfigs.json
  reason: Use of boolean type is required
- suppress: R3016
  from: AuthConfigs.json
  reason: Use disableWWWAuthenticate to align with AuthSettingV2
```

### Tag: package-2022-01-01-preview

These settings apply only when `--tag=package-2022-01-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-01-01-preview'
input-file:
  - Microsoft.App/preview/2022-01-01-preview/CommonDefinitions.json
  - Microsoft.App/preview/2022-01-01-preview/ContainerApps.json
  - Microsoft.App/preview/2022-01-01-preview/ContainerAppsRevisions.json
  - Microsoft.App/preview/2022-01-01-preview/ManagedEnvironments.json
  - Microsoft.App/preview/2022-01-01-preview/Global.json
  - Microsoft.App/preview/2022-01-01-preview/SourceControls.json
  - Microsoft.App/preview/2022-01-01-preview/DaprComponents.json
  - Microsoft.App/preview/2022-01-01-preview/AuthConfigs.json
  - Microsoft.App/preview/2022-01-01-preview/ManagedEnvironmentsStorages.json
directive:
- suppress: R4009
  from: ContainerAppsRevisions.json
  reason: False positive. This is not a tracked resource.
- suppress: R3010
  from: Global.json
  reason: False positive. The Revisions_list api already defined
- suppress: R3010
  from: ManagedEnvironments.json
  reason: False positive. The Revisions_list api already defined
- suppress: R3010
  from: ContainerAppsRevisions.json
  reason: False positive. The Revisions_list api already defined
- suppress: R3010
  from: CommonDefinitions.json
  reason: False positive. The Revisions_list api already defined
- suppress: R3010
  from: ContainerApps.json
  reason: False positive. The Revisions_list api already defined
- suppress: R3018
  from: Global.json
  reason: Use of boolean type is required
- suppress: R3018
  from: CommonDefinitions.json
  reason: Use of boolean type is required
- suppress: R3018
  from: ContainerApps.json
  reason: Use of boolean type is required
- suppress: R3018
  from: AuthConfigs.json
  reason: Use of boolean type is required
- suppress: R3016
  from: AuthConfigs.json
  reason: Use disableWWWAuthenticate to align with AuthSettingV2
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
  - repo: azure-powershell
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
