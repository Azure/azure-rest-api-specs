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
   - tag: package-resources-2016-02
     ApiVersionName: Api2016_02_01
```