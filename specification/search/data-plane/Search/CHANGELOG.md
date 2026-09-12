# Search Data-plane API Changelog

**Internal Reference Document**:
This changelog tracks cross-version changes to the Azure Search data-plane API specification since the TypeSpec migration (2025-11-01-preview).
It is maintained for internal engineering reference and API Stewardship Board reviews.

**Legend**: every item is new in the stated version unless labeled _Re-introduced (preview-only)_ — a preview feature dropped at the intervening GA and restored here.

---

## 2026-10-01

**Summary**: Built on top of the 2026-04-01 GA. Promotes File, Indexed SQL, and Indexed SharePoint
knowledge sources, indexed-reference citation URLs, server-sent-event knowledge retrieval, and
knowledge-base CORS options to stable, building on GA agentic planning and answer synthesis.
Adds File multipart management and capacity reporting, Indexed SharePoint list/page containers
and ingestion settings; promotes Content Understanding semantic chunking and image verbalization
to stable. File listing reuses the shared server-driven listing pagination contract.

### GA-to-GA Changes (2026-04-01 -> 2026-10-01)

#### Breaking Changes

No wire-level breaking changes from these promotions. The existing JSON retrieve route and content negotiation are unchanged.

The merged upstream list-operation search/paging changes trigger `ChangedParameterOrder` (`1042`, 46 findings) across `/aliases`, `/datasources`, `/indexers`, `/skillsets`, `/synonymmaps`, `/indexes`, `/knowledgebases`, and `/knowledgesources`: new optional query parameters (`search`, `pageSize`, `searchType`, and related listing/pagination fields) are spread in ahead of existing parameters in the TypeSpec operation signatures, so every parameter declared after them — including `x-ms-client-request-id` and, on writes, trailing path/body parameters — shifts to a higher positional index in the generated OpenAPI `parameters` array. It is not caused by the citation, streaming, or CORS promotions.

This is wire-compatible, not a breaking change: HTTP header parameters (RFC 7230 §3.2) and query-string parameters (RFC 3986) are both unordered name/value pairs, and REST clients / OpenAPI-generated SDKs bind by parameter name, not array index. The same rule fired identically for the 2026-05-01-preview promotion (see that version's entry below) and was accepted there for the same reason. The only residual, non-blocking risk is a generated SDK that binds these operations via positional (non-named) method parameters, where a reordered signature could change caller-visible overload resolution — a per-language codegen concern to verify, not a service/wire compatibility issue.

#### Non-Breaking Changes

- **Indexed citations**: optional `citationUrl` on `KnowledgeBaseSearchIndexReference`, `KnowledgeBaseAzureBlobReference`, `KnowledgeBaseIndexedOneLakeReference`, `KnowledgeBaseFileReference`, `KnowledgeBaseIndexedSqlReference`, and `KnowledgeBaseIndexedSharePointReference` points to the backing document on the Search service. The URL uses the request's API version.
- **Streaming retrieval**: `KnowledgeRetrieval_RetrieveStream` uses POST `.../knowledgebases('{knowledgeBaseName}')/retrieve` with `Accept: text/event-stream`. It preserves the preview event contract: `retrieval.started`, `activity.started`, `activity.completed`, `answer.completed`, `references.completed`, and either terminal `response.completed` or `error`. `response.completed` carries the completed response and semantic status (`200` or `206`); preflight errors remain JSON. Streaming accepts the same GA messages/intents, output modes, and `minimal`/`low`/`medium` reasoning settings as JSON retrieval; answer synthesis emits `answer.completed`. The `auto` reasoning mode remains preview-only.
- **Activity timing**: optional `KnowledgeBaseActivityRecord.startedAt` and `completedAt` are available in both JSON responses and streaming event payloads.
- **CORS**: optional `KnowledgeBase.corsOptions` and `FileKnowledgeSource.corsOptions` configure allowed browser origins and preflight cache duration, using the existing `CorsOptions` contract.
- **SDK representation**: the existing SSE event payload models are available in the stable SDK. OpenAPI 2.0 still represents the stream body as a string, and generated C# exposes a buffered protocol response rather than typed incremental event parsing. This promotion does not add typed streaming SDK support.

**New stable knowledge source types**:

- `file`, `indexedSql`, and `indexedSharePoint`, including their create/update models, runtime
  parameters, activity records, and reference types.
- Indexed SharePoint adds the named extensible-container values `allSiteLists`, `allSitePages`,
  and `allSiteContent`.

**File knowledge source management**:

- Multipart `KnowledgeSources_UploadFileMultipart` and `KnowledgeSources_UpdateFile`, plus
  `KnowledgeSources_ListFiles` and `KnowledgeSources_DeleteFile`.
- Multipart upload and update require structured `metadata` and binary `content` parts.
- `FileUploadMetadata.fileName` remains optional in every API version.
- `KnowledgeSourceFile` includes `prefix`, custom `metadata`, service-selected `parsingMode`, and
  service-selected `extractionMode`.
- File listing supports `prefix` and server-driven pagination and returns an opaque
  `@odata.nextLink`.
- `KnowledgeSourceStatus.fileCapacity` reports `maxFileCount`, `remainingFileCount`, and
  `maxFileSizeBytes` only for File sources; other kinds omit it. The existing status contract
  remains non-discriminated to preserve GA compatibility.
- Shared listing query parameters (`search`, `pageSize`, `searchType`) and the corresponding
  list response `@odata.nextLink` are retained in GA so File listings use the existing alias.

**Shared knowledge-source capabilities**:

- `KnowledgeSourceIngestionParameters` adds `ingestionPermissionOptions` and
  `networkAccessMode`. Permission values remain extensible; Indexed SharePoint uses `userIds` and
  `groupIds`, where `groupIds` represents both Entra and SharePoint groups.

**Content Understanding skill**:

- `ContentUnderstandingSkill.modelName` and `modelDeployment` configure the chat-completion model
  used for image descriptions.
- `ContentUnderstandingSkillChunkingProperties.method` supports `fixedSize` and `semantic`.
- `ContentUnderstandingSkillChunkingUnit` adds `tokens` for semantic chunking.

### Preview-to-GA Changes (2026-08-01-preview -> 2026-10-01)

#### Breaking Changes

No breaking changes to the promoted citation, streaming, or knowledge-base CORS contracts. The
items below existed in `2026-08-01-preview` and are cut (not promoted) at this GA, so they are
breaking only relative to that preview baseline — not relative to the `2026-04-01` GA above.

- The top-level raw `application/octet-stream` File upload operation is not promoted. GA callers
  must use multipart upload; the multipart binary `content` part may still use
  `application/octet-stream`.
- Generic stored `resultsProcessing` and runtime `neverQuerySource`,
  `failOnError`, `resultsProcessing`, and `maxOutputDocuments` remain preview-only.
- `queryHints` and `queryHintOverrides` are not promoted for File, Indexed SQL, or Indexed
  SharePoint knowledge sources.
- `assetStore`, `freshnessPolicy`, sensitivity-label ingestion, and image-serving-only surface are
  not promoted as part of these stable knowledge source contracts.
- **Query rewrites, hybrid search, and semantic debug info**: `queryRewrites`, `queryLanguage`,
  `speller`, `semanticFields`, `debugInfo` and its nested breakdown models (`QueryRewritesDebugInfo`,
  `SemanticDebugInfo`, `avg`/`min`/`max`/`sum`/`cardinality`/`facets`), and `hybridSearch`
  (`threshold`, `filterOverride`, `perDocumentVectorLimit`) remain preview-only across all
  affected request/response models.
- **New knowledge source connectors not promoted**: `remoteSharePoint`, `workIQ`,
  `fabricDataAgent`, `fabricOntology`, and `mcpServer` knowledge sources — including their
  create/update parameter models, authentication kinds (`EntraAppAuthentication`,
  `McpServerFoundryConnectionAuthentication`, `McpServerStoredHeadersAuthentication`), output
  parsing (`McpServerOutputParsing` and its variants), `queryHints`/`queryHintOverrides`/boost
  types, and their activity/reference record types — are not promoted.
- **Indexer cache is not promoted**: `SearchIndexerCache`, the indexer `cache` property,
  `disableCacheReprocessingChangeDetection`, `skipIndexerResetRequirementForCache`, and the
  `resetDocs`/`resetSkills` selective-reset operations remain preview-only.
- **Newer chat-completion model catalog entries are not promoted**: `AzureOpenAIModelName` values
  `gpt-4o`, `gpt-4o-mini`, `gpt-4.1`, `gpt-4.1-mini`, `gpt-4.1-nano`, `gpt-5`, `gpt-5.1`, `gpt-5.2`,
  `gpt-5.4`, `gpt-5.5`, `gpt-5.6-sol`, `gpt-5.6-terra`, and `gpt-5.6-luna` remain preview-only; GA
  retains `gpt-5-mini`/`nano` and the `gpt-5.4-mini`/`nano` GA baseline models.
- **Miscellaneous preview-only fields not promoted**: `SearchService.subType`,
  `isServiceLevelKey`, `flightingOptIn`, `purviewEnabled`, `sensitivityLabelId`,
  `sensitivityLabelName`, `sourceDocumentId`, `KnowledgeBase.tags`, `retrieveDefaults`
  (`KnowledgeBaseRetrieveDefaults`), `indexersRuntime`, `knowledgeBasesCount`,
  `knowledgeSourcesCount`, `maxVectorIndexSizePerIndexInBytes`, and
  `queryWorkIQSourceAuthorization`.
- **New vectorizer/skill types not promoted**: `AIServicesVisionVectorizer`,
  `AzureMachineLearningSkill`, `VisionVectorizeSkill`, and `AzureOpenAITokenizerParameters.unit`.

#### Non-Breaking Changes

The citation URLs, activity timestamps, streaming operation/event types, and knowledge-base CORS options described above retain their preview shapes in GA. Ordinary `application/json` retrieval and earlier API versions retain their existing behavior.

- The promoted multipart File operations and the retained File, Indexed SQL, and Indexed
  SharePoint models preserve their August preview wire names.
- File capacity reporting and the Indexed SharePoint list/page/content container values are
  additive relative to the August preview.
- The existing semantic chunking and image verbalization contract is promoted without changing its
  preview wire names or behavior.

---


## 2026-08-01-preview

**Summary**: Built on top of 2026-05-01-preview. Adds streaming (SSE) retrieval, an `auto` reasoning tier, search-index query hints, server-driven listing pagination, File-source upload enhancements, image serving, per-source controls, retrieve defaults, knowledge base tags, and WorkIQ on-behalf-of auth; restructures LLM activity-record metadata and the WorkIQ reference.

### GA-to-Preview Changes (2026-04-01 -> 2026-08-01-preview)

Cumulative: this view includes every change in the [2026-05-01-preview GA-to-Preview section](#2026-05-01-preview) plus this release's additions. CI (`openapi-diff`/OAD) diffs against the 2026-04-01 GA and re-reports the **full cumulative breaking set** on every run, so the Breaking Changes below carry the always-returned response fields first introduced in 2026-05-01-preview together with this release's new parameter-order shifts.

#### Breaking Changes

All items below are **wire-compatible** (a live caller is unaffected); they are OAD-detected and listed for the breaking-change review because this is a preview.

**AddedRequiredProperty** — cumulative, inherited from the [2026-05-01-preview GA-to-Preview section](#2026-05-01-preview); OAD flags all four vs the 2026-04-01 GA (`1034`):

- `SearchIndexerStatus.runtime`, `SearchServiceStatistics.indexersRuntime`, `SearchServiceCounters.knowledgeBasesCount`, and `SearchServiceCounters.knowledgeSourcesCount` are added to the `required` array of their response models (and via `SearchServiceStatistics.counters` / the `/servicestats` response schema). Wire-compatible: these are always-returned response fields, so an existing client just ignores them.

**ChangedParameterOrder** — cumulative; OAD reports 55 occurrences vs the 2026-04-01 GA (`1042`):

- The re-introduced preview parameters from 2026-05-01-preview (see that version's ChangedParameterOrder) **plus** this release's new listing/pagination query parameters (`search`, `pageSize`, `searchType`) added to the collection list GETs (`/aliases`, `/datasources`, `/indexers`, `/skillsets`, `/synonymmaps`, `/indexes`, `/knowledgebases`, `/knowledgesources`, `/indexstats`) shift `x-ms-client-request-id` — and, on the write operations that also gained parameters, the trailing path/body params — to higher positional indexes. Wire-compatible: HTTP parameters are keyed by name, not position.

> The `AddedRequiredProperty`, `RemovedParameter`, and `RemovedProperty`/`RemovedDefinition` items listed under Preview-to-Preview below touch models and parameters introduced *after* the 2026-04-01 GA (e.g. `WorkIQKnowledgeSource`, `McpServerTool`, the interim `$top`/`$skip`/`$count` paging), so they are additive — not breaking — relative to this GA baseline.

#### Non-Breaking Changes

**New operations**:

- **Streaming knowledge retrieval**: `KnowledgeRetrieval_RetrieveStream` (POST `.../knowledgebases('{knowledgeBaseName}')/retrieve` with `Accept: text/event-stream`) streams retrieval progress and results as server-sent events on the same route as `KnowledgeRetrieval_Retrieve`. The current OpenAPI 2.0 projection exposes the `200` response as an untyped string, so generated C# provides a buffered protocol `Response` without typed per-event parsing; typed SSE code generation remains deferred before GA.
- **File knowledge source file management**: `KnowledgeSources_UpdateFile` (PUT `.../files('{fileId}')`) and `KnowledgeSources_UploadFileMultipart` (POST `.../files`, `multipart/form-data`). Their `UpdateKnowledgeSourceFileRequest` and `UploadKnowledgeSourceFileMultipartRequest` bodies require both the structured `metadata` part and raw `content` part.

**Server-driven listing pagination**:

- Shared query parameters `search`, `pageSize` (1–3000), and `searchType` (`ListingSearchType`: `prefix`), plus `@odata.nextLink` continuation on the responses, added across the list operations (indexes, data sources, indexers, skillsets, synonym maps, aliases, knowledge bases, knowledge sources, and index-stats). The new `list`, `listWithSelectedProperties`, and `getIndexStatsSummary` TypeSpec operations replace the preview-only `listOffsetPaged`, `listWithSelectedPropertiesOffsetPaged`, and `getIndexStatsSummaryPaginated` operations, superseding their interim `$top`/`$skip`/`$count` OData paging introduced in 2026-05-01-preview (see Preview-to-Preview breaking changes).

**Streaming event model**:

- The TypeSpec source defines `KnowledgeBaseRetrievalStreamEvents` (`@events` server-sent-event union) with events `retrieval.started`, `activity.started`, `activity.completed`, `answer.completed`, `references.completed`, `error`, and the terminal `response.completed`. New event payloads: `KnowledgeBaseRetrievalStartedEvent`, `KnowledgeBaseActivityStartedEvent`, `KnowledgeBaseAnswerCompletedEvent`, `KnowledgeBaseStreamErrorEvent` (terminal `error`), and `KnowledgeBaseResponseCompletedEvent` (terminal `response.completed`, carrying `KnowledgeBaseRetrievalStatusCode`: `200` OK / `206` PartialContent); `activity.completed` reuses the existing `KnowledgeBaseActivityRecord` and `references.completed` reuses `KnowledgeBaseReference[]`.These event types are not currently referenced by the generated OpenAPI response because upstream OpenAPI 2.0 and C# SSE code generation does not yet project `SSEStream<T>` as a typed event stream.

**New reasoning effort tier**:

- **`auto`**: added to `KnowledgeRetrievalReasoningEffortKind`; new `KnowledgeRetrievalAutoReasoningEffort` polymorphic subtype. Selectable via `retrievalReasoningEffort.kind` on both `KnowledgeBaseRetrievalRequest` and the `KnowledgeBase` definition. The service seeds every request at the cheapest tier and escalates only as far as needed, up to the service's maximum available tier.

**Query hints for search-index knowledge sources**:

- Optional `queryHints` defaults (`SearchIndexKnowledgeSourceQueryHints`) on search-index-backed knowledge source parameters (`searchIndex`, `azureBlob`, `indexedSharePoint`, `indexedOneLake`, `indexedSql`, `file`), with `filters` (`SearchIndexKnowledgeSourceFilterHint`: required `field` and `fieldValues`, optional `filterInstructions`) and `boosts` (`SearchIndexKnowledgeSourceBoost` with optional `boostInstructions`, discriminated by `SearchIndexKnowledgeSourceBoostKind` into `fieldValue` (`SearchIndexKnowledgeSourceFieldValueBoost`: required `field` and `boost`, optional representative `fieldValues`) and `multiWordExpression` (`SearchIndexKnowledgeSourceMultiWordExpressionBoost`: required `boost`, optional representative `fieldValues`, no `field`)).
- Request-time `queryHintOverrides` on the corresponding knowledge source runtime params; an override replaces the stored hint object as a complete object.
- `queryType` on search-index activity arguments, and `queryHintProcessing` (`KnowledgeBaseQueryHintProcessing`) on index-backed retrieval activity records reporting the aggregate search clause and filter expression generated from the hints.

**Image serving**:

- `ServedImage`; `servedImages` on retrieval references; `citationUrl` on reference types.

**Per-source retrieval controls**:

- `KnowledgeSourceParams.neverQuerySource`: request-local exclusion of a knowledge source from the candidate set (mutually exclusive with `alwaysQuerySource`; does not modify knowledge base membership).
- `resultsProcessing` (`KnowledgeSourceResultsProcessing`: `rerank` (default), `none`) on `KnowledgeSource` and `McpServerTool`, controlling whether a source's results go through the reranking pipeline; request-time override on `KnowledgeSourceParams`.
- `networkAccessMode` (`KnowledgeSourceNetworkAccessMode`).

**LLM activity model metadata**:

- `model` (`KnowledgeBaseActivityRecordModel`: `modelName`, `deploymentId`) on the query-planning, answer-synthesis, and web-summarization activity records.
- `startedAt` and `completedAt` (`utcDateTime`) on `KnowledgeBaseActivityRecord`, reporting per-activity start and completion timestamps (alongside the existing `elapsedMs`).

**WorkIQ authentication**:

- Required `WorkIQKnowledgeSource.workIQParameters` (`WorkIQKnowledgeSourceParameters`), whose required `entraAppAuthentication` contains required `applicationId` and `federatedCredentialId` plus optional `tenantId`, for federated-credential on-behalf-of auth; `x-ms-query-work-iq-source-authorization` request header (`queryWorkIQSourceAuthorization`).
- `KnowledgeBaseWorkIQReference.searchSensitivityLabelInfo` (`PurviewSensitivityLabelInfo`) added as part of the WorkIQ reference payload restructure (see Preview-to-Preview breaking changes for the removed `attributions`).

**New optional fields on existing models**:

- `KnowledgeBase`: `retrieveDefaults` (`KnowledgeBaseRetrieveDefaults`: optional `maxRuntimeInSeconds`, `maxOutputDocuments`, and `maxOutputSizeInTokens`), `tags` (`Record<string>`, up to 10 user-defined key-value pairs for categorizing a knowledge base and attributing usage/costs).
- `KnowledgeBaseAgenticReasoningActivityRecord`: `logicalReasoningEffort`, reporting the requested logical effort when it differs from the execution or billing tier in `retrievalReasoningEffort`.
- `FileKnowledgeSource`: `corsOptions`; `FileKnowledgeSourceParameters`: `queryHints`.
- File upload/metadata: `FileUploadMetadata` (optional `fileName` and `metadata` — the service chooses parsing and extraction mode; the caller does not supply them), `FileKnowledgeSourceExtractionMode` (`minimal`, `standard`); `KnowledgeSourceFile`: `prefix`, `metadata`, `parsingMode`, `extractionMode`.
- Service limits: `maxVectorIndexSizePerIndexInBytes` (per-index vector index memory quota, in bytes).
- `AzureOpenAIModelName`: `Gpt56Sol` (`gpt-5.6-sol`), `Gpt56Terra` (`gpt-5.6-terra`), and `Gpt56Luna` (`gpt-5.6-luna`).

### Preview-to-Preview Changes (2026-05-01-preview -> 2026-08-01-preview)

#### Breaking Changes

Breaking vs 2026-05-01-preview only — the affected models and parameters don't exist in the 2026-04-01 GA.

**AddedRequiredProperty**:

- `WorkIQKnowledgeSource.workIQParameters` (`WorkIQKnowledgeSourceParameters`, required): the WorkIQ knowledge source (introduced in 2026-05-01-preview) now requires customer-owned Microsoft Entra app configuration for on-behalf-of authentication to the Work IQ API.

**ChangedParameterOrder**:

- The new listing/pagination query parameters (`search`, `pageSize`, `searchType`) added to the collection list GETs (`/aliases`, `/datasources`, `/indexers`, `/skillsets`, `/synonymmaps`, `/indexes`, `/knowledgebases`, `/knowledgesources`, `/indexstats`) push `x-ms-client-request-id` to a higher positional index; OAD reports this across every affected list operation. Wire-compatible: HTTP parameters are keyed by name, not position.

**RemovedParameter**:

- `$top`, `$skip`, `$count` removed with the preview-only `listOffsetPaged`, `listWithSelectedPropertiesOffsetPaged`, and `getIndexStatsSummaryPaginated` TypeSpec operations (emitted as `Indexes_List`, `Indexes_ListWithSelectedProperties`, and `GetIndexStatsSummary`); replaced by the server-driven `search`/`pageSize`/`searchType` + `@odata.nextLink` pagination.

**RemovedProperty / RemovedDefinition**:

- `modelName` (string) removed from `KnowledgeBaseModelQueryPlanningActivityRecord`, `KnowledgeBaseModelAnswerSynthesisActivityRecord`, and `KnowledgeBaseModelWebSummarizationActivityRecord`; replaced by the structured `model` (`KnowledgeBaseActivityRecordModel`: `modelName`, `deploymentId`).
- `KnowledgeBaseWorkIQReference.attributions` and the `WorkIQAttribution` definition removed (WorkIQ reference payload restructured; replaced by `searchSensitivityLabelInfo`).
- `McpServerTool.inclusionMode` and the `McpServerToolInclusionMode` union removed (both introduced in 2026-05-01-preview); replaced by `resultsProcessing` (`KnowledgeSourceResultsProcessing`).

#### Non-Breaking Changes

Same additions as the GA-to-Preview section above; all additive relative to this baseline.

---


## 2026-05-01-preview

**Summary**: Built on top of 2026-04-01 GA. Restores GA-dropped preview features and adds new knowledge source types, image serving, freshness, permission filtering, and more AI models.
**Summary**: Built on top of 2026-04-01 GA. Restores GA-dropped preview features and adds new knowledge source types, image serving, freshness, permission filtering, and more AI models.

### GA-to-Preview Changes (2026-04-01 → 2026-05-01-preview)

#### Breaking Changes

**AddedRequiredProperty**: The following properties become required.

_Re-introduced (preview-only):_
_Re-introduced (preview-only):_

- `SearchIndexerStatus.runtime` (`IndexerRuntime`): indexer cumulative runtime snapshot.
- `SearchServiceStatistics.indexersRuntime` (`ServiceIndexersRuntime`): service-level indexer runtime.

- `SearchServiceCounters.knowledgeBasesCount` (`ResourceCounter`): total knowledge bases.
- `SearchServiceCounters.knowledgeSourcesCount` (`ResourceCounter`): total knowledge sources.

**ChangedParameterOrder**: Preview-only parameters re-inserted, shifting subsequent parameter positions.

_Re-introduced (preview-only):_
_Re-introduced (preview-only):_

- `DataSources_CreateOrUpdate`: `ignoreResetRequirements` re-inserted before `x-ms-client-request-id`, `dataSourceName`, `dataSource`.
- `Indexers_CreateOrUpdate`: `ignoreResetRequirements`, `disableCacheReprocessingChangeDetection` re-inserted before `x-ms-client-request-id`, `indexerName`, `indexer`.
- `Documents_SearchGet`: `x-ms-query-source-authorization`, `x-ms-enable-elevated-read` re-inserted before `search`.

#### Non-Breaking Changes

**New operations**:

- **KnowledgeSources file management**: `KnowledgeSources_UploadFile` (POST), `KnowledgeSources_ListFiles` (GET), `KnowledgeSources_DeleteFile` (DELETE) under `.../files`.

_Re-introduced (preview-only):_
_Re-introduced (preview-only):_

- **GetIndexStatsSummary** (GET `/indexstats`): `$top`, `$skip`, `$count` pagination; returns `ListIndexStatsSummary`.
- `Indexers_Resync`, `Indexers_ResetDocs`, `Skillsets_ResetSkills`.

**New knowledge source types** (added to `KnowledgeSourceKind`):

- **`IndexedSql`**: `IndexedSqlKnowledgeSource`, `IndexedSqlKnowledgeSourceParameters` (connection string, query, column mappings), `ContentColumnMapping`, `EmbeddingColumnMapping`.
- **`WorkIQ`**: `WorkIQKnowledgeSource`, `WorkIQKnowledgeSourceParams`.
- **`File`**: `FileKnowledgeSource`, `FileKnowledgeSourceParameters`, `KnowledgeSourceFile`, `ListKnowledgeSourceFilesResult`.
- **`McpServer`**: `McpServerKnowledgeSource`, `McpServerKnowledgeSourceParameters`, `McpServerKnowledgeSourceParams`; auth via `McpServerAuthentication` (Foundry/StoredHeaders variants); tools via `McpServerTool`; output via `McpServerOutputParsing` (`auto`, `json`, `split`, `none`).
- **`FabricDataAgent`**: `FabricDataAgentKnowledgeSource`, `FabricDataAgentKnowledgeSourceParameters`; activity/reference types.
- **`FabricOntology`**: `FabricOntologyKnowledgeSource`, `FabricOntologyKnowledgeSourceParameters`; activity/reference types.

_Re-introduced (preview-only):_
_Re-introduced (preview-only):_

- **`IndexedSharePoint`** and **`RemoteSharePoint`**: full model, parameter, runtime-params, activity, and reference trees.

**New optional fields on existing models**:

- `KnowledgeBase`: `corsOptions`; `KnowledgeSource` (all kinds): `enableImageServing`, `enableFreshness`; `SearchIndexKnowledgeSource`: `baseFilter`.
- `KnowledgeSourceParams`: `failOnError`, `maxOutputDocuments`, `enableImageServing`; `KnowledgeBaseRetrievalRequest`: `maxOutputDocuments`.
- `WebKnowledgeSourceParameters`: `language`, `market`, `count`, `freshness`; `KnowledgeSourceIngestionParameters`: `assetStore`, `freshnessPolicy`; `SensitivityLabels` → `KnowledgeSourceIngestionPermissionOption`.
- `KnowledgeBaseRetrievalActivityRecord`: `imageServing`; `SearchIndex`/`SearchIndexResponse`: `sharePointConnectorAppRegistration`.
- `SearchField`: `sensitivityLabelId`, `sensitivityLabelName`, `sourceDocumentId`, `sharepointSiteUrl`; `SearchResourceEncryptionKey`: `isServiceLevelKey`.
- `SearchIndexerDataUserAssignedIdentity`: `federatedIdentityClientId` (federated identity for CMK); `ContentUnderstandingSkillChunkingProperties`: `method` (`fixedSize`/`semantic`), `tokens` enum value.
- `ListIndexesResult`, `ListIndexesSelectedResult`, `ListKnowledgeSourcesResult`: `@odata.count`, `@odata.nextLink`; `AzureOpenAIModelName`: `gpt-5.1`, `gpt-5.2`, `gpt-5.4`.
- `Indexes_List`/`Indexes_ListWithSelectedProperties`: `$top`, `$skip`, `$count`.

_Re-introduced (preview-only):_
_Re-introduced (preview-only):_

- `KnowledgeBase`: `retrievalReasoningEffort`, `outputMode`, `retrievalInstructions`, `answerInstructions`; `KnowledgeSourceParams`: `alwaysQuerySource`.
- `KnowledgeBaseRetrievalRequest`: `messages`, `maxOutputSize`, `retrievalReasoningEffort`, `outputMode`.
- `SearchIndex`/`SearchIndexResponse`: `permissionFilterOption`, `purviewEnabled`; `SearchField`: `permissionFilter`.
- `SearchIndexerDataSource`: `subType` (read-only), `indexerPermissionOptions`; `SearchIndexer`: `cache` (`SearchIndexerCache`).
- `SearchIndexerStatus`: `currentState`; `IndexerExecutionResult`: `statusDetail`, `mode`; `SearchIndexerKnowledgeStore`: `parameters`.
- `SemanticConfiguration`: `flightingOptIn`; `AzureOpenAIModelName`: `gpt-4o`, `gpt-4o-mini`, `gpt-4.1`, `gpt-4.1-mini`, `gpt-4.1-nano`, `gpt-5`.

**Query features**:

_Re-introduced (preview-only):_
_Re-introduced (preview-only):_

`QueryRewritesType`, `QueryLanguage`, `QuerySpellerType`, `SemanticQueryRewritesResultType`; `SearchRequest` fields `queryRewrites`, `queryLanguage`, `speller`, `semanticFields`, `hybridSearch`; `VectorizableTextQuery.queryRewrites`; `VectorQuery.threshold`, `filterOverride`, `perDocumentVectorLimit`; `FacetResult` aggregate metrics (`avg`, `min`, `max`, `sum`, `cardinality`, `@search.facets`); debug types `QueryRewritesDebugInfo`, `QueryRewritesValuesDebugInfo`, `SemanticDebugInfo`, `DocumentDebugInfo.innerHits`, `DocumentDebugInfo.semantic`, `SearchDocumentsResult.@search.semanticQueryRewritesResultType`; `HybridSearch` (`maxTextRecallSize`, `countAndFacetMode`).

**Skills and vectorizers**:

_Re-introduced (preview-only):_
_Re-introduced (preview-only):_

`AzureMachineLearningSkill`, `VisionVectorizeSkill`; `SplitSkill.unit`, `SplitSkill.azureOpenAITokenizerParameters`; `ChatCompletionSkill` WebApi-style properties (`authResourceId`, `batchSize`, `degreeOfParallelism`, `httpHeaders`, `httpMethod`, `timeout`).

**Knowledge base retrieval and permission filtering types**:

_Re-introduced (preview-only):_
_Re-introduced (preview-only):_

`KnowledgeRetrievalLowReasoningEffort`, `KnowledgeRetrievalMediumReasoningEffort`, `KnowledgeRetrievalOutputMode` (`extractiveData`, `answerSynthesis`); `KnowledgeBaseModelQueryPlanningActivityRecord`, `KnowledgeBaseModelAnswerSynthesisActivityRecord`; `SearchIndexPermissionFilterOption`, `PermissionFilter`.

**Knowledge base activity and reference types**:

- **WorkIQ**: `KnowledgeBaseWorkIQActivityRecord`, `KnowledgeBaseWorkIQActivityArguments`, `KnowledgeBaseWorkIQReference` (`WorkIQAttribution[]`), `WorkIQAttribution` (`seeMoreWebUrl`).
- **MCP Server**: `KnowledgeBaseMcpServerActivityRecord`, `KnowledgeBaseMcpServerActivityArguments` (`toolName`, `toolArguments`), `KnowledgeBaseMcpServerReference` (`toolName`, `title`).
- **LLM web summarization**: `KnowledgeBaseModelWebSummarizationActivityRecord` (`inputTokens`, `outputTokens`, `modelName`).
- **New enum values**: `modelWebSummarization`, `workIQ`, `fabricDataAgent`, `fabricOntology`, `mcpServer` → `KnowledgeBaseActivityRecordType`; `workIQ`, `fabricDataAgent`, `fabricOntology`, `mcpServer` → `KnowledgeBaseReferenceType`.

**Sensitivity label model**:

- `PurviewSensitivityLabelInfo` (replaces `SharePointSensitivityLabelInfo`): `displayName`, `sensitivityLabelId`, `toolTip`, `priority`, `color`, `isEncrypted`; added to `KnowledgeBaseSearchIndexReference`, `KnowledgeBaseAzureBlobReference`, and `KnowledgeBaseIndexedOneLakeReference`.

### Preview-to-Preview Changes (2025-11-01-preview → 2026-05-01-preview)

#### Non-Breaking Changes

All additive relative to this baseline: re-introduced items were restored with identical contracts; `SearchServiceCounters.knowledgeBasesCount` / `knowledgeSourcesCount` are new required fields on a response model (additive to clients); `SearchIndexerStatus.runtime` and `SearchServiceStatistics.indexersRuntime` were already required in 2025-11-01-preview and are unchanged.
All additive relative to this baseline: re-introduced items were restored with identical contracts; `SearchServiceCounters.knowledgeBasesCount` / `knowledgeSourcesCount` are new required fields on a response model (additive to clients); `SearchIndexerStatus.runtime` and `SearchServiceStatistics.indexersRuntime` were already required in 2025-11-01-preview and are unchanged.

---

## 2026-04-01 (GA)

**Summary**: Built on top of 2025-09-01 GA. First GA on the TypeSpec-unified `search.json` (migrated at 2025-11-01-preview); inherits that structure plus new features and refinements.
**Summary**: Built on top of 2025-09-01 GA. First GA on the TypeSpec-unified `search.json` (migrated at 2025-11-01-preview); inherits that structure plus new features and refinements.

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

**New skills and vectorizers**:

**New skills and vectorizers**:

- `ChatCompletionSkill` (#Microsoft.Skills.Custom.ChatCompletionSkill): calls a chat-completion model.
- `ContentUnderstandingSkill` (#Microsoft.Skills.Util.ContentUnderstandingSkill): Azure AI Content Understanding enrichment.

**New optional fields on existing models**:
**New optional fields on existing models**:

_Indexers / Data sources_
_Indexers / Data sources_

- `SearchIndexerDataSource`: `identity` (managed identity for data source authentication).
- `SearchIndexerKnowledgeStore`: `identity` (managed identity for knowledge store projections).

_Encryption_
_Encryption_

- `SearchResourceEncryptionKey.keyVaultKeyVersion`: changed from **required** to **optional**, aligning with actual service behavior. This property was modified as optional in the preview track since 2025-03-01-preview, but the fix was not applied to 2025-09-01 GA.

**Markdown parsing mode**:
**Markdown parsing mode**:

Native Markdown file parsing for blob indexers without requiring a separate skill:


- `BlobIndexerParsingMode`: new `markdown` enum value to enable Markdown parsing.
- `IndexingParametersConfiguration.markdownParsingSubmode`: controls document splitting — `oneToOne` (entire file becomes one document) or `oneToMany` (split by header sections).
- `IndexingParametersConfiguration.markdownHeaderDepth`: sets header depth for sectioning (`h1` through `h6`; default: `h6`).

**Knowledge base activity**:

**Knowledge base activity**:

- `KnowledgeBaseActivityRecordType`: new `modelWebSummarization` enum value for LLM web summarization activities, with corresponding `KnowledgeBaseModelWebSummarizationActivityRecord` model (`inputTokens`, `outputTokens`).

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
  - `KnowledgeSourceIngestionParameters`: `ingestionPermissionOptions` (array)
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
