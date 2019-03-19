# SearchServiceClient
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for SearchServiceClient.


---
## Getting Started 

To build the SDK for SearchServiceClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information 
These are the global settings for SearchServiceClient.

``` yaml
openapi-type: data-plane
tag: package-2017-11-preview
```

### Tag: package-2017-11-preview

These settings apply only when `--tag=package-2017-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-11-preview'
input-file:
- preview/2017-11-11-preview/searchservice.json
```

### Tag: package-2017-11

These settings apply only when `--tag=package-2017-11` is specified on the command line.

``` yaml $(tag) == 'package-2017-11'
input-file:
- preview/2017-11-11/searchservice.json
```

### Tag: package-2016-09-preview

These settings apply only when `--tag=package-2016-09-preview` is specified on the command line.

``` yaml $(tag) == 'package-2016-09-preview'
input-file:
- preview/2016-09-01-preview/searchservice.json
```

### Tag: package-2016-09

These settings apply only when `--tag=package-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-2016-09'
input-file:
- preview/2016-09-01/searchservice.json
```
 
### Tag: package-2015-02-preview

These settings apply only when `--tag=package-2015-02-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-02-preview'
input-file:
- preview/2015-02-28-preview/searchservice.json
```

### Tag: package-2015-02

These settings apply only when `--tag=package-2015-02` is specified on the command line.

``` yaml $(tag) == 'package-2015-02'
input-file:
- preview/2015-02-28/searchservice.json
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
  output-folder: $(csharp-sdks-folder)/Search/DataPlane/Microsoft.Azure.Search.Service/Generated

directive: 
  # TODO: Remove this workaround once AutoRest fixes the incorrect code generation when using a parameterized host and both client and operation groups paths.
  - from: source-file-csharp
    where: $
    transform: >-
      if ($.includes("class DataSourcesOperations") || $.includes("class IndexersOperations") || 
        $.includes("class IndexesOperations") ||  $.includes("class SynonymMapsOperations") ||
        $.includes("class SkillsetsOperations")) 
        
        return $.
          replace( /this.SearchServiceName/g, "Client.SearchServiceName" ).
          replace( /this.SearchDnsSuffix/g, "Client.SearchDnsSuffix" ).
          replace( /\"Client.SearchServiceName\"/g, "\"this.Client.SearchServiceName\"" ).
          replace( /\"Client.SearchDnsSuffix\"/g, "\"this.Client.SearchDnsSuffix\"" );
      return $;  
####
  # The following regex are required to make the generated Field class conform to the needs of the custom implementation
  # that we've had in the Azure Search .NET SDK since it was first released. We've decided to keep the custom behavior of
  # Field just for .NET for the sake of backward compatibility, but for other languages the client behavior will conform
  # to the REST API.
  # 
  # To achieve this, we need to make the generated constructors internal, as well as some of the generated properties.
  - from: source-file-csharp
    where: $
    transform: >-
        return $.
          replace( /public (Field\(\))/g, "internal $1" ).
          replace( /public (Field\(string name,)/g, "internal $1" ).
          replace( /public (bool\? Key { get; set; })/g, "internal $1" ).
          replace( /public (bool\? Retrievable { get; set; })/g, "internal $1" ).
          replace( /public (bool\? Searchable { get; set; })/g, "internal $1" ).
          replace( /public (bool\? Filterable { get; set; })/g, "internal $1" ).
          replace( /public (bool\? Sortable { get; set; })/g, "internal $1" ).
          replace( /public (bool\? Facetable { get; set; })/g, "internal $1" );
```
