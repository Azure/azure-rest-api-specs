# C# Authorization

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

## Common C# Settings
``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION  
  clear-output-folder: true
```

``` yaml $(csharp) && !$(multiApi)
namespace: Microsoft.Azure.Management.Authorization
output-folder: $(csharp-sdks-folder)/Authorization/Management.Authorization/Generated
```











## Batch settings
These settings are for batch mode only: (ie, add `--MultiApi` to the command line )

``` yaml $(multiApi)
namespace: Microsoft.Azure.Management.Authorization.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
- tag: package-2015-07-AzStk
  ApiVersionName: Api2015_07_01
#- tag: package-2017-10-AzStk
#  ApiVersionName: Api2017_10_01
```

## Tag: Packages for Azure Stack

### Tag: package-2015-07-AzStk

These settings apply only when `--tag=package-2015-07-AzStk` is specified on the command line.

``` yaml $(tag) == 'package-2015-07-AzStk'
input-file:
- Microsoft.Authorization/stable/2015-07-01/authorization.json
#- ../../resources/resource-manager/Microsoft.Authorization/stable/2015-01-01/locks.json
#- ../../resources/resource-manager/Microsoft.Authorization/preview/2015-10-01-preview/policy.json
#override-info:
#    title: AuthorizationManagementClient
```

### Tag: package-2017-10-AzStk

These settings apply only when `--tag=package-2017-10-AzStk` is specified on the command line.

``` yaml $(tag) == 'package-2017-10-AzStk'
input-file:
- Microsoft.Authorization\preview\2017-10-01-preview\authorization-RACalls.json
- ../../resources/resource-manager/Microsoft.Authorization/stable/2016-12-01/policyAssignments.json
- ../../resources/resource-manager/Microsoft.Authorization/stable/2016-12-01/policyDefinitions.json
override-info:
    title: AuthorizationManagementClient
```