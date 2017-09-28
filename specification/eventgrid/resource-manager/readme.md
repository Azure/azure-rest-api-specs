# EventGrid

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure EventGrid.



---
## Getting Started
To build the SDK for Azure EventGrid, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information
These are the global settings for the Azure EventGrid API.

``` yaml
openapi-type: arm
tag: package-2017-09-preview
```


### Tag: package-2017-09-preview

These settings apply only when `--tag=package-2017-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-09-preview'
input-file:
- Microsoft.EventGrid/2017-09-15-preview/EventGrid.json
```


### Tag: package-2017-06-preview

These settings apply only when `--tag=package-2017-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-06-preview'
input-file:
- Microsoft.EventGrid/2017-06-15-preview/EventGrid.json
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
  namespace: Microsoft.Azure.Management.EventGrid
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/EventGrid/Management.EventGrid/Generated
  clear-output-folder: true
```
