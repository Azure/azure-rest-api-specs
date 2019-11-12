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
tag: package-2019-05
```

### Tag: package-2019-05

These settings apply only when `--tag=package-2019-05` is specified on the command line.

``` yaml $(tag) == 'package-2019-05'
input-file:
- stable/2019-05-06/searchindex.json
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

### Tag: track1-package-2019-05

These settings apply only when `--tag=track1-package-2019-05` is specified on the command line.
It is meant to be used for generating Track 1 .NET SDK only!

``` yaml $(tag) == 'track1-package-2019-05'
input-file:
- track1/stable/2019-05-06/searchindex.json
```

### Tag: track1-package-2019-05-preview

These settings apply only when `--tag=track1-package-2019-05-preview` is specified on the command line.
It is meant to be used for generating Track 1 .NET SDK only!

``` yaml $(tag) == 'track1-package-2019-05-preview'
opt-in-extensible-enums: true
input-file:
- track1/preview/2019-05-06-preview/searchindex.json
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
  output-folder: $(csharp-sdks-folder)/search/Microsoft.Azure.Search.Data/src/Generated
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
####
  # Make the constructors and AdditionalProperties property of FacetResult internal.
  - from: source-file-csharp
    where: $
    transform: >-
      return $.
        replace( /public (FacetResult\()/g, "internal $1" ).
        replace( /public (IDictionary<string, object> AdditionalProperties { get; set; }\s*.*\s*\/\/\/ Gets the approximate count of documents falling within the bucket)/g, "internal $1" )
####
  # Make SearchResult and DocumentSearchResult generic so we can tell the deserializer what type to instantiate.
  # For SearchResult, this means we also have to replace AdditionalProperties with a property of the generic type.
  - from: source-file-csharp
    where: $
    transform: >-
      return $.
        replace( /(public partial class DocumentSearchResult)/g, "$1<T>" ).
        replace( /(IList<SearchResult)/g, "$1<T>" ).
        replace( /(public partial class SearchResult)/g, "$1<T>" ).
        replace( /(SearchResult class.\s*\/\/\/ <\/summary>\s*)\/\/\/ <param name="additionalProperties">Unmatched properties from the\s*\/\/\/ message are deserialized this collection<\/param>/g, "$1/// <param name=\"document\">The document found by the search query.</param>" ).
        replace( /(public SearchResult)\(IDictionary<string, object> additionalProperties = default\(IDictionary<string, object>\),/g, "$1(T document = default(T)," ).
        replace( /(public SearchResult\(.*\)\s*{\s*)AdditionalProperties = additionalProperties;/g, "$1Document = document;" ).
        replace( /(\/\/\/ <summary>\s*\/\/\/) Gets or sets unmatched properties from the message are deserialized\s*\/\/\/ this collection(\s*\/\/\/ <\/summary>\s*)\[JsonExtensionData\]\s*public IDictionary<string, object> AdditionalProperties { get; set; }(\s*.*\s*\/\/\/ Gets the relevance score of the document compared to other)/g, "$1 Gets the document found by the search query. $2public T Document { get; private set; }$3" ).
        replace( /(SearchGetWithHttpMessagesAsync)/g, "$1<T>" ).
        replace( /(SearchPostWithHttpMessagesAsync)/g, "$1<T>" ).
        replace( /(AzureOperationResponse<DocumentSearchResult)/g, "$1<T>" ).
        replace( /(DeserializeObject<DocumentSearchResult)/g, "$1<T>" )
####
  # Make DocumentSearchResult.NextPageParameters and NextLink internal. The public interface for continuations has
  # historically been the custom-written SearchContinuationToken class, and we want to maintain that for backward
  # compatibility. Also, NextPageParameters is of type SearchRequest, which is internal. For this reason, we also need
  # to make the DocumentSearchResult constructors internal.
  - from: source-file-csharp
    where: $
    transform: >-
      return $.
        replace( /public (SearchRequest NextPageParameters { get; private set; })/g, "internal $1" ).
        replace( /public (string NextLink { get; private set; })/g, "internal $1" ).
        replace( /public (DocumentSearchResult\()/g, "internal $1" )
####
  # Improve documentation for SearchParameters and make the ScoringParameters property strongly-typed for ease of use
  # and backward compatibility.
  # TODO: Remove the check for JsonIgnore in the ScoringParameters regex below once we have the ability to target
  # specific files. It is currently necessary in order to only modify the property in SearchParameters and not
  # SearchRequest.
  - from: source-file-csharp
    where: $
    transform: >-
      return $.
        replace( /(\/\/\/) Additional parameters for SearchGet operation./g, "$1 Parameters for filtering, sorting, faceting, paging, and other search query behaviors." ).
        replace( /(public SearchParameters\(.*IList<)string(> scoringParameters = default\(IList<)string/g, "$1ScoringParameter$2ScoringParameter" ).
        replace( /(public IList<)string(> ScoringParameters { get; set; }\s*.*\s*.*\s*.*\s*.*\s*\[Newtonsoft.Json.JsonIgnore\])/g, "$1ScoringParameter$2" ).
        replace( /(IList<)string(> scoringParameters = default\(IList<)string(>\);\s*if \(searchParameters != null\))/g, "$1ScoringParameter$2ScoringParameter$3" )
####
  # Split the generated SearchGet and SearchPost methods into separate parts so we can re-use them for ContinueSearch.
  # TODO: Simplify the regexes below once we have the ability to target specific files. Later, remove this entirely once
  # AutoRest has more flexibility around paging (the current x-ms-pageable implementation doesn't work for us because it
  # doesn't model additional top-level response properties or continuation POST requests).
  - from: source-file-csharp
    where: $
    transform: >-
      return $.
        replace( /(Task<AzureOperationResponse<DocumentSearchResult<T>>>) (SearchGetWithHttpMessagesAsync<T>)\((.*), (Newtonsoft.Json.JsonSerializerSettings requestSerializerSettings = null, Newtonsoft.Json.JsonSerializerSettings responseDeserializerSettings = null)\);/g, "$1 $2($3, $4);\n\n        $1 Continue$2(string url, System.Guid? clientRequestId, Dictionary<string, List<string>> customHeaders, bool shouldTrace, string invocationId, CancellationToken cancellationToken, $4);\n" ).
        replace( /(Task<AzureOperationResponse<DocumentSearchResult<T>>>) (SearchPostWithHttpMessagesAsync<T>)\((.*), (Newtonsoft.Json.JsonSerializerSettings requestSerializerSettings = null, Newtonsoft.Json.JsonSerializerSettings responseDeserializerSettings = null)\);/g, "$1 $2($3, $4);\n\n        $1 Continue$2(string url, SearchRequest searchRequest, System.Guid? clientRequestId, Dictionary<string, List<string>> customHeaders, bool shouldTrace, string invocationId, CancellationToken cancellationToken, $4);\n" ).
        replace( /(_queryParameters.Add\(string.Format\("searchMode=\{0\}",.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*)(\/\/ Create HTTP transport objects)/g, "$1return await ContinueSearchGetWithHttpMessagesAsync<T>(_url, clientRequestId, customHeaders, _shouldTrace, _invocationId, cancellationToken, requestSerializerSettings, responseDeserializerSettings).ConfigureAwait(false);\n        }\n\n        public async Task<AzureOperationResponse<DocumentSearchResult<T>>> ContinueSearchGetWithHttpMessagesAsync<T>(string _url, System.Guid? clientRequestId, Dictionary<string, List<string>> customHeaders, bool _shouldTrace, string _invocationId, CancellationToken cancellationToken, JsonSerializerSettings requestSerializerSettings, JsonSerializerSettings responseDeserializerSettings)\n        {\n            $2" ).
        replace( /(docs\/search.post.search.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*.*\s*)(\/\/ Create HTTP transport objects)/g, "$1return await ContinueSearchPostWithHttpMessagesAsync<T>(_url, searchRequest, clientRequestId, customHeaders, _shouldTrace, _invocationId, cancellationToken, requestSerializerSettings, responseDeserializerSettings).ConfigureAwait(false);\n        }\n\n        public async Task<AzureOperationResponse<DocumentSearchResult<T>>> ContinueSearchPostWithHttpMessagesAsync<T>(string _url, SearchRequest searchRequest, System.Guid? clientRequestId, Dictionary<string, List<string>> customHeaders, bool _shouldTrace, string _invocationId, CancellationToken cancellationToken, JsonSerializerSettings requestSerializerSettings, JsonSerializerSettings responseDeserializerSettings)\n        {\n            $2" )
```

## Multi-API/Profile support for AutoRest v3 generators 

AutoRest V3 generators require the use of `--tag=all-api-versions` to select api files.

This block is updated by an automatic script. Edits may be lost!

``` yaml $(tag) == 'all-api-versions' /* autogenerated */
# include the azure profile definitions from the standard location
require: $(this-folder)/../../../../profiles/readme.md

# all the input files across all versions
input-file:
  - $(this-folder)/stable/2019-05-06/searchindex.json
  - $(this-folder)/preview/2017-11-11-preview/searchindex.json
  - $(this-folder)/preview/2017-11-11/searchindex.json
  - $(this-folder)/preview/2016-09-01-preview/searchindex.json
  - $(this-folder)/preview/2016-09-01/searchindex.json
  - $(this-folder)/preview/2015-02-28-preview/searchindex.json
  - $(this-folder)/preview/2015-02-28/searchindex.json
  - $(this-folder)/track1/stable/2019-05-06/searchindex.json
  - $(this-folder)/track1/preview/2019-05-06-preview/searchindex.json

```

If there are files that should not be in the `all-api-versions` set, 
uncomment the  `exclude-file` section below and add the file paths.

``` yaml $(tag) == 'all-api-versions'
#exclude-file: 
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```

