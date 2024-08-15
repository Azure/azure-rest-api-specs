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

``` yaml
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
```

### Basic Information

These are the global settings for the IoTOperations.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-08-15-preview
```

### Tag: package-2024-07-01-preview

These settings apply only when `--tag=package-2024-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-07-01-preview'
input-file:
  - Microsoft.IoTOperations/preview/2024-07-01-preview/iotoperations.json
```

### Tag: package-2024-08-15-preview

These settings apply only when `--tag=package-2024-08-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-08-15-preview'
input-file:
  - Microsoft.IoTOperations/preview/2024-08-15-preview/iotoperations.json
```