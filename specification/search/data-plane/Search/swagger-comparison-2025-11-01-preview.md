# Swagger Comparison: Azure Search 2025-11-01-preview

**Scope**: `specification/search/data-plane/Search`

This document compares:
1. **Old (hand-authored)**: `searchservice.json` + `searchindex.json` + `knowledgebase.json` — the hand-authored swagger **before** [PR #38841](https://github.com/Azure/azure-rest-api-specs/pull/38841) was merged
2. **New (TSP-compiled)**: `search.json` — the TypeSpec-compiled swagger in the current `main` branch

---

## Overview

The PR (#38841) migrated the Azure Search data-plane specification from three separate hand-authored swagger files to a single TypeSpec-compiled `search.json`. Both describe the same `2025-11-01-preview` API.

**Note**: Per the comparison rules, if a `$ref` to a model is converted to an inline schema (or vice versa), and if their unfolded object schemas are the same, that is **not** a breaking change.

---

## Breaking Changes

### 1. Legacy Skill Types Removed from Discriminator Union

The V1 variants of `SentimentSkill` and `EntityRecognitionSkill` were removed from the `SearchIndexerSkill` polymorphic discriminator union.

| Type | Old `x-ms-discriminator-value` | Status in new spec |
|------|--------------------------------|--------------------|
| `SentimentSkill` | `#Microsoft.Skills.Text.SentimentSkill` | **Removed** |
| `EntityRecognitionSkill` | `#Microsoft.Skills.Text.EntityRecognitionSkill` | **Removed** |

The V3 variants remain:
- `SentimentSkillV3` (`#Microsoft.Skills.Text.V3.SentimentSkill`) — unchanged
- `EntityRecognitionSkillV3` (`#Microsoft.Skills.Text.V3.EntityRecognitionSkill`) — unchanged

**Impact**: Any skillset that uses the V1 variants (with `@odata.type` of `#Microsoft.Skills.Text.SentimentSkill` or `#Microsoft.Skills.Text.EntityRecognitionSkill`) will no longer match the swagger definitions. V3 equivalents remain fully supported. The V1 skills were deprecated in a previous API version.

---

### 2. `$select` Query Parameter Type Changed

For list operations on `/datasources`, `/indexers`, `/skillsets`, and `/synonymmaps`, the `$select` query parameter type changed:

| | Old | New |
|-|-----|-----|
| Type | `string` | `array` (items: `string`, collectionFormat: `csv`) |
| Wire format | Comma-separated string | Comma-separated string (same) |

**Example**: `$select=name,type` works identically on the wire in both cases.

**Impact**: No change to HTTP wire format (both serialize as `?$select=name,type`). However, SDK clients that were generated from the old spec may have typed this as a plain `string`, while new clients will use `string[]`. This is a breaking change for **code-generated SDK clients** but not for direct HTTP callers.

---

### 3. `Accept` Header Added as Required Parameter

The new TSP-compiled spec adds `Accept: application/json;odata.metadata=minimal` as a **required header parameter** to all operations.

**Old spec**: No explicit `Accept` header parameter defined  
**New spec**: Every operation includes:
```json
{
  "name": "Accept",
  "in": "header",
  "required": true,
  "type": "string",
  "enum": ["application/json;odata.metadata=minimal"]
}
```

**Impact**: Technically adds a new required parameter to all operations. In practice, well-behaved HTTP clients have always been expected to send an `Accept` header, and the service was already returning `application/json;odata.metadata=minimal`. This makes the implicit contract explicit. HTTP servers ignore the `Accept` header (or use it for content negotiation) and will still respond to requests that omit it. This is a **cosmetic/documentation breaking change** rather than an API behavior change.

---

### 4. Body Parameter Names Changed (Swagger-Level Only)

The names of request body parameters changed in several operations. The underlying JSON schema (`$ref` target) is **identical** — only the swagger parameter name differs.

| Operation | Old body param name | New body param name | Schema |
|-----------|---------------------|---------------------|--------|
| `POST /datasources` | `dataSource` | `dataSourceConnection` | `SearchIndexerDataSource` (same) |
| `POST /knowledgebases` | `KnowledgeBase` | `knowledgeBase` | `KnowledgeBase` (same) |
| `PUT /knowledgebases('{knowledgeBaseName}')` | `KnowledgeBase` | `knowledgeBase` | `KnowledgeBase` (same) |
| `POST /knowledgesources` | `KnowledgeSource` | `knowledgeSource` | `KnowledgeSource` (same) |
| `PUT /knowledgesources('{sourceName}')` | `KnowledgeSource` | `knowledgeSource` | `KnowledgeSource` (same) |

**Impact**: The HTTP body format (JSON schema) is unchanged. This is a **swagger metadata change** that may affect SDK method parameter names in generated clients.

---

### 5. `ChatCompletionExtraParametersBehavior` Enum Value Bug Fix

This is technically a breaking change in the swagger `enum` array, but it **fixes a pre-existing inconsistency** in the old hand-authored spec:

| | Old `enum` value | Old `x-ms-enum.values[0].value` | New `enum` value |
|-|-----------------|--------------------------------|-----------------|
| Pass-through | `"pass-through"` ❌ | `"passThrough"` ✅ | `"passThrough"` ✅ |

The old spec was **internally inconsistent**: the `enum` array listed `"pass-through"` (with hyphen) but the `x-ms-enum.values` listed `"passThrough"` (camelCase). The new spec correctly uses `"passThrough"` in the enum.

**Impact**: The API wire value was already `"passThrough"` (based on the correct `x-ms-enum.values`). This change fixes the swagger to match actual API behavior. Any client using the **incorrect** value `"pass-through"` would have been rejected by the service already.

---

## Non-Breaking Changes

### 1. Schema File Consolidation

Three separate swagger files merged into one:

| Old | New |
|-----|-----|
| `searchservice.json` (531 KB, service operations) | `search.json` (764 KB, all operations) |
| `searchindex.json` (137 KB, document operations) | *(merged)* |
| `knowledgebase.json` (35 KB, knowledge operations) | *(merged)* |

### 2. URL Path Consolidation (Equivalent Routing)

Document operations and knowledge retrieval moved from parameterized host templates to explicit path prefixes. The resolved URLs are **identical**:

| Old | New |
|-----|-----|
| host: `{endpoint}/indexes('{indexName}')` + path `/docs/...` | host: `{endpoint}` + path `/indexes('{indexName}')/docs/...` |
| host: `{endpoint}/knowledgebases('{knowledgeBaseName}')` + path `/retrieve` | host: `{endpoint}` + path `/knowledgebases('{knowledgeBaseName}')/retrieve` |

### 3. Definition Renames (35 Equivalent Renames)

All of the following definitions were renamed with **identical content** (verified by schema unfolding):

| Old Name | New Name |
|----------|----------|
| `AmlSkill` | `AzureMachineLearningSkill` |
| `AzureOpenAIParameters` | `AzureOpenAIVectorizerParameters` |
| `BM25Similarity` | `BM25SimilarityAlgorithm` |
| `BinaryQuantizationVectorSearchCompressionConfiguration` | `BinaryQuantizationCompression` |
| `CaptionResult` | `QueryCaptionResult` |
| `Captions` | `QueryCaptionType` |
| `ClassicSimilarity` | `ClassicSimilarityAlgorithm` |
| `DataToExtract` | `BlobIndexerDataToExtract` |
| `EncoderModelName` | `SplitSkillEncoderModelName` |
| `ExecutionEnvironment` | `IndexerExecutionEnvironment` |
| `ExhaustiveKnnVectorSearchAlgorithmConfiguration` | `ExhaustiveKnnAlgorithmConfiguration` |
| `HnswVectorSearchAlgorithmConfiguration` | `HnswAlgorithmConfiguration` |
| `ImageAction` | `BlobIndexerImageAction` |
| `OcrSkillLineEnding` | `OcrLineEnding` |
| `ParsingMode` | `BlobIndexerParsingMode` |
| `PdfTextRotationAlgorithm` | `BlobIndexerPDFTextRotationAlgorithm` |
| `PrioritizedFields` | `SemanticPrioritizedFields` |
| `QueryResultDocumentSemanticFieldState` | `SemanticFieldState` |
| `QueryRewrites` | `QueryRewritesType` |
| `RawVectorQuery` | `VectorizedQuery` |
| `ScalarQuantizationVectorSearchCompressionConfiguration` | `ScalarQuantizationCompression` |
| `SearchIndexerIndexProjections` | `SearchIndexerIndexProjection` |
| `SemanticErrorHandling` | `SemanticErrorMode` |
| `SemanticPartialResponseReason` | `SemanticErrorReason` |
| `SemanticPartialResponseType` | `SemanticSearchResultsType` |
| `SemanticSettings` | `SemanticSearch` |
| `ServiceCounters` | `SearchServiceCounters` |
| `ServiceLimits` | `SearchServiceLimits` |
| `ServiceStatistics` | `SearchServiceStatistics` |
| `Similarity` | `SimilarityAlgorithm` |
| `Speller` | `QuerySpellerType` |
| `Suggester` | `SearchSuggester` |
| `VectorSearchCompressionConfiguration` | `VectorSearchCompression` |
| `VectorSearchCompressionTargetDataType` | `VectorSearchCompressionTarget` |
| `AnswerResult` | `QueryAnswerResult` |
| `Answers` | `QueryAnswerType` |
| `WebApiParameters` | `WebApiVectorizerParameters` |

> Note: `WebApiParameters.httpHeaders` was typed as `$ref: WebApiHttpHeaders` (which expanded to `object{additionalProperties: {type: string}}`). The new `WebApiVectorizerParameters.httpHeaders` is the equivalent inline schema. Not breaking per the stated rules.

### 4. Inline ↔ `$ref` Conversions (Same Content)

All of the following property type changes involve converting between inline schema and `$ref` with **equivalent unfolded schemas** — not breaking per the stated rules:

| Definition | Property | Change |
|------------|----------|--------|
| `IndexAction` | `@search.action` | Inline enum → `$ref: IndexActionType` (same values) |
| `IndexedSharePointKnowledgeSourceParameters` | `containerName` | Inline enum → `$ref: IndexedSharePointContainerName` (same values) |
| `EdgeNGramTokenFilter` | `side` | `$ref: EdgeNGramTokenFilterSide` → inline enum (same values: `front`, `back`) |
| `EdgeNGramTokenFilterV2` | `side` | `$ref: EdgeNGramTokenFilterSide` → inline enum (same values) |
| `DocumentIntelligenceLayoutSkill` | `outputMode` | `$ref` → inline enum (same values: `oneToMany`) |
| `DocumentIntelligenceLayoutSkill` | `markdownHeaderDepth` | `$ref` → inline enum (same values: `h1`–`h6`) |
| `DocumentIntelligenceLayoutSkill` | `outputFormat` | `$ref` → inline enum (same values: `text`, `markdown`) |
| `DocumentIntelligenceLayoutSkillChunkingProperties` | `unit` | `$ref: DocumentIntelligenceLayoutSkillChunkingUnit` → inline (same: `characters`) |
| `ContentUnderstandingSkillChunkingProperties` | `unit` | `$ref: ContentUnderstandingSkillChunkingUnit` → inline (same: `characters`) |
| `ChatCompletionResponseFormat` | `jsonSchemaProperties` | Inline object → `$ref: ChatCompletionSchemaProperties` (equivalent schema) |
| `DocumentDebugInfo` | `innerHits` | `$ref: InnerHitsDebugInfo` → equivalent inline `object{additionalProperties: array[QueryResultDocumentInnerHit]}` |
| `FacetResult` | `@search.facets` | `$ref: SearchFacetsResult` → equivalent inline `object{additionalProperties: array[FacetResult]}` |
| `VectorSearch` | `compressions` | `array[VectorSearchCompressionConfiguration]` → `array[VectorSearchCompression]` (equivalent rename) |
| `SearchResult` | `@search.captions` | `array[CaptionResult]` → `array[QueryCaptionResult]` (equivalent rename) |
| `SemanticConfiguration` | `prioritizedFields` | `PrioritizedFields` → `SemanticPrioritizedFields` (equivalent rename) |
| `StopwordsTokenFilter` | `stopwordsList` | `$ref: StopwordsList` (modelAsString: false) → inline enum (same values) |
| `VectorizableTextQuery` | `queryRewrites` | `QueryRewrites` → `QueryRewritesType` (equivalent rename) |

### 5. Number Format Clarifications (Not Breaking)

Three properties in `ChatCompletionCommonModelParameters` had `format: double` added. Since these were already typed as `number` and format is a constraint hint, this is a clarification only:

| Property | Old | New |
|----------|-----|-----|
| `temperature` | `type: number` | `type: number, format: double` |
| `presencePenalty` | `type: number` | `type: number, format: double` |
| `frequencyPenalty` | `type: number` | `type: number, format: double` |

### 6. `FacetResult.cardinality` Type Clarification (Not Breaking)

| | Old | New |
|-|-----|-----|
| Type | `number` | `integer` |
| Format | `int64` | `int64` |

Both have `format: int64`, which constrains the value to a 64-bit integer. The `type: number` with `format: int64` was imprecise; the new `type: integer, format: int64` is more accurate and equivalent in practice.

### 7. `AzureOpenAIVectorizer.azureOpenAIParameters` Type Rename (Not Breaking)

Changed from `AzureOpenAIParameters` to `AzureOpenAIVectorizerParameters`. Both have identical properties: `resourceUri`, `deploymentId`, `apiKey`, `authIdentity`, `modelName`.

### 8. `KnowledgeBaseAzureOpenAIModel.azureOpenAIParameters` Type Rename (Not Breaking)

Changed from `AzureOpenAIParameters` to `AzureOpenAIVectorizerParameters` — same rename as above, same content.

### 9. `AzureOpenAITokenizerParameters.encoderModelName` Type Rename (Not Breaking)

Changed from `EncoderModelName` to `SplitSkillEncoderModelName` — equivalent rename with same enum values.

### 10. `GET /indexes` — `$select` Parameter Removed (Non-Breaking)

The optional `$select` query parameter was removed from `GET /indexes`. Since it was optional (`required: false`), its removal is non-breaking. Note that `ListIndexesSelectedResult` was added as a new response type to support a new filtered-fields response variant.

### 11. New Definitions Added (Non-Breaking Additions)

The following new definitions were added (new features or extracted from inline schemas):

| New Definition | Description |
|----------------|-------------|
| `ErrorAdditionalInfo` | Standard Azure error response detail |
| `ErrorDetail` | Standard Azure error detail |
| `ErrorResponse` | Standard Azure error response |
| `IndexerResyncBody` | New request body for indexer resync operation |
| `DocumentKeysOrIds` | New type for document keys/IDs |
| `PermissionFilter` | New permission filter type |
| `SearchIndexPermissionFilterOption` | New option for permission filtering |
| `SearchIndexResponse` | New response type for index list with select |
| `ListIndexesSelectedResult` | New result type for listing indexes |
| `SearchIndexClientOptions` | New client options type |
| `KnowledgeBaseRetrievalPartialResponse` | New response type for partial knowledge retrieval |
| `KnowledgeBaseRetrievalSuccessResponse` | New response type for successful knowledge retrieval |
| `KnowledgeBaseActivityRecordType` | Extracted enum for activity record type |
| `KnowledgeBaseImageContent` | New image content type |
| `KnowledgeBaseReferenceType` | Extracted enum for reference type |
| `KnowledgeSourceContentExtractionMode` | New content extraction mode type |
| `KnowledgeSourceIngestionPermissionOption` | New permission option type |
| `KnowledgeSourceSynchronizationStatus` | New sync status type |
| `IndexedSharePointContainerName` | Extracted enum (was inline in old spec) |
| `IndexActionType` | Extracted enum (was inline in old spec) |
| `IndexerExecutionEnvironment` | Renamed from `ExecutionEnvironment` |
| `ChatCompletionSchemaProperties` | Extracted from inline in old spec |
| `ChatCompletionResponseFormatType` | Extracted enum |
| `IndexedSharePointContainerName` | Extracted enum |

### 12. `KnowledgeBaseActivityRecord.type` — Added Enum Constraint (Not Breaking)

| | Old | New |
|-|-----|-----|
| Type | `string` (no enum) | `$ref: KnowledgeBaseActivityRecordType` |
| Values | None documented | `searchIndex`, `azureBlob`, `indexedSharePoint`, `indexedOneLake`, `web`, `remoteSharePoint`, `model...` |

The old spec had this as an unconstrained `string` with no enum values documented. The new spec adds specific valid values. This is a documentation improvement for a property that already had fixed service-side values.

---

## Summary

| Category | Count |
|----------|-------|
| **Real Breaking Changes** | **2** (V1 skill types removed) |
| **Debatable/Cosmetic Breaking Changes** | **4** (Accept header required, `$select` type, body param names, enum bug fix) |
| **Non-Breaking Changes** | **Many** |

### Real Breaking Changes (2)
1. `SentimentSkill` (V1, `@odata.type: #Microsoft.Skills.Text.SentimentSkill`) removed from discriminator
2. `EntityRecognitionSkill` (V1, `@odata.type: #Microsoft.Skills.Text.EntityRecognitionSkill`) removed from discriminator

### Debatable/Cosmetic "Breaking" Changes (4)
These show up as breaking in automated diff tools but have minimal practical impact:
1. **`Accept` header added as required**: Makes implicit HTTP contract explicit; no actual behavior change
2. **`$select` type: `string` → `array[string]` (csv)**: Wire format unchanged; SDK code-generation difference
3. **Body parameter names**: Swagger parameter names changed but underlying JSON schema unchanged
4. **`ChatCompletionExtraParametersBehavior` enum value**: Fixes an inconsistency bug (`"pass-through"` → `"passThrough"`)

### Non-Breaking Changes
- File consolidation (3 files → 1 file)
- URL path consolidation (equivalent when host templates expanded)
- 37 definition renames (all with identical content)
- Many inline↔`$ref` conversions (all with equivalent schemas)
- Type format clarifications (`number` → `number(double)`, `number(int64)` → `integer(int64)`)
- New definitions and features added
