# CostManagement

> see https://aka.ms/autorest

This is the AutoRest configuration file for Cost Management.

---

## Getting Started

To build the SDK for Cost Management, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Cost Management API.

``` yaml
openapi-type: arm
tag: package-2020-06
azure-validator: false
```

---


### Tag: package-preview-2020-03

These settings apply only when `--tag=package-preview-2020-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2020-03'
input-file:
  - Microsoft.CostManagement/stable/2020-06-01/costmanagement.json
  - Microsoft.CostManagement/preview/2020-03-01-preview/costallocation.json
```

### Tag: package-2020-06

These settings apply only when `--tag=package-2020-06` is specified on the command line.

```yaml $(tag) == 'package-2020-06'
input-file:
  - Microsoft.CostManagement/stable/2020-06-01/costmanagement.json
```


### Tag: package-2019-11

These settings apply only when `--tag=package-2019-11` is specified on the command line.

``` yaml $(tag) == 'package-2019-11'
input-file:
  - Microsoft.CostManagement/stable/2019-11-01/costmanagement.json
  - Microsoft.CostManagement/stable/2019-11-01/costmanagement.exports.json
```

### Tag: package-2019-10

These settings apply only when `--tag=package-2019-10` is specified on the command line.

``` yaml $(tag) == 'package-2019-10'
input-file:
  - Microsoft.CostManagement/stable/2019-10-01/costmanagement.json
```

### Tag: package-2019-09

These settings apply only when `--tag=package-2019-09` is specified on the command line.

``` yaml $(tag) == 'package-2019-09'
input-file:
  - Microsoft.CostManagement/stable/2019-09-01/costmanagement.json
```

### Tag: package-preview-2019-04

These settings apply only when `--tag=package-preview-2019-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2019-04'
input-file:
  - Microsoft.CostManagement/preview/2019-04-01-preview/costmanagement.json
```

### Tag: package-2019-01

These settings apply only when `--tag=package-2019-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-01'
input-file:
  - Microsoft.CostManagement/stable/2019-01-01/costmanagement.json
```

### Tag: package-preview-2019-03

These settings apply only when `--tag=package-preview-2019-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2019-03'
input-file:
  - Microsoft.CostManagement/preview/2019-03-01-preview/costmanagement.json
```

### Tag: package-2018-05

These settings apply only when `--tag=package-2018-05` is specified on the command line.

``` yaml $(tag) == 'package-2018-05'
input-file:
- Microsoft.CostManagement/stable/2018-05-31/costmanagement.json
```

## Suppression

``` yaml
directive:
  - suppress: R2059
    from: costmanagement.json
    where: $.paths
    reason: We are extending Microsoft.Billing RP in some scenarios
  - suppress: R3023
    from: costmanagement.json
    where: $.paths
    reason: operations API for Microsoft.Billing are defined in Microsoft.Billing    
  - suppress: XmsResourceInPutResponse
    from: costmanagement.json
    where: '$.paths["/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/providers/Microsoft.CostManagement/showbackRules/{ruleName}"].put'
    reason: 'older PR, not forecast.'
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: costmanagement.json
    where: $.definitions.CustomChargeProperties.properties.ChargeValue
    reason: 'older PR, not forecast.'
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: costmanagement.json
    where: $.definitions.CustomChargeProperties.properties.EffectiveMonth
    reason: 'older PR, not forecast.'
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: costmanagement.json
    where: $.definitions.CustomChargeProperties.properties.EndMonth
    reason: 'older PR, not forecast.'
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: costmanagement.json
    where: $.definitions.ShowbackRulesKind.properties.RuleType
    reason: 'older PR, not forecast.'
  - suppress: EnumInsteadOfBoolean
    from: costmanagement.json
    where: $.definitions.Notification.properties.enabled
    reason: 'false alarm '
  - suppress: EnumInsteadOfBoolean
    from: costmanagement.json
    where: $.definitions.CheckNameAvailabilityResult.properties.nameAvailable
    reason: 'false alarm '  
  - suppress: EnumInsteadOfBoolean
    from: costmanagement.json
    where: $.definitions.KpiProperties.properties.enabled
    reason: 'false alarm ' 
  - suppress: EnumInsteadOfBoolean
    from: costmanagement.json
    where: $.definitions.ViewProperties.properties.accumulated
    reason: 'false alarm ' 
```

### Tag: package-2018-08-preview

These settings apply only when `--tag=package-2018-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-08-preview'
input-file:
- Microsoft.CostManagement/preview/2018-08-01-preview/costmanagement.json
```

### Tag: package-2018-12-preview

These settings apply only when `--tag=package-2018-12-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-12-preview'
input-file:
- Microsoft.CostManagement/preview/2018-12-01-preview/costmanagement.json
```

### Tag: package-2019-01

These settings apply only when `--tag=package-2019-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-01'
input-file:
- Microsoft.CostManagement/stable/2019-01-01/costmanagement.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_costmanagement']
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
    after_scripts:
      - node sdkauto_afterscript.js cost-management/resource-manager
```

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.CostManagement
  output-folder: $(csharp-sdks-folder)/cost-management/Microsoft.Azure.Management.CostManagement/src/Generated
  clear-output-folder: true
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.costmanagement
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-costmanagement
```

### Java multi-api

``` yaml $(java) && $(multiapi)
batch:
  - tag: package-2018-05
  - tag: package-2018-08-preview
  - tag: package-2019-01
  - tag: package-2019-09
  - tag: package-2019-11
```

### Tag: package-2018-05 and java

These settings apply only when `--tag=package-2018-05 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-05' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.costmanagement.v2018_05_31
  output-folder: $(azure-libraries-for-java-folder)/sdk/costmanagement/mgmt-v2018_05_31
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-08-preview and java

These settings apply only when `--tag=package-2018-08-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-08-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.costmanagement.v2018_08_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/costmanagement/mgmt-v2018_08_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2018-12-preview and java

These settings apply only when `--tag=package-2018-12-preview --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2018-10-preview' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.costmanagement.v2018_12_01_preview
  output-folder: $(azure-libraries-for-java-folder)/sdk/costmanagement/mgmt-v2018_12_01_preview
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-01 and java

These settings apply only when `--tag=package-2019-01 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-01' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.costmanagement.v2019_01_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/costmanagement/mgmt-v2019_01_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-09 and java

These settings apply only when `--tag=package-2019-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.costmanagement.v2019_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/costmanagement/mgmt-v2019_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-2019-11 and java

These settings apply only when `--tag=package-2019-11 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-2019-11' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.costmanagement.v2019_11_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/costmanagement/mgmt-v2019_11_01
regenerate-manager: true
generate-interface: true
```

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)

