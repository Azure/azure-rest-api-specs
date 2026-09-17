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
tag: package-horizondb-2026-10-01-preview
```

### Tag: package-horizondb-2026-10-01-preview

These settings apply only when `--tag=package-horizondb-2026-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-horizondb-2026-10-01-preview'
input-file:
  - preview/2026-10-01-preview/openapi.json
suppressions:
  - code: PathForNestedResource
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HorizonDb/clusters/{clusterName}/authentications/microsoftEntra"]
    reason: >-
      The Microsoft Entra authentication method is a service-created singleton
      resource with the fixed name microsoftEntra under the authentications
      collection. Customers cannot create additional instances.
  - code: PathForNestedResource
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HorizonDb/clusters/{clusterName}/authentications/passwordMethod"]
    reason: >-
      The password authentication method is a service-created singleton resource
      with the fixed name passwordMethod under the authentications collection.
      Customers cannot create additional instances.
  - code: ConsistentPatchProperties
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HorizonDb/clusters/{clusterName}/authentications/passwordMethod"].patch.parameters[4].schema
    reason: >-
      administratorLogin and administratorLoginPassword are write-only
      credentials accepted only by PATCH and are never returned in the
      Authentication resource model.
  - code: PutRequestResponseSchemeArm
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HorizonDb/clusters/{clusterName}"].put
    reason: >-
      The PUT operation uses ClusterCreateRequest because postgreSqlVersion is
      required for ordinary creation but must be omitted for point-in-time
      restore. The Cluster response always returns the resolved PostgreSQL
      version and other service-owned read-only properties. Mutable cluster
      properties are supported by the PATCH operation on the same resource.
  - code: PutRequestResponseSchemeArm
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HorizonDb/clusters/{clusterName}/microsoftEntraAdministrators/{objectId}"].put
    reason: >-
      The administrator create (PUT) accepts a dedicated add model
      (HorizonDbAdministratorAdd) whose properties are a subset of the resource
      read model. objectId are read-only fields returned by GET but not accepted on PUT.
      The resource has no updatable fields beyond create, so no PATCH operation is provided.
  - code: ConsistentPatchProperties
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HorizonDb/clusters/{clusterName}/pools/{poolName}"].patch.parameters[5].schema
    reason: >-
      The PATCH model exposes computeModel.vCores for the Provisioned compute
      subtype. The validator compares it against the base compute model and does
      not resolve the resource model's discriminated subtype hierarchy.
  - code: RequiredPropertiesMissingInResourceModel
    from: openapi.json
    where: $.definitions["PagedParameterGroupConnectionProperties"]
    reason: >-
      PagedParameterGroupConnectionProperties is a paged response envelope
      containing value and nextLink, not an ARM resource model.
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
