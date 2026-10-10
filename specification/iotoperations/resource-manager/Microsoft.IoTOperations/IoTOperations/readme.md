# IoTOperations

> see https://aka.ms/autorest

This is the AutoRest configuration file for IoTOperations.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

## Suppression

```yaml
directive:
  - suppress: AvoidAdditionalProperties
    where: $.definitions.BrokerAuthenticatorMethodCustom.properties.headers
    reason: User defined properties that are not subject to any validations.

  - suppress: AvoidAdditionalProperties
    where: $.definitions.BrokerAuthenticatorMethodX509.properties.authorizationAttributes
    reason: User defined properties that are not subject to any validations.

  - suppress: AvoidAdditionalProperties
    where: $.definitions.BrokerAuthenticatorMethodX509Attributes.properties.attributes
    reason: User defined properties that are not subject to any validations.

  - suppress: AvoidAdditionalProperties
    where: $.definitions.PrincipalDefinition.properties.attributes.items
    reason: User defined properties that are not subject to any validations.

  - suppress: AvoidAdditionalProperties
    where: $.definitions.VolumeClaimResourceRequirements.properties.limits
    reason: User defined properties that are not subject to any validations.

  - suppress: AvoidAdditionalProperties
    where: $.definitions.VolumeClaimResourceRequirements.properties.requests
    reason: User defined properties that are not subject to any validations.

  - suppress: AvoidAdditionalProperties
    where: $.definitions.VolumeClaimSpecSelector.properties.matchLabels
    reason: User defined properties that are not subject to any validations.

  - suppress: BodyTopLevelProperties
    reason: Temporary suppression due to failing pipeline.

  - suppress: PatchBodyParametersSchema
    reason: Type is required because it is a part of managed identity.
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTOperations/instances/{instanceName}"].patch.parameters[4].schema.properties.identity

  - suppress: AvoidAdditionalProperties
    where: $.definitions.InstanceProperties.properties.features
    reason: User defined feature flags that are not subject to any validations and can differ between the versions of AIO deployed on the customer's cluster.

  - suppress: AvoidAdditionalProperties
    where: $.definitions.InstanceFeature.properties.settings
    reason: User defined feature flag settings that are not subject to any validations and can differ between the versions of AIO deployed on the customer's cluster.

  - suppress: AvoidAdditionalProperties
    where: $.definitions.AkriConnectorTemplateHelmConfigurationSettings.properties.values
    reason: There represent helm values to customer provided helm charts hence the properties are not known ahead of time.

  - suppress: AvoidAdditionalProperties
    where: $.definitions.AkriConnectorTemplateRuntimeImageConfigurationSettings.properties.additionalConfiguration
    reason: These are additional configuration settings with dynamic properties that are not known ahead of time.

  - suppress: AvoidAdditionalProperties
    where: $.definitions.AkriDiscoveryHandlerProperties.properties.additionalConfiguration
    reason: These are additional configuration settings with dynamic properties that are not known ahead of time.

  - suppress: AvoidAdditionalProperties
    where: $.definitions.AkriConnectorTemplateManagedConfigurationSettings.properties.persistentVolumeClaimTemplates.items
    reason: These are additional configuration settings with dynamic properties that are not known ahead of time.

  - suppress: AvoidAdditionalProperties
    where: $.definitions.AkriConnectorTemplateManagedConfigurationSettings.properties.additionalConfiguration
    reason: These are additional configuration settings with dynamic properties that are not known ahead of time.

  - suppress: AvoidAdditionalProperties
    where: $.definitions.AkriConnectorTemplateRuntimeStatefulSetConfiguration.properties.statefulSetConfigurationSettings
    reason: These are additional configuration settings with dynamic properties that are not known ahead of time.

  - suppress: LatestVersionOfCommonTypesMustBeUsed
    from: iotoperations.json
    where: $..['$ref']
    reason: >-
      Azure IoT Operations uses ARM common-types v5 across its existing API
      versions. Moving only 2026-11-01-preview to v6 changes inherited common
      resource schemas, including managed identity shapes, and introduces
      cross-version breaking changes. This suppression is limited to reference
      nodes in the generated 2026-11-01-preview specification so the API can
      remain on its established v5 compatibility baseline.
  - suppress: AvoidAdditionalProperties
    from: iotoperations.json
    where: $.definitions.McpAuthorizationPolicyRule.properties.context
    reason: >-
      MCP tools can define arbitrary parameters, so authorization policy
      context values are intentionally modeled as a free-form object whose
      properties cannot be known when the API is authored.
  - suppress: AvoidAdditionalProperties
    from: iotoperations.json
    where: $.definitions.AioApplicationConfigurationProperties.properties.configuration
    reason: >-
      Customers bring their own applications and define each application's
      configuration parameters and structure, so the resource provider cannot
      define a fixed schema.
  - suppress: AvoidAdditionalProperties
    from: iotoperations.json
    where: $.definitions.AioConnectorApplicationConfigurationProperties.properties.configuration
    reason: >-
      Customers bring their own applications and define each application's
      configuration parameters and structure, so the resource provider cannot
      define a fixed schema.
  - suppress: AvoidAdditionalProperties
    from: iotoperations.json
    where: $.definitions.AioConnectorConfigurationProperties.properties.configuration
    reason: >-
      Customers bring their own applications and define each application's
      configuration parameters and structure, so the resource provider cannot
      define a fixed schema.
  - suppress: AvoidAdditionalProperties
    from: iotoperations.json
    where: $.definitions.AioApplicationImageConfigurationSettings.properties.persistentVolumeClaimTemplates.items
    reason: >-
      The resource provider forwards complete Kubernetes PersistentVolumeClaim
      templates without interpreting their contents. The schema varies across
      supported Kubernetes versions and may contain Kubernetes extension
      fields, so the API must preserve fields that are not known when this API
      version is authored.
  - suppress: PatchSkuProperty
    from: iotoperations.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.IoTOperations/instances/{instanceName}"].patch.parameters[4]
    reason: >-
      The resource provider does not support SKU updates in this API version.
      Exposing SKU in the PATCH body would advertise an unsupported operation.
  - suppress: EnumInsteadOfBoolean
    from: iotoperations.json
    where: $.definitions.DataflowGraphFileStore.properties.readOnly
    reason: >-
      File-store access is inherently binary: the volume is mounted either
      read-only or writable. A boolean directly represents these two states,
      and an extensible string enum would advertise unsupported values.
  - suppress: XMSSecretInResponse
    from: iotoperations.json
    where: $.definitions.AkriConnectorsSecret.properties.secretKey
    reason: >-
      secretKey is a non-sensitive key name used to select one value from a
      Kubernetes secret; it never contains the secret value itself and is safe
      to return in a response.
```

### Basic Information

These are the global settings for the IoTOperations.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-10-01
```

### Tag: package-2024-07-01-preview

These settings apply only when `--tag=package-2024-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-07-01-preview'
input-file:
  - preview/2024-07-01-preview/iotoperations.json
```

### Tag: package-2024-08-15-preview

These settings apply only when `--tag=package-2024-08-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-08-15-preview'
input-file:
  - preview/2024-08-15-preview/iotoperations.json
```

### Tag: package-2024-09-15-preview

These settings apply only when `--tag=package-2024-09-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-09-15-preview'
input-file:
  - preview/2024-09-15-preview/iotoperations.json
```

### Tag: package-2024-11-01

These settings apply only when `--tag=package-2024-11-01` is specified on the command line.

```yaml $(tag) == 'package-2024-11-01'
input-file:
  - stable/2024-11-01/iotoperations.json
```

### Tag: package-2025-04-01

These settings apply only when `--tag=package-2025-04-01` is specified on the command line.

```yaml $(tag) == 'package-2025-04-01'
input-file:
  - stable/2025-04-01/iotoperations.json
```

### Tag: package-2025-07-01-preview

These settings apply only when `--tag=package-2025-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-07-01-preview'
input-file:
  - preview/2025-07-01-preview/iotoperations.json
```

### Tag: package-2025-10-01

These settings apply only when `--tag=package-2025-10-01` is specified on the command line.

```yaml $(tag) == 'package-2025-10-01'
input-file:
  - stable/2025-10-01/iotoperations.json
```

### Tag: package-2026-03-01

These settings apply only when `--tag=package-2026-03-01` is specified on the command line.

```yaml $(tag) == 'package-2026-03-01'
input-file:
  - stable/2026-03-01/iotoperations.json
```

### Tag: package-2026-07-01

These settings apply only when `--tag=package-2026-07-01` is specified on the command line.

```yaml $(tag) == 'package-2026-07-01'
input-file:
  - stable/2026-07-01/iotoperations.json
```

### Tag: package-2026-10-01

These settings apply only when `--tag=package-2026-10-01` is specified on the command line.

```yaml $(tag) == 'package-2026-10-01'
input-file:
  - stable/2026-10-01/iotoperations.json
```

### Tag: package-2026-11-01-preview

These settings apply only when `--tag=package-2026-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-11-01-preview'
input-file:
  - preview/2026-11-01-preview/iotoperations.json
```
