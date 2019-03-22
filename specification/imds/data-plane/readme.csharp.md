# C# Storage

> see https://aka.ms/autorest

This is the AutoRest configuration file for IMDS.

## Common C# Settings

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION  
  clear-output-folder: true
```

``` yaml $(csharp) && !$(multiapi) && !$(profile)
payload-flattening-threshold: 2
namespace: Microsoft.Azure.InstanceMetadataService
output-folder: $(csharp-sdks-folder)/Azure/InstanceMetadataService/Generated
```
