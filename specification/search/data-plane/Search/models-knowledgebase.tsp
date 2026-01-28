import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models-service.tsp";
import "./models-shared.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Search;

/** The input contract for the retrieval request. */
model KnowledgeBaseRetrievalRequest {
  /** A list of chat message style input. */
  messages?: KnowledgeBaseMessage[];

  /** A list of intended queries to execute without model query planning. */
  intents?: KnowledgeRetrievalIntent[];

  /** The maximum runtime in seconds. */
  maxRuntimeInSeconds?: int32;

  /** Limits the maximum size of the content in the output. */
  maxOutputSize?: int32;

  /** The retrieval reasoning effort configuration. */
  retrievalReasoningEffort?: KnowledgeRetrievalReasoningEffort;

  /** Indicates retrieval results should include activity information. */
  includeActivity?: boolean;

  /** The output configuration for this retrieval. */
  outputMode?: KnowledgeRetrievalOutputMode;

  /** A list of runtime parameters for the knowledge sources. */
  knowledgeSourceParams?: KnowledgeSourceParams[];
}

/** The output contract for the retrieval response. */
model KnowledgeBaseRetrievalResponse {
  /** The response messages. */
  response?: KnowledgeBaseMessage[];

  /** The activity records for tracking progress and billing implications. */
  activity?: KnowledgeBaseActivityRecord[];

  /** The references for the retrieval data used in the response. */
  references?: KnowledgeBaseReference[];
}

/** Base type for reasoning effort. */
@discriminator("kind")
model KnowledgeRetrievalReasoningEffort {
  /** The kind of reasoning effort. */
  kind: KnowledgeRetrievalReasoningEffortKind;
}

/** Run knowledge retrieval with minimal reasoning effort. */
model KnowledgeRetrievalMinimalReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  /** The discriminator value. */
  kind: KnowledgeRetrievalReasoningEffortKind.minimal;
}

/** Run knowledge retrieval with low reasoning effort. */
model KnowledgeRetrievalLowReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  /** The discriminator value. */
  kind: KnowledgeRetrievalReasoningEffortKind.low;
}

/** Run knowledge retrieval with medium reasoning effort. */
model KnowledgeRetrievalMediumReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  /** The discriminator value. */
  kind: KnowledgeRetrievalReasoningEffortKind.medium;
}

/** The amount of effort to use during retrieval. */
union KnowledgeRetrievalReasoningEffortKind {
  string,

  /** Does not perform any source selections, query planning, or iterative search. */
  minimal: "minimal",

  /** Use low reasoning during retrieval. */
  low: "low",

  /** Use a moderate amount of reasoning during retrieval. */
  medium: "medium",
}

/** The output configuration for this retrieval. */
union KnowledgeRetrievalOutputMode {
  string,

  /** Return data from the knowledge sources directly without generative alteration. */
  extractiveData: "extractiveData",

  /** Synthesize an answer for the response payload. */
  answerSynthesis: "answerSynthesis",
}

/** Base type for knowledge source runtime parameters. */
@discriminator("kind")
model KnowledgeSourceParams {
  /** The name of the index the params apply to. */
  knowledgeSourceName: string;

  /** Indicates whether references should be included for data retrieved from this source. */
  includeReferences?: boolean;

  /** Indicates whether references should include the structured data obtained during retrieval in their payload. */
  includeReferenceSourceData?: boolean;

  /** Indicates that this knowledge source should bypass source selection and always be queried at retrieval time. */
  alwaysQuerySource?: boolean;

  /** The reranker threshold all retrieved documents must meet to be included in the response. */
  rerankerThreshold?: float32;

  /** The type of the knowledge source. */
  kind: KnowledgeSourceKind;
}

/** Specifies runtime parameters for a search index knowledge source */
model SearchIndexKnowledgeSourceParams extends KnowledgeSourceParams {
  /** The discriminator value. */
  kind: KnowledgeSourceKind.SearchIndex;

  /** A filter condition applied to the index (e.g., 'State eq VA'). */
  filterAddOn?: string;
}

/** Specifies runtime parameters for a azure blob knowledge source */
model AzureBlobKnowledgeSourceParams extends KnowledgeSourceParams {
  /** The discriminator value. */
  kind: KnowledgeSourceKind.AzureBlob;
}

/** Specifies which SharePoint libraries to access. */
union IndexedSharePointContainerName {
  string,

  /** Index content from the site's default document library. */
  DefaultSiteLibrary: "defaultSiteLibrary",

  /** Index content from every document library in the site. */
  AllSiteLibraries: "allSiteLibraries",

  /** Use a query to filter SharePoint content. */
  UseQuery: "useQuery",
}

/** Specifies runtime parameters for a indexed SharePoint knowledge source */
@removed(Versions.v2026_04_01)
model IndexedSharePointKnowledgeSourceParams extends KnowledgeSourceParams {
  /** The discriminator value. */
  kind: KnowledgeSourceKind.IndexedSharePoint;
}

/** Specifies runtime parameters for a indexed OneLake knowledge source */
model IndexedOneLakeKnowledgeSourceParams extends KnowledgeSourceParams {
  /** The discriminator value. */
  kind: KnowledgeSourceKind.IndexedOneLake;
}

/** Specifies runtime parameters for a web knowledge source */
model WebKnowledgeSourceParams extends KnowledgeSourceParams {
  /** The discriminator value. */
  kind: KnowledgeSourceKind.Web;

  /** The language of the web results. */
  language?: string;

  /** The market of the web results. */
  market?: string;

  /** The number of web results to return. */
  count?: int32;

  /** The freshness of web results. */
  freshness?: string;
}

/** Specifies runtime parameters for a remote SharePoint knowledge source */
@removed(Versions.v2026_04_01)
model RemoteSharePointKnowledgeSourceParams extends KnowledgeSourceParams {
  /** The discriminator value. */
  kind: KnowledgeSourceKind.RemoteSharePoint;

  /** A filter condition applied to the SharePoint data source. It must be specified in the Keyword Query Language syntax. It will be combined as a conjunction with the filter expression specified in the knowledge source definition. */
  filterExpressionAddOn?: string;
}

/** An intended query to execute without model query planning. */
@discriminator("type")
model KnowledgeRetrievalIntent {
  /** The type of the intent. */
  type: KnowledgeRetrievalIntentType;
}

/** The kind of knowledge base configuration to use. */
union KnowledgeRetrievalIntentType {
  string,

  /** A natural language semantic query intent. */
  semantic: "semantic",
}

/** A semantic query intent. */
model KnowledgeRetrievalSemanticIntent extends KnowledgeRetrievalIntent {
  /** The discriminator value. */
  type: KnowledgeRetrievalIntentType.semantic;

  /** The semantic query to execute */
  search: string;
}

/** The natural language message style object. */
model KnowledgeBaseMessage {
  /** The role of the tool response. */
  role?: string;

  /** The content of the message. */
  content: KnowledgeBaseMessageContent[];
}

/** Specifies the type of the message content. */
@discriminator("type")
model KnowledgeBaseMessageContent {
  /** The type of the message */
  type: KnowledgeBaseMessageContentType;
}

/** The type of message content. */
union KnowledgeBaseMessageContentType {
  string,

  /** Text message content kind. */
  text: "text",

  /** Image message content kind. */
  image: "image",
}

/** Text message type. */
model KnowledgeBaseMessageTextContent extends KnowledgeBaseMessageContent {
  /** The discriminator value. */
  type: KnowledgeBaseMessageContentType.text;

  /** The text content. */
  text: string;
}

/** Image message type. */
model KnowledgeBaseMessageImageContent extends KnowledgeBaseMessageContent {
  /** The discriminator value. */
  type: KnowledgeBaseMessageContentType.image;

  /** The image content. */
  image: KnowledgeBaseImageContent;
}

/** Image content. */
model KnowledgeBaseImageContent {
  /** The url of the image. */
  url: url;
}

/** The type of activity record. */
union KnowledgeBaseActivityRecordType {
  string,

  /** Search index retrieval activity. */
  searchIndex: "searchIndex",

  /** Azure Blob retrieval activity. */
  azureBlob: "azureBlob",

  /** Indexed SharePoint retrieval activity. */
  indexedSharePoint: "indexedSharePoint",

  /** Indexed OneLake retrieval activity. */
  indexedOneLake: "indexedOneLake",

  /** Web retrieval activity. */
  web: "web",

  /** Remote SharePoint retrieval activity. */
  remoteSharePoint: "remoteSharePoint",

  /** LLM query planning activity. */
  modelQueryPlanning: "modelQueryPlanning",

  /** LLM answer synthesis activity. */
  modelAnswerSynthesis: "modelAnswerSynthesis",

  /** Agentic reasoning activity. */
  agenticReasoning: "agenticReasoning",
}

/** Base type for activity records. Tracks execution details, timing, and errors for knowledge base operations. */
@discriminator("type")
model KnowledgeBaseActivityRecord {
  /** The ID of the activity record. */
  id: int32;

  /** The type of the activity record. */
  type: KnowledgeBaseActivityRecordType;

  /** The elapsed time in milliseconds for the retrieval activity. */
  elapsedMs?: int32;

  /** The error detail explaining why the operation failed. This property is only included when the activity does not succeed. */
  error?: KnowledgeBaseErrorDetail;
}

/** Represents a retrieval activity record. */
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Inherits typed discriminator from base"
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@discriminator("type")
model KnowledgeBaseRetrievalActivityRecord extends KnowledgeBaseActivityRecord {
  /** The knowledge source for the retrieval activity. */
  knowledgeSourceName?: string;

  /** The query time for this retrieval activity. */
  queryTime?: utcDateTime;

  /** The count of documents retrieved that were sufficiently relevant to pass the reranker threshold. */
  count?: int32;
}

/** Represents a search index retrieval activity record. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
#suppress "DISCRIMINATOR_VALUE_NOT_FOUND" "Multi-Level Discrimination"
model KnowledgeBaseSearchIndexActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.searchIndex;

  /** The search index arguments for the retrieval activity. */
  searchIndexArguments?: KnowledgeBaseSearchIndexActivityArguments;
}

/** Represents the arguments the search index retrieval activity was run with. */
model KnowledgeBaseSearchIndexActivityArguments {
  /** The search string used to query the search index. */
  search?: string;

  /** The filter string. */
  filter?: string;

  /** What fields were selected for search. */
  sourceDataFields?: SearchIndexFieldReference[];

  /** What fields were searched against. */
  searchFields?: SearchIndexFieldReference[];

  /** What semantic configuration was used from the search index. */
  semanticConfigurationName?: string;
}

/** Represents a azure blob retrieval activity record. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
#suppress "DISCRIMINATOR_VALUE_NOT_FOUND" "Multi-Level Discrimination"
model KnowledgeBaseAzureBlobActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.azureBlob;

  /** The azure blob arguments for the retrieval activity. */
  azureBlobArguments?: KnowledgeBaseAzureBlobActivityArguments;
}

/** Represents the arguments the azure blob retrieval activity was run with. */
model KnowledgeBaseAzureBlobActivityArguments {
  /** The search string used to query blob contents. */
  search?: string;
}

/** Represents a indexed SharePoint retrieval activity record. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
#suppress "DISCRIMINATOR_VALUE_NOT_FOUND" "Multi-Level Discrimination"
@removed(Versions.v2026_04_01)
model KnowledgeBaseIndexedSharePointActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.indexedSharePoint;

  /** The indexed SharePoint arguments for the retrieval activity. */
  indexedSharePointArguments?: KnowledgeBaseIndexedSharePointActivityArguments;
}

/** Represents the arguments the indexed SharePoint retrieval activity was run with. */
@removed(Versions.v2026_04_01)
model KnowledgeBaseIndexedSharePointActivityArguments {
  /** The search string used to query indexed SharePoint contents. */
  search?: string;
}

/** Represents a indexed OneLake retrieval activity record. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
#suppress "DISCRIMINATOR_VALUE_NOT_FOUND" "Multi-Level Discrimination"
model KnowledgeBaseIndexedOneLakeActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.indexedOneLake;

  /** The indexed OneLake arguments for the retrieval activity. */
  indexedOneLakeArguments?: KnowledgeBaseIndexedOneLakeActivityArguments;
}

/** Represents the arguments the indexed OneLake retrieval activity was run with. */
model KnowledgeBaseIndexedOneLakeActivityArguments {
  /** The search string used to query indexed OneLake contents. */
  search?: string;
}

/** Represents a web retrieval activity record. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
#suppress "DISCRIMINATOR_VALUE_NOT_FOUND" "Multi-Level Discrimination"
model KnowledgeBaseWebActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.web;

  /** The web arguments for the retrieval activity. */
  webArguments?: KnowledgeBaseWebActivityArguments;
}

/** Represents the arguments the web retrieval activity was run with. */
model KnowledgeBaseWebActivityArguments {
  /** The search string used to query the web. */
  search?: string;

  /** The language for the retrieval activity. */
  language?: string;

  /** The market for the retrieval activity. */
  market?: string;

  /** The number of web results returned. */
  count?: int32;

  /** The freshness for the retrieval activity. */
  freshness?: string;
}

/** Represents a remote SharePoint retrieval activity record. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
#suppress "DISCRIMINATOR_VALUE_NOT_FOUND" "Multi-Level Discrimination"
@removed(Versions.v2026_04_01)
model KnowledgeBaseRemoteSharePointActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.remoteSharePoint;

  /** The remote SharePoint arguments for the retrieval activity. */
  remoteSharePointArguments?: KnowledgeBaseRemoteSharePointActivityArguments;
}

/** Represents the arguments the remote SharePoint retrieval activity was run with. */
@removed(Versions.v2026_04_01)
model KnowledgeBaseRemoteSharePointActivityArguments {
  /** The search string used to query the remote SharePoint knowledge source. */
  search?: string;

  /** The filter expression add-on for the retrieval activity. */
  filterExpressionAddOn?: string;
}

/** Represents an LLM query planning activity record. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
model KnowledgeBaseModelQueryPlanningActivityRecord
  extends KnowledgeBaseActivityRecord {
  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.modelQueryPlanning;

  /** The number of input tokens for the LLM query planning activity. */
  inputTokens?: int32;

  /** The number of output tokens for the LLM query planning activity. */
  outputTokens?: int32;
}

/** Represents an LLM answer synthesis activity record. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
model KnowledgeBaseModelAnswerSynthesisActivityRecord
  extends KnowledgeBaseActivityRecord {
  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.modelAnswerSynthesis;

  /** The number of input tokens for the LLM answer synthesis activity. */
  inputTokens?: int32;

  /** The number of output tokens for the LLM answer synthesis activity. */
  outputTokens?: int32;
}

/** Represents an agentic reasoning activity record. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
model KnowledgeBaseAgenticReasoningActivityRecord
  extends KnowledgeBaseActivityRecord {
  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.agenticReasoning;

  /** The number of input tokens for agentic reasoning. */
  reasoningTokens?: int32;

  /** The retrieval reasoning effort configuration. */
  retrievalReasoningEffort?: KnowledgeRetrievalReasoningEffort;
}

/** The type of reference. */
union KnowledgeBaseReferenceType {
  string,

  /** Search index document reference. */
  searchIndex: "searchIndex",

  /** Azure Blob document reference. */
  azureBlob: "azureBlob",

  /** Indexed SharePoint document reference. */
  indexedSharePoint: "indexedSharePoint",

  /** Indexed OneLake document reference. */
  indexedOneLake: "indexedOneLake",

  /** Web document reference. */
  web: "web",

  /** Remote SharePoint document reference. */
  remoteSharePoint: "remoteSharePoint",
}

/** Base type for references. */
@discriminator("type")
model KnowledgeBaseReference {
  /** The type of the reference. */
  type: KnowledgeBaseReferenceType;

  /** The ID of the reference. */
  id: string;

  /** The source activity ID for the reference. */
  activitySource: int32;

  /** The source data for the reference. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Allows arbitrary JSON via additionalProperties: true."
  sourceData?: Record<unknown>;

  /** The reranker score for the document reference. */
  rerankerScore?: float32;
}

/** Represents an Azure Search document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
model KnowledgeBaseSearchIndexReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.searchIndex;

  /** The document key for the reference. */
  docKey?: string;
}

/** Represents an Azure Blob Storage document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
model KnowledgeBaseAzureBlobReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.azureBlob;

  /** The blob URL for the reference. */
  blobUrl?: string;
}

/** Represents an indexed SharePoint document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@removed(Versions.v2026_04_01)
model KnowledgeBaseIndexedSharePointReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.indexedSharePoint;

  /** The document URL for the reference. */
  docUrl?: string;
}

/** Represents an indexed OneLake document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
model KnowledgeBaseIndexedOneLakeReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.indexedOneLake;

  /** The document URL for the reference. */
  docUrl?: string;
}

/** Represents a web document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
model KnowledgeBaseWebReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.web;

  /** The url the reference data originated from. */
  url?: url;

  /** The title of the web document. */
  title?: string;
}

/** Represents a remote SharePoint document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@removed(Versions.v2026_04_01)
model KnowledgeBaseRemoteSharePointReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.remoteSharePoint;

  /** The url the reference data originated from. */
  webUrl?: url;

  /** Information about the sensitivity label applied to the SharePoint document. */
  searchSensitivityLabelInfo?: SharePointSensitivityLabelInfo;
}

/** Information about the sensitivity label applied to a SharePoint document. */
model SharePointSensitivityLabelInfo {
  /** The display name for the sensitivity label. */
  displayName?: string;

  /** The ID of the sensitivity label. */
  sensitivityLabelId?: string;

  /** The tooltip that should be displayed for the label in a UI. */
  tooltip?: string;

  /** The priority in which the sensitivity label is applied. */
  priority?: int32;

  /** The color that the UI should display for the label, if configured. */
  color?: string;

  /** Indicates whether the sensitivity label enforces encryption. */
  isEncrypted?: boolean;
}

/** The error details. */
model KnowledgeBaseErrorDetail {
  /** The error code. */
  @visibility(Lifecycle.Read)
  code?: string;

  /** The error message. */
  @visibility(Lifecycle.Read)
  message?: string;

  /** The error target. */
  @visibility(Lifecycle.Read)
  target?: string;

  /** The error details. */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  details?: KnowledgeBaseErrorDetail[];

  /** The error additional info. */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  additionalInfo?: KnowledgeBaseErrorAdditionalInfo[];
}

/** The resource management error additional info. */
model KnowledgeBaseErrorAdditionalInfo {
  /** The additional info type. */
  @visibility(Lifecycle.Read)
  type?: string;

  /** The additional info. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Allows arbitrary JSON via additionalProperties: true."
  @visibility(Lifecycle.Read)
  info?: Record<unknown>;
}

/** Successful retrieval response. */
model KnowledgeBaseRetrievalSuccessResponse {
  /** The retrieval response is successfully returned. */
  @statusCode
  code: 200;

  /** The retrieval response body. */
  @body
  body: KnowledgeBaseRetrievalResponse;
}

/** Partial retrieval response. */
model KnowledgeBaseRetrievalPartialResponse {
  /** A partial retrieval response is returned. */
  @statusCode
  code: 206;

  /** The partial retrieval response body. */
  @body
  body: KnowledgeBaseRetrievalResponse;
}

/** Parameters for AI Services. */
model AIServices {
  /** The URI of the AI Services endpoint. */
  uri: url;

  /** The API key for accessing AI Services. */
  apiKey?: string;
}

/** Optional content extraction mode. Default is 'minimal'. */
union KnowledgeSourceContentExtractionMode {
  string,

  /** Extracts only essential metadata while deferring most content processing. */
  Minimal: "minimal",

  /** Performs the full default content extraction pipeline. */
  Standard: "standard",
}

/** Permission types to ingest together with document content. */
union KnowledgeSourceIngestionPermissionOption {
  string,

  /** Ingest explicit user identifiers alongside document content. */
  UserIds: "userIds",

  /** Ingest group identifiers alongside document content. */
  GroupIds: "groupIds",

  /** Ingest RBAC scope information alongside document content. */
  RbacScope: "rbacScope",
}

/** Consolidates all general ingestion settings for knowledge sources. */
model KnowledgeSourceIngestionParameters {
  /** An explicit identity to use for this knowledge source. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  identity?: SearchIndexerDataIdentity | null;

  /** Optional vectorizer configuration for vectorizing content. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  embeddingModel?: KnowledgeSourceVectorizer | null;

  /** Optional chat completion model for image verbalization or context extraction. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  chatCompletionModel?: KnowledgeBaseModel | null;

  /** Indicates whether image verbalization should be disabled. Default is false. */
  disableImageVerbalization?: boolean = false;

  /** Optional schedule for data ingestion. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  ingestionSchedule?: IndexingSchedule | null;

  /** Optional list of permission types to ingest together with document content. If specified, it will set the indexer permission options for the data source. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  ingestionPermissionOptions?: KnowledgeSourceIngestionPermissionOption[] | null;

  /** Optional content extraction mode. Default is 'minimal'. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  contentExtractionMode?: KnowledgeSourceContentExtractionMode | null = KnowledgeSourceContentExtractionMode.Minimal;

  /** Optional AI Services configuration for content processing. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  aiServices?: AIServices | null;
}

/** Specifies the vectorization method to be used for knowledge source embedding model. */
@discriminator("kind")
model KnowledgeSourceVectorizer {
  /** The name of the kind of vectorization method being configured for use with vector search. */
  kind: VectorSearchVectorizerKind;
}

/** Specifies the Azure OpenAI resource used to vectorize a query string. */
model KnowledgeSourceAzureOpenAIVectorizer extends KnowledgeSourceVectorizer {
  /** The discriminator value. */
  kind: VectorSearchVectorizerKind.AzureOpenAI;

  /** Contains the parameters specific to Azure OpenAI embedding vectorization. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  azureOpenAIParameters?: AzureOpenAIVectorizerParameters;
}

/** The current synchronization status of the knowledge source. */
union KnowledgeSourceSynchronizationStatus {
  string,

  /** The knowledge source is being provisioned. */
  Creating: "creating",

  /** The knowledge source is active and synchronization runs are occurring. */
  Active: "active",

  /** The knowledge source is being deleted and synchronization is paused. */
  Deleting: "deleting",
}

/** Represents the status and synchronization history of a knowledge source. */
model KnowledgeSourceStatus {
  /** The current synchronization status. */
  synchronizationStatus: KnowledgeSourceSynchronizationStatus;

  /** The synchronization interval (e.g., '1d' for daily). Null if no schedule is configured. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  synchronizationInterval?: string | null;

  /** Current synchronization state that spans multiple indexer runs. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  currentSynchronizationState?: SynchronizationState | null;

  /** Details of the last completed synchronization. Null on first sync. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  lastSynchronizationState?: CompletedSynchronizationState | null;

  /** Statistical information about the knowledge source synchronization history. Null on first sync. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  statistics?: KnowledgeSourceStatistics | null;
}

/** Statistical information about knowledge source synchronization history. */
model KnowledgeSourceStatistics {
  /** Total number of synchronizations. */
  totalSynchronization: int32;

  /** Average synchronization duration in HH:MM:SS format. */
  averageSynchronizationDuration: string;

  /** Average items processed per synchronization. */
  averageItemsProcessedPerSynchronization: int32;
}

/** Represents the current state of an ongoing synchronization that spans multiple indexer runs. */
model SynchronizationState {
  /** The start time of the current synchronization. */
  startTime: utcDateTime;

  /** The number of item updates successfully processed in the current synchronization. */
  itemsUpdatesProcessed: int32;

  /** The number of item updates that failed in the current synchronization. */
  itemsUpdatesFailed: int32;

  /** The number of items skipped in the current synchronization. */
  itemsSkipped: int32;
}

/** Represents the completed state of the last synchronization. */
model CompletedSynchronizationState {
  /** The start time of the last completed synchronization. */
  startTime: utcDateTime;

  /** The end time of the last completed synchronization. */
  endTime: utcDateTime;

  /** The number of item updates successfully processed in the last synchronization. */
  itemsUpdatesProcessed: int32;

  /** The number of item updates that failed in the last synchronization. */
  itemsUpdatesFailed: int32;

  /** The number of items skipped in the last synchronization. */
  itemsSkipped: int32;
}
