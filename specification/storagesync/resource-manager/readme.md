# StorageSync
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for StorageSync.



---
## Getting Started 
To build the SDK for Storage, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Storage Sync API.

``` yaml
openapi-type: arm
tag: package-2017-06-05-preview
```



### Tag: package-2017-06-05-preview

These settings apply only when `--tag=package-2017-06-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-06-05-preview'
input-file:
- Microsoft.StorageSync/preview/2017-06-05-preview/storagesync.json
```


---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.StorageSync
  payload-flattening-threshold: 2
  output-folder: $(csharp-sdks-folder)/Storage/Management.StorageSync/Generated
  clear-output-folder: true
```