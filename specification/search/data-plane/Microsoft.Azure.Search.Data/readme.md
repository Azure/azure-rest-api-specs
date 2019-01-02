# SearchIndexClient
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for SearchIndexClient.


---
## Getting Started 

To build the SDK for SearchIndexClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information 
These are the global settings for SearchIndexClient.

``` yaml
openapi-type: data-plane
tag: package-2017-11-preview
```

### Tag: package-2017-11-preview

These settings apply only when `--tag=package-2017-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-11-preview'
input-file:
- preview/2017-11-11-preview/searchindex.json
```
### Tag: package-2017-11

These settings apply only when `--tag=package-2017-11` is specified on the command line.

``` yaml $(tag) == 'package-2017-11'
input-file:
- preview/2017-11-11/searchindex.json
```

### Tag: package-2016-09-preview

These settings apply only when `--tag=package-2016-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-2016-09-preview'
input-file:
- preview/2016-09-01-preview/searchindex.json
```

### Tag: package-2016-09

These settings apply only when `--tag=package-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-2016-09'
input-file:
- preview/2016-09-01/searchindex.json
```
 
### Tag: package-2015-02-preview

These settings apply only when `--tag=package-2015-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-02-preview'
input-file:
- preview/2015-02-28-preview/searchindex.json
```
 
### Tag: package-2015-02

These settings apply only when `--tag=package-2015-02` is specified on the command line.

``` yaml $(tag) == 'package-2015-02'
input-file:
- preview/2015-02-28/searchindex.json
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
  output-folder: $(csharp-sdks-folder)/Search/DataPlane/Microsoft.Azure.Search.Data/Generated
```
