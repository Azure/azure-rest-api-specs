# Azure Location Based Services
    
> see https://aka.ms/autorest

Configuration for generating Azure Location Based Services Proxy API SDK.

The current release is `package-1.0`.

``` yaml
tag: package-1.0
openapi-type: data-plane
```
### Tag: package-1.0
These settings apply only when `--tag=package-1.0` is specified on the command line.

``` yaml $(tag) == 'package-1.0'
input-file: Microsoft.LocationBasedServices/1.0/LBS.json
```

## CSharp Settings
These settings apply only when `--csharp` is specified on the command line.
``` yaml $(csharp) 
csharp: 
  license-header: MICROSOFT_MIT_NO_VERSION
  azure-arm: false
  namespace: Microsoft.LocationBasedServices
  output-folder: $(csharp-sdks-folder)/LocationBasedServices/Generated
  clear-output-folder: true
```

## Validation Steps
``` yaml $(validation)
azure-validator: true
semantic-validator: true

# ToDo: Commenting this out for now. It is failing for an unknown reason.  I believe
# it is related to what is discussed in this thread: 
# https://github.com/Azure/oav/issues/182
# model-validator: true
```

``` yaml
directive:
    from: swagger-document
    where: $..*[?(@.name === "format" && @.enum.includes('json'))]
    transform: $.enum = ['json']
```