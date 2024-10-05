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
tag: package-2024-08
azure-validator: false
```

---


### Tag: package-2024-08

These settings apply only when `--tag=package-2024-08` is specified on the command line.

```yaml $(tag) == 'package-2024-08'
input-file:
  - Microsoft.CostManagement/stable/2024-08-01/common-types.json
  - Microsoft.CostManagement/stable/2024-08-01/costallocation.json
  - Microsoft.CostManagement/stable/2024-08-01/costmanagement.benefits.json
  - Microsoft.CostManagement/stable/2024-08-01/costmanagement.budgets.json
  - Microsoft.CostManagement/stable/2024-08-01/costmanagement.exports.json
  - Microsoft.CostManagement/stable/2024-08-01/costmanagement.generatecostdetailsreport.json
  - Microsoft.CostManagement/stable/2024-08-01/costmanagement.generatedetailedcostreport.json
  - Microsoft.CostManagement/stable/2024-08-01/costmanagement.json
  - Microsoft.CostManagement/stable/2024-08-01/costmanagement.pricesheets.json
  - Microsoft.CostManagement/stable/2024-08-01/scheduledActions.json
  - Microsoft.CostManagement/stable/2024-08-01/settings.json
```

### Tag: package-2023-11

These settings apply only when `--tag=package-2023-11` is specified on the command line.

``` yaml $(tag) == 'package-2023-11'
input-file:
  - Microsoft.CostManagement/stable/2023-11-01/common-types.json
  - Microsoft.CostManagement/stable/2023-11-01/costallocation.json
  - Microsoft.CostManagement/stable/2023-11-01/costmanagement.benefits.json
  - Microsoft.CostManagement/stable/2023-11-01/costmanagement.budgets.json
  - Microsoft.CostManagement/stable/2023-11-01/costmanagement.exports.json
  - Microsoft.CostManagement/stable/2023-11-01/costmanagement.generatecostdetailsreport.json
  - Microsoft.CostManagement/stable/2023-11-01/costmanagement.generatedetailedcostreport.json
  - Microsoft.CostManagement/stable/2023-11-01/costmanagement.json
  - Microsoft.CostManagement/stable/2023-11-01/costmanagement.pricesheets.json
  - Microsoft.CostManagement/stable/2023-11-01/scheduledActions.json
  - Microsoft.CostManagement/stable/2023-11-01/settings.json
```

### Tag: package-2023-09

These settings apply only when `--tag=package-2023-09` is specified on the command line.

``` yaml $(tag) == 'package-2023-09'
input-file:
  - Microsoft.CostManagement/stable/2023-09-01/common-types.json
  - Microsoft.CostManagement/stable/2023-09-01/costallocation.json
  - Microsoft.CostManagement/stable/2023-09-01/costmanagement.benefits.json
  - Microsoft.CostManagement/stable/2023-09-01/costmanagement.budgets.json
  - Microsoft.CostManagement/stable/2023-09-01/costmanagement.exports.json
  - Microsoft.CostManagement/stable/2023-09-01/costmanagement.generatecostdetailsreport.json
  - Microsoft.CostManagement/stable/2023-09-01/costmanagement.generatedetailedcostreport.json
  - Microsoft.CostManagement/stable/2023-09-01/costmanagement.json
  - Microsoft.CostManagement/stable/2023-09-01/costmanagement.pricesheets.json
  - Microsoft.CostManagement/stable/2023-09-01/scheduledActions.json
  - Microsoft.CostManagement/stable/2023-09-01/settings.json
```

### Tag: package-2023-08

These settings apply only when `--tag=package-2023-08` is specified on the command line.

``` yaml $(tag) == 'package-2023-08'
input-file:
  - Microsoft.CostManagement/stable/2023-08-01/common-types.json
  - Microsoft.CostManagement/stable/2023-08-01/costmanagement.benefits.json
  - Microsoft.CostManagement/stable/2023-08-01/costmanagement.budgets.json
  - Microsoft.CostManagement/stable/2023-08-01/costmanagement.exports.json
  - Microsoft.CostManagement/stable/2023-08-01/costmanagement.generatecostdetailsreport.json
  - Microsoft.CostManagement/stable/2023-08-01/costmanagement.generatedetailedcostreport.json
  - Microsoft.CostManagement/stable/2023-08-01/costmanagement.json
  - Microsoft.CostManagement/stable/2023-08-01/costmanagement.pricesheets.json
  - Microsoft.CostManagement/stable/2023-08-01/scheduledActions.json
  - Microsoft.CostManagement/stable/2023-08-01/costallocation.json
  - Microsoft.CostManagement/stable/2023-08-01/settings.json
```

### Tag: package-preview-2023-07

These settings apply only when `--tag=package-preview-2023-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-07'
input-file:
  - Microsoft.CostManagement/preview/2023-07-01-preview/common-types.json
  - Microsoft.CostManagement/preview/2023-07-01-preview/costmanagement.benefits.json
  - Microsoft.CostManagement/preview/2023-07-01-preview/costmanagement.exports.json
  - Microsoft.CostManagement/preview/2023-07-01-preview/costmanagement.generatecostdetailsreport.json
  - Microsoft.CostManagement/preview/2023-07-01-preview/costmanagement.generatedetailedcostreport.json
  - Microsoft.CostManagement/preview/2023-07-01-preview/costmanagement.json
  - Microsoft.CostManagement/preview/2023-07-01-preview/costmanagement.pricesheets.json
  - Microsoft.CostManagement/preview/2023-07-01-preview/scheduledActions.json
```

### Tag: package-2023-03

These settings apply only when `--tag=package-2023-03` is specified on the command line.

``` yaml $(tag) == 'package-2023-03'
input-file:
  - Microsoft.CostManagement/stable/2023-03-01/common-types.json
  - Microsoft.CostManagement/stable/2023-03-01/costmanagement.benefits.json
  - Microsoft.CostManagement/stable/2023-03-01/costmanagement.exports.json
  - Microsoft.CostManagement/stable/2023-03-01/costmanagement.generatecostdetailsreport.json
  - Microsoft.CostManagement/stable/2023-03-01/costmanagement.generatedetailedcostreport.json
  - Microsoft.CostManagement/stable/2023-03-01/costmanagement.json
  - Microsoft.CostManagement/stable/2023-03-01/costmanagement.pricesheets.json
  - Microsoft.CostManagement/stable/2023-03-01/scheduledActions.json
```

### Tag: package-preview-2023-04

These settings apply only when `--tag=package-preview-2023-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-04'
input-file:
  - Microsoft.CostManagement/preview/2023-04-01-preview/common-types.json
  - Microsoft.CostManagement/preview/2023-04-01-preview/costmanagement.benefits.json
  - Microsoft.CostManagement/preview/2023-04-01-preview/costmanagement.budgets.json
  - Microsoft.CostManagement/preview/2023-04-01-preview/costmanagement.exports.json
  - Microsoft.CostManagement/preview/2023-04-01-preview/costmanagement.generatecostdetailsreport.json
  - Microsoft.CostManagement/preview/2023-04-01-preview/costmanagement.generatedetailedcostreport.json
  - Microsoft.CostManagement/preview/2023-04-01-preview/costmanagement.json
  - Microsoft.CostManagement/preview/2023-04-01-preview/costmanagement.pricesheets.json
  - Microsoft.CostManagement/preview/2023-04-01-preview/scheduledActions.json
```

### Tag: package-2022-10

These settings apply only when `--tag=package-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-2022-10'
input-file:
  - Microsoft.CostManagement/stable/2022-10-01/common-types.json
  - Microsoft.CostManagement/stable/2022-10-01/costmanagement.json
  - Microsoft.CostManagement/stable/2022-10-01/costmanagement.exports.json
  - Microsoft.CostManagement/stable/2022-10-01/costmanagement.generatecostdetailsreport.json
  - Microsoft.CostManagement/stable/2022-10-01/costmanagement.generatedetailedcostreport.json
  - Microsoft.CostManagement/stable/2022-10-01/costmanagement.pricesheets.json
  - Microsoft.CostManagement/stable/2022-10-01/scheduledActions.json
  - Microsoft.CostManagement/stable/2022-10-01/costmanagement.benefits.json
```

### Tag: package-preview-2022-10-05

These settings apply only when `--tag=package-preview-2022-10-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-10-05'
input-file:
  - Microsoft.CostManagement/preview/2022-10-05-preview/costmanagement.json
  - Microsoft.CostManagement/preview/2022-10-05-preview/settings.json
  - Microsoft.CostManagement/preview/2022-10-05-preview/markup.json
```

### Tag: package-preview-2022-10

These settings apply only when `--tag=package-preview-2022-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-10'
input-file:
  - Microsoft.CostManagement/preview/2022-10-01-preview/costmanagement.json
  - Microsoft.CostManagement/preview/2022-10-01-preview/settings.json
```

### Tag: package-preview-2022-08

These settings apply only when `--tag=package-preview-2022-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-08'
input-file:
  - Microsoft.CostManagement/preview/2022-08-01-preview/costmanagement.json
```

### Tag: package-2022-05

These settings apply only when `--tag=package-2022-05` is specified on the command line.

``` yaml $(tag) == 'package-2022-05'
input-file:
  - Microsoft.CostManagement/stable/2022-05-01/costmanagement.generatecostdetailsreport.json
  - Microsoft.CostManagement/stable/2021-10-01/costmanagement.json
  - Microsoft.CostManagement/stable/2021-10-01/costmanagement.exports.json
  - Microsoft.CostManagement/stable/2021-10-01/costmanagement.generatedetailedcostreport.json
```

### Tag: package-preview-2020-08

These settings apply only when `--tag=package-preview-2020-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-08'
input-file:
  - Microsoft.CostManagement/preview/2020-08-01-preview/costmanagement.insights.json
  - Microsoft.CostManagement/stable/2021-10-01/costmanagement.json
  - Microsoft.CostManagement/preview/2022-06-01-preview/scheduledActions.json
```

### Tag: package-preview-2022-06

These settings apply only when `--tag=package-preview-2022-06` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-06'
input-file:
  - Microsoft.CostManagement/preview/2022-06-01-preview/scheduledActions.json
  - Microsoft.CostManagement/stable/2021-10-01/costmanagement.json
  - Microsoft.CostManagement/stable/2021-10-01/costmanagement.exports.json
```

### Tag: package-preview-2022-04

These settings apply only when `--tag=package-preview-2022-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-04'
input-file:
  - Microsoft.CostManagement/preview/2022-04-01-preview/scheduledActions.json
  - Microsoft.CostManagement/stable/2021-10-01/costmanagement.json
  - Microsoft.CostManagement/stable/2021-10-01/costmanagement.exports.json
```

### Tag: package-preview-2022-02

These settings apply only when `--tag=package-preview-2022-02` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-02'
input-file:
  - Microsoft.CostManagement/preview/2022-02-01-preview/costmanagement.pricesheets.json
```

### Tag: package-2021-10

These settings apply only when `--tag=package-2021-10` is specified on the command line.

``` yaml $(tag) == 'package-2021-10'
input-file:
  - Microsoft.CostManagement/stable/2021-10-01/costmanagement.exports.json
  - Microsoft.CostManagement/stable/2021-10-01/costmanagement.generatedetailedcostreport.json
  - Microsoft.CostManagement/stable/2021-10-01/costmanagement.json
```

### Tag: package-2021-01

These settings apply only when `--tag=package-2021-01` is specified on the command line.

``` yaml $(tag) == 'package-2021-01'
input-file:
  - Microsoft.CostManagement/stable/2021-01-01/costmanagement.exports.json
  - Microsoft.CostManagement/stable/2021-01-01/costmanagement.generatedetailedcostreport.json
  - Microsoft.CostManagement/stable/2020-06-01/costmanagement.json
```

### Tag: package-preview-2020-12

These settings apply only when `--tag=package-preview-2020-12` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-12'
input-file:
  - Microsoft.CostManagement/preview/2020-12-01-preview/costmanagement.exports.json
  - Microsoft.CostManagement/preview/2020-12-01-preview/costmanagement.generatedetailedcostreport.json
  - Microsoft.CostManagement/stable/2020-06-01/costmanagement.json
```

### Tag: package-preview-2020-03

These settings apply only when `--tag=package-preview-2020-03` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-03'
input-file:
  - Microsoft.CostManagement/stable/2020-06-01/costmanagement.json
  - Microsoft.CostManagement/preview/2020-03-01-preview/costallocation.json
```

### Tag: package-2020-06

These settings apply only when `--tag=package-2020-06` is specified on the command line.

``` yaml $(tag) == 'package-2020-06'
input-file:
  - Microsoft.CostManagement/stable/2020-06-01/costmanagement.json
  - Microsoft.CostManagement/stable/2020-06-01/costmanagement.exports.json
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
  - suppress: R4011
    from: costmanagement.exports.json
    reason: 'API change needed, The delete operation is defined without a 200 or 204 error response implementation,please add it'
  - suppress: TrackedResourcePatchOperation
    from: costmanagement.exports.json
    reason: False alarm, Export is a proxy resource
  - suppress: RequestSchemaForTrackedResourcesMustHaveTags
    from: costmanagement.exports.json
    reason: False alarm, Export is a proxy resource  
  - suppress: R3023
    from: costmanagement.generatedetailedcostreport.json    
    reason: 'API change needed, Operations API must be implemented for operations'
  - suppress: R4018
    from: costmanagement.json    
    reason: 'API change needed, Response schema of OperatioAPI does not match Arm Schema'
  - suppress: R4037
    from: costmanagement.generatedetailedcostreport.json
    reason: 'This needs api change - MissingTypeObject' 
  - suppress: R4009
    from: costmanagement.exports.json
    reason: API change needed, we do not yet support systemdata
  - suppress: R4009
    from: costmanagement.json
    reason: API change needed, we do not yet support systemdata
  - suppress: EnumInsteadOfBoolean
    from: costmanagement.exports.json
    where: $.definitions.CommonExportProperties.properties.partitionData
    reason: 'API change needed'
  - suppress: EnumInsteadOfBoolean
    from: costmanagement.json
    where: $.definitions.DimensionProperties.properties.filterEnabled
    reason: 'API change needed'
  - suppress: EnumInsteadOfBoolean
    from: costmanagement.json
    where: $.definitions.DimensionProperties.properties.groupingEnabled
    reason: 'API change needed'
  - suppress: EnumInsteadOfBoolean
    from: costmanagement.json
    where: $.definitions.ForecastDefinition.properties.includeFreshPartialCost
    reason: 'API change needed'
  - suppress: EnumInsteadOfBoolean
    from: costmanagement.json
    where: $.definitions.ForecastDefinition.properties.includeActualCost
    reason: 'API change needed'    
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
  - suppress: DeleteOperationResponses
    from: costmanagement.budgets.json
    reason: 'Consistent with delete api from other versions, modifying it will be a breaking change'
  - suppress: TopLevelResourcesListBySubscription
    from: costmanagement.budgets.json
    reason: 'List by subscription is included in the Budgets_List operation with the scope path parameter'
  - suppress: NoDuplicatePathsForScopeParameter
    from: costmanagement.budgets.json
    reason: 'Budgets_Get does not use an explicitly defined scope'
  - suppress: ResourceMustReferenceCommonTypes
    from: costmanagement.budgets.json
    reason: 'Budget references CostManagementProxyResource, which references the common type ProxyResource'
  - suppress: GetCollectionResponseSchema
    from: common-types.json
    reason: 'Operations does not contain a path for individual GET'
  - suppress: TopLevelResourcesListBySubscription
    from: costallocation.json
    reason: 'List by subscription is not supported in cost allocation by desgin'
  - suppress: PathForResourceAction
    from: costallocation.json
    reason: 'This is not a valid scenario for the checkNameAvailability API as the name itself represents an action.'
  - suppress: PathForPutOperation
    from: costallocation.json
    reason: 'Subscripiton and ResourceGroup scope is not supported in cost allocation by desgin'
  - suppress: RequiredReadOnlySystemData
    from: costallocation.json
    reason: 'cost allocation does not return system data and will consider adding it in the future or upcoming api version'
  - suppress: EnumInsteadOfBoolean
    from: costallocation.json
    reason: 'Keeping it as boolean property as per the design'
  - suppress: NoDuplicatePathsForScopeParameter
    from: settings.json
    reason: 'Settings does not use scope for List API'
  - suppress: GetCollectionOnlyHasValueAndNextLink
    from: settings.json
    reason: 'Settings List designed to deliver very limited records'
  - suppress: PageableOperation
    from: settings.json
    reason: 'Settings List designed to deliver very limited records'
  - suppress: TopLevelResourcesListBySubscription
    from: settings.json
    reason: 'List by subscription is not supported in settings by desgin'
  - suppress: EnumInsteadOfBoolean
    from: settings.json
    reason: 'Keeping it as boolean property as per the design'
  - suppress: ParameterNotUsingCommonTypes
    from: settings.json
    reason: 'Settings does not support all the scopes to use it from common types, hence we have defined exclusively with custom description.'
  - suppress: RequiredReadOnlySystemData
    from: settings.json
    reason: 'Settings does not return system data and will consider adding it in the future or upcoming api version'
        
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
  - repo: azure-sdk-for-net-track2
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_costmanagement']
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
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

## Python

See configuration in [readme.python.md](./readme.python.md)

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
