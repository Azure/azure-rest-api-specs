# Batch
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Batch.



---
## Getting Started 
To build the SDK for Batch, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Batch API.

``` yaml
openapi-type: arm
tag: package-2017-05
```


### Tag: package-2017-05

These settings apply only when `--tag=package-2017-05` is specified on the command line.

``` yaml $(tag) == 'package-2017-05'
input-file:
- Microsoft.Batch/2017-05-01/BatchManagement.json
```


### Tag: package-2017-01

These settings apply only when `--tag=package-2017-01` is specified on the command line.

``` yaml $(tag) == 'package-2017-01'
input-file:
- Microsoft.Batch/2017-01-01/BatchManagement.json
```
 
### Tag: package-2015-12

These settings apply only when `--tag=package-2015-12` is specified on the command line.

``` yaml $(tag) == 'package-2015-12'
input-file:
- Microsoft.Batch/2015-12-01/BatchManagement.json
```


---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # last generated with AutoRest.1.0.0-Nightly20170129 from commit 19f63015ea5a8a0fc64b9d7e2cdfeac447d93eaf 
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Batch
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/Batch/Management/Management.Batch/Generated
  clear-output-folder: true
```
