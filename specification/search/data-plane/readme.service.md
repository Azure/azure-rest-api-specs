# SearchServiceClient
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for SearchServiceClient.



---
## Getting Started 
To build the SDK for SearchServiceClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest --service`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Tag: package-2016-09-preview

These settings apply only when `--tag=package-2016-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-2016-09-preview'
input-file:
- Microsoft.Search/preview/2016-09-01-preview/searchservice.json
```

### Tag: package-2016-09

These settings apply only when `--tag=package-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-2016-09'
input-file:
- Microsoft.Search/preview/2016-09-01/searchservice.json
```
 
### Tag: package-2015-02-preview

These settings apply only when `--tag=package-2015-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-02-preview'
input-file:
- Microsoft.Search/preview/2015-02-28-preview/searchservice.json
```
 
### Tag: package-2015-02

These settings apply only when `--tag=package-2015-02` is specified on the command line.

``` yaml $(tag) == 'package-2015-02'
input-file:
- Microsoft.Search/preview/2015-02-28/searchservice.json
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
  output-folder: $(csharp-sdks-folder)/Search/DataPlane/Microsoft.Azure.Search/GeneratedSearchService
```
