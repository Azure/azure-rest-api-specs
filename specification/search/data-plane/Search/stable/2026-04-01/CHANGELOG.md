## Table of Contents

- [2025-09-01 vs 2026-04-01](#2025-09-01-vs-2026-04-01)
  - [Spec file consolidation](#spec-file-consolidation)
  - [Non-breaking changes](#non-breaking-changes)
  - [TypeSpec migration artifacts](#typespec-migration-artifacts)
- [2025-11-01-preview vs 2026-04-01](#2025-11-01-preview-vs-2026-04-01)
  - [Breaking changes](#breaking-changes-1)
  - [Non-breaking changes](#non-breaking-changes-1)

---

# 2025-09-01 vs 2026-04-01

> The 2025-09-01 release consisted of two separate Swagger files (`searchservice.json` and
> `searchindex.json`). The 2026-04-01 release merges them into a single `search.json`.

## Spec file consolidation

| Previous (2025-09-01) | Current (2026-04-01) |
|---|---|
| `searchservice.json` + `searchindex.json` (two files, two clients) | `search.json` (single unified file, single client) |

---

## Changes

### Non-Breaking Changes

#### New operations

Full CRUD support is added for three new resource types (Aliases, KnowledgeBases, KnowledgeSources). `Indexes_GetStatistics` is also new (on the existing Indexes resource).

| Operation | Method + Path |
|---|---|
| `Aliases_Create` | `POST /aliases` |
| `Aliases_CreateOrUpdate` | `PUT /aliases('{aliasName}')` |
| `Aliases_Delete` | `DELETE /aliases('{aliasName}')` |
| `Aliases_Get` | `GET /aliases('{aliasName}')` |
| `Aliases_List` | `GET /aliases` |
| `KnowledgeBases_Create` | `POST /knowledgebases` |
| `KnowledgeBases_CreateOrUpdate` | `PUT /knowledgebases('{knowledgeBaseName}')` |
| `KnowledgeBases_Delete` | `DELETE /knowledgebases('{knowledgeBaseName}')` |
| `KnowledgeBases_Get` | `GET /knowledgebases('{knowledgeBaseName}')` |
| `KnowledgeBases_List` | `GET /knowledgebases` |
| `KnowledgeRetrieval_Retrieve` | `POST /knowledgebases('{knowledgeBaseName}')/retrieve` |
| `KnowledgeSources_Create` | `POST /knowledgesources` |
| `KnowledgeSources_CreateOrUpdate` | `PUT /knowledgesources('{sourceName}')` |
| `KnowledgeSources_Delete` | `DELETE /knowledgesources('{sourceName}')` |
| `KnowledgeSources_Get` | `GET /knowledgesources('{sourceName}')` |
| `KnowledgeSources_GetStatus` | `GET /knowledgesources('{sourceName}')/status` |
| `KnowledgeSources_List` | `GET /knowledgesources` |
| `Indexes_GetStatistics` | `GET /indexes('{indexName}')/search.stats` |

Aliases enable an index to be accessed via multiple logical names. KnowledgeBases and KnowledgeSources support AI-powered knowledge retrieval backed by search-index, Azure Blob, Azure One Lake, and web data sources.

#### New skills and vectorizers

| Type | `@odata.type` / name | Description |
|---|---|---|
| Skill | `AzureMachineLearningSkill` (`#Microsoft.Skills.Custom.AmlSkill`) | Calls a custom Azure ML endpoint |
| Skill | `ChatCompletionSkill` (`#Microsoft.Skills.Custom.ChatCompletionSkill`) | Calls a chat-completion model |
| Skill | `ContentUnderstandingSkill` (`#Microsoft.Skills.Util.ContentUnderstandingSkill`) | Azure AI Content Understanding enrichment |
| Skill | `VisionVectorizeSkill` (`#Microsoft.Skills.Vision.VectorizeSkill`) | Image vectorization via AI Vision |
| Vectorizer | `AIServicesVisionVectorizer` | Vectorizes text/image using Azure AI Vision |

#### New optional fields on existing models

| Model | New optional property | Notes |
|---|---|---|
| `AzureOpenAIEmbeddingSkill` | `resourceUri`, `deploymentId`, `apiKey`, `authIdentity`, `modelName` | Previously inherited from shared `AzureOpenAIParameters` mixin; now explicit properties |
| `DocumentDebugInfo` | `innerHits` | Debug info for inner hit scoring |
| `FacetResult` | `avg`, `cardinality`, `max`, `min`, `sum`, `@search.facets` | Aggregation statistics on facet buckets |
| `IndexerExecutionResult` | `mode`, `statusDetail` | Fine-grained execution mode and detail code |
| `IndexingParametersConfiguration` | `markdownHeaderDepth`, `markdownParsingSubmode` | Markdown parsing options |
| `SearchDocumentsResult` | `@search.debug` | Debug information in search responses |
| `SearchField` | `permissionFilter`, `sensitivityLabel` | Per-field ACL and data sensitivity metadata |
| `SearchIndexerDataSource` | `identity` | Managed identity for data source authentication |
| `SearchIndexerKnowledgeStore` | `identity` | Managed identity for knowledge store |
| `SearchIndexerStatus` | `currentState` | Live indexer state detail |
| `SearchResourceEncryptionKey` | `identity` | User-assigned managed identity for CMK |
| `SplitSkill` | `unit`, `azureOpenAITokenizerParameters` | Token-aware splitting |
| `VectorQuery` | `filterOverride`, `perDocumentVectorLimit`, `threshold` | Fine-grained vector query controls |

#### Other additions

- **`SearchResourceEncryptionKey.keyVaultKeyVersion` made optional** — supports auto-rotation of key vault keys.
- **`BlobIndexerParsingMode` — new `markdown` value** — enables direct Markdown ingestion without a separate skill.
- **Security definitions added** — `ApiKeyAuth` (API key in `api-key` header) and `OAuth2Auth` (OAuth2 implicit flow against `https://search.azure.com/.default`) are formally declared in `securityDefinitions`; documents existing authentication without changing client behaviour.
- **`SearchIndexerDataUserAssignedIdentity.federatedIdentityClientId` added** — new optional property for workload identity federation.
- **`Indexes_ListWithSelectedProperties` operation** — `GET /indexes` via `x-ms-paths` overload returns a lightweight index summary (name, ETag, selected statistics fields only).

---

## TypeSpec migration artifacts

The REST wire format is **identical** between 2025-09-01 and 2026-04-01 for all items in this
section. The apparent breaks exist only in the generated SDK because TypeSpec applies stricter
naming and typing conventions than the previous hand-authored Swagger. Clients that speak the raw
JSON/HTTP API directly are **not** affected; clients using a generated SDK will see compile-time
name or type changes, but **no service re-deployment or data migration is needed**.

### 1. `SearchIndexerLimits` numeric type narrowed to integer

`maxDocumentExtractionSize` and `maxDocumentContentCharactersToExtract` both change their JSON
schema type from `number` (double) to `integer` (int64). The live service always returned integer
values for these fields; the Swagger incorrectly typed them as `number` (double). TypeSpec enforces
explicit integer types, correcting the spec to match actual service behavior. The JSON wire values
are compatible for any in-range integer. Only generated SDK clients typed against `double`/`number`
need a code update.

### 2. Definition renames (SDK-level breaking)

Thirty-two model types have been renamed for clarity and consistency. The REST wire format (JSON
property names and enum string values) is **identical** — the change only affects the generated
client type names. Clients consuming the raw JSON API are not affected; clients using a generated
SDK will see compile-time name changes.

| Old name (2025-09-01) | New name (2026-04-01) |
|---|---|
| `AzureOpenAIParameters` | `AzureOpenAIVectorizerParameters` |
| `BM25Similarity` | `BM25SimilarityAlgorithm` |
| `BinaryQuantizationVectorSearchCompressionConfiguration` | `BinaryQuantizationCompression` |
| `ClassicSimilarity` | `ClassicSimilarityAlgorithm` |
| `DataToExtract` | `BlobIndexerDataToExtract` |
| `ExecutionEnvironment` | `IndexerExecutionEnvironment` |
| `ExhaustiveKnnVectorSearchAlgorithmConfiguration` | `ExhaustiveKnnAlgorithmConfiguration` |
| `HnswVectorSearchAlgorithmConfiguration` | `HnswAlgorithmConfiguration` |
| `ImageAction` | `BlobIndexerImageAction` |
| `OcrSkillLineEnding` | `OcrLineEnding` |
| `ParsingMode` | `BlobIndexerParsingMode` |
| `PdfTextRotationAlgorithm` | `BlobIndexerPDFTextRotationAlgorithm` |
| `PrioritizedFields` | `SemanticPrioritizedFields` |
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
| `Suggester` | `SearchSuggester` |
| `VectorSearchCompressionConfiguration` | `VectorSearchCompression` |
| `VectorSearchCompressionTargetDataType` | `VectorSearchCompressionTarget` |
| `WebApiParameters` | `WebApiVectorizerParameters` |
| `AnswerResult` | `QueryAnswerResult` |
| `CaptionResult` | `QueryCaptionResult` |
| `Answers` | `QueryAnswerType` |
| `Captions` | `QueryCaptionType` |

### 3. `IndexAction.@search.action` — enum moved to standalone definition

The `@search.action` property of `IndexAction` changes from an inline string enum to a `$ref` to
the new `IndexActionType` definition. The four enum values (`upload`, `merge`, `mergeOrUpload`,
`delete`) are unchanged on the wire; however, the `x-ms-client-name` changes from `ActionType`
(old) to `actionType` (new, camelCase).

### 4. `DocumentIntelligenceLayoutSkill` enum properties inlined

The `outputMode`, `outputFormat`, and `markdownHeaderDepth` properties change from `$ref` to named
enum definitions to inline string enums with the same allowed values. The standalone definitions
`DocumentIntelligenceLayoutSkillOutputMode`, `DocumentIntelligenceLayoutSkillOutputFormat`, and
`DocumentIntelligenceLayoutSkillMarkdownHeaderDepth` are removed. Wire values are unchanged.

### 5. `IndexingParametersConfiguration` — enum properties inlined

Similarly, `parsingMode`, `executionEnvironment`, `dataToExtract`, `imageAction`, and
`pdfTextRotationAlgorithm` change from `$ref` to inline string enums (renamed as listed in §2
above). Wire values are unchanged.

### 6. `PatternAnalyzer` and `PatternTokenizer` — `flags` inlined

The `flags` property changes from `$ref: #/definitions/RegexFlags` to an inline string. The allowed
values are unchanged; the `RegexFlags` standalone definition is retained.

### 7. `PhoneticTokenFilter.encoder` and `StopwordsTokenFilter.stopwordsList` inlined

Same pattern: `$ref` to named enum replaced with inline string. Wire values are unchanged.

### 8. URL path consolidation (equivalent routing)

Index-document operations and the knowledge-base retrieval endpoint moved from parameterized host
templates to explicit path prefixes. The REST wire paths are **wire-identical** — no caller changes
are required. This is a Swagger structural change only, driven by TypeSpec's single-host model.

### 9. `$select` query parameter type changed (`string` → `array[string]`)

For list operations on `/datasources`, `/indexers`, `/skillsets`, and `/synonymmaps`, the `$select`
query parameter type changes from `string` to `array` (items: `string`, `collectionFormat: csv`).
The wire format — a comma-separated list — is **unchanged**; only the SDK-generated parameter type
changes from `string` to `string[]`.

### 10. `POST /datasources` body parameter name changed

The request-body parameter for `POST /datasources` is renamed from `dataSource` to
`dataSourceConnection`. The underlying JSON schema (`SearchIndexerDataSource`) is **identical** — only
the Swagger parameter `name` field differs. This may affect generated SDK method signatures but has
no effect on the HTTP wire format.

### 11. `Accept` header added as required parameter

Every operation gains an explicit `Accept: application/json;odata.metadata=minimal` required header
parameter. The 2025-09-01 Swagger had no explicit `Accept` parameter; the service already required
and returned this content type. This is a **documentation-level change** — no wire behaviour change.

### 12. Legacy v1 cognitive skill types removed from discriminator

`SentimentSkill` (`#Microsoft.Skills.Text.SentimentSkill`) and `EntityRecognitionSkill`
(`#Microsoft.Skills.Text.EntityRecognitionSkill`) are removed from the `SearchIndexerSkill`
polymorphic discriminator union. Both V1 types were deprecated in a prior API version and were not
carried forward into the TypeSpec-authored spec. The V3 replacements remain fully supported:

- `SentimentSkillV3` (`#Microsoft.Skills.Text.V3.SentimentSkill`)
- `EntityRecognitionSkillV3` (`#Microsoft.Skills.Text.V3.EntityRecognitionSkill`)

The corresponding enums `SentimentSkillLanguage` and `EntityRecognitionSkillLanguage` are also
removed. The service has long rejected V1-typed skill submissions; callers still using V1
`@odata.type` values must migrate to the V3 equivalents.

### 13. `QueryResultDocumentVectorSubscores` removed — inline schema equivalent

The named definition `QueryResultDocumentVectorSubscores`
(`object{additionalProperties: SingleVectorFieldResult}`) is removed. The
`QueryResultDocumentSubscores.vectors` array items are now typed with the semantically equivalent
inline schema (`object{additionalProperties: SingleVectorFieldResult}`). The REST wire response
format is **unchanged**; this is a named-type-to-inline conversion with identical JSON structure.

---

# 2025-11-01-preview vs 2026-04-01

This section summarizes changes between the `2026-04-01` GA release and the immediately-preceding
`2025-11-01-preview` release.

## Changes

### Breaking Changes

#### 1. Operations removed (preview-only, not promoted to GA)

| Operation | Method + Path | Notes |
|---|---|---|
| `GetIndexStatsSummary` | `GET /indexstats` | Aggregate index-stats endpoint dropped |
| `Indexers_ResetDocs` | `POST /indexers('{indexerName}')/search.resetdocs` | Selective document re-ingestion |
| `Indexers_Resync` | `POST /indexers('{indexerName}')/search.resync` | Datasource re-sync |
| `Skillsets_ResetSkills` | `POST /skillsets('{skillsetName}')/search.resetskills` | Selective skill reset |

#### 2. SharePoint knowledge-source types removed

Both `IndexedSharePoint` and `RemoteSharePoint` knowledge-source variants are not promoted to GA.
All related definitions are removed:

- `IndexedSharePointKnowledgeSource`, `IndexedSharePointKnowledgeSourceParameters`,
  `IndexedSharePointKnowledgeSourceParams`
- `RemoteSharePointKnowledgeSource`, `RemoteSharePointKnowledgeSourceParameters`,
  `RemoteSharePointKnowledgeSourceParams`
- `KnowledgeBaseIndexedSharePointActivityArguments`,
  `KnowledgeBaseIndexedSharePointActivityRecord`,
  `KnowledgeBaseIndexedSharePointReference`
- `KnowledgeBaseRemoteSharePointActivityArguments`,
  `KnowledgeBaseRemoteSharePointActivityRecord`,
  `KnowledgeBaseRemoteSharePointReference`

The `KnowledgeSourceKind` enum loses `indexedSharePoint` and `remoteSharePoint` values
(`searchIndex`, `azureBlob`, `indexedOneLake`, `web` remain).

`KnowledgeBaseActivityRecordType` loses `indexedSharePoint` and `remoteSharePoint` values.
`KnowledgeBaseReferenceType` loses `indexedSharePoint` and `remoteSharePoint` values.

#### 3. Query-rewrite and speller features removed

The preview query-rewrite and spell-correction features are not promoted to GA. Removed from
`SearchRequest`:

- `hybridSearch` (`HybridSearch` object — `maxTextRecallSize` / `countAndFacetMode`)
- `queryLanguage` (`QueryLanguage` enum — 70+ locale values)
- `queryRewrites` (`QueryRewritesType` enum — `none` / `generative`)
- `speller` (`QuerySpellerType` enum — `none` / `lexicon`)
- `semanticFields` (comma-separated field list for semantic ranking)

Removed from `VectorizableTextQuery`: `queryRewrites`.

Removed from `DebugInfo`: `queryRewrites` (`QueryRewritesDebugInfo`).

Removed definitions: `HybridSearch`, `QueryLanguage`, `QueryRewritesType`, `QuerySpellerType`,
`QueryRewritesDebugInfo`, `QueryRewritesValuesDebugInfo`, `SemanticQueryRewritesResultType`.

Removed from `SearchDocumentsResult`: `@search.semanticQueryRewritesResultType`.

#### 4. Semantic debug information removed

`DocumentDebugInfo.semantic` property (`SemanticDebugInfo`) is removed. The `SemanticDebugInfo`
definition (with `titleField`, `contentFields`, `keywordFields`, `rerankerInput`) is also removed.

`SemanticConfiguration.flightingOptIn` boolean property removed.

#### 5. Incremental enrichment cache removed

`SearchIndexer.cache` property (`SearchIndexerCache`) removed. The `SearchIndexerCache` definition
(with `id`, `storageConnectionString`, `enableReprocessing`, `identity`) is removed.

#### 6. `SearchIndexerStatus.runtime` removed and no longer required

`SearchIndexerStatus.runtime` property (`IndexerRuntime`) is removed from both the property bag
and the `required` array. Previously required; now absent entirely.

#### 7. `SearchServiceStatistics.indexersRuntime` removed

`SearchServiceStatistics.indexersRuntime` property (`ServiceIndexersRuntime`) is removed. The
`ServiceIndexersRuntime` and `IndexerRuntime` definitions remain present (used elsewhere).

#### 8. `SearchIndexerKnowledgeStore.parameters` removed

The `parameters` property (`SearchIndexerKnowledgeStoreParameters`) on
`SearchIndexerKnowledgeStore` is removed.

#### 9. `SearchIndex` / `SearchIndexResponse` — permission-filter and Purview fields removed

Removed from both `SearchIndex` and `SearchIndexResponse`:
- `permissionFilterOption` (`SearchIndexPermissionFilterOption`)
- `purviewEnabled` (boolean)

#### 10. `SearchIndexerDataSource` — permission and sub-type fields removed

- `indexerPermissionOptions` (array of `IndexerPermissionOption`) removed
- `subType` (read-only string) removed

#### 11. `KnowledgeBase` — retrieval configuration fields removed

Removed from `KnowledgeBase`:
- `answerInstructions` (string)
- `outputMode` (`KnowledgeRetrievalOutputMode`)
- `retrievalInstructions` (string)
- `retrievalReasoningEffort` (`KnowledgeRetrievalReasoningEffort`)

The `KnowledgeRetrievalOutputMode` enum (`extractiveData` / `answerSynthesis`) is removed entirely.

#### 12. `KnowledgeBaseRetrievalRequest` — output and reasoning fields replaced

Removed: `maxOutputSize` (int32), `outputMode`, `retrievalReasoningEffort`.
Added as non-breaking replacement: `maxOutputSizeInTokens` (optional int32).

#### 13. `KnowledgeRetrievalReasoningEffortKind` — `low` and `medium` values removed

`KnowledgeRetrievalReasoningEffortKind` enum loses `low` and `medium`; only `minimal` remains in GA.
`KnowledgeRetrievalLowReasoningEffort` and `KnowledgeRetrievalMediumReasoningEffort` definitions
are removed.
`KnowledgeBaseModelAnswerSynthesisActivityRecord` and `KnowledgeBaseModelQueryPlanningActivityRecord`
(LLM activity token-count records) are also removed.

#### 14. `KnowledgeSourceParams.alwaysQuerySource` removed

The boolean `alwaysQuerySource` property is removed from `KnowledgeSourceParams`.

#### 15. `ChatCompletionSkill` — HTTP/Web-API properties removed

Six WebApiSkill-style properties are removed from `ChatCompletionSkill`:
`authResourceId`, `batchSize`, `degreeOfParallelism`, `httpHeaders`, `httpMethod`, `timeout`.
Remaining properties: `uri`, `apiKey`, `authIdentity`, `commonModelParameters`,
`extraParameters`, `extraParametersBehavior`, `responseFormat`.

### Non-Breaking Changes

#### 1. New definition: `KnowledgeSourceSynchronizationError`

A new model representing a document-level indexing error during knowledge-source synchronization:

```typescript
{
  errorMessage: string;          // required
  docId?: string;
  statusCode?: number;           // int32
  name?: string;
  details?: string;
  documentationLink?: string;
}
```

#### 2. `KnowledgeSourceStatus.kind` added

New optional `kind` property added to `KnowledgeSourceStatus`.

#### 3. `SynchronizationState.errors` added

New optional `errors` property added to `SynchronizationState`.

#### 4. `SearchIndexerDataUserAssignedIdentity.federatedIdentityClientId` added

New optional `federatedIdentityClientId` property on `SearchIndexerDataUserAssignedIdentity`.
