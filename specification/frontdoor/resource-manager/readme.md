# Frontdoor

> see https://aka.ms/autorest

This is the AutoRest configuration file for Network.

---

## Getting Started

To build the SDK for FrontDoor, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the FrontDoor API.

``` yaml
title: FrontDoorManagementClient
description: FrontDoor Client
openapi-type: arm
tag: package-2024-02
```


### Tag: package-2024-02

These settings apply only when `--tag=package-2024-02` is specified on the command line.

```yaml $(tag) == 'package-2024-02'
input-file:
  - Microsoft.Network/stable/2024-02-01/network.json
  - Microsoft.Network/stable/2024-02-01/webapplicationfirewall.json
  - Microsoft.Network/stable/2021-06-01/frontdoor.json
  - Microsoft.Network/stable/2019-11-01/networkexperiment.json
```

### Tag: package-2022-05

These settings apply only when `--tag=package-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-2022-05'
input-file:
  - Microsoft.Network/stable/2022-05-01/network.json
  - Microsoft.Network/stable/2022-05-01/webapplicationfirewall.json
  - Microsoft.Network/stable/2021-06-01/frontdoor.json
  - Microsoft.Network/stable/2019-11-01/networkexperiment.json
```

### Tag: package-2021-06

These settings apply only when `--tag=package-2021-06` is specified on the command line.

```yaml $(tag) == 'package-2021-06'
input-file:
  - Microsoft.Network/stable/2021-06-01/frontdoor.json
  - Microsoft.Network/stable/2021-06-01/webapplicationfirewall.json
  - Microsoft.Network/stable/2021-06-01/network.json
  - Microsoft.Network/stable/2019-11-01/networkexperiment.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
```

### Tag: package-2020-11

These settings apply only when `--tag=package-2020-11` is specified on the command line.

``` yaml $(tag) == 'package-2020-11'
input-file:
  - Microsoft.Network/stable/2020-11-01/network.json
  - Microsoft.Network/stable/2019-11-01/networkexperiment.json
  - Microsoft.Network/stable/2020-05-01/frontdoor.json
  - Microsoft.Network/stable/2020-11-01/webapplicationfirewall.json
```

### Tag: package-2020-05

These settings apply only when `--tag=package-2020-05` is specified on the command line.

``` yaml $(tag) == 'package-2020-05'
input-file:
- Microsoft.Network/stable/2020-05-01/network.json
- Microsoft.Network/stable/2019-11-01/networkexperiment.json
- Microsoft.Network/stable/2020-05-01/frontdoor.json
- Microsoft.Network/stable/2020-04-01/webapplicationfirewall.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
```

### Tag: package-2020-04

These settings apply only when `--tag=package-2020-04` is specified on the command line.

``` yaml $(tag) == 'package-2020-04'
input-file:
- Microsoft.Network/stable/2020-04-01/network.json
- Microsoft.Network/stable/2019-11-01/networkexperiment.json
- Microsoft.Network/stable/2020-04-01/frontdoor.json
- Microsoft.Network/stable/2020-04-01/webapplicationfirewall.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
```

### Tag: package-2020-01

These settings apply only when `--tag=package-2020-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-01'
input-file:
- Microsoft.Network/stable/2020-01-01/network.json
- Microsoft.Network/stable/2019-11-01/networkexperiment.json
- Microsoft.Network/stable/2020-01-01/frontdoor.json
- Microsoft.Network/stable/2019-10-01/webapplicationfirewall.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
```

### Tag: package-2019-11

These settings apply only when `--tag=package-2019-11` is specified on the command line.

``` yaml $(tag) == 'package-2019-11'
input-file:
- Microsoft.Network/stable/2019-11-01/network.json
- Microsoft.Network/stable/2019-11-01/networkexperiment.json
- Microsoft.Network/stable/2019-05-01/frontdoor.json
- Microsoft.Network/stable/2019-10-01/webapplicationfirewall.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
```

### Tag: package-2019-10

These settings apply only when `--tag=package-2019-10` is specified on the command line.

``` yaml $(tag) == 'package-2019-10'
input-file:
- Microsoft.Network/stable/2019-05-01/frontdoor.json
- Microsoft.Network/stable/2019-05-01/network.json
- Microsoft.Network/stable/2019-10-01/webapplicationfirewall.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
```

### Tag: package-2019-05

These settings apply only when `--tag=package-2019-05` is specified on the command line.

``` yaml $(tag) == 'package-2019-05'
input-file:
- Microsoft.Network/stable/2019-05-01/frontdoor.json
- Microsoft.Network/stable/2019-05-01/network.json
- Microsoft.Network/stable/2019-03-01/webapplicationfirewall.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
```

### Tag: package-2019-04

These settings apply only when `--tag=package-2019-04` is specified on the command line.

``` yaml $(tag) == 'package-2019-04'
input-file:
- Microsoft.Network/stable/2019-04-01/frontdoor.json
- Microsoft.Network/stable/2019-04-01/network.json
- Microsoft.Network/stable/2019-03-01/webapplicationfirewall.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
```

### Tag: package-2019-03-preview

These settings apply only when `--tag=package-2019-03-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-03-preview'
input-file:
- Microsoft.Network/preview/2018-08-01-preview/frontdoor.json
- Microsoft.Network/preview/2018-08-01-preview/network.json
- Microsoft.Network/preview/2019-03-01-preview/webapplicationfirewall.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
```

### Tag: package-2018-08-preview

These settings apply only when `--tag=package-2018-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-08-preview'
input-file:
- Microsoft.Network/preview/2018-08-01-preview/frontdoor.json
- Microsoft.Network/preview/2018-08-01-preview/network.json
- Microsoft.Network/preview/2018-08-01-preview/webapplicationfirewall.json
directive:
  - where:
      - $.paths
    suppress:
      - OperationsAPIImplementation
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-python
  - repo: azure-libraries-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-resource-manager-schemas
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.FrontDoor
  output-folder: $(csharp-sdks-folder)/frontdoor/Microsoft.Azure.Management.FrontDoor/src/Generated
  clear-output-folder: true
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## CLI

See configuration in [readme.cli.md](./readme.cli.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

# Validation Suppressions

``` yaml $(azure-validator)
directive:
  - from: frontdoor.json
    where: [$.paths]
    suppress: OperationsAPIImplementation
    reason: Networking resource operations defined elsewhere.
  - from: frontdoor.json
    where: [$.definitions.Frontdoor,$.definitions.RoutingRule,$.definitions.FrontendEndpoint,$.definitions.BackendPool,$.definitions.LoadBalancingSettingsModel,$.definitions.HealthProbeSettingsModel]
    suppress: RequiredPropertiesMissingInResourceModel
    reason: Networking resource id is not readonly.
  - from: frontdoor.json
    where: [$.definitions.ValidateCustomDomainOutput.properties.customDomainValidated]
    suppress: EnumInsteadOfBoolean
    reason: Direct copy of ValidateCustomDomain API in CDN Resource Provider.
```

## Suppression

``` yaml
directive:
  - suppress: TopLevelResourcesListBySubscription
    where: $.definitions.WebApplicationFirewallPolicy
    from: webapplicationfirewall.json
    reason: 'We don''t have Top Level list resource by subscription api yet. '
  - suppress: PathResourceTypeNameCamelCase
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/FrontDoorWebApplicationFirewallPolicies/{policyName}"]'
    from: webapplicationfirewall.json
    reason: The resource type name FrontDoorWebApplicationFirewallPolicies was already defined for all the versions.
  - suppress: INVALID_TYPE
    where: $.definitions.Resource.properties.tags.additionalProperties
    from: network.json
    reason: 'Same as version in 2020-11-01, will not change since it will involves breaking change. '
  - suppress: RequiredSystemDataInNewApiVersions
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/FrontDoorWebApplicationFirewallPolicies/{policyName}"].get'
    from: webapplicationfirewall.json
    reason: 'Same as the old versions. '
  - suppress: RequiredSystemDataInNewApiVersions
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/FrontDoorWebApplicationFirewallPolicies/{policyName}"].get'
    from: webapplicationfirewall.json
    reason: 'Same as old versions. '
  - suppress: RequiredSystemDataInNewApiVersions
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/FrontDoorWebApplicationFirewallPolicies/{policyName}"].get'
    from: webapplicationfirewall.json
    reason: 'same as old versions. '
  - suppress: DefaultErrorResponseSchema
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}"].put.responses.default'
    from: networkexperiment.json
    reason: 'same as old versions. '
  - suppress: RequiredSystemDataInNewApiVersions
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/FrontDoorWebApplicationFirewallPolicies/{policyName}"].get'
    from: webapplicationfirewall.json
    reason: Same as old versions.
  - suppress: RequiredSystemDataInNewApiVersions
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/FrontDoorWebApplicationFirewallPolicies/{policyName}"].put'
    from: webapplicationfirewall.json
    reason: Same as old versions.
  - suppress: RequiredSystemDataInNewApiVersions
    where: '$.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/FrontDoorWebApplicationFirewallPolicies/{policyName}"].get'
    from: webapplicationfirewall.json
    reason: same as old versions.
  - suppress: R4007
    from: webapplicationfirewall.json
    reason: we will be Implementing in new API version
```
