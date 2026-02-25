# Network

> see https://aka.ms/autorest

This is the AutoRest configuration file for Network.

---

## Getting Started

To build the SDK for Network, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Network API.

```yaml
title: NetworkManagementClient
description: Network Client
openapi-type: arm
tag: package-2025-05-01
```

### Tag: package-2025-05-01

These settings apply only when `--tag=package-2025-05-01` is specified on the command line.

```yaml $(tag) == 'package-2025-05-01'
input-file:
  - stable/2025-05-01/applicationGateway.json
  - stable/2025-05-01/common.json
  - stable/2025-05-01/expressRoute.json
  - stable/2025-05-01/firewall.json
  - stable/2025-05-01/loadBalancer.json
  - stable/2025-05-01/networkGateway.json
  - stable/2025-05-01/networkingOperations.json
  - stable/2025-05-01/networkManager.json
  - stable/2025-05-01/networkSecurityPerimeter.json
  - stable/2025-05-01/networkWatcher.json
  - stable/2025-05-01/virtualNetwork.json
  - stable/2025-05-01/virtualWan.json
suppressions:
  - code: PutResponseCodes
    reason: Required for multiple response codes. Reviewed by ARM team.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}"].put
  - code: DeleteResponseCodes
    reason: Required for multiple response codes. Reviewed by ARM team.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/resourceAssociations/{associationName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/linkReferences/{linkReferenceName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}/links/{linkName}"].delete
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityPerimeters/{networkSecurityPerimeterName}"].delete
  - code: PatchIdentityProperty
    reason: False alarm.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}"].patch.parameters[2]
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}"].patch.parameters[3]
  - code: SystemDataDefinitionsCommonTypes
    from: virtualNetwork.json
    reason: False alarm for common type errors.
  - code: SystemDataDefinitionsCommonTypes
    from: common.json
    reason: False alarm.
  - code: PutRequestResponseSchemeArm
    from: common.json
    reason: API spec code issue in PutRequestResponseSchemeArm validation.
  - code: RequiredPropertiesMissingInResourceModel
    reason: Not a standard azure resource.
    where:
      - $.definitions.GetServiceGatewayAddressLocationsResult
  - code: RequiredPropertiesMissingInResourceModel
    reason: Not a standard azure resource.
    where:
      - $.definitions.GetServiceGatewayServicesResult
directive:
  - from: specification/common-types/resource-management/v6/types.json
    where: "$.definitions.ProxyResource"
    transform: >
      $["x-ms-client-name"] = "SecurityPerimeterProxyResource"

  - from: specification/common-types/resource-management/v6/types.json
    where: "$.definitions.Resource"
    transform: >
      $["x-ms-client-name"] = "SecurityPerimeterResource"

  - from: specification/common-types/resource-management/v6/types.json
    where: "$.definitions.systemData"
    transform: >
      $["x-ms-client-name"] = "SecurityPerimeterSystemData"
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
