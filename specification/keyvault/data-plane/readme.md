# KeyVault
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for KeyVault.



---
## Getting Started 
To build the SDK for KeyVault, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the KeyVault API.

``` yaml
openapi-type: data-plane
tag: package-2016-10
```


### Tag: package-2016-10

These settings apply only when `--tag=package-2016-10` is specified on the command line.

``` yaml $(tag) == 'package-2016-10'
input-file:
- Microsoft.KeyVault/2016-10-01/keyvault.json
```
 
### Tag: package-2015-06

These settings apply only when `--tag=package-2015-06` is specified on the command line.

``` yaml $(tag) == 'package-2015-06'
input-file:
- Microsoft.KeyVault/2015-06-01/keyvault.json
```


---
## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.KeyVault
  sync-methods: None
  output-folder: $(csharp-sdks-folder)/KeyVault/dataPlane/Microsoft.Azure.KeyVault/Generated
  clear-output-folder: true
```