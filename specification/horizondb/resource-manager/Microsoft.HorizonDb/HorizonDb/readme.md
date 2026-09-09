# HorizonDb

> see https://aka.ms/autorest

This is the AutoRest configuration file for HorizonDb.

---

## Getting Started

To build the SDK for HorizonDb, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the HorizonDb API.

```yaml
title: HorizonDbManagementClient
description: The Microsoft HorizonDb Management API provides Azure Resource Manager operations for managing HorizonDb clusters, pools, replicas, and firewall rules.
openapi-type: arm
tag: package-horizondb-2026-09-01
```

### Tag: package-horizondb-2026-09-01

These settings apply only when `--tag=package-horizondb-2026-09-01` is specified on the command line.

```yaml $(tag) == 'package-horizondb-2026-09-01'
input-file:
  - stable/2026-09-01/openapi.json
suppressions:
  - code: PutRequestResponseSchemeArm
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HorizonDb/clusters/{clusterName}/microsoftEntraAdministrators/{objectId}"].put
    reason: >-
      The Microsoft Entra administrator create (PUT) accepts a dedicated add model
      (MicrosoftEntraAdministratorAdd) whose properties are a subset of the resource
      read model. objectId are read-only fields returned by GET but not accepted on PUT.
      The resource has no updatable fields beyond create, so no PATCH operation is provided.
  - code: PathForNestedResource
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HorizonDb/clusters/{clusterName}/authentications/passwordMethod"]
    reason: >-
      passwordMethod is a service-created singleton authentication resource with a fixed
      literal name. It cannot be created or deleted independently, and parameterizing the
      final segment would incorrectly imply that callers can address arbitrary instances.
  - code: PathForNestedResource
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HorizonDb/clusters/{clusterName}/authentications/microsoftEntra"]
    reason: >-
      microsoftEntra is a service-created singleton authentication resource with a fixed
      literal name. It cannot be created or deleted independently, and parameterizing the
      final segment would incorrectly imply that callers can address arbitrary instances.
  - code: ConsistentPatchProperties
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HorizonDb/clusters/{clusterName}/authentications/passwordMethod"].patch.parameters[4].schema
    reason: >-
      administratorLogin and administratorLoginPassword are update-only secrets used to
      create, rename, or reset the PostgreSQL administrator. The control plane does not
      store or return these credentials, so exposing them on the read resource model would
      violate the API's security boundary.
  - code: ConsistentPatchProperties
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HorizonDb/clusters/{clusterName}/pools/{poolName}"].patch.parameters[5].schema
    reason: >-
      vCores is defined on the ProvisionedHorizonDbPoolComputeModel resource subtype and
      applies only when computeModel.type is Provisioned. The validator compares the PATCH
      field only with the base PoolComputeModel and cannot resolve the discriminator
      hierarchy, so it incorrectly reports the subtype property as missing.
  - code: EnumInsteadOfBoolean
    from: openapi.json
    where: $.definitions.ChangeDataCaptureCapabilityProperties.properties.autoUpgradeExtension
    reason: >-
      autoUpgradeExtension is an intrinsically binary authorization indicating whether
      HorizonDB may automatically upgrade the service-owned extension. Additional extension
      lifecycle states are represented by the extension status model, not this permission.
  - code: EnumInsteadOfBoolean
    from: openapi.json
    where: $.definitions.ChangeDataCaptureCapabilityPropertiesForPatchUpdate.properties.autoUpgradeExtension
    reason: >-
      autoUpgradeExtension is an intrinsically binary authorization indicating whether
      HorizonDB may automatically upgrade the service-owned extension. Omission preserves
      the current setting, so a third enum value is not needed for partial updates.
  - code: EnumInsteadOfBoolean
    from: openapi.json
    where: $.definitions.MaintenanceEventActionResponse.properties.appliedNow
    reason: >-
      appliedNow records the binary outcome of whether the customer selected the apply-now
      action rather than rescheduling the event. Other maintenance lifecycle conditions are
      represented by the separate status property.
  - code: EnumInsteadOfBoolean
    from: openapi.json
    where: $.definitions.MaintenanceEventProperties.properties.deferrable
    reason: >-
      deferrable indicates whether the maintenance event can be rescheduled at all. The
      deferral deadline provides the associated scheduling detail when this capability is
      available, so an enum would not add another meaningful state.
```

### Tag: package-horizondb-2026-05-01-preview

These settings apply only when `--tag=package-horizondb-2026-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-horizondb-2026-05-01-preview'
input-file:
  - preview/2026-05-01-preview/openapi.json
suppressions:
  - code: PutRequestResponseSchemeArm
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HorizonDb/clusters/{clusterName}/administrators/{objectId}"].put
    reason: >-
      The administrator create (PUT) accepts a dedicated add model
      (HorizonDbAdministratorAdd) whose properties are a subset of the resource
      read model. objectId are read-only fields returned by GET but not accepted on PUT.
      The resource has no updatable fields beyond create, so no PATCH operation is provided.
```

### Tag: package-horizondb-2026-01-20-preview

These settings apply only when `--tag=package-horizondb-2026-01-20-preview` is specified on the command line.

```yaml $(tag) == 'package-horizondb-2026-01-20-preview'
input-file:
  - preview/2026-01-20-preview/openapi.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```
