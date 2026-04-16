# Search Data-plane API Changelog

**Internal Reference Document**:
This changelog tracks cross-version changes to the Azure Search data-plane API specification since the TypeSpec migration (2025-11-01-preview).
It is maintained for internal engineering reference and API Stewardship Board reviews.

---
## 2026-05-01-preview

**Context**: Preview release built on top of 2026-04-01 GA. Restores several features removed from GA and introduces new knowledge source types, image serving, freshness policies, permission filtering, and expanded AI model support.

### GA-to-Preview Changes (2026-04-01 → 2026-05-01-preview)

#### Breaking Changes

**AddedRequiredProperty**: The following properties become required.

[RE-INTRODUCED (preview-only)]

- `SearchIndexerStatus.runtime` (`IndexerRuntime`): indexer cumulative runtime snapshot.
- `SearchServiceStatistics.indexersRuntime` (`ServiceIndexersRuntime`): service-level indexer runtime.

[NEW in this preview]

- `SearchServiceCounters.knowledgeBasesCount` (`ResourceCounter`): total knowledge bases.
- `SearchServiceCounters.knowledgeSourcesCount` (`ResourceCounter`): total knowledge sources.

**ChangedParameterOrder**: Preview-only parameters re-inserted, shifting subsequent parameter positions.

[RE-INTRODUCED (preview-only)]

- `DataSources_CreateOrUpdate`: `ignoreResetRequirements` re-inserted before `x-ms-client-request-id`, `dataSourceName`, `dataSource`.
- `Indexers_CreateOrUpdate`: `ignoreResetRequirements`, `disableCacheReprocessingChangeDetection` re-inserted before `x-ms-client-request-id`, `indexerName`, `indexer`.
- `Documents_SearchGet`: `x-ms-query-source-authorization`, `x-ms-enable-elevated-read` re-inserted before `search`.

#### Non-Breaking Changes

**New operations**:

[NEW in this preview]

- **KnowledgeSources file management**: `KnowledgeSources_UploadFile` (POST), `KnowledgeSources_ListFiles` (GET), `KnowledgeSources_DeleteFile` (DELETE) under `.../files`.

[RE-INTRODUCED (preview-only)]

- **GetIndexStatsSummary** (GET `/indexstats`): `$top`, `$skip`, `$count` pagination; returns `ListIndexStatsSummary`.
- `Indexers_Resync`, `Indexers_ResetDocs`, `Skillsets_ResetSkills`.

**New knowledge source types** (added to `KnowledgeSourceKind`):

[NEW in this preview]

- **`IndexedSql`**: `IndexedSqlKnowledgeSource`, `IndexedSqlKnowledgeSourceParameters` (connection string, query, column mappings), `ContentColumnMapping`, `EmbeddingColumnMapping`.
- **`WorkIQ`**: `WorkIQKnowledgeSource`, `WorkIQKnowledgeSourceParams`.
- **`File`**: `FileKnowledgeSource`, `FileKnowledgeSourceParameters`, `KnowledgeSourceFile`, `ListKnowledgeSourceFilesResult`.
- **`McpServer`**: `McpServerKnowledgeSource`, `McpServerKnowledgeSourceParameters`; auth via `McpServerAuthentication` (Foundry/StoredHeaders variants); tools via `McpServerTool`; output via `McpServerOutputParsing` (`auto`, `json`, `split`, `none`).
- **`FabricDataAgent`**: `FabricDataAgentKnowledgeSource`, `FabricDataAgentKnowledgeSourceParameters`; activity/reference types.
- **`FabricOntology`**: `FabricOntologyKnowledgeSource`, `FabricOntologyKnowledgeSourceParameters`; activity/reference types.

[RE-INTRODUCED (preview-only)]

- **`IndexedSharePoint`** and **`RemoteSharePoint`**: full model, parameter, runtime-params, activity, and reference trees.

**New optional fields on existing models**:

[NEW in this preview]

- `KnowledgeBase`: `corsOptions`; `KnowledgeSource` (all kinds): `enableImageServing`, `enableFreshness`; `SearchIndexKnowledgeSource`: `baseFilter`.
- `KnowledgeSourceParams`: `failOnError`, `maxOutputDocuments`, `enableImageServing`; `KnowledgeBaseRetrievalRequest`: `maxOutputDocuments`.
- `WebKnowledgeSourceParameters`: `language`, `market`, `count`, `freshness`; `KnowledgeSourceIngestionParameters`: `assetStore`, `freshnessPolicy`; `SensitivityLabels` → `KnowledgeSourceIngestionPermissionOption`.
- `KnowledgeBaseRetrievalActivityRecord`: `imageServing`; `SearchIndex`/`SearchIndexResponse`: `sharePointConnectorAppRegistration`.
- `SearchField`: `sensitivityLabelId`, `sensitivityLabelName`, `sourceDocumentId`, `sharepointSiteUrl`; `SearchResourceEncryptionKey`: `isServiceLevelKey`.
- `SearchIndexerDataUserAssignedIdentity`: `federatedIdentityClientId` (federated identity for CMK); `ContentUnderstandingSkillChunkingProperties`: `method` (`fixedSize`/`semantic`), `tokens` enum value.
- `ListIndexesResult`, `ListIndexesSelectedResult`, `ListKnowledgeSourcesResult`: `@odata.count`, `@odata.nextLink`; `AzureOpenAIModelName`: `gpt-5.1`, `gpt-5.2`, `gpt-5.4`.
- `Indexes_List`/`Indexes_ListWithSelectedProperties`: `$top`, `$skip`, `$count`.

[RE-INTRODUCED (preview-only)]

- `KnowledgeBase`: `retrievalReasoningEffort`, `outputMode`, `retrievalInstructions`, `answerInstructions`; `KnowledgeSourceParams`: `alwaysQuerySource`.
- `KnowledgeBaseRetrievalRequest`: `messages`, `maxOutputSize`, `retrievalReasoningEffort`, `outputMode`.
- `SearchIndex`/`SearchIndexResponse`: `permissionFilterOption`, `purviewEnabled`; `SearchField`: `permissionFilter`.
- `SearchIndexerDataSource`: `subType` (read-only), `indexerPermissionOptions`; `SearchIndexer`: `cache` (`SearchIndexerCache`).
- `SearchIndexerStatus`: `currentState`; `IndexerExecutionResult`: `statusDetail`, `mode`; `SearchIndexerKnowledgeStore`: `parameters`.
- `SemanticConfiguration`: `flightingOptIn`; `AzureOpenAIModelName`: `gpt-4o`, `gpt-4o-mini`, `gpt-4.1`, `gpt-4.1-mini`, `gpt-4.1-nano`, `gpt-5`.

**Query features**:

[RE-INTRODUCED (preview-only)]

`QueryRewritesType`, `QueryLanguage`, `QuerySpellerType`, `SemanticQueryRewritesResultType`; `SearchRequest` fields `queryRewrites`, `queryLanguage`, `speller`, `semanticFields`, `hybridSearch`; `VectorizableTextQuery.queryRewrites`; `VectorQuery.threshold`, `filterOverride`, `perDocumentVectorLimit`; `FacetResult` aggregate metrics (`avg`, `min`, `max`, `sum`, `cardinality`, `@search.facets`); debug types `QueryRewritesDebugInfo`, `QueryRewritesValuesDebugInfo`, `SemanticDebugInfo`, `DocumentDebugInfo.innerHits`, `DocumentDebugInfo.semantic`, `SearchDocumentsResult.@search.semanticQueryRewritesResultType`; `HybridSearch` (`maxTextRecallSize`, `countAndFacetMode`).

**Skills and vectorizers**:

[RE-INTRODUCED (preview-only)]

`AzureMachineLearningSkill`, `VisionVectorizeSkill`; `SplitSkill.unit`, `SplitSkill.azureOpenAITokenizerParameters`; `ChatCompletionSkill` WebApi-style properties (`authResourceId`, `batchSize`, `degreeOfParallelism`, `httpHeaders`, `httpMethod`, `timeout`).

**Knowledge base retrieval and permission filtering types**:

[RE-INTRODUCED (preview-only)]

`KnowledgeRetrievalLowReasoningEffort`, `KnowledgeRetrievalMediumReasoningEffort`, `KnowledgeRetrievalOutputMode` (`extractiveData`, `answerSynthesis`); `KnowledgeBaseModelQueryPlanningActivityRecord`, `KnowledgeBaseModelAnswerSynthesisActivityRecord`; `SearchIndexPermissionFilterOption`, `PermissionFilter`.

**Knowledge base activity and reference types**:

[NEW in this preview]

- **WorkIQ**: `KnowledgeBaseWorkIQActivityRecord`, `KnowledgeBaseWorkIQActivityArguments`, `KnowledgeBaseWorkIQReference` (`WorkIQAttribution[]`, `searchSensitivityLabelInfo`), `WorkIQAttribution` (`seeMoreWebUrl`).
- **LLM web summarization**: `KnowledgeBaseModelWebSummarizationActivityRecord` (`inputTokens`, `outputTokens`, `modelName`).
- **New enum values**: `modelWebSummarization`, `workIQ`, `fabricDataAgent`, `fabricOntology` → `KnowledgeBaseActivityRecordType`; `workIQ`, `fabricDataAgent`, `fabricOntology` → `KnowledgeBaseReferenceType`.

**Sensitivity label model**:

[NEW in this preview]
- `PurviewSensitivityLabelInfo` (replaces `SharePointSensitivityLabelInfo`): `displayName`, `sensitivityLabelId`, `toolTip`, `priority`, `color`, `isEncrypted`; added to `KnowledgeBaseSearchIndexReference`, `KnowledgeBaseAzureBlobReference`, `KnowledgeBaseIndexedOneLakeReference`, `KnowledgeBaseWorkIQReference`.

### Preview-to-Preview Changes (2025-11-01-preview → 2026-05-01-preview)

#### Non-Breaking Changes

[RE-INTRODUCED (preview-only)]

All items in the GA-to-Preview section under *Re-introduced (preview-only)* are non-breaking relative to this baseline (restored with identical contracts).

[NEW in this preview]

All net-new additions are additive and non-breaking:
- `SearchServiceCounters.knowledgeBasesCount` and `SearchServiceCounters.knowledgeSourcesCount`: new required fields on a **response** model; additive from a client perspective.
- `SearchIndexerStatus.runtime` and `SearchServiceStatistics.indexersRuntime`: already required in 2025-11-01-preview and restored with the same contract.

---

## 2026-04-01 (GA)

**Context**: Azure Search migrated from hand-authored Swagger to TypeSpec at 2025-11-01-preview. Three separate Swagger files (`searchservice.json`, `searchindex.json`, `knowledgebase.json`) were merged into a single TypeSpec-compiled `search.json`. This GA release inherits that unified structure plus new features and refinements.

**REST API Review Tracking**: [[Azure Search - Azure AI Search] DP 2026-04-01 GA API Review #40034](https://github.com/Azure/azure-rest-api-specs/issues/40034)

### GA-to-GA Changes (2025-09-01 → 2026-04-01)

#### Breaking Changes

**No wire-level breaking changes**. All HTTP API changes are backward-compatible additions.

**SDK breaking only** (due to TypeSpec Migration Artifacts which are wire-compatible):

- **Summary**: 2026-04-01 inherits TypeSpec migration artifacts from 2025-11-01-preview. These changes do not affect the HTTP wire format. SDK regeneration and customization is required and has been addressed in the SDK migration process.

- **Key Changes** (see [detailed migration section](#2025-11-01-preview-typespec-migration)):

  - **Legacy V1 skill types removed** (`SentimentSkill`, `EntityRecognitionSkill`; use V3 equivalents)
  - **32 definition renames** (e.g., `BM25Similarity` → `BM25SimilarityAlgorithm`, `RawVectorQuery` → `VectorizedQuery`)
  - **Type clarifications** (`SearchIndexerLimits` properties: `number` → `integer`; `$select`: `string` → `array[string]`)
  - **Parameter renames** (e.g., `POST /datasources` body: `dataSource` → `dataSourceConnection`)
  - **URL path consolidation** (host templates → explicit paths; resolved URLs identical)
  - **Schema restructuring** (inline ↔ `$ref` conversions with equivalent schemas)
  - **Shared route operations**: `Indexes_ListWithSelectedProperties` added as separate operation sharing `GET /indexes` route with `Indexes_List` via TypeSpec `@sharedRoute` decorator. Wire-compatible: both map to the same endpoint with optional `$select` parameter. Improves SDK generation by providing distinct methods for listing all index properties vs. selected properties.
  - **Security definitions**: `ApiKeyAuth` (header `api-key`) and `OAuth2Auth` (implicit flow, `https://search.azure.com/.default`) formally declared; documents existing authentication without changing client behavior.

#### Non-Breaking Changes

**New operations**:

- **Aliases**: full CRUD for index aliasing (mapping a logical name to a physical index): `Aliases_Create` (POST), `Aliases_CreateOrUpdate` (PUT), `Aliases_Delete`, `Aliases_Get`, `Aliases_List`.

- **KnowledgeBases**: full CRUD plus a retrieval action for AI-powered knowledge retrieval (backed by search-index, Azure Blob, Azure One Lake, and web sources): `KnowledgeBases_Create` (POST), `KnowledgeBases_CreateOrUpdate` (PUT), `KnowledgeBases_Delete`, `KnowledgeBases_Get`, `KnowledgeBases_List`, `KnowledgeRetrieval_Retrieve` (POST .../retrieve).

- **KnowledgeSources**: full CRUD plus a status endpoint: `KnowledgeSources_Create` (POST), `KnowledgeSources_CreateOrUpdate` (PUT), `KnowledgeSources_Delete`, `KnowledgeSources_Get`, `KnowledgeSources_List`, `KnowledgeSources_GetStatus` (GET .../status).

**New skills and vectorizers**
- `ChatCompletionSkill` (#Microsoft.Skills.Custom.ChatCompletionSkill): calls a chat-completion model.
- `ContentUnderstandingSkill` (#Microsoft.Skills.Util.ContentUnderstandingSkill): Azure AI Content Understanding enrichment.

**New optional fields on existing models**

*Indexers / Data sources*

- `SearchIndexerDataSource`: `identity` (managed identity for data source authentication).
- `SearchIndexerKnowledgeStore`: `identity` (managed identity for knowledge store projections).

*Encryption*

- `SearchResourceEncryptionKey.keyVaultKeyVersion`: changed from **required** to **optional**, aligning with actual service behavior. This property was modified as optional in the preview track since 2025-03-01-preview, but the fix was not applied to 2025-09-01 GA.

**Markdown parsing mode**

Native Markdown file parsing for blob indexers without requiring a separate skill:
- `BlobIndexerParsingMode`: new `markdown` enum value to enable Markdown parsing.
- `IndexingParametersConfiguration.markdownParsingSubmode`: controls document splitting — `oneToOne` (entire file becomes one document) or `oneToMany` (split by header sections).
- `IndexingParametersConfiguration.markdownHeaderDepth`: sets header depth for sectioning (`h1` through `h6`; default: `h6`).


### Preview-to-GA Changes (2025-11-01-preview → 2026-04-01)

#### Breaking Changes (Preview Users Only)

The following preview features were not promoted to the GA release.

- **Operations removed**:
  - `GetIndexStatsSummary` (GET /indexstats)
  - `Indexers_ResetDocs` (POST .../search.resetdocs — selective document re-ingestion)
  - `Indexers_Resync` (POST .../search.resync — datasource re-sync)
  - `Skillsets_ResetSkills` (POST .../search.resetskills — selective skill reset).

- **Indexed and Remote SharePoint knowledge sources removed**: Complete removal of SharePoint knowledge-source variants:
  - `IndexedSharePointKnowledgeSource` (with `IndexedSharePointKnowledgeSourceParameters`, `IndexedSharePointKnowledgeSourceParams`, activity/reference types)
  - `RemoteSharePointKnowledgeSource` (with `RemoteSharePointKnowledgeSourceParameters`, `RemoteSharePointKnowledgeSourceParams`, activity/reference types)
  - Enum values `indexedSharePoint` and `remoteSharePoint` removed from `KnowledgeSourceKind`, `KnowledgeBaseActivityRecordType`, `KnowledgeBaseReferenceType` (remaining values: `searchIndex`, `azureBlob`, `indexedOneLake`, `web`).

- **Query features (e.g. query rewrite, speller) removed**:
  - `SearchRequest`: `hybridSearch` (object with `maxTextRecallSize`, `countAndFacetMode`), `queryLanguage` (70+ locale values), `queryRewrites` (enum: `none`, `generative`), `speller` (enum: `none`, `lexicon`), `semanticFields` (comma-separated field list)
  - `VectorizableTextQuery`: `queryRewrites`
  - `DebugInfo`: `queryRewrites` (object)
  - `SearchDocumentsResult`: `@search.semanticQueryRewritesResultType`, `@search.debug`
  - `VectorQuery`: `filterOverride`, `perDocumentVectorLimit`, `threshold`
  - `FacetResult`: `avg`, `cardinality`, `max`, `min`, `sum`, `@search.facets`
  - `DocumentDebugInfo`: `innerHits`
  - Related definitions removed: `HybridSearch`, `QueryLanguage`, `QueryRewritesType`, `QuerySpellerType`, `QueryRewritesDebugInfo`, `QueryRewritesValuesDebugInfo`, `SemanticQueryRewritesResultType`.

- **Semantic configuration removed**: `DocumentDebugInfo.semantic` (property and `SemanticDebugInfo` definition), `SemanticConfiguration.flightingOptIn`.

- **Indexer configuration removed**:
  - `SearchIndexer.cache` (incremental enrichment cache; property and `SearchIndexerCache` definition)
  - `SearchIndexerStatus.runtime` (removed from property bag and required array), `currentState`
  - `IndexerExecutionResult`: `mode`, `statusDetail`
  - `SearchServiceStatistics.indexersRuntime`
  - `SearchIndexerKnowledgeStore.parameters`

- **Index and data source configuration removed**:
  - `SearchIndex` / `SearchIndexResponse`: `permissionFilterOption`, `purviewEnabled`
  - `SearchIndexerDataSource`: `indexerPermissionOptions` (array), `subType` (read-only)
  - `SearchField`: `permissionFilter`, `sensitivityLabel`
  - `SearchIndexPermissionFilterOption`, `PermissionFilter`

- **Skill configuration removed**:
  - `SplitSkill`: `unit`, `azureOpenAITokenizerParameters`
  - `ChatCompletionSkill`: WebApiSkill-style properties `authResourceId`, `batchSize`, `degreeOfParallelism`, `httpHeaders`, `httpMethod`, `timeout` (remaining: `uri`, `apiKey`, `authIdentity`, `commonModelParameters`, `extraParameters`, `extraParametersBehavior`, `responseFormat`)

- **Knowledge base configuration removed**:
  - `KnowledgeBase`: `answerInstructions`, `outputMode`, `retrievalInstructions`, `retrievalReasoningEffort`
  - `KnowledgeBaseRetrievalRequest`: `maxOutputSize` (int32; replaced with `maxOutputSizeInTokens`), `outputMode`, `retrievalReasoningEffort`
  - `KnowledgeRetrievalReasoningEffortKind`: values `low`, `medium` removed (only `minimal` remains in GA)
  - `KnowledgeSourceParams`: `alwaysQuerySource`
  - Related definitions removed: `KnowledgeRetrievalOutputMode`, `KnowledgeRetrievalLowReasoningEffort`, `KnowledgeRetrievalMediumReasoningEffort`, `KnowledgeBaseModelAnswerSynthesisActivityRecord`, `KnowledgeBaseModelQueryPlanningActivityRecord`

#### Non-Breaking Changes

- New optional properties: `KnowledgeSourceStatus.kind`, `SynchronizationState.errors`, `KnowledgeBaseRetrievalRequest.maxOutputSizeInTokens` (int32; replaces preview `maxOutputSize`).

- Promoted from preview: `SearchResourceEncryptionKey.identity` (managed identity for encryption key access).

- `KnowledgeSourceSynchronizationError` definition added (document-level indexing error model with `errorMessage` [required], `docId`, `statusCode` [int32], `name`, `details`, `documentationLink`).

---

## 2025-11-01-preview: TypeSpec Migration

**Scope**: Migration from three hand-authored Swagger files (`searchservice.json`, `searchindex.json`, `knowledgebase.json`) to a single TypeSpec-compiled `search.json` describing the same `2025-11-01-preview` API.
- This TypeSpec migration applies to both REST API specification and SDKs. Changes listed here have been addressed in the SDK migration process as well.

### Breaking Changes

#### High Impact (Wire-Breaking)

- **Legacy V1 skill types removed from discriminator**: `SentimentSkill` (#Microsoft.Skills.Text.SentimentSkill) and `EntityRecognitionSkill` (#Microsoft.Skills.Text.EntityRecognitionSkill) removed from the `SearchIndexerSkill` polymorphic discriminator union.
  - These V1 cognitive skills were marked deprecated in the specification for multiple API versions and documented in [Deprecated Cognitive Skills](https://learn.microsoft.com/en-us/azure/search/cognitive-search-skill-deprecated). The service no longer supports these deprecated skills as of API version 2023-07-01-Preview. V3 replacements remain fully supported: `SentimentSkillV3` (#Microsoft.Skills.Text.V3.SentimentSkill), `EntityRecognitionSkillV3` (#Microsoft.Skills.Text.V3.EntityRecognitionSkill).
  - This breaking change has been addressed in the SDK migration process.

#### Medium Impact (SDK-Breaking, Wire-Compatible)

- **`$select` query parameter type changed**: For list operations on `/datasources`, `/indexers`, `/skillsets`, `/synonymmaps`: old `string` → new `array[string]` (collectionFormat: csv). Wire format unchanged (both serialize as comma-separated string); SDK method signatures change from `string` to `string[]`.

- **Shared route operations**: `Indexes_ListWithSelectedProperties` added as separate operation sharing `GET /indexes` route with `Indexes_List` via TypeSpec `@sharedRoute` decorator. Wire-compatible: both map to the same endpoint with optional `$select` parameter. Improves SDK generation by providing distinct methods for listing all index properties vs. selected properties.

- **Body parameter names changed** (Swagger metadata only; schema identical):
  - `POST /datasources`: `dataSource` → `dataSourceConnection`
  - `POST /knowledgebases`: `KnowledgeBase` → `knowledgeBase`
  - `PUT /knowledgebases('{knowledgeBaseName}')`: `KnowledgeBase` → `knowledgeBase`
  - `POST /knowledgesources`: `KnowledgeSource` → `knowledgeSource`
  - `PUT /knowledgesources('{sourceName}')`: `KnowledgeSource` → `knowledgeSource`

#### Low Impact (Bug Fixes)

- **`ChatCompletionExtraParametersBehavior` enum value fix**: Old spec had internal inconsistency: `enum` listed `"pass-through"` (hyphenated) but `x-ms-enum.values` listed `"passThrough"` (camelCase). New spec uses `"passThrough"` consistently. Fixes swagger to match actual service behavior (API already returned `"passThrough"`).

### Non-Breaking Changes

- **Schema file consolidation**: Three hand-authored Swagger files (`searchservice.json`, `searchindex.json`, `knowledgebase.json`) merged into one TypeSpec-compiled `search.json`.

- **URL path consolidation** (equivalent routing; resolved URLs identical): Document operations and knowledge retrieval moved from parameterized host templates to explicit path prefixes:
  - Old: `{endpoint}/indexes('{indexName}')` + `/docs/...` → New: `{endpoint}` + `/indexes('{indexName}')/docs/...`
  - Old: `{endpoint}/knowledgebases('{knowledgeBaseName}')` + `/retrieve` → New: `{endpoint}` + `/knowledgebases('{knowledgeBaseName}')/retrieve`

- **Definition renames** (37 types; all with identical content, wire format unchanged): Applied consistent naming conventions across similarity algorithms (e.g., `BM25Similarity` → `BM25SimilarityAlgorithm`), vector search configurations, semantic search types, indexer/skill types, and service statistics models. See detailed list in TypeSpec source files.

- **Inline ↔ `$ref` conversions** (equivalent schemas): Various schema restructuring between inline definitions and references with equivalent content (e.g., enum extractions, object references). Wire format unchanged.

- **Type format clarifications**:
  - `ChatCompletionCommonModelParameters`: `temperature`, `presencePenalty`, `frequencyPenalty` gain `format: double`
  - `FacetResult.cardinality`: `number` → `integer` (both with `format: int64`)
  - `SearchIndexerLimits`: `maxDocumentExtractionSize`, `maxDocumentContentCharactersToExtract`: `number` → `integer` (int64) — corrects spec to match service behavior

- **New definitions added** (new features or schema extractions): Standard Azure error response types, operation request body models, permission filtering types, knowledge base feature definitions, content understanding skill types, runtime tracking models, and extracted enum types.
