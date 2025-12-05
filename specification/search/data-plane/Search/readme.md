# AI Search

> see https://aka.ms/autorest

This is the AutoRest configuration file for AI Search.


---

## Getting Started

To build the SDK for AI Search, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for SearchServiceClient and SearchIndexClient.

These are the global settings for the AI Search API.

``` yaml
# common
openapi-type: data-plane
tag: package-2025-11-01-preview

directive:
  - where:
      -  $.definitions.AnalyzedTokenInfo.properties.endOffset
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.AnalyzedTokenInfo.properties.position
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.AnalyzedTokenInfo.properties.startOffset
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.AnalyzedTokenInfo.properties.token
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.AutocompleteItem.properties.queryPlusText
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.AutocompleteItem.properties.text
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.AutocompleteResult.properties.value
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.GetIndexStatisticsResult.properties.documentCount
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.GetIndexStatisticsResult.properties.storageSize
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.IndexDocumentsResult.properties.value
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.IndexerExecutionResult.properties.errors
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.IndexerExecutionResult.properties.itemsFailed
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.IndexerExecutionResult.properties.itemsProcessed
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.IndexerExecutionResult.properties.status
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.IndexerExecutionResult.properties.warnings
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.IndexingResult.properties.key
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.IndexingResult.properties.status
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.IndexingResult.properties.statusCode
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.ListDataSourcesResult.properties.value
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.ListIndexersResult.properties.value
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.ListIndexesResult.properties.value
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.ListAliasesResult.properties.value
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.ListSkillsetsResult.properties.value
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.ListSynonymMapsResult.properties.value
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.SearchDocumentsResult.properties.value
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.SearchIndexerError.properties.errorMessage
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.SearchIndexerError.properties.statusCode
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.SearchIndexerStatus.properties.executionHistory
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.SearchIndexerStatus.properties.limits
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.SearchIndexerStatus.properties.status
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.SearchIndexerWarning.properties.message
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.SearchResult.properties["@search.score"]
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.SuggestDocumentsResult.properties.value
    suppress:
      - RequiredReadOnlyProperties
  - where:
      -  $.definitions.SuggestResult.properties["@search.text"]
    suppress:
      - RequiredReadOnlyProperties
```

### Tag: package-2025-11-01-preview

These settings apply only when `--tag=package-2025-11-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2025-11-01-preview'
input-file:
  - preview/2025-11-01-preview/search.json
suppressions:
  - code: LroExtension
    from: search.json
    reason: Legacy swagger file
```

### Suppression
``` yaml
directive:
  - suppress: INVALID_TYPE
  - suppress: DISCRIMINATOR_VALUE_NOT_FOUND
```
