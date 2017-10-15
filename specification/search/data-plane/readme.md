# SearchClient
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for SearchClient.



---
## Getting Started 
To build the SDK for SearchClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the SearchClient API.

C# packages this RP a little different from the others, so the following defaults don't apply to it.

``` yaml !$(csharp)
title: SearchClient
description: Search Client
openapi-type: data-plane
tag: package-2016-09
```


### Tag: package-2016-09

These settings apply only when `--tag=package-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-2016-09'
input-file:
- Microsoft.Search/2016-09-01/searchindex.json
- Microsoft.Search/2016-09-01/searchservice.json
```
 
### Tag: package-2015-02-preview

These settings apply only when `--tag=package-2015-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-02-preview'
input-file:
- Microsoft.Search/2015-02-28-preview/searchindex.json
- Microsoft.Search/2015-02-28-preview/searchservice.json
```
 
### Tag: package-2015-02

These settings apply only when `--tag=package-2015-02` is specified on the command line.

``` yaml $(tag) == 'package-2015-02'
input-file:
- Microsoft.Search/2015-02-28/searchindex.json
- Microsoft.Search/2015-02-28/searchservice.json
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
  namespace: Microsoft.Azure.Search
  output-folder: $(csharp-sdks-folder)/Search/DataPlane/Microsoft.Azure.Search/Generated$(search-folder)
  clear-output-folder: true
```
