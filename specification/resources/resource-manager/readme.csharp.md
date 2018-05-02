# C# ResourceManager

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

## Common C# Settings

``` yaml !$(MultiApi)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
clear-output-folder: true
namespace: Microsoft.Azure.Management.ResourceManager  
output-folder: $(csharp-sdks-folder)/Resource/Management.ResourceManager/Generated

batch:
  - package-features: true
  - package-locks: true
  - package-policy: true
  - package-resources: true
  - package-subscriptions: true
  - package-links: true
#  - package-managedapplications: true
```


## Batch settings
These settings are for batch mode only: (ie, add `--MultiApi` to the command line )

``` yaml $(MultiApi)
namespace: Microsoft.Azure.Management.ResourceManager.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
   - tag: package-2016-02-AzStk
     ApiVersionName: Api2016_02_01
   - tag: package-2018-02-AzStk
     ApiVersionName: Api2018_02_01
```

## Tag: Packages for Azure Stack

### Tag: package-2016-02-AzStk

These settings apply only when `--tag=package-2016-02-AzStk` is specified on the command line.

``` yaml $(tag) == 'package-2016-02-AzStk'
input-file:
- Microsoft.Resources\stable\2016-02-01\resources.json
- Microsoft.Resources\stable\2016-09-01\links.json
- Microsoft.Resources\stable\2016-06-01\subscriptions.json
override-info:
    title: ResourceManagementClient
```

### Tag: package-2018-02-AzStk

These settings apply only when `--tag=package-2018-02-AzStk` is specified on the command line.

``` yaml $(tag) == 'package-2018-02-AzStk'
input-file:
- Microsoft.Resources\stable\2018-02-01\resources.json
# override-info:
#     title: ResourceManagementClient
```