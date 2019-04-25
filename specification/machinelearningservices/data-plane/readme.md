# AzureMachineLearning

> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureMachineLearning.



---
## Getting Started
To build the SDK for AzureMachineLearning, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the AzureMachineLearning API.

``` yaml
openapi-type: data-plane
tag: package-2019-05-preview
use-internal-constructors: true
add-credentials: true
```


### Tag: package-2019-05-preview

These settings apply only when `--tag=package-2019-05-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-05-preview'
input-file:
- Microsoft.MachineLearningServices/preview/2019-05-01/AzureMachineLearning.json
```


---
# Code Generation


## Swagger to SDK

Swagger to SDK has been intentionally disabled for this spec.

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.MachineLearning.Services
  output-folder: $(csharp-sdks-folder)/MachineLearning/Services/Generated
  clear-output-folder: true
```


## Python

Python generation is intentionally disabled.  Please use the published Python package for Azure Machine Learning on PyPi.


## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  namespace: com.microsoft.azure.machinelearning.services
  license-header: MICROSOFT_MIT_NO_CODEGEN
  output-folder: $(azure-libraries-for-java-folder)/azure-machinelearning-services
```
