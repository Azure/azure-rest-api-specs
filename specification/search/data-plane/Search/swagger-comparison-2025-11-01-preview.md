# Azure Search 2025-11-01-preview: Breaking vs Non-Breaking Changes for TypeSpec Migration

**Scope**: `specification/search/data-plane/Search`

[PR #38841](https://github.com/Azure/azure-rest-api-specs/pull/38841) migrated the Azure Search data-plane specification from three separate hand-authored swagger files (`searchservice.json`, `searchindex.json`, `knowledgebase.json`) to a single TypeSpec-compiled `search.json`. Both describe the same `2025-11-01-preview` API.

> **Refreshed**: Updated against the latest TSP-compiled `search.json` in `main`. The `Accept` header was initially flagged as a breaking change but has since been fixed (see [All Operations §15](#15-accept-header--made-optional-fixed-non-breaking)).

**Comparison rule**: Inline schema ↔ `$ref` conversions with equivalent unfolded schemas are **not** breaking changes.

---

## Breaking Changes

### Skillset Operations

#### 1. Legacy V1 Skill Types Removed from Discriminator Union

`SentimentSkill` (`#Microsoft.Skills.Text.SentimentSkill`) and `EntityRecognitionSkill` (`#Microsoft.Skills.Text.EntityRecognitionSkill`) were removed from the `SearchIndexerSkill` polymorphic discriminator union. The V3 variants remain unchanged:
- `SentimentSkillV3` → `#Microsoft.Skills.Text.V3.SentimentSkill`
- `EntityRecognitionSkillV3` → `#Microsoft.Skills.Text.V3.EntityRecognitionSkill`

Any skillset using a V1 `@odata.type` will no longer match the swagger discriminator. The V1 skills were deprecated in a prior API version; callers should migrate to V3.

---

### Service List Operations

#### 2. `$select` Query Parameter Type Changed (`string` → `array`)

For list operations on `/datasources`, `/indexers`, `/skillsets`, and `/synonymmaps`, `$select` changed from `type: string` to `type: array` (items: `string`, `collectionFormat: csv`). The wire format is identical — `?$select=name,type` serializes the same way in both cases. This is a **code-generation breaking change** for SDK consumers (typed parameter changes from `string` to `string[]`), not for direct HTTP callers.

---

### Datasource & Knowledge Base Operations

#### 3. Body Parameter Names Changed (Swagger Metadata Only)

The swagger `name` field for request-body parameters changed in five operations. The underlying JSON schema (`$ref` target) is identical in each case; only the parameter label differs:
- `POST /datasources`: `dataSource` → `dataSourceConnection` (schema: `SearchIndexerDataSource`)
- `POST /knowledgebases`: `KnowledgeBase` → `knowledgeBase`
- `PUT /knowledgebases('{knowledgeBaseName}')`: `KnowledgeBase` → `knowledgeBase`
- `POST /knowledgesources`: `KnowledgeSource` → `knowledgeSource`
- `PUT /knowledgesources('{sourceName}')`: `KnowledgeSource` → `knowledgeSource`

This may affect generated SDK method parameter names but has no HTTP wire impact.

---

### ChatCompletion Operations

#### 4. `ChatCompletionExtraParametersBehavior` Enum Value Bug Fix

The old spec was internally inconsistent: the `enum` array listed `"pass-through"` (with hyphen) while `x-ms-enum.values` listed `"passThrough"` (camelCase). The new spec uses `"passThrough"` throughout. Clients using the incorrect `"pass-through"` value would already have been rejected by the service, so this corrects the swagger to match actual API behavior.

---

## Non-Breaking Changes

### Schema & Infrastructure

#### 1. Schema File Consolidation

Three hand-authored files merged into one TSP-compiled file:
- `searchservice.json` (531 KB, service operations) → merged into `search.json` (764 KB)
- `searchindex.json` (137 KB, document operations) → merged
- `knowledgebase.json` (35 KB, knowledge operations) → merged

#### 2. URL Path Consolidation (Equivalent Routing)

Document and knowledge-retrieval operations moved from parameterized host templates to explicit path prefixes. Resolved URLs are identical:
- Document ops: host `{endpoint}/indexes('{indexName}')` + path `/docs/...` → host `{endpoint}` + path `/indexes('{indexName}')/docs/...`
- Knowledge retrieval: host `{endpoint}/knowledgebases('{knowledgeBaseName}')` + path `/retrieve` → host `{endpoint}` + path `/knowledgebases('{knowledgeBaseName}')/retrieve`

---

### Model & Definition Changes

#### 3. Definition Renames (37 Equivalent Renames)

All 37 renames below have **identical content** verified by schema unfolding:
- `AmlSkill` → `AzureMachineLearningSkill`
- `AzureOpenAIParameters` → `AzureOpenAIVectorizerParameters`
- `BM25Similarity` → `BM25SimilarityAlgorithm`
- `BinaryQuantizationVectorSearchCompressionConfiguration` → `BinaryQuantizationCompression`
- `CaptionResult` → `QueryCaptionResult`
- `Captions` → `QueryCaptionType`
- `ClassicSimilarity` → `ClassicSimilarityAlgorithm`
- `DataToExtract` → `BlobIndexerDataToExtract`
- `EncoderModelName` → `SplitSkillEncoderModelName`
- `ExecutionEnvironment` → `IndexerExecutionEnvironment`
- `ExhaustiveKnnVectorSearchAlgorithmConfiguration` → `ExhaustiveKnnAlgorithmConfiguration`
- `HnswVectorSearchAlgorithmConfiguration` → `HnswAlgorithmConfiguration`
- `ImageAction` → `BlobIndexerImageAction`
- `OcrSkillLineEnding` → `OcrLineEnding`
- `ParsingMode` → `BlobIndexerParsingMode`
- `PdfTextRotationAlgorithm` → `BlobIndexerPDFTextRotationAlgorithm`
- `PrioritizedFields` → `SemanticPrioritizedFields`
- `QueryResultDocumentSemanticFieldState` → `SemanticFieldState`
- `QueryRewrites` → `QueryRewritesType`
- `RawVectorQuery` → `VectorizedQuery`
- `ScalarQuantizationVectorSearchCompressionConfiguration` → `ScalarQuantizationCompression`
- `SearchIndexerIndexProjections` → `SearchIndexerIndexProjection`
- `SemanticErrorHandling` → `SemanticErrorMode`
- `SemanticPartialResponseReason` → `SemanticErrorReason`
- `SemanticPartialResponseType` → `SemanticSearchResultsType`
- `SemanticSettings` → `SemanticSearch`
- `ServiceCounters` → `SearchServiceCounters`
- `ServiceLimits` → `SearchServiceLimits`
- `ServiceStatistics` → `SearchServiceStatistics`
- `Similarity` → `SimilarityAlgorithm`
- `Speller` → `QuerySpellerType`
- `Suggester` → `SearchSuggester`
- `VectorSearchCompressionConfiguration` → `VectorSearchCompression`
- `VectorSearchCompressionTargetDataType` → `VectorSearchCompressionTarget`
- `AnswerResult` → `QueryAnswerResult`
- `Answers` → `QueryAnswerType`
- `WebApiParameters` → `WebApiVectorizerParameters`

> Note: `WebApiParameters.httpHeaders` was `$ref: WebApiHttpHeaders` (expanding to `object{additionalProperties: {type: string}}`); the new `WebApiVectorizerParameters.httpHeaders` is the equivalent inline schema. Not breaking per the stated rules.

#### 4. Inline ↔ `$ref` Conversions (Same Content)

The following property type changes convert between inline schema and `$ref` with equivalent unfolded schemas:
- `IndexAction.@search.action`: inline enum → `$ref: IndexActionType` (same values)
- `IndexedSharePointKnowledgeSourceParameters.containerName`: inline enum → `$ref: IndexedSharePointContainerName` (same values)
- `EdgeNGramTokenFilter.side` and `EdgeNGramTokenFilterV2.side`: `$ref: EdgeNGramTokenFilterSide` → inline enum (`front`, `back`)
- `DocumentIntelligenceLayoutSkill.outputMode`: `$ref` → inline enum (`oneToMany`)
- `DocumentIntelligenceLayoutSkill.markdownHeaderDepth`: `$ref` → inline enum (`h1`–`h6`)
- `DocumentIntelligenceLayoutSkill.outputFormat`: `$ref` → inline enum (`text`, `markdown`)
- `DocumentIntelligenceLayoutSkillChunkingProperties.unit`: `$ref: DocumentIntelligenceLayoutSkillChunkingUnit` → inline (`characters`)
- `ContentUnderstandingSkillChunkingProperties.unit`: `$ref: ContentUnderstandingSkillChunkingUnit` → inline (`characters`)
- `ChatCompletionResponseFormat.jsonSchemaProperties`: inline object → `$ref: ChatCompletionSchemaProperties` (equivalent schema)
- `DocumentDebugInfo.innerHits`: `$ref: InnerHitsDebugInfo` → equivalent inline `object{additionalProperties: array[QueryResultDocumentInnerHit]}`
- `FacetResult.@search.facets`: `$ref: SearchFacetsResult` → equivalent inline `object{additionalProperties: array[FacetResult]}`
- `VectorSearch.compressions`: `array[VectorSearchCompressionConfiguration]` → `array[VectorSearchCompression]` (equivalent rename)
- `SearchResult.@search.captions`: `array[CaptionResult]` → `array[QueryCaptionResult]` (equivalent rename)
- `SemanticConfiguration.prioritizedFields`: `PrioritizedFields` → `SemanticPrioritizedFields` (equivalent rename)
- `StopwordsTokenFilter.stopwordsList`: `$ref: StopwordsList` (modelAsString: false) → inline enum (same values)
- `VectorizableTextQuery.queryRewrites`: `QueryRewrites` → `QueryRewritesType` (equivalent rename)

#### 5. Number Format Clarifications

Three properties in `ChatCompletionCommonModelParameters` — `temperature`, `presencePenalty`, `frequencyPenalty` — had `format: double` added. All were already `type: number`; the format annotation is a clarification hint, not a type change.

#### 6. `FacetResult.cardinality` Type Clarification

Changed from `type: number, format: int64` to `type: integer, format: int64`. Both have `format: int64`; the new `type: integer` is more precise and equivalent in practice.

#### 7. `AzureOpenAIVectorizer` and `KnowledgeBaseAzureOpenAIModel` — `azureOpenAIParameters` Type Rename

Both models changed their `azureOpenAIParameters` property type from `AzureOpenAIParameters` to `AzureOpenAIVectorizerParameters`. The schemas are identical (`resourceUri`, `deploymentId`, `apiKey`, `authIdentity`, `modelName`).

#### 8. `AzureOpenAITokenizerParameters.encoderModelName` Type Rename

Changed from `EncoderModelName` to `SplitSkillEncoderModelName` — equivalent rename with the same enum values.

---

### Index Operations

#### 9. `GET /indexes` — Optional `$select` Parameter Removed

The optional `$select` query parameter (`required: false`) was removed from `GET /indexes`. Removing an optional parameter is non-breaking. A new `ListIndexesSelectedResult` response type was added to support filtered-field responses.

#### 10. New Index Statistics Operations

Two new operations were added to the updated `search.json`:
- `Indexes_GetStatistics` — `GET /indexes('{indexName}')/search.stats` — retrieves statistics for a specific index
- `GetIndexStatsSummary` — `GET /indexstats` — retrieves a statistics summary for all indexes in the service

---

### Knowledge Base & Indexer Operations

#### 11. New Definitions (Non-Breaking Additions)

New definitions added for new features or schema extractions:
- Standard Azure error types: `ErrorAdditionalInfo`, `ErrorDetail`, `ErrorResponse`
- Indexer operations: `IndexerResyncBody`, `DocumentKeysOrIds` (used in `resetdocs`)
- Permission filtering: `PermissionFilter` (enum: `userIds`, `groupIds`, `rbacScope`), `SearchIndexPermissionFilterOption` (enum: `enabled`/`disabled`)
- Index listing: `SearchIndexResponse`, `ListIndexesSelectedResult`, `SearchIndexClientOptions`
- Knowledge base: `KnowledgeBaseRetrievalPartialResponse`, `KnowledgeBaseRetrievalSuccessResponse`, `KnowledgeBaseActivityRecordType`, `KnowledgeBaseImageContent`, `KnowledgeBaseReferenceType`
- Knowledge source: `KnowledgeSourceContentExtractionMode`, `KnowledgeSourceIngestionPermissionOption`, `KnowledgeSourceSynchronizationStatus`
- Extracted enums (were inline): `IndexedSharePointContainerName`, `IndexActionType`, `ChatCompletionSchemaProperties`, `ChatCompletionResponseFormatType`

#### 12. `KnowledgeBaseActivityRecord.type` — Enum Constraint Added

Previously an unconstrained `string`; now `$ref: KnowledgeBaseActivityRecordType` with documented values: `searchIndex`, `azureBlob`, `indexedSharePoint`, `indexedOneLake`, `web`, `remoteSharePoint`, and others. This documents values that were already fixed service-side.

---

### Skillset Operations (New Features)

#### 13. New Definitions in Refreshed TSP-Compiled Swagger

New features captured in the refreshed TypeSpec:
- `ContentUnderstandingSkill` — new skill type (`#Microsoft.Skills.Util.ContentUnderstandingSkill`) with `extractionOptions` and `chunkingProperties`
- `ContentUnderstandingSkillChunkingProperties` — chunking configuration for the above skill
- `ContentUnderstandingSkillExtractionOptions` — enum: `images`, `locationMetadata`
- `ContentUnderstandingSkillChunkingUnit` — enum: `characters`
- `AIServices` — new object for AI Services connection parameters (`uri` required, `apiKey` optional)
- `SkillNames` — request body for `POST /skillsets/{skillsetName}/search.resetskills`
- `IndexerRuntime` — cumulative runtime snapshot (`usedSeconds`, `remainingSeconds`, `beginningTime`, `endingTime`)
- `ServiceIndexersRuntime` — service-level indexer runtime counters (same shape as `IndexerRuntime`)

New fields on existing models (non-breaking additions):
- `SearchIndexerStatus.runtime` (`$ref: IndexerRuntime`) — cumulative runtime snapshot for the indexer
- `SearchServiceStatistics.indexersRuntime` (`$ref: ServiceIndexersRuntime`) — service-level indexer runtime counters
- `SearchServiceLimits.maxCumulativeIndexerRuntimeSeconds` (`integer, int64, nullable`) — maximum cumulative indexer runtime allowed

---

### All Operations

#### 14. `Accept` Header — Made Optional (Fixed, Non-Breaking)

The TSP-compiled spec initially added `Accept: application/json;odata.metadata=minimal` as a **required** header on every operation. This was subsequently fixed:
- [PR #41045](https://github.com/Azure/azure-rest-api-specs/pull/41045) (merged) — made `acceptHeaderNone` optional
- [PR #41062](https://github.com/Azure/azure-rest-api-specs/pull/41062) — made `acceptHeaderMinimal` optional, covering all remaining operations

The new spec now declares `Accept` as `"required": false`. Since the old spec had no explicit `Accept` parameter, an optional header is not a breaking change.

---

## Summary

**Breaking changes (4):**
- **Skillset operations**: V1 `SentimentSkill` and `EntityRecognitionSkill` removed from discriminator union — callers must migrate to V3 variants.
- **Service list operations**: `$select` type changed `string` → `array[string]` (csv) — wire format unchanged; SDK-generated client types change.
- **Datasource & knowledge base operations**: Body parameter names changed in 5 operations — swagger metadata only; JSON schemas unchanged.
- **ChatCompletion operations**: `ChatCompletionExtraParametersBehavior` enum corrected from `"pass-through"` to `"passThrough"` — fixes swagger to match actual API behavior.

**Non-breaking changes:** file consolidation (3 → 1 file), equivalent URL path restructuring, 37 definition renames with identical content, inline ↔ `$ref` conversions with equivalent schemas, number format clarifications, new definitions and operations, `Accept` header made optional.
