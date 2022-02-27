# Azure Synapse Analytics

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure Synapse Analytics.

---

## Getting Started

To build the SDK for Azure Synapse Analytics, [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Azure Synapse Analytics API.

``` yaml
description: Azure Synapse Analytics Management Client
openapi-type: arm
azure-arm: true
tag: package-composite-v1
generate-empty-classes: true
modelerfour:
  lenient-model-deduplication: true
```

### Tag: package-composite-v1

These settings apply only when `--tag=package-composite-v1` is specified on the command line.

```yaml $(tag) == 'package-composite-v1'
input-file:
  - Microsoft.Synapse/stable/2021-06-01/azureADOnlyAuthentication.json
  - Microsoft.Synapse/stable/2021-06-01/checkNameAvailability.json
  - Microsoft.Synapse/stable/2021-06-01/firewallRule.json
  - Microsoft.Synapse/stable/2021-06-01/keys.json
  - Microsoft.Synapse/stable/2021-06-01/operations.json
  - Microsoft.Synapse/stable/2021-06-01/privateEndpointConnections.json
  - Microsoft.Synapse/stable/2021-06-01/privateLinkResources.json
  - Microsoft.Synapse/stable/2021-06-01/privatelinkhub.json
  - Microsoft.Synapse/stable/2021-06-01/sqlPool.json
  - Microsoft.Synapse/stable/2021-06-01/sqlServer.json
  - Microsoft.Synapse/stable/2021-06-01/workspace.json
  - Microsoft.Synapse/preview/2021-06-01-preview/bigDataPool.json
  - Microsoft.Synapse/preview/2021-06-01-preview/library.json
  - Microsoft.Synapse/preview/2021-06-01-preview/integrationRuntime.json
  - Microsoft.Synapse/preview/2021-06-01-preview/sparkConfiguration.json
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

```yaml $(tag) == 'package-2021-06'
input-file:
  - Microsoft.Synapse/stable/2021-06-01/bigDataPool.json
  - Microsoft.Synapse/stable/2021-06-01/checkNameAvailability.json
  - Microsoft.Synapse/stable/2021-06-01/firewallRule.json
  - Microsoft.Synapse/stable/2021-06-01/integrationRuntime.json
  - Microsoft.Synapse/stable/2021-06-01/keys.json
  - Microsoft.Synapse/stable/2021-06-01/library.json
  - Microsoft.Synapse/stable/2021-06-01/operations.json
  - Microsoft.Synapse/stable/2021-06-01/privateEndpointConnections.json
  - Microsoft.Synapse/stable/2021-06-01/privateLinkResources.json
  - Microsoft.Synapse/stable/2021-06-01/privatelinkhub.json
  - Microsoft.Synapse/stable/2021-06-01/sqlPool.json
  - Microsoft.Synapse/stable/2021-06-01/sqlServer.json
  - Microsoft.Synapse/stable/2021-06-01/workspace.json
  - Microsoft.Synapse/stable/2021-06-01/azureADOnlyAuthentication.json
```

### Tag: package-preview-2021-06

These settings apply only when `--tag=package-preview-2021-06` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-06'
input-file:
  - Microsoft.Synapse/preview/2021-06-01-preview/bigDataPool.json
  - Microsoft.Synapse/preview/2021-06-01-preview/checkNameAvailability.json
  - Microsoft.Synapse/preview/2021-06-01-preview/firewallRule.json
  - Microsoft.Synapse/preview/2021-06-01-preview/integrationRuntime.json
  - Microsoft.Synapse/preview/2021-06-01-preview/keys.json
  - Microsoft.Synapse/preview/2021-06-01-preview/library.json
  - Microsoft.Synapse/preview/2021-06-01-preview/operations.json
  - Microsoft.Synapse/preview/2021-06-01-preview/privateEndpointConnections.json
  - Microsoft.Synapse/preview/2021-06-01-preview/privateLinkResources.json
  - Microsoft.Synapse/preview/2021-06-01-preview/privatelinkhub.json
  - Microsoft.Synapse/preview/2021-06-01-preview/sqlPool.json
  - Microsoft.Synapse/preview/2021-06-01-preview/sqlServer.json
  - Microsoft.Synapse/preview/2021-06-01-preview/workspace.json
  - Microsoft.Synapse/preview/2021-06-01-preview/sparkConfiguration.json
  - Microsoft.Synapse/preview/2021-06-01-preview/azureADOnlyAuthentication.json
```

### Tag: package-kusto-pool-2021-06-preview

These settings apply only when `--tag=package-kusto-pool-2021-06-preview` is specified on the command line.

**ATTENTION**: Please DO NOT generate SDK based on this tag. Kusto pool API set is not ready to be widely used.

``` yaml $(tag) == 'package-kusto-pool-2021-06-preview'
input-file:
  - Microsoft.Synapse/preview/2021-06-01-preview/kustoPool.json
```

### Tag: package-2021-05

These settings apply only when `--tag=package-2021-05` is specified on the command line.

``` yaml $(tag) == 'package-2021-05'
input-file:
  - Microsoft.Synapse/stable/2021-05-01/bigDataPool.json
  - Microsoft.Synapse/stable/2021-05-01/checkNameAvailability.json
  - Microsoft.Synapse/stable/2021-05-01/firewallRule.json
  - Microsoft.Synapse/stable/2021-05-01/integrationRuntime.json
  - Microsoft.Synapse/stable/2021-05-01/keys.json
  - Microsoft.Synapse/stable/2021-05-01/library.json
  - Microsoft.Synapse/stable/2021-05-01/operations.json
  - Microsoft.Synapse/stable/2021-05-01/privateEndpointConnections.json
  - Microsoft.Synapse/stable/2021-05-01/privateLinkResources.json
  - Microsoft.Synapse/stable/2021-05-01/privatelinkhub.json
  - Microsoft.Synapse/stable/2021-05-01/sqlPool.json
  - Microsoft.Synapse/stable/2021-05-01/sqlServer.json
  - Microsoft.Synapse/stable/2021-05-01/workspace.json
```

### Tag: package-2021-04-preview

These settings apply only when `--tag=package-2021-04-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-04-preview'
input-file:
  - Microsoft.Synapse/preview/2021-04-01-preview/bigDataPool.json
  - Microsoft.Synapse/preview/2021-04-01-preview/checkNameAvailability.json
  - Microsoft.Synapse/preview/2021-04-01-preview/firewallRule.json
  - Microsoft.Synapse/preview/2021-04-01-preview/integrationRuntime.json
  - Microsoft.Synapse/preview/2021-04-01-preview/keys.json
  - Microsoft.Synapse/preview/2021-04-01-preview/library.json
  - Microsoft.Synapse/preview/2021-04-01-preview/operations.json
  - Microsoft.Synapse/preview/2021-04-01-preview/privateEndpointConnections.json
  - Microsoft.Synapse/preview/2021-04-01-preview/privateLinkResources.json
  - Microsoft.Synapse/preview/2021-04-01-preview/privatelinkhub.json
  - Microsoft.Synapse/preview/2021-04-01-preview/sqlPool.json
  - Microsoft.Synapse/preview/2021-04-01-preview/sqlServer.json
  - Microsoft.Synapse/preview/2021-04-01-preview/workspace.json
```

### Tag: package-kusto-pool-2021-04-preview

These settings apply only when `--tag=package-kusto-pool-2021-04-preview` is specified on the command line.

**ATTENTION**: Please DO NOT generate SDK based on this tag. Kusto pool API set is not ready to be widely used.

``` yaml $(tag) == 'package-kusto-pool-2021-04-preview'
input-file:
  - Microsoft.Synapse/preview/2021-04-01-preview/kustoPool.json
```

### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-2021-03'
input-file:
  - Microsoft.Synapse/stable/2021-03-01/bigDataPool.json
  - Microsoft.Synapse/stable/2021-03-01/checkNameAvailability.json
  - Microsoft.Synapse/stable/2021-03-01/firewallRule.json
  - Microsoft.Synapse/stable/2021-03-01/integrationRuntime.json
  - Microsoft.Synapse/stable/2021-03-01/keys.json
  - Microsoft.Synapse/stable/2021-03-01/library.json
  - Microsoft.Synapse/stable/2021-03-01/operations.json
  - Microsoft.Synapse/stable/2021-03-01/privateEndpointConnections.json
  - Microsoft.Synapse/stable/2021-03-01/privateLinkResources.json
  - Microsoft.Synapse/stable/2021-03-01/privatelinkhub.json
  - Microsoft.Synapse/stable/2021-03-01/sqlPool.json
  - Microsoft.Synapse/stable/2021-03-01/sqlServer.json
  - Microsoft.Synapse/stable/2021-03-01/workspace.json
```

### Tag: package-2019-06-01-preview

These settings apply only when `--tag=package-2019-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-06-01-preview'
input-file:
- Microsoft.Synapse/preview/2019-06-01-preview/bigDataPool.json
- Microsoft.Synapse/preview/2019-06-01-preview/checkNameAvailability.json
- Microsoft.Synapse/preview/2019-06-01-preview/firewallRule.json
- Microsoft.Synapse/preview/2019-06-01-preview/operations.json
- Microsoft.Synapse/preview/2019-06-01-preview/sqlPool.json
- Microsoft.Synapse/preview/2019-06-01-preview/workspace.json
- Microsoft.Synapse/preview/2019-06-01-preview/integrationRuntime.json
- Microsoft.Synapse/preview/2019-06-01-preview/privateLinkResources.json
- Microsoft.Synapse/preview/2019-06-01-preview/privateEndpointConnections.json
- Microsoft.Synapse/preview/2019-06-01-preview/privatelinkhub.json
- Microsoft.Synapse/preview/2019-06-01-preview/sqlServer.json
- Microsoft.Synapse/preview/2019-06-01-preview/keys.json
```

### Tag: package-sqlGen3-2020-04-01-preview

These settings apply only when `--tag=package-sqlGen3-2020-04-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-sqlGen3-2020-04-01-preview'
input-file:
- Microsoft.Synapse/preview/2020-04-01-preview/operations.json
- Microsoft.Synapse/preview/2020-04-01-preview/sqlPool.json
- Microsoft.Synapse/preview/2020-04-01-preview/sqlDatabase.json
```

### Tag: package-2020-12-01

These settings apply only when `--tag=package-2020-12-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-12-01'
input-file:
- Microsoft.Synapse/stable/2020-12-01/bigDataPool.json
- Microsoft.Synapse/stable/2020-12-01/checkNameAvailability.json
- Microsoft.Synapse/stable/2020-12-01/firewallRule.json
- Microsoft.Synapse/stable/2020-12-01/operations.json
- Microsoft.Synapse/stable/2020-12-01/sqlPool.json
- Microsoft.Synapse/stable/2020-12-01/workspace.json
- Microsoft.Synapse/stable/2020-12-01/integrationRuntime.json
- Microsoft.Synapse/stable/2020-12-01/privateLinkResources.json
- Microsoft.Synapse/stable/2020-12-01/privateEndpointConnections.json
- Microsoft.Synapse/stable/2020-12-01/privatelinkhub.json
- Microsoft.Synapse/stable/2020-12-01/sqlServer.json
- Microsoft.Synapse/stable/2020-12-01/keys.json
- Microsoft.Synapse/stable/2020-12-01/library.json
```

## Suppressions

``` yaml
directive:
  - suppress: EnumInsteadOfBoolean
    reason: This boolean values are actually boolean in the model.
  - suppress: TrackedResourceListByImmediateParent
    reason: Does not apply to workspace/operationStatus and workspace/operationResults .
  - suppress: PostOperationIdContainsUrlVerb
    reason: ReplaceAllIpFirewallRules has a nonstandard verb ReplaceAll.
  - suppress: TrackedResourceListByResourceGroup
    reason: Does not apply to sqlPool and bigDataPool as they are nested tracked resources
  - suppress: TrackedResourceListBySubscription
    reason: Does not apply to sqlPool and bigDataPool as they are nested tracked resources
  - from: Microsoft.Synapse/preview/2019-06-01-preview/sqlPool.json
    where:
        - $.definitions.SqlPoolVulnerabilityAssessmentRuleBaseline
        - $.definitions.DataMaskingPolicy
        - $.definitions.DataWarehouseUserActivities
        - $.definitions.SqlPoolConnectionPolicy
        - $.definitions.TransparentDataEncryption
    suppress:
        - R4015
    reason: SQL doesn't support 'list' operation everywhere, so we cannot support List for certain Sql pool operations
  - from: Microsoft.Synapse/preview/2019-06-01-preview/sqlPool.json
    where :
        - '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/sqlPools/{sqlPoolName}/restorePoints/{restorePointName}"].delete.responses'
    suppress:
        - R4011
    reason: SQL Pools APIs are proxy APIs that call SQL DB APIs. The SQL DB delete restore points API only supports return method 200, so we cannot support 204. It is not possible for the SQL DB team to add 204 support for delete restore points.
  - suppress: AllResourcesMustHaveGetOperation
    from: Microsoft.Synapse/preview/2019-06-01-preview/sqlPool.json
    where:
      - $.definitions.DataMaskingRule
      - $.definitions.SqlPoolOperation
  - suppress: R4015
    reason: Needs implementation
    from: Microsoft.Synapse/preview/2019-06-01-preview/workspace_managedIdentity.json
    where:
      - $.definitions.ManagedIdentitySqlControlSettingsInfo
  - suppress: R2010
    reason: x-ms-long-running-operation-options not available in datafactory swagger
    from: Microsoft.Synapse/preview/2019-06-01-preview/integrationRuntime.json
  - suppress: AvoidNestedProperties
    reason: Existing models
    from: Microsoft.Synapse/preview/2019-06-01-preview/integrationRuntime.json
    where:
      - $.definitions.IntegrationRuntimeResource.properties.properties
      - $.definitions.IntegrationRuntimeStatusResponse.properties.properties
      - $.definitions.SsisObjectMetadataStatusResponse.properties.properties
  - from: Microsoft.Synapse/stable/2020-12-01/sqlPool.json
    where:
        - $.definitions.SqlPoolVulnerabilityAssessmentRuleBaseline
        - $.definitions.DataMaskingPolicy
        - $.definitions.DataWarehouseUserActivities
        - $.definitions.SqlPoolConnectionPolicy
        - $.definitions.TransparentDataEncryption
    suppress:
        - R4015
    reason: SQL doesn't support 'list' operation everywhere, so we cannot support List for certain Sql pool operations
  - from: Microsoft.Synapse/stable/2020-12-01/sqlPool.json
    where :
        - '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/sqlPools/{sqlPoolName}/restorePoints/{restorePointName}"].delete.responses'
    suppress:
        - R4011
    reason: SQL Pools APIs are proxy APIs that call SQL DB APIs. The SQL DB delete restore points API only supports return method 200, so we cannot support 204. It is not possible for the SQL DB team to add 204 support for delete restore points.
  - suppress: AllResourcesMustHaveGetOperation
    from: Microsoft.Synapse/stable/2020-12-01/sqlPool.json
    where:
      - $.definitions.DataMaskingRule
      - $.definitions.SqlPoolOperation
  - suppress: R4015
    reason: Needs implementation
    from: Microsoft.Synapse/stable/2020-12-01/workspace_managedIdentity.json
    where:
      - $.definitions.ManagedIdentitySqlControlSettingsInfo
  - suppress: R2010
    reason: x-ms-long-running-operation-options not available in datafactory swagger
    from: Microsoft.Synapse/stable/2020-12-01/integrationRuntime.json
  - suppress: AvoidNestedProperties
    reason: Existing models
    from: Microsoft.Synapse/stable/2020-12-01/integrationRuntime.json
    where:
      - $.definitions.IntegrationRuntimeResource.properties.properties
      - $.definitions.IntegrationRuntimeStatusResponse.properties.properties
      - $.definitions.SsisObjectMetadataStatusResponse.properties.properties
  - suppress: R4009
    reason: systemData will be in the next API version
    from: Microsoft.Synapse/stable/2020-12-01/library.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-go
  - repo: azure-resource-manager-schemas
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Synapse
  output-folder: $(csharp-sdks-folder)/synapse/Microsoft.Azure.Management.Synapse/src/Generated
  clear-output-folder: true
batch:
 - tag: $(tag)
 - tag: package-sqlGen3-2020-04-01-preview
```

## Go

See configuration in [readme.go.md](./readme.go.md)
