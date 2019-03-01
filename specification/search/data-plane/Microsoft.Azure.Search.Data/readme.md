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
  # TODO: Simplify all the below regexes once we gain the ability to target them at specific files.

  # Rename the IDocumentsOperations interface and implementation, then make the interface internal so we can version it freely.
  # This requires these changes:
  #   1. Globally rename the interface and implementation class, along with comments and constructors
  #   2. Make the interface itself internal
  #   3. Make the SearchIndexClient.Documents property internal and rename it to DocumentsProxy
  #   4. Rename the type of the ISearchIndexClient.Documents property back to IDocumentsOperations, effectively removing the
  #      generated property from the interface (this reverses step 1 above just for this case)
  #
  # The ISearchIndexClient.Documents property is of type IDocumentsOperations, which is hand-written and delegates to DocumentsProxy.
  # This allows us to do two things:
  #   1. Abstract away the detail of whether GET or POST is used for read operations (Search, Suggest, etc.)
  #   2. Add methods with type parameters and custom serialization to make our SDK easier to use in strongly-typed scenarios
  #      (i.e. -- where the customer is using a class to represent their model because its schema is known at design-time)
  - from: source-file-csharp
    where: $
    transform: >-
      return $.
        replace( /DocumentsOperations/g, "DocumentsProxyOperations" ).
        replace( /public (partial interface IDocumentsProxyOperations)/g, "internal $1" ).
        replace( /public virtual (IDocumentsProxyOperations) Documents ({ get;)/g, "internal $1 DocumentsProxy $2" ).
        replace( /Documents = new DocumentsProxyOperations\(this\);/g, "DocumentsProxy = new DocumentsProxyOperations\(this\);" ).
        replace( /(Gets the) IDocumentsProxyOperations(.\s*\/\/\/ <\/summary>\s*)IDocumentsProxyOperations (Documents { get; })/g, "$1 IDocumentsOperations$2IDocumentsOperations $3" )
####
  # Adds extra JsonSerializerSettings parameters to all operation methods. This enables the SDK to delegate serialization/de-serialization to the custom serializer on a per-call basis.
  - from: source-file-csharp
    where: $
    transform: >-
      return $.
        replace( /(Async\(.*, CancellationToken cancellationToken = default\(CancellationToken\))/g, "$1, Newtonsoft.Json.JsonSerializerSettings requestSerializerSettings = null, Newtonsoft.Json.JsonSerializerSettings responseDeserializerSettings = null" ).
        replace( /(DeserializeObject<.+>\(.+), Client\.DeserializationSettings/g, "$1, responseDeserializerSettings ?? Client.DeserializationSettings" ).
        replace( /(SerializeObject\(.+), Client\.SerializationSettings/g , "$1, requestSerializerSettings ?? Client.SerializationSettings" )
####
  # Make GetWithHttpMessagesAsync generic so we can tell the deserializer what type to instantiate.
  # ASSUMPTION: Only GetWithHttpMessagesAsync makes a call to DeserializeObject<object>(), and only when it's deserializing the non-error response.
  # Ideally we'd be able to more finely target these transform rules.
  - from: source-file-csharp
    where: $
    transform: >-
      return $.
        replace( /(Task<AzureOperationResponse)<object>(> GetWithHttpMessagesAsync)/g, "$1<T>$2<T>" ).
        replace( /(DeserializeObject)<object>/g, "$1<T>" ).
        replace( /(var _result = new AzureOperationResponse)<object>/g, "$1<T>" )
####
  # Make SearchRequest/SuggestRequest/AutocompleteRequest internal, since they are implementation details.
  - from: source-file-csharp
    where: $
    transform: >-
      return $.
        replace( /public (partial class) (Suggest|Search|Autocomplete)(Request)/g, "internal $1 $2$3" )
####
  # Change the documentation for $select for Suggest. The .NET SDK treats this property differently than the REST API
  # does by default, and we don't want to change it for backwards compatibility reasons.
  - from: source-file-csharp
    where: $
    transform: >-
      return $.
        replace( /(The comma-separated list of fields to retrieve. If unspecified,) only the key field will be included in the results./g, "$1 all fields marked as retrievable in the schema are included." )
####
  # Make SuggestResult and DocumentSuggestResult generic so we can tell the deserializer what type to instantiate.
  # For SuggestResult, this means we also have to replace AdditionalProperties with a property of the generic type.
  - from: source-file-csharp
    where: $
    transform: >-
      return $.
        replace( /(public partial class DocumentSuggestResult)/g, "$1<T>" ).
        replace( /(IList<SuggestResult)/g, "$1<T>" ).
        replace( /(public partial class SuggestResult)/g, "$1<T>" ).
        replace( /(SuggestResult class.\s*\/\/\/ <\/summary>\s*)\/\/\/ <param name="additionalProperties">Unmatched properties from the\s*\/\/\/ message are deserialized this collection<\/param>/g, "$1/// <param name=\"document\">The document on which the suggested text is based.</param>" ).
        replace( /(public SuggestResult)\(IDictionary<string, object> additionalProperties = default\(IDictionary<string, object>\),/g, "$1(T document = default(T)," ).
        replace( /(public SuggestResult\(.*\)\s*{\s*)AdditionalProperties = additionalProperties;/g, "$1Document = document;" ).
        replace( /(\/\/\/ <summary>\s*\/\/\/) Gets or sets unmatched properties from the message are deserialized\s*\/\/\/ this collection(\s*\/\/\/ <\/summary>\s*)\[JsonExtensionData\]\s*public IDictionary<string, object> AdditionalProperties { get; set; }(\s*.*\s*\/\/\/ Gets the text of the suggestion result.)/g, "$1 Gets the document on which the suggested text is based. $2public T Document { get; private set; }$3" ).
        replace( /(SuggestGetWithHttpMessagesAsync)/g, "$1<T>" ).
        replace( /(SuggestPostWithHttpMessagesAsync)/g, "$1<T>" ).
        replace( /(AzureOperationResponse<DocumentSuggestResult)/g, "$1<T>" ).
        replace( /(DeserializeObject<DocumentSuggestResult)/g, "$1<T>" )
####
  # Improve documentation for SuggestParameters.
  - from: source-file-csharp
    where: $
    transform: >-
      return $.
        replace( /(\/\/\/) Additional parameters for SuggestGet operation./g, "$1 Parameters for filtering, sorting, fuzzy matching, and other suggestions query behaviors." )
####
  # Make IndexBatch and IndexAction generic so we can provide a strongly-typed interface all the way down.
  # For IndexAction, this means we also have to replace AdditionalProperties with a property of the generic type.
  # Also use IEnumerable<IndexAction> instead of IList for backwards compatibility.
  - from: source-file-csharp
    where: $
    transform: >-
      return $.
        replace( /(public partial class IndexBatch)/g, "$1<T>" ).
        replace( /IList<IndexAction>/g, "IEnumerable<IndexAction<T>>" ).
        replace( /(public partial class IndexAction)/g, "$1<T>" ).
        replace( /(IndexAction class.\s*\/\/\/ <\/summary>\s*)\/\/\/ <param name="additionalProperties">Unmatched properties from the\s*\n\s*\/\/\/ message are deserialized this collection<\/param>/g, "$1/// <param name=\"document\">The document on which the action will be performed.</param>" ).
        replace( /(public IndexAction)\(IDictionary<string, object> additionalProperties = default\(IDictionary<string, object>\),/g, "$1(T document = default(T)," ).
        replace( /(public IndexAction\(.*\)\s*{\s*)AdditionalProperties = additionalProperties;/g, "$1Document = document;" ).
        replace( /(\/\/\/ <summary>\s*\n\s*\/\/\/) Gets or sets unmatched properties from the message are deserialized\s*\n\s*\/\/\/ this collection(\s*\n\s*\/\/\/ <\/summary>\s*\n\s*)\[JsonExtensionData\]\s*\n\s*public IDictionary<string, object> AdditionalProperties ({ get; set; }\s*.*\s*\/\/\/ Gets or sets the operation to perform on a document)/g, "$1 Gets the document on which the action will be performed; Fields other than the key are ignored for delete actions. $2public T Document $3" ).
        replace( /(IndexWithHttpMessagesAsync)\((IndexBatch)/g, "$1<T>($2<T>" )
```
