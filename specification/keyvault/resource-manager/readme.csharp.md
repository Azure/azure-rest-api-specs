# C# KeyVault

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

## Common settings
``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION  
  clear-output-folder: true
```

``` yaml $(csharp) && !$(multiapi)
namespace: Microsoft.Azure.Management.KeyVault
output-folder: $(csharp-sdks-folder)/KeyVault/Management/Management.KeyVault/Generated
```

## Batch settings
These settings are for batch mode only: (ie, add `--multiapi` to the command line )

``` yaml $(multiapi)
ProfileName: 2018-03-01-profile
namespace: Microsoft.Azure.$(ProfileName).KeyVault
output-folder: $(csharp-sdks-folder)/$(ProfileName)/Generated

batch:
  - tag: package-2016-10
  - tag: package-2015-06
```