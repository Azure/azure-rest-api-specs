# Search
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for the Azure Search data plane.



---
## Getting Started 
The Azure Search data plane SDK is comprised of two clients: SearchServiceClient, and SearchIndexClient. To build the data plane SDK for Azure Search, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest --service`
> `autorest --index`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Azure Search data plane API.

C# packages this service a little different from the others, so the following defaults don't apply to it.

``` yaml !$(csharp)
title: SearchClient
description: Search Client
openapi-type: data-plane
tag: package-2016-09-preview
```

---
# Code Generation

!!! READ THIS !!!
This swagger is not yet ready for languages other than C#.
!!! READ THIS !!!

## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Search
  clear-output-folder: true
```
