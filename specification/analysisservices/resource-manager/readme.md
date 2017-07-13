# AnalysisServices
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for AnalysisServices.



---
## Getting Started 
To build the SDK for AnalysisServices, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the AnalysisServices API.

``` yaml
openapi-type: arm
tag: package-2016-05
```


### Tag: package-2016-05

These settings apply only when `--tag=package-2016-05` is specified on the command line.

``` yaml $(tag) == 'package-2016-05'
input-file:
- Microsoft.AnalysisServices/2016-05-16/analysisservices.json
```

---
# Code Generation

## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT
  namespace: Microsoft.Azure.Management.Analysis
  output-folder: $(csharp-sdks-folder)/AnalysisServices/Management.Analysis/Generated
```

