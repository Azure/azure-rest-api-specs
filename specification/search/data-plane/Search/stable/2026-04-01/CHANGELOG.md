# 2025-09-01 vs 2026-04-01

The two Swagger files `searchservice.json` and `searchindex.json` are consolidated into a single
`search.json`, and the two generated clients merge into one.

---

## Non-Breaking Changes

### New operations

**Aliases** — full CRUD for index aliasing (mapping a logical name to a physical index):
`Aliases_Create` (POST), `Aliases_CreateOrUpdate` (PUT), `Aliases_Delete`, `Aliases_Get`,
`Aliases_List`.

**KnowledgeBases** — full CRUD plus a retrieval action for AI-powered knowledge retrieval
(backed by search-index, Azure Blob, Azure One Lake, and web sources):
`KnowledgeBases_Create` (POST), `KnowledgeBases_CreateOrUpdate` (PUT), `KnowledgeBases_Delete`,
`KnowledgeBases_Get`, `KnowledgeBases_List`, `KnowledgeRetrieval_Retrieve`
(POST `.../retrieve`).

**KnowledgeSources** — full CRUD plus a status endpoint:
`KnowledgeSources_Create` (POST), `KnowledgeSources_CreateOrUpdate` (PUT),
`KnowledgeSources_Delete`, `KnowledgeSources_Get`, `KnowledgeSources_List`,
`KnowledgeSources_GetStatus` (GET `.../status`).

**Indexes** — `Indexes_GetStatistics` (GET `.../search.stats`); `Indexes_ListWithSelectedProperties`
(`GET /indexes` overload via `x-ms-paths` returning name, ETag, and selected statistics fields).

### New skills and vectorizers

- `AzureMachineLearningSkill` (`#Microsoft.Skills.Custom.AmlSkill`) — calls a custom Azure ML
  endpoint.
- `ChatCompletionSkill` (`#Microsoft.Skills.Custom.ChatCompletionSkill`) — calls a
  chat-completion model.
- `ContentUnderstandingSkill` (`#Microsoft.Skills.Util.ContentUnderstandingSkill`) — Azure AI
  Content Understanding enrichment.
- `VisionVectorizeSkill` (`#Microsoft.Skills.Vision.VectorizeSkill`) — image vectorization via
  AI Vision.
- `AIServicesVisionVectorizer` — vectorizes text/image using Azure AI Vision.

### New optional fields on existing models

**Search / Query**
- `SearchDocumentsResult`: `@search.debug` (debug info in search responses).
- `FacetResult`: `avg`, `cardinality`, `max`, `min`, `sum`, `@search.facets` (aggregation
  statistics on facet buckets).
- `VectorQuery`: `filterOverride`, `perDocumentVectorLimit`, `threshold`.

**Indexes / Fields**
- `SearchField`: `permissionFilter`, `sensitivityLabel` (per-field ACL and sensitivity metadata).

**Indexers / Data sources**
- `IndexerExecutionResult`: `mode`, `statusDetail`.
- `IndexingParametersConfiguration`: `markdownHeaderDepth`, `markdownParsingSubmode`.
- `SearchIndexerDataSource`: `identity` (managed identity for data source authentication).
- `SearchIndexerKnowledgeStore`: `identity`.
- `SearchIndexerStatus`: `currentState`.
- `SearchIndexerDataUserAssignedIdentity`: `federatedIdentityClientId` (workload identity
  federation).

**Skills**
- `AzureOpenAIEmbeddingSkill`: `resourceUri`, `deploymentId`, `apiKey`, `authIdentity`,
  `modelName` (explicit properties; previously inherited from the shared `AzureOpenAIParameters`
  mixin).
- `SplitSkill`: `unit`, `azureOpenAITokenizerParameters` (token-aware splitting).
- `DocumentDebugInfo`: `innerHits`.

**Encryption**
- `SearchResourceEncryptionKey`: `identity`; `keyVaultKeyVersion` made optional (auto-rotation
  support).

### Other additions

- `BlobIndexerParsingMode`: new `markdown` value — direct Markdown ingestion without a separate
  skill.
- Security definitions `ApiKeyAuth` (header `api-key`) and `OAuth2Auth` (implicit flow,
  `https://search.azure.com/.default`) formally declared; documents existing authentication
  without changing client behaviour.

---

## TypeSpec migration artifacts

REST wire format is **identical** for all items in this section. Apparent SDK breaks arise only
because TypeSpec applies stricter naming and typing conventions than the previous hand-authored
Swagger. Clients speaking raw JSON/HTTP are **not** affected; generated-SDK clients will see
compile-time name or type changes, but **no service re-deployment or data migration is needed**.

1. **`SearchIndexerLimits` field types narrowed** — `maxDocumentExtractionSize` and
   `maxDocumentContentCharactersToExtract` change from `number` (double) to `integer` (int64).
   The service always returned integers; the Swagger was incorrect. Only SDK clients typed as
   `double` need a code update.

2. **32 model type renames (SDK-level only)** — Wire JSON is unchanged; only generated client
   type names change. Grouped by category:
   - *Similarity algorithms*: `BM25Similarity` → `BM25SimilarityAlgorithm`,
     `ClassicSimilarity` → `ClassicSimilarityAlgorithm`, `Similarity` → `SimilarityAlgorithm`.
   - *Vector algorithms*: `ExhaustiveKnnVectorSearchAlgorithmConfiguration` →
     `ExhaustiveKnnAlgorithmConfiguration`,
     `HnswVectorSearchAlgorithmConfiguration` → `HnswAlgorithmConfiguration`,
     `RawVectorQuery` → `VectorizedQuery`.
   - *Vector compression*: `BinaryQuantizationVectorSearchCompressionConfiguration` →
     `BinaryQuantizationCompression`,
     `ScalarQuantizationVectorSearchCompressionConfiguration` → `ScalarQuantizationCompression`,
     `VectorSearchCompressionConfiguration` → `VectorSearchCompression`,
     `VectorSearchCompressionTargetDataType` → `VectorSearchCompressionTarget`.
   - *Vectorizer parameters*: `AzureOpenAIParameters` → `AzureOpenAIVectorizerParameters`,
     `WebApiParameters` → `WebApiVectorizerParameters`.
   - *Blob indexer enums*: `DataToExtract` → `BlobIndexerDataToExtract`,
     `ExecutionEnvironment` → `IndexerExecutionEnvironment`,
     `ImageAction` → `BlobIndexerImageAction`, `ParsingMode` → `BlobIndexerParsingMode`,
     `PdfTextRotationAlgorithm` → `BlobIndexerPDFTextRotationAlgorithm`.
   - *Semantic*: `PrioritizedFields` → `SemanticPrioritizedFields`,
     `SemanticErrorHandling` → `SemanticErrorMode`,
     `SemanticPartialResponseReason` → `SemanticErrorReason`,
     `SemanticPartialResponseType` → `SemanticSearchResultsType`,
     `SemanticSettings` → `SemanticSearch`.
   - *Service statistics*: `ServiceCounters` → `SearchServiceCounters`,
     `ServiceLimits` → `SearchServiceLimits`, `ServiceStatistics` → `SearchServiceStatistics`.
   - *Query results*: `AnswerResult` → `QueryAnswerResult`, `CaptionResult` →
     `QueryCaptionResult`, `Answers` → `QueryAnswerType`, `Captions` → `QueryCaptionType`.
   - *Misc*: `OcrSkillLineEnding` → `OcrLineEnding`,
     `SearchIndexerIndexProjections` → `SearchIndexerIndexProjection`,
     `Suggester` → `SearchSuggester`.

3. **`IndexAction.@search.action` enum extracted** — Changed from inline enum to
   `$ref IndexActionType`. Values (`upload`, `merge`, `mergeOrUpload`, `delete`) unchanged;
   `x-ms-client-name` changes from `ActionType` to `actionType` (camelCase).

4. **Enum properties inlined on several models** — `$ref` to named enum replaced with equivalent
   inline string enum (wire values unchanged):
   - `DocumentIntelligenceLayoutSkill`: `outputMode`, `outputFormat`, `markdownHeaderDepth`
     (removes `DocumentIntelligenceLayoutSkillOutputMode`, `…OutputFormat`,
     `…MarkdownHeaderDepth` definitions).
   - `IndexingParametersConfiguration`: `parsingMode`, `executionEnvironment`, `dataToExtract`,
     `imageAction`, `pdfTextRotationAlgorithm`.
   - `PatternAnalyzer` and `PatternTokenizer`: `flags` (inline string; `RegexFlags` definition
     retained).
   - `PhoneticTokenFilter`: `encoder`; `StopwordsTokenFilter`: `stopwordsList`.

5. **URL path consolidation** — Index-document operations and knowledge-base retrieval moved from
   parameterized host templates to explicit path prefixes. Wire paths are identical; Swagger
   structural change only (TypeSpec single-host model).

6. **`$select` parameter type** — For LIST operations on `/datasources`, `/indexers`,
   `/skillsets`, `/synonymmaps`: type changes from `string` to `array[string]` (csv). Wire
   format (comma-separated) unchanged; SDK parameter changes from `string` to `string[]`.

7. **`POST /datasources` body parameter name** — Renamed from `dataSource` to
   `dataSourceConnection`. JSON schema (`SearchIndexerDataSource`) identical; Swagger `name`
   field only.

8. **`Accept` header added as explicit required parameter** — Every operation gains
   `Accept: application/json;odata.metadata=minimal`. Service always required this;
   documentation-level change only.

9. **V1 skill types removed from discriminator** — `SentimentSkill`
   (`#Microsoft.Skills.Text.SentimentSkill`) and `EntityRecognitionSkill`
   (`#Microsoft.Skills.Text.EntityRecognitionSkill`) removed from the `SearchIndexerSkill`
   discriminator union; both were deprecated. V3 replacements (`SentimentSkillV3`,
   `EntityRecognitionSkillV3`) remain. Enums `SentimentSkillLanguage` and
   `EntityRecognitionSkillLanguage` also removed.

10. **`QueryResultDocumentVectorSubscores` inlined** — Named definition removed;
    `QueryResultDocumentSubscores.vectors` items now use semantically equivalent inline schema
    `object{additionalProperties: SingleVectorFieldResult}`. Wire response unchanged.

---

# 2025-11-01-preview vs 2026-04-01

---

## Breaking Changes

### Indexer / stats operations removed (preview-only, not promoted to GA)

- `GetIndexStatsSummary` (`GET /indexstats`) — aggregate index-stats endpoint.
- `Indexers_ResetDocs` (`POST /indexers('{indexerName}')/search.resetdocs`) — selective
  document re-ingestion.
- `Indexers_Resync` (`POST /indexers('{indexerName}')/search.resync`) — datasource re-sync.
- `Skillsets_ResetSkills` (`POST /skillsets('{skillsetName}')/search.resetskills`) — selective
  skill reset.

### Search request — query-rewrite and speller features removed

Removed from `SearchRequest`: `hybridSearch` (`HybridSearch`), `queryLanguage` (`QueryLanguage`),
`queryRewrites` (`QueryRewritesType`), `speller` (`QuerySpellerType`), `semanticFields`.
Removed from `VectorizableTextQuery`: `queryRewrites`.
Removed from `DebugInfo`: `queryRewrites` (`QueryRewritesDebugInfo`).
Removed from `SearchDocumentsResult`: `@search.semanticQueryRewritesResultType`.
Removed definitions: `HybridSearch`, `QueryLanguage`, `QueryRewritesType`, `QuerySpellerType`,
`QueryRewritesDebugInfo`, `QueryRewritesValuesDebugInfo`, `SemanticQueryRewritesResultType`.

### Index / Fields

- `SearchIndex` and `SearchIndexResponse`: `permissionFilterOption`
  (`SearchIndexPermissionFilterOption`) and `purviewEnabled` removed.
- `SearchIndexerDataSource`: `indexerPermissionOptions` (array of `IndexerPermissionOption`)
  and `subType` (read-only string) removed.

### Indexers

- `SearchIndexer.cache` (`SearchIndexerCache`) removed; `SearchIndexerCache` definition
  (fields: `id`, `storageConnectionString`, `enableReprocessing`, `identity`) removed.
- `SearchIndexerStatus.runtime` (`IndexerRuntime`) removed from property bag and `required`
  array.
- `SearchServiceStatistics.indexersRuntime` (`ServiceIndexersRuntime`) removed.
- `SearchIndexerKnowledgeStore.parameters` (`SearchIndexerKnowledgeStoreParameters`) removed.

### Semantic debug

- `DocumentDebugInfo.semantic` (`SemanticDebugInfo`) removed; `SemanticDebugInfo` definition
  (fields: `titleField`, `contentFields`, `keywordFields`, `rerankerInput`) removed.
- `SemanticConfiguration.flightingOptIn` removed.

### Skills

- `ChatCompletionSkill`: WebApiSkill-style properties `authResourceId`, `batchSize`,
  `degreeOfParallelism`, `httpHeaders`, `httpMethod`, `timeout` removed. Remaining: `uri`,
  `apiKey`, `authIdentity`, `commonModelParameters`, `extraParameters`,
  `extraParametersBehavior`, `responseFormat`.

### KnowledgeBase / KnowledgeSource

SharePoint variants not promoted to GA — all `IndexedSharePoint*` and `RemoteSharePoint*`
definitions removed, along with associated activity-argument, activity-record, and reference
types. `KnowledgeSourceKind`, `KnowledgeBaseActivityRecordType`, `KnowledgeBaseReferenceType`
enums lose `indexedSharePoint` and `remoteSharePoint` values.

- `KnowledgeBase`: `answerInstructions`, `outputMode`, `retrievalInstructions`,
  `retrievalReasoningEffort` removed; `KnowledgeRetrievalOutputMode` enum removed.
- `KnowledgeBaseRetrievalRequest`: `maxOutputSize`, `outputMode`, `retrievalReasoningEffort`
  removed; replaced by `maxOutputSizeInTokens` (optional int32).
- `KnowledgeRetrievalReasoningEffortKind`: `low` and `medium` values removed (only `minimal`
  remains); `KnowledgeRetrievalLowReasoningEffort`,
  `KnowledgeRetrievalMediumReasoningEffort`, `KnowledgeBaseModelAnswerSynthesisActivityRecord`,
  `KnowledgeBaseModelQueryPlanningActivityRecord` definitions removed.
- `KnowledgeSourceParams.alwaysQuerySource` (boolean) removed.

---

## Non-Breaking Changes

- `KnowledgeSourceSynchronizationError` model added: `errorMessage` (required string), `docId?`,
  `statusCode?` (int32), `name?`, `details?`, `documentationLink?`.
- `KnowledgeSourceStatus.kind` added (optional).
- `SynchronizationState.errors` added (optional).
- `SearchIndexerDataUserAssignedIdentity.federatedIdentityClientId` added (optional).
