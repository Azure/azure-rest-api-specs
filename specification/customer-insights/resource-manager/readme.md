# CustomerInsights
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for CustomerInsights.



---
## Getting Started 
To build the SDK for CustomerInsights, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the CustomerInsights API.

``` yaml
openapi-type: arm
tag: package-2017-04
```


### Tag: package-2017-04

These settings apply only when `--tag=package-2017-04` is specified on the command line.

``` yaml $(tag) == 'package-2017-04'
input-file:
- Microsoft.CustomerInsights/2017-04-26/customer-insights.json
```


### Tag: package-2017-01

These settings apply only when `--tag=package-2017-01` is specified on the command line.

``` yaml $(tag) == 'package-2017-01'
input-file:
- Microsoft.CustomerInsights/2017-01-01/customer-insights.json
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
  namespace: Microsoft.Azure.Management.CustomerInsights
  output-folder: $(csharp-sdks-folder)/CustomerInsights/Management.CustomerInsights/Generated
  clear-output-folder: true
```
