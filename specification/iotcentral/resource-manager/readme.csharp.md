# C# Storage

> see https://aka.ms/autorest
This is the AutoRest configuration file for IotCentral.

## Common C# Settings

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION  
  clear-output-folder: true
  payload-flattening-threshold: 2
  namespace: Microsoft.Azure.Management.IotCentral
  output-folder: $(csharp-sdks-folder)/iotcentral/Microsoft.Azure.Management.IotCentral/src/Generated
```