# MachineLearningCompute
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Machine Learning Compute.



---
## Getting Started 
To build the SDK for EventHub, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Machine Learning Compute API.

``` yaml
openapi-type: arm
tag: package-2017-08-preview
```


### Tag: package-2017-08-preview

These settings apply only when `--tag=package-2017-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-08-preview'
input-file:
- Microsoft.MachineLearningCompute/2017-08-01-preview/machineLearningCompute.json
```


### Tag: package-2017-06-preview

These settings apply only when `--tag=package-2017-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-06-preview'
input-file:
- Microsoft.MachineLearningCompute/2017-06-01-preview/machineLearningCompute.json
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
  namespace: Microsoft.Azure.Management.MachineLearningCompute
  output-folder: $(csharp-sdks-folder)/MachineLearningCompute/Management.MachineLearningCompute/Generated
  clear-output-folder: true
```