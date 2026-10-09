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
tag: package-2026-07-01
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
  - suppress: AvoidAdditionalProperties
    from: CommonDefinitions.json    
    where:
      - $.definitions.DaprSubscription.properties.properties.properties.metadata
      - $.definitions.ServiceBind.properties.customizedKeys
    reason: |
      Do not introduce breaking changes in GA services
```

### Tag: package-preview-2026-03-02-preview

These settings apply only when `--tag=package-preview-2026-03-02-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-03-02-preview'
input-file:
  - preview/2026-03-02-preview/openapi.json
directive:
  - suppress: PatchBodyParametersSchema
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}"].patch.parameters[4].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}"].patch.parameters[4].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}"].patch.parameters[4].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/javaComponents/{name}"].patch.parameters[5].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}"].patch.parameters[4].schema
    reason: |
      Pre-existing preview contract. Patch models retain required and defaulted properties for compatibility.
  - suppress: AvoidAdditionalProperties
    from: openapi.json
    where:
      - $.definitions.CustomScaleRule.properties.metadata
      - $.definitions.DaprSubscriptionProperties.properties.metadata
      - $.definitions.HttpScaleRule.properties.metadata
      - $.definitions.IdentityProviders.properties.customOpenIdConnectProviders
      - $.definitions.Object
      - $.definitions.ServiceBind.properties.customizedKeys
      - $.definitions.TcpScaleRule.properties.metadata
    reason: |
      Pre-existing dictionary contract. The validator reports these additionalProperties usages as errors.
  - suppress: PutResponseCodes
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/authConfigs/{authConfigName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/certificates/{certificateName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/daprComponents/{componentName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/managedCertificates/{managedCertificateName}"].put
    reason: |
      Pre-existing preview contract. Do not change response codes while restoring the preview surface.
  - suppress: PostResponseCodes
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/patches/{patchName}/skipConfig"].post
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/providers/Microsoft.App/logicApps/{logicAppName}/deployWorkflowArtifacts"].post
    reason: |
      Pre-existing preview contract. Do not change response codes while restoring the preview surface.
  - suppress: LroErrorContent
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/connectedEnvironments/{connectedEnvironmentName}"].delete.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/connectedEnvironments/{connectedEnvironmentName}"].put.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/sourcecontrols/{sourceControlName}"].delete.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/sourcecontrols/{sourceControlName}"].put.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}"].delete.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}/executions/{jobExecutionName}/stop"].post.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}"].patch.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}"].put.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}/start"].post.responses.default.schema["$ref"]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}/stop"].post.responses.default.schema["$ref"]
    reason: |
      Pre-existing preview contract. These operations use the service's existing error response shape.
  - suppress: ProvisioningStateMustBeReadOnly
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/builders/{builderName}/builds/{buildName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/builders/{builderName}/builds/{buildName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/builders/{builderName}/builds/{buildName}"].put.responses["201"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/builders/{builderName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/builders/{builderName}"].patch.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/builders/{builderName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/builders/{builderName}"].put.responses["201"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/builds/{buildName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}/resume"].post.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}/suspend"].post.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/dotNetComponents/{name}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/dotNetComponents/{name}"].patch.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/dotNetComponents/{name}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/dotNetComponents/{name}"].put.responses["201"].schema
    reason: |
      Pre-existing preview contract. Restored resource models preserve their original provisioningState behavior.
  - suppress: UnSupportedPatchProperties
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/dotNetComponents/{name}"].patch.parameters[5]
    reason: |
      Pre-existing preview contract. Patch request shapes are preserved for compatibility.
  - suppress: DescriptionMustNotBeNodeName
    from: openapi.json
    where:
      - $.definitions.BuilderProvisioningState["x-ms-enum"].values[*].description
      - $.definitions.BuildProvisioningState["x-ms-enum"].values[*].description
      - $.definitions.BuildStatus["x-ms-enum"].values[*].description
      - $.definitions.CertificateType["x-ms-enum"].values[*].description
      - $.definitions.Configuration.properties.activeRevisionsMode["x-ms-enum"].values[*].description
      - $.definitions.ContainerType["x-ms-enum"].values[*].description
      - $.definitions.DetectionStatus["x-ms-enum"].values[*].description
      - $.definitions.DotNetComponentProvisioningState["x-ms-enum"].values[*].description
      - $.definitions.DotNetComponentType["x-ms-enum"].values[*].description
      - $.definitions.ImageType["x-ms-enum"].values[*].description
      - $.definitions.IngressTargetPortHttpScheme["x-ms-enum"].values[*].description
      - $.definitions.JavaComponentType["x-ms-enum"].values[*].description
      - $.definitions.JobRunningState["x-ms-enum"].values[*].description
      - $.definitions.Level["x-ms-enum"].values[*].description
      - $.definitions.PatchApplyStatus["x-ms-enum"].values[*].description
      - $.definitions.PatchingMode["x-ms-enum"].values[*].description
      - $.definitions.PatchType["x-ms-enum"].values[*].description
      - $.definitions.Status["x-ms-enum"].values[*].description
      - $.definitions.StorageType["x-ms-enum"].values[*].description
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/providers/Microsoft.App/logicApps/{logicAppName}/invoke"].post.parameters[6]["x-ms-enum"].values[*].description
    reason: |
      Pre-existing preview contract. Existing wire-value descriptions are preserved without changing generated clients.
```

### Tag: package-2026-07-01
These settings apply only when `--tag=package-2026-07-01` is specified on the command line.

```yaml $(tag) == 'package-2026-07-01'
input-file:
  - stable/2026-07-01/openapi.json
directive:
  - suppress: PatchBodyParametersSchema
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}"].patch.parameters[4].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}"].patch.parameters[4].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}"].patch.parameters[4].schema.properties.properties
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}"].patch.parameters[4].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/javaComponents/{name}"].patch.parameters[5].schema.properties.properties
    reason: |
      The established Container App and Managed Environment PATCH schemas retain required
      location, Container App and Job PATCH retain nested required fields and defaults, and Java
      Component PATCH retains the required componentType discriminator. Changing those published
      request schemas would break the existing stable wire contract.
  - suppress: EnumInsteadOfBoolean
    from: openapi.json
    where: $.definitions.ContainerAppsFunctionProperties.properties.isDisabled
    reason: |
      isDisabled is an established boolean retained as deprecated read-only for wire compatibility;
      state is its string-enum replacement. Removing or changing isDisabled would break existing
      stable clients.
  - suppress: AvoidAdditionalProperties
    from: openapi.json
    where:
      - $.definitions.CustomScaleRule.properties.metadata
      - $.definitions.HttpScaleRule.properties.metadata
      - $.definitions.IdentityProviders.properties.customOpenIdConnectProviders
      - $.definitions.TcpScaleRule.properties.metadata
    reason: |
      Scale rule metadata accepts scaler-specific keys, and customOpenIdConnectProviders is keyed
      by provider name. Replacing these established open maps with closed models would break
      existing payloads.
  - suppress: PutResponseCodes
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/authConfigs/{authConfigName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/certificates/{certificateName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/daprComponents/{componentName}"].put
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/managedCertificates/{managedCertificateName}"].put
    reason: |
      These established PUT operations do not all expose exactly 200, 201, and default responses;
      managedCertificates also exposes 400. Changing their published response-code sets would
      break the existing stable wire contract.
  - suppress: LroErrorContent
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/connectedEnvironments/{connectedEnvironmentName}"].put.responses.default.schema['$ref']
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/connectedEnvironments/{connectedEnvironmentName}"].delete.responses.default.schema['$ref']
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/sourcecontrols/{sourceControlName}"].put.responses.default.schema['$ref']
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/sourcecontrols/{sourceControlName}"].delete.responses.default.schema['$ref']
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}"].put.responses.default.schema['$ref']
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}"].patch.responses.default.schema['$ref']
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}"].delete.responses.default.schema['$ref']
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}/executions/{jobExecutionName}/stop"].post.responses.default.schema['$ref']
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}/start"].post.responses.default.schema['$ref']
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}/stop"].post.responses.default.schema['$ref']
    reason: |
      These established long-running operations use the service-defined DefaultErrorResponse.
      Replacing it with the ARM common-types error schema would change the published stable error
      contract.
  - suppress: ProvisioningStateMustBeReadOnly
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}/resume"].post.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/jobs/{jobName}/suspend"].post.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/dotNetComponents/{name}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/dotNetComponents/{name}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/dotNetComponents/{name}"].put.responses["201"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/dotNetComponents/{name}"].patch.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/privateEndpointConnections/{privateEndpointConnectionName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/containerApps/{containerAppName}/privateEndpointConnections/{privateEndpointConnectionName}"].put.responses["201"].schema
    reason: |
      The TypeSpec properties are read-only, but typespec-autorest emits readOnly as a sibling
      of $ref. The validator discards sibling properties while resolving $ref and reports a
      false positive. This emitter issue is tracked by
      https://github.com/Azure/typespec-azure/issues/2042.
      The use-read-only-status-schema workaround was tested, but it changes the schemas emitted
      for existing API versions and caused 76 cross-version breaking-change findings.
      Remove this suppression when the emitter uses an allOf wrapper that preserves readOnly.
  - suppress: ProvisioningStateMustBeReadOnly
    from: openapi.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/sandboxGroups/{sandboxGroupName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/sandboxGroups/{sandboxGroupName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/sandboxGroups/{sandboxGroupName}"].put.responses["201"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/sandboxGroups/{sandboxGroupName}"].patch.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/sandboxGroups/{sandboxGroupName}/vnetConnections/{vnetConnectionName}"].get.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/sandboxGroups/{sandboxGroupName}/vnetConnections/{vnetConnectionName}"].put.responses["200"].schema
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/sandboxGroups/{sandboxGroupName}/vnetConnections/{vnetConnectionName}"].put.responses["201"].schema
    reason: |
      TypeSpec models provisioningState as read-only, but the emitter represents it as a
      $ref with a sibling readOnly annotation, which OpenAPI ignores. Enabling
      use-read-only-status-schema produces the compliant definition-level annotation,
      but applies project-wide and changes 47 status schemas, including 45 unrelated to
      SandboxGroup and VnetConnection. Suppress these seven affected response schemas
      until the emitter supports a scoped compliant representation.
  - suppress: UnSupportedPatchProperties
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.App/managedEnvironments/{environmentName}/dotNetComponents/{name}"].patch.parameters[5]
    reason: |
      The published preview PATCH contract uses the full resource schema. Its provisioningState
      property is read-only in TypeSpec, but typespec-autorest emits readOnly as a sibling of
      $ref, which the validator discards while resolving the schema. Changing to a dedicated
      PATCH model redirected two published model references and removed provisioningState, id,
      name, type, and systemData from the existing preview PATCH request.
      This emitter issue is tracked by https://github.com/Azure/typespec-azure/issues/2042.
      Remove this suppression when the emitter uses an allOf wrapper that preserves readOnly.
  - suppress: LatestVersionOfCommonTypesMustBeUsed
    from: openapi.json
    where: $..['$ref']
    reason: |
      This established API family uses ARM common types v5. Moving only the 2026-07-01 version
      to v6 changes the identity, SKU, and plan schemas, including newly required properties,
      and caused 12 cross-version breaking-change findings. The rule reports on the common-types
      $ref nodes throughout this API family, so the suppression is scoped to $ref nodes only.
      Remove this suppression when the API family can migrate common types without changing
      its existing wire contract.
```

### Tag: package-preview-2025-10-02-preview

These settings apply only when `--tag=package-preview-2025-10-02-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-10-02-preview'
input-file:
  - preview/2025-10-02-preview/openapi.json
```

### Tag: package-2026-01-01
These settings apply only when `--tag=package-2026-01-01` is specified on the command line.

```yaml $(tag) == 'package-2026-01-01'
input-file:
  - stable/2026-01-01/openapi.json
directive:
  - suppress: PatchBodyParametersSchema
    from: openapi.json
    reason: |
      Pre-existing. Java Component and Session Pool use discriminator/identity type as required property.
      Managed Service Identity requires type for patching.
  - suppress: AvoidAdditionalProperties
    from: openapi.json
    reason: |
      Pre-existing. Scale rule metadata and service bind customized keys use additionalProperties.
  - suppress: PutResponseCodes
    from: openapi.json
    reason: |
      Pre-existing. Do not introduce breaking changes in GA services.
  - suppress: TrackedExtensionResourcesAreNotAllowed
    from: openapi.json
    reason: |
      Pre-existing. Do not introduce breaking changes in GA services.
  - suppress: LroErrorContent
    from: openapi.json
    reason: |
      Pre-existing. Using the same error response as other APIs.
```

### Tag: package-2025-07-01
These settings apply only when `--tag=package-2025-07-01` is specified on the command line.

```yaml $(tag) == 'package-2025-07-01'
input-file:
  - stable/2025-07-01/AuthConfigs.json
  - stable/2025-07-01/AvailableWorkloadProfiles.json
  - stable/2025-07-01/BillingMeters.json
  - stable/2025-07-01/CommonDefinitions.json
  - stable/2025-07-01/ConnectedEnvironments.json
  - stable/2025-07-01/ConnectedEnvironmentsCertificates.json
  - stable/2025-07-01/ConnectedEnvironmentsDaprComponents.json
  - stable/2025-07-01/ConnectedEnvironmentsStorages.json
  - stable/2025-07-01/ContainerApps.json
  - stable/2025-07-01/ContainerAppsRevisions.json
  - stable/2025-07-01/Diagnostics.json
  - stable/2025-07-01/Global.json
  - stable/2025-07-01/JavaComponents.json
  - stable/2025-07-01/Jobs.json
  - stable/2025-07-01/ManagedEnvironments.json
  - stable/2025-07-01/ManagedEnvironmentsDaprComponents.json
  - stable/2025-07-01/ManagedEnvironmentsHttpRouteConfig.json
  - stable/2025-07-01/ManagedEnvironmentsMaintenanceConfigurations.json
  - stable/2025-07-01/ManagedEnvironmentsStorages.json
  - stable/2025-07-01/SessionPools.json
  - stable/2025-07-01/SourceControls.json
  - stable/2025-07-01/Subscriptions.json
  - stable/2025-07-01/Usages.json
  - stable/2025-07-01/LogicAppsExtension.json
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
