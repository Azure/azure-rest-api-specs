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
tag: package-preview-2025-02-02-preview
```

### Suppression

``` yaml
directive:
  - suppress: PatchBodyParametersSchema
    from: JavaComponents.json
    reason: |
      Java Component is using componentType as the discriminator. While the discriminator is a required property, this rule prevent it being present in the patch request body.
  - suppress: PatchBodyParametersSchema
    from: ManagedEnvironments.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}"].patch.parameters[3].schema.properties.identity
    reason: False positive based on Azure common types. Managed Service Identity requires type, and the Managed Service Identity can be patched.
```

### Tag: package-2025-01-01

These settings apply only when `--tag=package-2025-01-01` is specified on the command line.

```yaml $(tag) == 'package-2025-01-01'
input-file:
  - stable/2025-01-01/AuthConfigs.json
  - stable/2025-01-01/AvailableWorkloadProfiles.json
  - stable/2025-01-01/BillingMeters.json
  - stable/2025-01-01/CommonDefinitions.json
  - stable/2025-01-01/ConnectedEnvironments.json
  - stable/2025-01-01/ConnectedEnvironmentsCertificates.json
  - stable/2025-01-01/ConnectedEnvironmentsDaprComponents.json
  - stable/2025-01-01/ConnectedEnvironmentsStorages.json
  - stable/2025-01-01/ContainerApps.json
  - stable/2025-01-01/ContainerAppsRevisions.json
  - stable/2025-01-01/Diagnostics.json
  - stable/2025-01-01/Global.json
  - stable/2025-01-01/JavaComponents.json
  - stable/2025-01-01/Jobs.json
  - stable/2025-01-01/ManagedEnvironments.json
  - stable/2025-01-01/ManagedEnvironmentsDaprComponents.json
  - stable/2025-01-01/ManagedEnvironmentsStorages.json
  - stable/2025-01-01/SessionPools.json
  - stable/2025-01-01/SourceControls.json
  - stable/2025-01-01/Subscriptions.json
  - stable/2025-01-01/Usages.json
directive:
  - suppress: PatchBodyParametersSchema
    from: SessionPools.json
    reason: |
      Session Pool is using managed identity. While the type is a required property, this rule prevent it being present in the patch request body.
  - suppress: PutResponseCodes
    from: ConnectedEnvironmentsCertificates.json
    reason: |
      Do not introduce breaking changes in GA services
  - suppress: PutResponseCodes
    from: ConnectedEnvironmentsDaprComponents.json
    reason: |
      Do not introduce breaking changes in GA services
  - suppress: PutResponseCodes
    from: ConnectedEnvironmentsStorages.json
    reason: |
      Do not introduce breaking changes in GA services
```

### Tag: package-preview-2025-02-02-preview

These settings apply only when `--tag=package-preview-2025-02-02-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-02-02-preview'
input-file:
  - preview/2025-02-02-preview/AppResiliency.json
  - preview/2025-02-02-preview/AuthConfigs.json
  - preview/2025-02-02-preview/AvailableWorkloadProfiles.json
  - preview/2025-02-02-preview/BillingMeters.json
  - preview/2025-02-02-preview/Builders.json
  - preview/2025-02-02-preview/Builds.json
  - preview/2025-02-02-preview/CommonDefinitions.json
  - preview/2025-02-02-preview/ConnectedEnvironments.json
  - preview/2025-02-02-preview/ConnectedEnvironmentsCertificates.json
  - preview/2025-02-02-preview/ConnectedEnvironmentsDaprComponents.json
  - preview/2025-02-02-preview/ConnectedEnvironmentsStorages.json
  - preview/2025-02-02-preview/ContainerApps.json
  - preview/2025-02-02-preview/ContainerAppsBuilds.json
  - preview/2025-02-02-preview/ContainerAppsLabelHistory.json
  - preview/2025-02-02-preview/ContainerAppsPatches.json
  - preview/2025-02-02-preview/ContainerAppsRevisions.json
  - preview/2025-02-02-preview/Diagnostics.json
  - preview/2025-02-02-preview/DotNetComponents.json
  - preview/2025-02-02-preview/FunctionsExtension.json
  - preview/2025-02-02-preview/Global.json
  - preview/2025-02-02-preview/JavaComponents.json
  - preview/2025-02-02-preview/Jobs.json
  - preview/2025-02-02-preview/LogicAppsExtension.json
  - preview/2025-02-02-preview/ManagedEnvironments.json
  - preview/2025-02-02-preview/ManagedEnvironmentsDaprComponentResiliencyPolicies.json
  - preview/2025-02-02-preview/ManagedEnvironmentsDaprComponents.json
  - preview/2025-02-02-preview/ManagedEnvironmentsDaprSubscriptions.json
  - preview/2025-02-02-preview/ManagedEnvironmentsHttpRouteConfig.json
  - preview/2025-02-02-preview/ManagedEnvironmentsMaintenanceConfigurations.json
  - preview/2025-02-02-preview/ManagedEnvironmentsStorages.json
  - preview/2025-02-02-preview/SessionPools.json
  - preview/2025-02-02-preview/SourceControls.json
  - preview/2025-02-02-preview/Subscriptions.json
  - preview/2025-02-02-preview/Usages.json
directive:
  - suppress: AvoidAdditionalProperties
    from: CommonDefinitions.json    
    where:
      - $.definitions.DaprSubscription.properties.properties.properties.metadata
      - $.definitions.ServiceBind.properties.customizedKeys
    reason: |
      Do not introduce breaking changes in GA services
  - suppress: TrackedExtensionResourcesAreNotAllowed
    from: LogicAppsExtension.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/providers/Microsoft.App/logicApps/{logicAppName}/workflows/{workflowName}"].get
    reason: |
      Do not introduce breaking changes in GA services
```

### Tag: package-preview-2024-10

These settings apply only when `--tag=package-preview-2024-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-10'
input-file:
  - preview/2024-10-02-preview/AppResiliency.json
  - preview/2024-10-02-preview/AuthConfigs.json
  - preview/2024-10-02-preview/AvailableWorkloadProfiles.json
  - preview/2024-10-02-preview/BillingMeters.json
  - preview/2024-10-02-preview/Builders.json
  - preview/2024-10-02-preview/Builds.json
  - preview/2024-10-02-preview/CommonDefinitions.json
  - preview/2024-10-02-preview/ConnectedEnvironments.json
  - preview/2024-10-02-preview/ConnectedEnvironmentsCertificates.json
  - preview/2024-10-02-preview/ConnectedEnvironmentsDaprComponents.json
  - preview/2024-10-02-preview/ConnectedEnvironmentsStorages.json
  - preview/2024-10-02-preview/ContainerApps.json
  - preview/2024-10-02-preview/ContainerAppsBuilds.json
  - preview/2024-10-02-preview/ContainerAppsPatches.json
  - preview/2024-10-02-preview/ContainerAppsLabelHistory.json
  - preview/2024-10-02-preview/ContainerAppsRevisions.json
  - preview/2024-10-02-preview/Diagnostics.json
  - preview/2024-10-02-preview/DotNetComponents.json
  - preview/2024-10-02-preview/FunctionsExtension.json
  - preview/2024-10-02-preview/Global.json
  - preview/2024-10-02-preview/JavaComponents.json
  - preview/2024-10-02-preview/Jobs.json
  - preview/2024-10-02-preview/LogicAppsExtension.json
  - preview/2024-10-02-preview/ManagedEnvironments.json
  - preview/2024-10-02-preview/ManagedEnvironmentsDaprComponentResiliencyPolicies.json
  - preview/2024-10-02-preview/ManagedEnvironmentsDaprComponents.json
  - preview/2024-10-02-preview/ManagedEnvironmentsDaprSubscriptions.json
  - preview/2024-10-02-preview/ManagedEnvironmentsHttpRouteConfig.json
  - preview/2024-10-02-preview/ManagedEnvironmentsMaintenanceConfigurations.json
  - preview/2024-10-02-preview/ManagedEnvironmentsStorages.json
  - preview/2024-10-02-preview/SessionPools.json
  - preview/2024-10-02-preview/SourceControls.json
  - preview/2024-10-02-preview/Subscriptions.json
  - preview/2024-10-02-preview/Usages.json
directive:
  - suppress: PatchBodyParametersSchema
    from: SessionPools.json
    reason: |
      Session Pool is using componentType as the discriminator. While the discriminator is a required property, this rule prevent it being present in the patch request body.
```

### Tag: package-preview-2024-08

These settings apply only when `--tag=package-preview-2024-08` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-08'
input-file:
  - preview/2024-08-02-preview/AppResiliency.json
  - preview/2024-08-02-preview/AuthConfigs.json
  - preview/2024-08-02-preview/AvailableWorkloadProfiles.json
  - preview/2024-08-02-preview/BillingMeters.json
  - preview/2024-08-02-preview/Builders.json
  - preview/2024-08-02-preview/Builds.json
  - preview/2024-08-02-preview/CommonDefinitions.json
  - preview/2024-08-02-preview/ConnectedEnvironments.json
  - preview/2024-08-02-preview/ConnectedEnvironmentsCertificates.json
  - preview/2024-08-02-preview/ConnectedEnvironmentsDaprComponents.json
  - preview/2024-08-02-preview/ConnectedEnvironmentsStorages.json
  - preview/2024-08-02-preview/ContainerApps.json
  - preview/2024-08-02-preview/ContainerAppsBuilds.json
  - preview/2024-08-02-preview/ContainerAppsPatches.json
  - preview/2024-08-02-preview/ContainerAppsRevisions.json
  - preview/2024-08-02-preview/Diagnostics.json
  - preview/2024-08-02-preview/DotNetComponents.json
  - preview/2024-08-02-preview/FunctionsExtension.json
  - preview/2024-08-02-preview/Global.json
  - preview/2024-08-02-preview/JavaComponents.json
  - preview/2024-08-02-preview/Jobs.json
  - preview/2024-08-02-preview/LogicAppsExtension.json
  - preview/2024-08-02-preview/ManagedEnvironments.json
  - preview/2024-08-02-preview/ManagedEnvironmentsDaprComponentResiliencyPolicies.json
  - preview/2024-08-02-preview/ManagedEnvironmentsDaprComponents.json
  - preview/2024-08-02-preview/ManagedEnvironmentsDaprSubscriptions.json
  - preview/2024-08-02-preview/ManagedEnvironmentsStorages.json
  - preview/2024-08-02-preview/SessionPools.json
  - preview/2024-08-02-preview/SourceControls.json
  - preview/2024-08-02-preview/Subscriptions.json
  - preview/2024-08-02-preview/Usages.json
directive:
  - suppress: PatchBodyParametersSchema
    from: JavaComponents.json
    reason: |
      Java Component is using componentType as the discriminator. While the discriminator is a required property, this rule prevent it being present in the patch request body.
```

### Tag: package-preview-2024-02

These settings apply only when `--tag=package-preview-2024-02` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-02'
input-file:
  - preview/2024-02-02-preview/AppResiliency.json
  - preview/2024-02-02-preview/AuthConfigs.json
  - preview/2024-02-02-preview/AvailableWorkloadProfiles.json
  - preview/2024-02-02-preview/BillingMeters.json
  - preview/2024-02-02-preview/Builders.json
  - preview/2024-02-02-preview/Builds.json
  - preview/2024-02-02-preview/CommonDefinitions.json
  - preview/2024-02-02-preview/ConnectedEnvironments.json
  - preview/2024-02-02-preview/ConnectedEnvironmentsCertificates.json
  - preview/2024-02-02-preview/ConnectedEnvironmentsDaprComponents.json
  - preview/2024-02-02-preview/ConnectedEnvironmentsStorages.json
  - preview/2024-02-02-preview/ContainerApps.json
  - preview/2024-02-02-preview/ContainerAppsRevisions.json
  - preview/2024-02-02-preview/ContainerAppsBuilds.json
  - preview/2024-02-02-preview/ContainerAppsPatches.json
  - preview/2024-02-02-preview/Diagnostics.json
  - preview/2024-02-02-preview/DotNetComponents.json
  - preview/2024-02-02-preview/Global.json
  - preview/2024-02-02-preview/JavaComponents.json
  - preview/2024-02-02-preview/Jobs.json
  - preview/2024-02-02-preview/ManagedEnvironments.json
  - preview/2024-02-02-preview/ManagedEnvironmentsDaprComponentResiliencyPolicies.json
  - preview/2024-02-02-preview/ManagedEnvironmentsDaprComponents.json
  - preview/2024-02-02-preview/ManagedEnvironmentsDaprSubscriptions.json
  - preview/2024-02-02-preview/ManagedEnvironmentsStorages.json
  - preview/2024-02-02-preview/SourceControls.json
  - preview/2024-02-02-preview/Subscriptions.json
  - preview/2024-02-02-preview/Usages.json
  - preview/2024-02-02-preview/FunctionsExtension.json
  - preview/2024-02-02-preview/LogicAppsExtension.json
  - preview/2024-02-02-preview/SessionPools.json
directive:
  - suppress: PatchBodyParametersSchema
    from: JavaComponents.json
    reason: |
      Java Component is using componentType as the discriminator. While the discriminator is a required property, this rule prevent it being present in the patch request body.
  - suppress: LroErrorContent
    from: SessionPools.json
    reason: |
      Using the same error response as other APIs.
```

### Tag: package-2024-03

These settings apply only when `--tag=package-2024-03` is specified on the command line.

```yaml $(tag) == 'package-2024-03'
input-file:
  - stable/2024-03-01/AuthConfigs.json
  - stable/2024-03-01/AvailableWorkloadProfiles.json
  - stable/2024-03-01/BillingMeters.json
  - stable/2024-03-01/CommonDefinitions.json
  - stable/2024-03-01/ConnectedEnvironments.json
  - stable/2024-03-01/ConnectedEnvironmentsCertificates.json
  - stable/2024-03-01/ConnectedEnvironmentsDaprComponents.json
  - stable/2024-03-01/ConnectedEnvironmentsStorages.json
  - stable/2024-03-01/ContainerApps.json
  - stable/2024-03-01/ContainerAppsRevisions.json
  - stable/2024-03-01/Diagnostics.json
  - stable/2024-03-01/Global.json
  - stable/2024-03-01/Jobs.json
  - stable/2024-03-01/ManagedEnvironments.json
  - stable/2024-03-01/ManagedEnvironmentsDaprComponents.json
  - stable/2024-03-01/ManagedEnvironmentsStorages.json
  - stable/2024-03-01/SourceControls.json
  - stable/2024-03-01/Subscriptions.json
  - stable/2024-03-01/Usages.json
```

### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-11'
input-file:
  - preview/2023-11-02-preview/AppResiliency.json
  - preview/2023-11-02-preview/AuthConfigs.json
  - preview/2023-11-02-preview/AvailableWorkloadProfiles.json
  - preview/2023-11-02-preview/BillingMeters.json
  - preview/2023-11-02-preview/Builders.json
  - preview/2023-11-02-preview/Builds.json
  - preview/2023-11-02-preview/CommonDefinitions.json
  - preview/2023-11-02-preview/ConnectedEnvironments.json
  - preview/2023-11-02-preview/ConnectedEnvironmentsCertificates.json
  - preview/2023-11-02-preview/ConnectedEnvironmentsDaprComponents.json
  - preview/2023-11-02-preview/ConnectedEnvironmentsStorages.json
  - preview/2023-11-02-preview/ContainerApps.json
  - preview/2023-11-02-preview/ContainerAppsRevisions.json
  - preview/2023-11-02-preview/Diagnostics.json
  - preview/2023-11-02-preview/Global.json
  - preview/2023-11-02-preview/Jobs.json
  - preview/2023-11-02-preview/ManagedEnvironments.json
  - preview/2023-11-02-preview/ManagedEnvironmentsDaprComponentResiliencyPolicies.json
  - preview/2023-11-02-preview/ManagedEnvironmentsDaprComponents.json
  - preview/2023-11-02-preview/ManagedEnvironmentsDaprSubscriptions.json
  - preview/2023-11-02-preview/ManagedEnvironmentsStorages.json
  - preview/2023-11-02-preview/SourceControls.json
  - preview/2023-11-02-preview/Subscriptions.json
  - preview/2023-11-02-preview/Usages.json
  - preview/2023-11-02-preview/JavaComponents.json
  - preview/2023-11-02-preview/DotNetComponents.json
```

### Tag: package-preview-2023-08

These settings apply only when `--tag=package-preview-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-08'
input-file:
  - preview/2023-08-01-preview/AppResiliency.json
  - preview/2023-08-01-preview/AuthConfigs.json
  - preview/2023-08-01-preview/AvailableWorkloadProfiles.json
  - preview/2023-08-01-preview/BillingMeters.json
  - preview/2023-08-01-preview/Builders.json
  - preview/2023-08-01-preview/Builds.json
  - preview/2023-08-01-preview/CommonDefinitions.json
  - preview/2023-08-01-preview/ConnectedEnvironments.json
  - preview/2023-08-01-preview/ConnectedEnvironmentsCertificates.json
  - preview/2023-08-01-preview/ConnectedEnvironmentsDaprComponents.json
  - preview/2023-08-01-preview/ConnectedEnvironmentsStorages.json
  - preview/2023-08-01-preview/ContainerApps.json
  - preview/2023-08-01-preview/ContainerAppsRevisions.json
  - preview/2023-08-01-preview/Diagnostics.json
  - preview/2023-08-01-preview/Global.json
  - preview/2023-08-01-preview/Jobs.json
  - preview/2023-08-01-preview/ManagedEnvironments.json
  - preview/2023-08-01-preview/ManagedEnvironmentsDaprComponents.json
  - preview/2023-08-01-preview/ManagedEnvironmentsDaprComponentResiliencyPolicies.json
  - preview/2023-08-01-preview/ManagedEnvironmentsDaprSubscriptions.json
  - preview/2023-08-01-preview/ManagedEnvironmentsStorages.json
  - preview/2023-08-01-preview/SourceControls.json
  - preview/2023-08-01-preview/Subscriptions.json
  - preview/2023-08-01-preview/Usages.json
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
  - preview/2023-05-02-preview/AuthConfigs.json
  - preview/2023-05-02-preview/AvailableWorkloadProfiles.json
  - preview/2023-05-02-preview/BillingMeters.json
  - preview/2023-05-02-preview/CommonDefinitions.json
  - preview/2023-05-02-preview/ConnectedEnvironments.json
  - preview/2023-05-02-preview/ConnectedEnvironmentsCertificates.json
  - preview/2023-05-02-preview/ConnectedEnvironmentsDaprComponents.json
  - preview/2023-05-02-preview/ConnectedEnvironmentsStorages.json
  - preview/2023-05-02-preview/ContainerApps.json
  - preview/2023-05-02-preview/ContainerAppsRevisions.json
  - preview/2023-05-02-preview/Diagnostics.json
  - preview/2023-05-02-preview/Global.json
  - preview/2023-05-02-preview/Jobs.json
  - preview/2023-05-02-preview/ManagedEnvironments.json
  - preview/2023-05-02-preview/ManagedEnvironmentsDaprComponents.json
  - preview/2023-05-02-preview/ManagedEnvironmentsStorages.json
  - preview/2023-05-02-preview/SourceControls.json
  - preview/2023-05-02-preview/Subscriptions.json
  - preview/2023-05-02-preview/Usages.json
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-2023-05'
input-file:
  - stable/2023-05-01/AuthConfigs.json
  - stable/2023-05-01/AvailableWorkloadProfiles.json
  - stable/2023-05-01/BillingMeters.json
  - stable/2023-05-01/CommonDefinitions.json
  - stable/2023-05-01/ConnectedEnvironments.json
  - stable/2023-05-01/ConnectedEnvironmentsCertificates.json
  - stable/2023-05-01/ConnectedEnvironmentsDaprComponents.json
  - stable/2023-05-01/ConnectedEnvironmentsStorages.json
  - stable/2023-05-01/ContainerApps.json
  - stable/2023-05-01/ContainerAppsRevisions.json
  - stable/2023-05-01/Diagnostics.json
  - stable/2023-05-01/Global.json
  - stable/2023-05-01/Jobs.json
  - stable/2023-05-01/ManagedEnvironments.json
  - stable/2023-05-01/ManagedEnvironmentsDaprComponents.json
  - stable/2023-05-01/ManagedEnvironmentsStorages.json
  - stable/2023-05-01/SourceControls.json
```

### Tag: package-preview-2023-04

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-04'
input-file:
  - preview/2023-04-01-preview/AuthConfigs.json
  - preview/2023-04-01-preview/AvailableWorkloadProfiles.json
  - preview/2023-04-01-preview/BillingMeters.json
  - preview/2023-04-01-preview/CommonDefinitions.json
  - preview/2023-04-01-preview/ConnectedEnvironments.json
  - preview/2023-04-01-preview/ConnectedEnvironmentsCertificates.json
  - preview/2023-04-01-preview/ConnectedEnvironmentsDaprComponents.json
  - preview/2023-04-01-preview/ConnectedEnvironmentsStorages.json
  - preview/2023-04-01-preview/ContainerApps.json
  - preview/2023-04-01-preview/ContainerAppsRevisions.json
  - preview/2023-04-01-preview/Diagnostics.json
  - preview/2023-04-01-preview/Global.json
  - preview/2023-04-01-preview/Jobs.json
  - preview/2023-04-01-preview/ManagedEnvironments.json
  - preview/2023-04-01-preview/ManagedEnvironmentsDaprComponents.json
  - preview/2023-04-01-preview/ManagedEnvironmentsStorages.json
  - preview/2023-04-01-preview/SourceControls.json
```

### Tag: package-preview-2022-11

These settings apply only when `--tag=package-preview-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-11'
input-file:
  - preview/2022-11-01-preview/AuthConfigs.json
  - preview/2022-11-01-preview/AvailableWorkloadProfiles.json
  - preview/2022-11-01-preview/BillingMeters.json
  - preview/2022-11-01-preview/CommonDefinitions.json
  - preview/2022-11-01-preview/ConnectedEnvironments.json
  - preview/2022-11-01-preview/ConnectedEnvironmentsCertificates.json
  - preview/2022-11-01-preview/ConnectedEnvironmentsDaprComponents.json
  - preview/2022-11-01-preview/ConnectedEnvironmentsStorages.json
  - preview/2022-11-01-preview/ContainerApps.json
  - preview/2022-11-01-preview/Jobs.json
  - preview/2022-11-01-preview/ContainerAppsRevisions.json
  - preview/2022-11-01-preview/Diagnostics.json
  - preview/2022-11-01-preview/Global.json
  - preview/2022-11-01-preview/ManagedEnvironments.json
  - preview/2022-11-01-preview/ManagedEnvironmentsDaprComponents.json
  - preview/2022-11-01-preview/ManagedEnvironmentsStorages.json
  - preview/2022-11-01-preview/SourceControls.json
```

### Tag: package-2022-10

These settings apply only when `--tag=package-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-2022-10'
input-file:
  - stable/2022-10-01/AuthConfigs.json
  - stable/2022-10-01/AvailableWorkloadProfiles.json
  - stable/2022-10-01/BillingMeters.json
  - stable/2022-10-01/CommonDefinitions.json
  - stable/2022-10-01/ConnectedEnvironments.json
  - stable/2022-10-01/ConnectedEnvironmentsCertificates.json
  - stable/2022-10-01/ConnectedEnvironmentsDaprComponents.json
  - stable/2022-10-01/ConnectedEnvironmentsStorages.json
  - stable/2022-10-01/ContainerApps.json
  - stable/2022-10-01/ContainerAppsRevisions.json
  - stable/2022-10-01/Diagnostics.json
  - stable/2022-10-01/Global.json
  - stable/2022-10-01/ManagedEnvironments.json
  - stable/2022-10-01/ManagedEnvironmentsDaprComponents.json
  - stable/2022-10-01/ManagedEnvironmentsStorages.json
  - stable/2022-10-01/SourceControls.json
```

### Tag: package-preview-2022-06

These settings apply only when `--tag=package-preview-2022-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-06'
input-file:
  - preview/2022-06-01-preview/AuthConfigs.json
  - preview/2022-06-01-preview/CommonDefinitions.json
  - preview/2022-06-01-preview/ContainerApps.json
  - preview/2022-06-01-preview/ContainerAppsRevisions.json
  - preview/2022-06-01-preview/ManagedEnvironmentsDaprComponents.json
  - preview/2022-06-01-preview/Diagnostics.json
  - preview/2022-06-01-preview/Global.json
  - preview/2022-06-01-preview/ManagedEnvironments.json
  - preview/2022-06-01-preview/ManagedEnvironmentsStorages.json
  - preview/2022-06-01-preview/SourceControls.json
  - preview/2022-06-01-preview/ConnectedEnvironments.json
  - preview/2022-06-01-preview/ConnectedEnvironmentsCertificates.json
  - preview/2022-06-01-preview/ConnectedEnvironmentsDaprComponents.json
  - preview/2022-06-01-preview/ConnectedEnvironmentsStorages.json
  - preview/2022-06-01-preview/AvailableWorkloadProfiles.json
  - preview/2022-06-01-preview/BillingMeters.json
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
  - stable/2022-03-01/AuthConfigs.json
  - stable/2022-03-01/CommonDefinitions.json
  - stable/2022-03-01/ContainerApps.json
  - stable/2022-03-01/ContainerAppsRevisions.json
  - stable/2022-03-01/DaprComponents.json
  - stable/2022-03-01/Global.json
  - stable/2022-03-01/ManagedEnvironments.json
  - stable/2022-03-01/ManagedEnvironmentsStorages.json
  - stable/2022-03-01/SourceControls.json
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
  - preview/2022-01-01-preview/CommonDefinitions.json
  - preview/2022-01-01-preview/ContainerApps.json
  - preview/2022-01-01-preview/ContainerAppsRevisions.json
  - preview/2022-01-01-preview/ManagedEnvironments.json
  - preview/2022-01-01-preview/Global.json
  - preview/2022-01-01-preview/SourceControls.json
  - preview/2022-01-01-preview/DaprComponents.json
  - preview/2022-01-01-preview/AuthConfigs.json
  - preview/2022-01-01-preview/ManagedEnvironmentsStorages.json
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
