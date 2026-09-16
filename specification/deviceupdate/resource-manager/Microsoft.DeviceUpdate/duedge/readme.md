# Microsoft.DeviceUpdate - Device Update for IoT Edge

> see https://aka.ms/autorest

This is the AutoRest configuration file for Device Update for IoT Edge under Microsoft.DeviceUpdate.

## Configuration

### Basic Information

These are the global settings for Device Update for IoT Edge.

```yaml
openapi-type: arm
tag: package-2025-05-01-preview
```

### Tag: package-2025-05-01-preview

These settings apply only when `--tag=package-2025-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-05-01-preview'
input-file:
  - preview/2025-05-01-preview/deviceupdate.json
suppressions:
  - code: AvoidAdditionalProperties
    from: deviceupdate.json
    reason: Pass-through properties (not consumed by service but pass-through to device).
    where:
      - $.definitions.UpdateFile.properties.properties
      - $.definitions.AgentInfo.properties.compatibilityProperties
      - $.definitions.DeviceClassInfo.properties.compatibilityProperties
      - $.definitions.UpdateFileBase.properties.properties
      - $.definitions.UpdateProperties.properties.compatibility.items
  - code: ProvisioningStateMustBeReadOnly
    from: deviceupdate.json
    reason: False positive. Provisioning state is read-only. We cannot set use-read-only-status-schema true as it makes other internal types readonly (AgentEnrollmentState, DeviceDeploymentState)
  - code: PatchBodyParametersSchema
    from: deviceupdate.json
    reason: False positive based on Azure common types. Managed Service Identity requires type, and the Managed Service Identity can be patched. Bug https://msazure.visualstudio.com/One/_workitems/edit/30069110
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/updateAccounts/{updateAccountName}].patch.parameters[4].schema.properties.identity
```

### Tag: package-2025-04-01-preview

These settings apply only when `--tag=package-2025-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-04-01-preview'
input-file:
  - preview/2025-04-01-preview/deviceupdate.json
suppressions:
  - code: AvoidAdditionalProperties
    from: deviceupdate.json
    reason: Pass-through properties (not consumed by service but pass-through to device).
    where:
      - $.definitions.UpdateFile.properties.properties
      - $.definitions.AgentInfo.properties.compatibilityProperties
      - $.definitions.DeviceClassInfo.properties.compatibilityProperties
      - $.definitions.UpdateFileBase.properties.properties
      - $.definitions.UpdateProperties.properties.compatibility.items
  - code: ProvisioningStateMustBeReadOnly
    from: deviceupdate.json
    reason: False positive. Provisioning state is read-only. We cannot set use-read-only-status-schema true as it makes other internal types readonly (AgentEnrollmentState, DeviceDeploymentState)
  - code: PatchBodyParametersSchema
    from: deviceupdate.json
    reason: False positive based on Azure common types. Managed Service Identity requires type, and the Managed Service Identity can be patched. Bug https://msazure.visualstudio.com/One/_workitems/edit/30069110
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/updateAccounts/{updateAccountName}].patch.parameters[4].schema.properties.identity
```

### Tag: package-2024-10-01-preview

These settings apply only when `--tag=package-2024-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-10-01-preview'
input-file:
  - preview/2024-10-01-preview/deviceupdate.json
suppressions:
  - code: AvoidAdditionalProperties
    from: deviceupdate.json
    reason: Hash algorithm to hashed value map. Service validates the algorithms.
    where:
      - $.definitions.UpdateFile.properties.hashes
  - code: AvoidAdditionalProperties
    from: deviceupdate.json
    reason: Optional file properties (not consumed by service but pass-through to device).
    where:
      - $.definitions.UpdateFile.properties.properties
  - code: ProvisioningStateMustBeReadOnly
    from: deviceupdate.json
    reason: False positive. Provisioning state is read-only.
```

### Tag: package-2024-04-01-preview

These settings apply only when `--tag=package-2024-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-04-01-preview'
input-file:
  - preview/2024-04-01-preview/deviceupdate.json
```
