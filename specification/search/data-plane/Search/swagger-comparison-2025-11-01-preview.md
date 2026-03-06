# Azure Search 2025-11-01-preview: Breaking vs Non-Breaking Changes for TypeSpec Migration

**Scope**: `specification/search/data-plane/Search`

This document compares:
1. **Old (hand-authored)**: `searchservice.json` + `searchindex.json` + `knowledgebase.json` — the hand-authored swagger **before** [PR #38841](https://github.com/Azure/azure-rest-api-specs/pull/38841) was merged
2. **New (TSP-compiled)**: `search.json` — the TypeSpec-compiled swagger in the current `main` branch

> **Refreshed**: This comparison was updated against the latest TSP-compiled `search.json` in the `main` branch.

---

## Overview

[PR #38841](https://github.com/Azure/azure-rest-api-specs/pull/38841) migrated the Azure Search data-plane specification from three separate hand-authored swagger files to a single TypeSpec-compiled `search.json`. Both describe the same `2025-11-01-preview` API.

**Comparison rule**: If a `$ref` to a model is converted to an inline schema (or vice versa), and if their unfolded object schemas are the same, that is **not** a breaking change.

---

## Breaking Changes

Breaking changes are classified by impact level:

| Impact | Definition |
|--------|-----------|
| **High** | Affects API wire behavior or removes documented contract features; requires caller changes |
| **Medium** | Affects SDK-generated client code only; no change to the HTTP wire format |
| **Low** | Cosmetic or documentation-level; no practical behavioral change, or fixes a pre-existing bug |

---

### High Impact

#### 1. Legacy V1 Skill Types Removed from Discriminator Union

The V1 variants of `SentimentSkill` and `EntityRecognitionSkill` were removed from the `SearchIndexerSkill` polymorphic discriminator union.

| Type | Old `x-ms-discriminator-value` | Status in new spec |
|------|--------------------------------|--------------------|
| `SentimentSkill` | `#Microsoft.Skills.Text.SentimentSkill` | **Removed** |
| `EntityRecognitionSkill` | `#Microsoft.Skills.Text.EntityRecognitionSkill` | **Removed** |

The V3 variants remain:
- `SentimentSkillV3` (`#Microsoft.Skills.Text.V3.SentimentSkill`) — unchanged
- `EntityRecognitionSkillV3` (`#Microsoft.Skills.Text.V3.EntityRecognitionSkill`) — unchanged

**Impact**: Any skillset whose `@odata.type` is `#Microsoft.Skills.Text.SentimentSkill` or `#Microsoft.Skills.Text.EntityRecognitionSkill` will no longer match the swagger discriminator. V3 equivalents remain fully supported. The V1 skills were deprecated in a prior API version; callers still using V1 values should migrate to V3.

---

### Medium Impact

#### 2. `$select` Query Parameter Type Changed (`string` → `array`)

For list operations on `/datasources`, `/indexers`, `/skillsets`, and `/synonymmaps`, the `$select` query parameter type changed:

| | Old | New |
|-|-----|-----|
| Type | `string` | `array` (items: `string`, `collectionFormat: csv`) |
| Wire format | Comma-separated string | Comma-separated string (same) |

**Example**: `?$select=name,type` serializes identically on the wire in both cases.

**Impact**: No change to the HTTP wire format. SDK clients generated from the old spec may have typed this parameter as a plain `string`; clients generated from the new spec will use `string[]`. This is a **code-generation breaking change** for SDK consumers, not for direct HTTP callers.

---

#### 3. Body Parameter Names Changed (Swagger Metadata Only)

The names of request-body parameters changed in several operations. The underlying JSON schema (`$ref` target) is **identical** — only the swagger parameter `name` field differs.

| Operation | Old body param name | New body param name | Schema |
|-----------|---------------------|---------------------|--------|
| `POST /datasources` | `dataSource` | `dataSourceConnection` | `SearchIndexerDataSource` (same) |
| `POST /knowledgebases` | `KnowledgeBase` | `knowledgeBase` | `KnowledgeBase` (same) |
| `PUT /knowledgebases('{knowledgeBaseName}')` | `KnowledgeBase` | `knowledgeBase` | `KnowledgeBase` (same) |
| `POST /knowledgesources` | `KnowledgeSource` | `knowledgeSource` | `KnowledgeSource` (same) |
| `PUT /knowledgesources('{sourceName}')` | `KnowledgeSource` | `knowledgeSource` | `KnowledgeSource` (same) |

**Impact**: The HTTP body format (JSON schema) is unchanged. This is a **swagger metadata change** that may affect generated SDK method parameter names.

---

### Low Impact

#### 4. `Accept` Header Added as Required Parameter

The TSP-compiled spec adds `Accept: application/json;odata.metadata=minimal` as a **required header parameter** to every operation.

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

**Impact**: Makes the implicit HTTP contract explicit. The service was already returning `application/json;odata.metadata=minimal` and will continue to respond to requests that omit the header. This is a **documentation-level change** with no API behavior impact.

---

#### 5. `ChatCompletionExtraParametersBehavior` Enum Value Bug Fix

This change fixes a pre-existing inconsistency in the old hand-authored spec:

| | Old `enum` value | Old `x-ms-enum.values[0].value` | New `enum` value |
|-|-----------------|--------------------------------|-----------------|
| Pass-through | `"pass-through"` ❌ | `"passThrough"` ✅ | `"passThrough"` ✅ |

The old spec was internally inconsistent: the `enum` array listed `"pass-through"` (with hyphen) but `x-ms-enum.values` listed `"passThrough"` (camelCase). The new spec uses `"passThrough"` consistently.

**Impact**: The API wire value was already `"passThrough"` (per the authoritative `x-ms-enum.values`). Clients using the incorrect value `"pass-through"` would have been rejected by the service already. This change fixes the swagger to match actual API behavior.

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

### 3. Definition Renames (37 Equivalent Renames)

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

All of the following property type changes convert between inline schema and `$ref` with **equivalent unfolded schemas** — not breaking per the comparison rules:

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

Both have `format: int64`. The old `type: number` with `format: int64` was imprecise; the new `type: integer, format: int64` is more accurate and equivalent in practice.

### 7. `AzureOpenAIVectorizer.azureOpenAIParameters` Type Rename (Not Breaking)

Changed from `AzureOpenAIParameters` to `AzureOpenAIVectorizerParameters`. Both have identical properties: `resourceUri`, `deploymentId`, `apiKey`, `authIdentity`, `modelName`.

### 8. `KnowledgeBaseAzureOpenAIModel.azureOpenAIParameters` Type Rename (Not Breaking)

Changed from `AzureOpenAIParameters` to `AzureOpenAIVectorizerParameters` — same rename as above, same content.

### 9. `AzureOpenAITokenizerParameters.encoderModelName` Type Rename (Not Breaking)

Changed from `EncoderModelName` to `SplitSkillEncoderModelName` — equivalent rename with same enum values.

### 10. `GET /indexes` — `$select` Parameter Removed (Non-Breaking)

The optional `$select` query parameter was removed from `GET /indexes`. Since it was optional (`required: false`), its removal is non-breaking. `ListIndexesSelectedResult` was added as a new response type to support a filtered-fields response variant.

### 11. New Definitions Added (Non-Breaking Additions)

The following new definitions were added (new features or schema extractions):

| New Definition | Description |
|----------------|-------------|
| `ErrorAdditionalInfo` | Standard Azure error response detail |
| `ErrorDetail` | Standard Azure error detail |
| `ErrorResponse` | Standard Azure error response |
| `IndexerResyncBody` | Request body for the indexer resync operation |
| `DocumentKeysOrIds` | Type for document keys / IDs used in `resetdocs` |
| `PermissionFilter` | Enum: field-level permission filter kind (`userIds`, `groupIds`, `rbacScope`) |
| `SearchIndexPermissionFilterOption` | Enum: whether permission filtering is `enabled` / `disabled` for an index |
| `SearchIndexResponse` | Response type for index list with field selection |
| `ListIndexesSelectedResult` | Result type for listing indexes with `$select` |
| `SearchIndexClientOptions` | Client options type |
| `KnowledgeBaseRetrievalPartialResponse` | Response type for partial knowledge-base retrieval |
| `KnowledgeBaseRetrievalSuccessResponse` | Response type for successful knowledge-base retrieval |
| `KnowledgeBaseActivityRecordType` | Extracted enum for activity record type |
| `KnowledgeBaseImageContent` | Image content type for knowledge-base messages |
| `KnowledgeBaseReferenceType` | Extracted enum for reference type |
| `KnowledgeSourceContentExtractionMode` | Content extraction mode for knowledge sources |
| `KnowledgeSourceIngestionPermissionOption` | Permission option for knowledge source ingestion |
| `KnowledgeSourceSynchronizationStatus` | Sync status type for knowledge sources |
| `IndexedSharePointContainerName` | Extracted enum (was inline in old spec) |
| `IndexActionType` | Extracted enum (was inline in old spec) |
| `ChatCompletionSchemaProperties` | Extracted from inline in old spec |
| `ChatCompletionResponseFormatType` | Extracted enum for response format type |

### 12. `KnowledgeBaseActivityRecord.type` — Added Enum Constraint (Not Breaking)

| | Old | New |
|-|-----|-----|
| Type | `string` (no enum) | `$ref: KnowledgeBaseActivityRecordType` |
| Values | None documented | `searchIndex`, `azureBlob`, `indexedSharePoint`, `indexedOneLake`, `web`, `remoteSharePoint`, `model...` |

The old spec had this as an unconstrained `string`. The new spec adds the specific valid values. This is a documentation improvement for a property that already had fixed service-side values.

### 13. New Definitions Added in Refreshed TSP-Compiled Swagger

The following definitions were added in the updated TSP-compiled `search.json` and were not present in the initial migration comparison. They represent new features now fully captured in the TypeSpec:

| New Definition | Description |
|----------------|-------------|
| `ContentUnderstandingSkill` | New skill type (`#Microsoft.Skills.Util.ContentUnderstandingSkill`) with `extractionOptions` and `chunkingProperties` |
| `ContentUnderstandingSkillChunkingProperties` | Chunking configuration for the `ContentUnderstandingSkill` |
| `ContentUnderstandingSkillExtractionOptions` | Enum: what to extract — `images`, `locationMetadata` |
| `ContentUnderstandingSkillChunkingUnit` | Enum: chunk unit (`characters`) |
| `AIServices` | New object type for AI Services connection parameters (`uri` required, `apiKey` optional) |
| `SkillNames` | Request body for `POST /skillsets/{skillsetName}/search.resetskills` (list of skill names to reset) |
| `IndexerRuntime` | Indexer cumulative runtime snapshot: `usedSeconds`, `remainingSeconds`, `beginningTime`, `endingTime` |
| `ServiceIndexersRuntime` | Service-level indexer runtime counters with the same shape as `IndexerRuntime` |

**Associated property additions** (non-breaking — new fields on existing models):

| Model | New Property | Type | Description |
|-------|-------------|------|-------------|
| `SearchIndexerStatus` | `runtime` | `$ref: IndexerRuntime` | Cumulative runtime snapshot for the indexer |
| `SearchServiceStatistics` | `indexersRuntime` | `$ref: ServiceIndexersRuntime` | Service-level indexer runtime counters |
| `SearchServiceLimits` | `maxCumulativeIndexerRuntimeSeconds` | `integer (int64, nullable)` | Maximum cumulative indexer runtime allowed |

### 14. New Operations Added in Refreshed TSP-Compiled Swagger

The following operations were added in the updated `search.json`:

| Operation | HTTP | Description |
|-----------|------|-------------|
| `Indexes_GetStatistics` | `GET /indexes('{indexName}')/search.stats` | Retrieves statistics for a specific index |
| `GetIndexStatsSummary` | `GET /indexstats` | Retrieves a summary of statistics for all indexes in the service |

---

## Summary

| Category | Count | Notes |
|----------|-------|-------|
| **High Impact Breaking Changes** | **1** | V1 skill types removed from discriminator |
| **Medium Impact Breaking Changes** | **2** | `$select` type change; body param name changes |
| **Low Impact Breaking Changes** | **2** | `Accept` header added; `ChatCompletion` enum bug fix |
| **Non-Breaking Changes** | **Many** | See sections 1–14 above |

### High Impact Breaking Changes (1)
1. **V1 skill types removed from discriminator union** — both `SentimentSkill` (`@odata.type: #Microsoft.Skills.Text.SentimentSkill`) and `EntityRecognitionSkill` (`@odata.type: #Microsoft.Skills.Text.EntityRecognitionSkill`) were removed in the same change (V1 skill deprecation).

### Medium Impact Breaking Changes (2)
1. **`$select` type: `string` → `array[string]` (csv)** — Wire format unchanged; generated SDK client types change
2. **Body parameter names** — Swagger metadata only; underlying JSON schema unchanged

### Low Impact Breaking Changes (2)
1. **`Accept` header added as required** — Makes implicit HTTP contract explicit; no actual behavior change
2. **`ChatCompletionExtraParametersBehavior` enum value** — Fixes inconsistency (`"pass-through"` → `"passThrough"`); corrects swagger to match API reality

### Non-Breaking Changes
- File consolidation: 3 hand-authored files → 1 TSP-compiled file
- URL path consolidation (equivalent when host templates are expanded)
- 37 definition renames (all with identical content)
- Inline ↔ `$ref` conversions (all with equivalent schemas)
- Type format clarifications (`number` → `number(double)`, `number(int64)` → `integer(int64)`)
- New definitions, operations, and features added (see sections 11–14)
