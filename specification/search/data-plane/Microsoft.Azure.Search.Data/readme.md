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

### Tweak generated code

Use the below directives sparingly. Every modification we make in here, we potentially have to replicate for every target language.

``` yaml $(csharp)
directive:
  # Make the IDocumentsProxyOperations interface internal so we can version it freely. This requires three changes:
  #   1. Make the interface itself internal
  #   2. Make the DocumentsProxy property of SearchIndexClient internal
  #   3. Rename the interface property and its type from DocumentsProxy to Documents, effectively removing the property
  #      from the ISearchIndexClient interface
  # Its replacement property, Documents of type IDocumentsOperations, is hand-written so that it can delegate to DocumentsProxy.
  # This allows us to do two things:
  #   1. Abstract away the detail of whether GET or POST is used for read operations (Search, Suggest, etc.)
  #   2. Add methods with type parameters and custom serialization to make our SDK easier to use in strongly-typed scenarios
  #      (i.e. -- where the customer is using a class to represent their model because its schema is known at design-time)
  - from: source-file-csharp
    where: $
    transform: >-
      return $.replace( /public (partial interface IDocumentsProxyOperations)/g, "internal $1" ).
        replace( /public virtual (IDocumentsProxyOperations DocumentsProxy { get;)/g, "internal $1" ).
        replace( /(Gets the )IDocumentsProxyOperations(.\s*\n\s*\/\/\/ <\/summary>\s*\n\s*)IDocumentsProxyOperations DocumentsProxy ({ get; })/g, "$1IDocumentsOperations$2IDocumentsOperations Documents $3" )
```
