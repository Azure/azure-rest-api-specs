# Search Data-plane API Changelog

**Internal Reference Document**:
This changelog tracks cross-version changes to the Azure Search data-plane API specification since the TypeSpec migration (2025-11-01-preview).
It is maintained for internal engineering reference and API Stewardship Board reviews.

---
## 2026-05-01-preview

**Context**: Preview release built on top of 2026-04-01 GA. Restores several features that were removed from GA and introduces new knowledge source types, image serving, freshness policies, permission filtering, and expanded AI model support.

### Non-Breaking Changes

#### New operations

**KnowledgeSources — File knowledge source file management**:
- `KnowledgeSources_UploadFile` (POST `.../knowledgesources('{sourceName}')/files`): uploads a file (application/octet-stream) directly to a File knowledge source for processing and indexing; returns `KnowledgeSourceFile` (201).
- `KnowledgeSources_ListFiles` (GET `.../knowledgesources('{sourceName}')/files`): lists all files in a File knowledge source; returns `ListKnowledgeSourceFilesResult`.
- `KnowledgeSources_DeleteFile` (DELETE `.../knowledgesources('{sourceName}')/files('{fileId}')`): deletes a file and all indexed content derived from it (204 / 404).

**GetIndexStatsSummary** (GET `/indexstats`) — re-introduced from 2025-11-01-preview with `$top`, `$skip`, and `$count` pagination parameters; returns `ListIndexStatsSummary`.

#### New knowledge source types

New concrete knowledge source types added to `KnowledgeSourceKind` union and corresponding model trees:

- **`IndexedSql`** (`indexedSql`): reads data from Azure SQL Database or SQL Managed Instance.
  - `IndexedSqlKnowledgeSource`, `IndexedSqlKnowledgeSourceParameters` (connection string, query, column mappings), `ContentColumnMapping`, `EmbeddingColumnMapping`.
- **`WorkIQ`** (`workIQ`): reads data from WorkIQ.
  - `WorkIQKnowledgeSource`, `WorkIQKnowledgeSourceParams` (runtime params).
- **`File`** (`file`): supports direct file upload and indexing.
  - `FileKnowledgeSource`, `FileKnowledgeSourceParameters`, `KnowledgeSourceFile`, `ListKnowledgeSourceFilesResult`.
- **`McpServer`** (`mcpServer`): knowledge source backed by a Model Context Protocol (MCP) server.
  - `McpServerKnowledgeSource`, `McpServerKnowledgeSourceParameters` (serverURL, authentication, tools).
  - Authentication hierarchy: `McpServerAuthentication` (discriminated by `McpServerAuthenticationKind`): `McpServerFoundryConnectionAuthentication` / `McpServerStoredHeadersAuthentication` (with corresponding `*Parameters` models and `McpServerHeaders`).
  - Per-tool configuration: `McpServerTool` (name, description, inclusionMode, outputParsing).
  - Output parsing hierarchy: `McpServerOutputParsing` (discriminated by `McpServerOutputParsingKind`): `McpServerAutoOutputParsing`, `McpServerJsonOutputParsing` (with `McpServerOutputParsingJsonParameters`), `McpServerSplitOutputParsing` (with `McpServerOutputParsingSplitParameters`), `McpServerNoneOutputParsing`.
- **`FabricDataAgent`** (`fabricDataAgent`): retrieves data from a Microsoft Fabric Data Agent.
  - `FabricDataAgentKnowledgeSource`, `FabricDataAgentKnowledgeSourceParameters` (workspaceId, dataAgentId).
  - `FabricDataAgentKnowledgeSourceParams` (runtime params), `KnowledgeBaseFabricDataAgentActivityRecord`, `KnowledgeBaseFabricDataAgentActivityArguments`, `KnowledgeBaseFabricDataAgentReference`.
- **`FabricOntology`** (`fabricOntology`): retrieves data from Microsoft Fabric Ontology ontologies.
  - `FabricOntologyKnowledgeSource`, `FabricOntologyKnowledgeSourceParameters` (workspaceId, ontologyId).
  - `FabricOntologyKnowledgeSourceParams` (runtime params), `KnowledgeBaseFabricOntologyActivityRecord`, `KnowledgeBaseFabricOntologyActivityArguments`, `KnowledgeBaseFabricOntologyReference`.

#### New optional fields on existing models

**KnowledgeBase**:
- `corsOptions`: CORS configuration for the knowledge base.
- `retrievalReasoningEffort`, `outputMode`, `retrievalInstructions`, `answerInstructions` (preview-only; control AI reasoning and answer generation).

**KnowledgeSource** (all kinds):
- `enableImageServing`: enables image serving at retrieval time — images extracted during ingestion are delivered to downstream models.
- `enableFreshness`: enables freshness-aware retrieval; applies a freshness scoring profile to bias results toward newer documents.

**SearchIndexKnowledgeSource**:
- `baseFilter`: default OData filter applied at retrieval time; overridable via runtime parameters.

**KnowledgeSourceParams** (runtime retrieval parameters):
- `failOnError`: causes the entire retrieval request to fail if this source encounters an error (default: false).
- `maxOutputDocuments`: per-source cap on number of documents returned.
- `enableImageServing`: enables image serving for this source at retrieval time.
- `alwaysQuerySource` (preview-only): bypasses source selection and always queries this source.

**KnowledgeBaseRetrievalRequest**:
- `maxOutputDocuments`: cap on total documents across all sources.
- `messages`, `maxOutputSize`, `retrievalReasoningEffort`, `outputMode` (preview-only; re-introduced from 2025-11-01-preview).

**WebKnowledgeSourceParameters**:
- `language`, `market`, `count`, `freshness`: default web search parameters, each overridable at runtime.

**KnowledgeSourceIngestionParameters**:
- `assetStore` (`AssetStore`): blob storage configuration for storing extracted assets such as images.
- `freshnessPolicy` (`FreshnessPolicy`): freshness boosting window (`boostingDuration`, ISO 8601 duration).
- `ingestionPermissionOptions`: `SensitivityLabels` added to `KnowledgeSourceIngestionPermissionOption`.

**KnowledgeBaseRetrievalActivityRecord**:
- `imageServing` (`ImageServingStatistics`): statistics about image serving — images retrieved, sent to model, total size, and whether verbalization was used.

**SearchServiceCounters**:
- `knowledgeBasesCount` (`ResourceCounter`): total number of knowledge bases.
- `knowledgeSourcesCount` (`ResourceCounter`): total number of knowledge sources.

**SearchIndex / SearchIndexResponse**:
- `sharePointConnectorAppRegistration` (`SharePointConnectorAppRegistration`): app registration for SharePoint document-level permission filtering.
- `permissionFilterOption`, `purviewEnabled` (preview-only; re-introduced permission filtering fields).

**SearchField**:
- `sensitivityLabelId`: field contains Microsoft Purview sensitivity label IDs for document-level filtering.
- `sensitivityLabelName`: field contains Purview sensitivity label name.
- `sourceDocumentId`: field contains the source document identifier used for Purview audit tracking.
- `sharepointSiteUrl`: field contains a SharePoint site URL for SharePoint group-based filtering.
- `permissionFilter` (preview-only; re-introduced).

**SearchIndexerDataSource**:
- `subType` (read-only): specific subtype for data sources capable of different modalities (e.g., `MongoDb` for certain Cosmos DB accounts) (preview-only; re-introduced).
- `indexerPermissionOptions` (preview-only; re-introduced).

**SearchIndexer**:
- `cache` (`SearchIndexerCache`): incremental enrichment cache (preview-only; re-introduced).

**SearchIndexerStatus**:
- `runtime`, `currentState` (preview-only; re-introduced).

**IndexerExecutionResult**:
- `statusDetail`, `mode` (preview-only; re-introduced).

**SearchIndexerKnowledgeStore**:
- `parameters` (`SearchIndexerKnowledgeStoreParameters`) (preview-only; re-introduced).

**SearchResourceEncryptionKey**:
- `isServiceLevelKey`: indicates whether this is a service-level key (default: false).

**SearchResourceEncryptionKey** / **CmkEnforcement**:
- `federatedIdentityClientId` on `SearchIndexerDataUserAssignedIdentity`: supports multi-tenant federated identity for CMK.

**SemanticConfiguration**:
- `flightingOptIn` (preview-only; re-introduced): opts into semantic/query rewrite model flighting.

**ContentUnderstandingSkillChunkingProperties**:
- `method` (`ContentUnderstandingSkillChunkingMethod`): `fixedSize` (default) or `semantic`; `tokens` value also added.

**ListIndexesResult / ListIndexesSelectedResult / ListKnowledgeSourcesResult**:
- `@odata.count`, `@odata.nextLink`: pagination support for index and knowledge source list responses.

**AzureOpenAIModelName** (new values):
- `gpt-4o`, `gpt-4o-mini`, `gpt-4.1`, `gpt-4.1-mini`, `gpt-4.1-nano`, `gpt-5` (preview-only re-introduced).
- `gpt-5.1`, `gpt-5.2`, `gpt-5.4` (new stable additions).

**Indexes_List / Indexes_ListWithSelectedProperties**:
- `$top`, `$skip`, `$count` query parameters for pagination.

#### New knowledge base activity and reference types

- **WorkIQ**: `KnowledgeBaseWorkIQActivityRecord`, `KnowledgeBaseWorkIQActivityArguments`, `KnowledgeBaseWorkIQReference` (with `attributions?: WorkIQAttribution[]` and `searchSensitivityLabelInfo`), `WorkIQAttribution` (with `seeMoreWebUrl`).
- **LLM web summarization**: `KnowledgeBaseModelWebSummarizationActivityRecord` (inputTokens, outputTokens, modelName).
- `modelWebSummarization`, `workIQ`, `fabricDataAgent`, `fabricOntology` values added to `KnowledgeBaseActivityRecordType`.
- `workIQ`, `fabricDataAgent`, `fabricOntology` values added to `KnowledgeBaseReferenceType`.

#### New sensitivity label models

- `PurviewSensitivityLabelInfo` (replaces `SharePointSensitivityLabelInfo`): unified sensitivity label model with `displayName`, `sensitivityLabelId`, `toolTip`, `priority`, `color`, `isEncrypted`; added to `KnowledgeBaseSearchIndexReference`, `KnowledgeBaseAzureBlobReference`, `KnowledgeBaseIndexedOneLakeReference`, `KnowledgeBaseWorkIQReference`.

#### Re-introduced features (preview-only; were removed in 2026-04-01 GA)

The following were present in 2025-11-01-preview, removed in GA, and are restored in this preview release:

**Operations**: `Indexers_Resync`, `Indexers_ResetDocs`, `Skillsets_ResetSkills`.

**Query features**: `QueryRewritesType`, `QueryLanguage`, `QuerySpellerType`, `SemanticQueryRewritesResultType`; corresponding request fields on `SearchRequest` (`queryRewrites`, `queryLanguage`, `speller`, `semanticFields`, `hybridSearch`); `VectorizableTextQuery.queryRewrites`; `VectorQuery.threshold`, `filterOverride`, `perDocumentVectorLimit`; `FacetResult` aggregate metrics (`avg`, `min`, `max`, `sum`, `cardinality`, `@search.facets`); debug types (`DebugInfo.queryRewrites`, `QueryRewritesDebugInfo`, `QueryRewritesValuesDebugInfo`, `SemanticDebugInfo`, `DocumentDebugInfo.innerHits`, `DocumentDebugInfo.semantic`); `SearchDocumentsResult.@search.semanticQueryRewritesResultType`.

**Hybrid search**: `HybridSearch` model with `maxTextRecallSize` and `countAndFacetMode`.

**Knowledge sources**: `IndexedSharePoint` and `RemoteSharePoint` knowledge source types (with full model, parameter, runtime-params, activity, and reference trees).

**Knowledge base retrieval**: `KnowledgeRetrievalLowReasoningEffort`, `KnowledgeRetrievalMediumReasoningEffort`, `KnowledgeRetrievalOutputMode` (values: `extractiveData`, `answerSynthesis`); `KnowledgeBaseModelQueryPlanningActivityRecord`, `KnowledgeBaseModelAnswerSynthesisActivityRecord` (each with `inputTokens`, `outputTokens`, `modelName`); `KnowledgeSourceParams.alwaysQuerySource`.

**Skills/vectorizers**: `AzureMachineLearningSkill`, `VisionVectorizeSkill`; `SplitSkill.unit` and `SplitSkill.azureOpenAITokenizerParameters`; `ChatCompletionSkill` WebApi-style properties (`authResourceId`, `batchSize`, `degreeOfParallelism`, `httpHeaders`, `httpMethod`, `timeout`).

**Indexer cache and runtime**: `SearchIndexer.cache`, `SearchIndexerCache`, `SearchIndexerStatus.runtime` / `.currentState`, `IndexerExecutionResult.mode` / `.statusDetail`, `SearchServiceStatistics.indexersRuntime` (`ServiceIndexersRuntime`).

**Index permission filtering**: `SearchIndex.permissionFilterOption`, `SearchIndex.purviewEnabled`, `SearchField.permissionFilter`, `SearchIndexPermissionFilterOption`, `PermissionFilter`, `SearchIndexerDataSource.subType`, `SearchIndexerDataSource.indexerPermissionOptions`, `SearchIndexerKnowledgeStore.parameters`.

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

---

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
