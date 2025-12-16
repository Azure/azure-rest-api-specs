import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models-service.tsp";
import "./models-shared.tsp";

using TypeSpec.Http;
using Azure.ClientGenerator.Core.Legacy;

namespace Search;

@doc("The input contract for the retrieval request.")
model KnowledgeBaseRetrievalRequest {
  @doc("A list of chat message style input.")
  messages?: KnowledgeBaseMessage[];

  @doc("A list of intended queries to execute without model query planning.")
  intents?: KnowledgeRetrievalIntent[];

  @doc("The maximum runtime in seconds.")
  maxRuntimeInSeconds?: int32;

  @doc("Limits the maximum size of the content in the output.")
  maxOutputSize?: int32;

  @doc("The retrieval reasoning effort configuration.")
  retrievalReasoningEffort?: KnowledgeRetrievalReasoningEffort;

  @doc("Indicates retrieval results should include activity information.")
  includeActivity?: boolean;

  @doc("The output configuration for this retrieval.")
  outputMode?: KnowledgeRetrievalOutputMode;

  @doc("A list of runtime parameters for the knowledge sources.")
  knowledgeSourceParams?: KnowledgeSourceParams[];
}

@doc("The output contract for the retrieval response.")
model KnowledgeBaseRetrievalResponse {
  @doc("The response messages.")
  response?: KnowledgeBaseMessage[];

  @doc("The activity records for tracking progress and billing implications.")
  activity?: KnowledgeBaseActivityRecord[];

  @doc("The references for the retrieval data used in the response.")
  references?: KnowledgeBaseReference[];
}

@doc("Base type for reasoning effort.")
@discriminator("kind")
model KnowledgeRetrievalReasoningEffort {
  @doc("The kind of reasoning effort.")
  kind: KnowledgeRetrievalReasoningEffortKind;
}

@doc("Run knowledge retrieval with minimal reasoning effort.")
model KnowledgeRetrievalMinimalReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  @doc("The discriminator value.")
  kind: KnowledgeRetrievalReasoningEffortKind.minimal;
}

@doc("Run knowledge retrieval with low reasoning effort.")
model KnowledgeRetrievalLowReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  @doc("The discriminator value.")
  kind: KnowledgeRetrievalReasoningEffortKind.low;
}

@doc("Run knowledge retrieval with medium reasoning effort.")
model KnowledgeRetrievalMediumReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  @doc("The discriminator value.")
  kind: KnowledgeRetrievalReasoningEffortKind.medium;
}

@doc("The amount of effort to use during retrieval.")
union KnowledgeRetrievalReasoningEffortKind {
  string,

  @doc("Does not perform any source selections, query planning, or iterative search.")
  minimal: "minimal",

  @doc("Use low reasoning during retrieval.")
  low: "low",

  @doc("Use a moderate amount of reasoning during retrieval.")
  medium: "medium",
}

@doc("The output configuration for this retrieval.")
union KnowledgeRetrievalOutputMode {
  string,

  @doc("Return data from the knowledge sources directly without generative alteration.")
  extractiveData: "extractiveData",

  @doc("Synthesize an answer for the response payload.")
  answerSynthesis: "answerSynthesis",
}

@doc("Base type for knowledge source runtime parameters.")
@discriminator("kind")
model KnowledgeSourceParams {
  @doc("The name of the index the params apply to.")
  knowledgeSourceName: string;

  @doc("Indicates whether references should be included for data retrieved from this source.")
  includeReferences?: boolean;

  @doc("Indicates whether references should include the structured data obtained during retrieval in their payload.")
  includeReferenceSourceData?: boolean;

  @doc("Indicates that this knowledge source should bypass source selection and always be queried at retrieval time.")
  alwaysQuerySource?: boolean;

  @doc("The reranker threshold all retrieved documents must meet to be included in the response.")
  rerankerThreshold?: float32;

  @doc("The type of the knowledge source.")
  kind: KnowledgeSourceKind;
}

@doc("Specifies runtime parameters for a search index knowledge source")
model SearchIndexKnowledgeSourceParams extends KnowledgeSourceParams {
  @doc("The discriminator value.")
  kind: KnowledgeSourceKind.SearchIndex;

  @doc("A filter condition applied to the index (e.g., 'State eq VA').")
  filterAddOn?: string;
}

@doc("Specifies runtime parameters for a azure blob knowledge source")
model AzureBlobKnowledgeSourceParams extends KnowledgeSourceParams {
  @doc("The discriminator value.")
  kind: KnowledgeSourceKind.AzureBlob;
}

@doc("Specifies which SharePoint libraries to access.")
union IndexedSharePointContainerName {
  string,

  @doc("Index content from the site's default document library.")
  DefaultSiteLibrary: "defaultSiteLibrary",

  @doc("Index content from every document library in the site.")
  AllSiteLibraries: "allSiteLibraries",

  @doc("Use a query to filter SharePoint content.")
  UseQuery: "useQuery",
}

@doc("Specifies runtime parameters for a indexed SharePoint knowledge source")
model IndexedSharePointKnowledgeSourceParams extends KnowledgeSourceParams {
  @doc("The discriminator value.")
  kind: KnowledgeSourceKind.IndexedSharePoint;
}

@doc("Specifies runtime parameters for a indexed OneLake knowledge source")
model IndexedOneLakeKnowledgeSourceParams extends KnowledgeSourceParams {
  @doc("The discriminator value.")
  kind: KnowledgeSourceKind.IndexedOneLake;
}

@doc("Specifies runtime parameters for a web knowledge source")
model WebKnowledgeSourceParams extends KnowledgeSourceParams {
  @doc("The discriminator value.")
  kind: KnowledgeSourceKind.Web;

  @doc("The language of the web results.")
  language?: string;

  @doc("The market of the web results.")
  market?: string;

  @doc("The number of web results to return.")
  count?: int32;

  @doc("The freshness of web results.")
  freshness?: string;
}

@doc("Specifies runtime parameters for a remote SharePoint knowledge source")
model RemoteSharePointKnowledgeSourceParams extends KnowledgeSourceParams {
  @doc("The discriminator value.")
  kind: KnowledgeSourceKind.RemoteSharePoint;

  @doc("A filter condition applied to the SharePoint data source. It must be specified in the Keyword Query Language syntax. It will be combined as a conjunction with the filter expression specified in the knowledge source definition.")
  filterExpressionAddOn?: string;
}

@doc("An intended query to execute without model query planning.")
@discriminator("type")
model KnowledgeRetrievalIntent {
  @doc("The type of the intent.")
  type: KnowledgeRetrievalIntentType;
}

@doc("The kind of knowledge base configuration to use.")
union KnowledgeRetrievalIntentType {
  string,

  @doc("A natural language semantic query intent.")
  semantic: "semantic",
}

@doc("A semantic query intent.")
model KnowledgeRetrievalSemanticIntent extends KnowledgeRetrievalIntent {
  @doc("The discriminator value.")
  type: KnowledgeRetrievalIntentType.semantic;

  @doc("The semantic query to execute")
  search: string;
}

@doc("The natural language message style object.")
model KnowledgeBaseMessage {
  @doc("The role of the tool response.")
  role?: string;

  @doc("The content of the message.")
  content: KnowledgeBaseMessageContent[];
}

@doc("Specifies the type of the message content.")
@discriminator("type")
model KnowledgeBaseMessageContent {
  @doc("The type of the message")
  type: KnowledgeBaseMessageContentType;
}

@doc("The type of message content.")
union KnowledgeBaseMessageContentType {
  string,

  @doc("Text message content kind.")
  text: "text",

  @doc("Image message content kind.")
  image: "image",
}

@doc("Text message type.")
model KnowledgeBaseMessageTextContent extends KnowledgeBaseMessageContent {
  @doc("The discriminator value.")
  type: KnowledgeBaseMessageContentType.text;

  @doc("The text content.")
  text: string;
}

@doc("Image message type.")
model KnowledgeBaseMessageImageContent extends KnowledgeBaseMessageContent {
  @doc("The discriminator value.")
  type: KnowledgeBaseMessageContentType.image;

  @doc("The image content.")
  image: KnowledgeBaseImageContent;
}

@doc("Image content.")
model KnowledgeBaseImageContent {
  @doc("The url of the image.")
  url: url;
}

@doc("The type of activity record.")
union KnowledgeBaseActivityRecordType {
  string,

  @doc("Search index retrieval activity.")
  searchIndex: "searchIndex",

  @doc("Azure Blob retrieval activity.")
  azureBlob: "azureBlob",

  @doc("Indexed SharePoint retrieval activity.")
  indexedSharePoint: "indexedSharePoint",

  @doc("Indexed OneLake retrieval activity.")
  indexedOneLake: "indexedOneLake",

  @doc("Web retrieval activity.")
  web: "web",

  @doc("Remote SharePoint retrieval activity.")
  remoteSharePoint: "remoteSharePoint",

  @doc("LLM query planning activity.")
  modelQueryPlanning: "modelQueryPlanning",

  @doc("LLM answer synthesis activity.")
  modelAnswerSynthesis: "modelAnswerSynthesis",

  @doc("Agentic reasoning activity.")
  agenticReasoning: "agenticReasoning",
}

@doc("Base type for activity records. Tracks execution details, timing, and errors for knowledge base operations.")
@discriminator("type")
model KnowledgeBaseActivityRecord {
  @doc("The ID of the activity record.")
  id: int32;

  @doc("The type of the activity record.")
  type: KnowledgeBaseActivityRecordType;

  @doc("The elapsed time in milliseconds for the retrieval activity.")
  elapsedMs?: int32;

  @doc("The error detail explaining why the operation failed. This property is only included when the activity does not succeed.")
  error?: KnowledgeBaseErrorDetail;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Inherits typed discriminator from base"
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents a retrieval activity record.")
@discriminator("type")
model KnowledgeBaseRetrievalActivityRecord extends KnowledgeBaseActivityRecord {
  @doc("The knowledge source for the retrieval activity.")
  knowledgeSourceName?: string;

  @doc("The query time for this retrieval activity.")
  queryTime?: utcDateTime;

  @doc("The count of documents retrieved that were sufficiently relevant to pass the reranker threshold.")
  count?: int32;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
#suppress "DISCRIMINATOR_VALUE_NOT_FOUND" "Multi-Level Discrimination"
@doc("Represents a search index retrieval activity record.")
model KnowledgeBaseSearchIndexActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  @doc("The discriminator value.")
  type: KnowledgeBaseActivityRecordType.searchIndex;

  @doc("The search index arguments for the retrieval activity.")
  searchIndexArguments?: KnowledgeBaseSearchIndexActivityArguments;
}

@doc("Represents the arguments the search index retrieval activity was run with.")
model KnowledgeBaseSearchIndexActivityArguments {
  @doc("The search string used to query the search index.")
  search?: string;

  @doc("The filter string.")
  filter?: string;

  @doc("What fields were selected for search.")
  sourceDataFields?: SearchIndexFieldReference[];

  @doc("What fields were searched against.")
  searchFields?: SearchIndexFieldReference[];

  @doc("What semantic configuration was used from the search index.")
  semanticConfigurationName?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
#suppress "DISCRIMINATOR_VALUE_NOT_FOUND" "Multi-Level Discrimination"
@doc("Represents a azure blob retrieval activity record.")
model KnowledgeBaseAzureBlobActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  @doc("The discriminator value.")
  type: KnowledgeBaseActivityRecordType.azureBlob;

  @doc("The azure blob arguments for the retrieval activity.")
  azureBlobArguments?: KnowledgeBaseAzureBlobActivityArguments;
}

@doc("Represents the arguments the azure blob retrieval activity was run with.")
model KnowledgeBaseAzureBlobActivityArguments {
  @doc("The search string used to query blob contents.")
  search?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
#suppress "DISCRIMINATOR_VALUE_NOT_FOUND" "Multi-Level Discrimination"
@doc("Represents a indexed SharePoint retrieval activity record.")
model KnowledgeBaseIndexedSharePointActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  @doc("The discriminator value.")
  type: KnowledgeBaseActivityRecordType.indexedSharePoint;

  @doc("The indexed SharePoint arguments for the retrieval activity.")
  indexedSharePointArguments?: KnowledgeBaseIndexedSharePointActivityArguments;
}

@doc("Represents the arguments the indexed SharePoint retrieval activity was run with.")
model KnowledgeBaseIndexedSharePointActivityArguments {
  @doc("The search string used to query indexed SharePoint contents.")
  search?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
#suppress "DISCRIMINATOR_VALUE_NOT_FOUND" "Multi-Level Discrimination"
@doc("Represents a indexed OneLake retrieval activity record.")
model KnowledgeBaseIndexedOneLakeActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  @doc("The discriminator value.")
  type: KnowledgeBaseActivityRecordType.indexedOneLake;

  @doc("The indexed OneLake arguments for the retrieval activity.")
  indexedOneLakeArguments?: KnowledgeBaseIndexedOneLakeActivityArguments;
}

@doc("Represents the arguments the indexed OneLake retrieval activity was run with.")
model KnowledgeBaseIndexedOneLakeActivityArguments {
  @doc("The search string used to query indexed OneLake contents.")
  search?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
#suppress "DISCRIMINATOR_VALUE_NOT_FOUND" "Multi-Level Discrimination"
@doc("Represents a web retrieval activity record.")
model KnowledgeBaseWebActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  @doc("The discriminator value.")
  type: KnowledgeBaseActivityRecordType.web;

  @doc("The web arguments for the retrieval activity.")
  webArguments?: KnowledgeBaseWebActivityArguments;
}

@doc("Represents the arguments the web retrieval activity was run with.")
model KnowledgeBaseWebActivityArguments {
  @doc("The search string used to query the web.")
  search?: string;

  @doc("The language for the retrieval activity.")
  language?: string;

  @doc("The market for the retrieval activity.")
  market?: string;

  @doc("The number of web results returned.")
  count?: int32;

  @doc("The freshness for the retrieval activity.")
  freshness?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
#suppress "DISCRIMINATOR_VALUE_NOT_FOUND" "Multi-Level Discrimination"
@doc("Represents a remote SharePoint retrieval activity record.")
model KnowledgeBaseRemoteSharePointActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  @doc("The discriminator value.")
  type: KnowledgeBaseActivityRecordType.remoteSharePoint;

  @doc("The remote SharePoint arguments for the retrieval activity.")
  remoteSharePointArguments?: KnowledgeBaseRemoteSharePointActivityArguments;
}

@doc("Represents the arguments the remote SharePoint retrieval activity was run with.")
model KnowledgeBaseRemoteSharePointActivityArguments {
  @doc("The search string used to query the remote SharePoint knowledge source.")
  search?: string;

  @doc("The filter expression add-on for the retrieval activity.")
  filterExpressionAddOn?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents an LLM query planning activity record.")
model KnowledgeBaseModelQueryPlanningActivityRecord
  extends KnowledgeBaseActivityRecord {
  @doc("The discriminator value.")
  type: KnowledgeBaseActivityRecordType.modelQueryPlanning;

  @doc("The number of input tokens for the LLM query planning activity.")
  inputTokens?: int32;

  @doc("The number of output tokens for the LLM query planning activity.")
  outputTokens?: int32;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents an LLM answer synthesis activity record.")
model KnowledgeBaseModelAnswerSynthesisActivityRecord
  extends KnowledgeBaseActivityRecord {
  @doc("The discriminator value.")
  type: KnowledgeBaseActivityRecordType.modelAnswerSynthesis;

  @doc("The number of input tokens for the LLM answer synthesis activity.")
  inputTokens?: int32;

  @doc("The number of output tokens for the LLM answer synthesis activity.")
  outputTokens?: int32;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents an agentic reasoning activity record.")
model KnowledgeBaseAgenticReasoningActivityRecord
  extends KnowledgeBaseActivityRecord {
  @doc("The discriminator value.")
  type: KnowledgeBaseActivityRecordType.agenticReasoning;

  @doc("The number of input tokens for agentic reasoning.")
  reasoningTokens?: int32;

  @doc("The retrieval reasoning effort configuration.")
  retrievalReasoningEffort?: KnowledgeRetrievalReasoningEffort;
}

@doc("The type of reference.")
union KnowledgeBaseReferenceType {
  string,

  @doc("Search index document reference.")
  searchIndex: "searchIndex",

  @doc("Azure Blob document reference.")
  azureBlob: "azureBlob",

  @doc("Indexed SharePoint document reference.")
  indexedSharePoint: "indexedSharePoint",

  @doc("Indexed OneLake document reference.")
  indexedOneLake: "indexedOneLake",

  @doc("Web document reference.")
  web: "web",

  @doc("Remote SharePoint document reference.")
  remoteSharePoint: "remoteSharePoint",
}

@doc("Base type for references.")
@discriminator("type")
model KnowledgeBaseReference {
  @doc("The type of the reference.")
  type: KnowledgeBaseReferenceType;

  @doc("The ID of the reference.")
  id: string;

  @doc("The source activity ID for the reference.")
  activitySource: int32;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Allows arbitrary JSON via additionalProperties: true."
  @doc("The source data for the reference.")
  sourceData?: Record<unknown>;

  @doc("The reranker score for the document reference.")
  rerankerScore?: float32;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents an Azure Search document reference.")
model KnowledgeBaseSearchIndexReference extends KnowledgeBaseReference {
  @doc("The discriminator value.")
  type: KnowledgeBaseReferenceType.searchIndex;

  @doc("The document key for the reference.")
  docKey?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents an Azure Blob Storage document reference.")
model KnowledgeBaseAzureBlobReference extends KnowledgeBaseReference {
  @doc("The discriminator value.")
  type: KnowledgeBaseReferenceType.azureBlob;

  @doc("The blob URL for the reference.")
  blobUrl?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents an indexed SharePoint document reference.")
model KnowledgeBaseIndexedSharePointReference extends KnowledgeBaseReference {
  @doc("The discriminator value.")
  type: KnowledgeBaseReferenceType.indexedSharePoint;

  @doc("The document URL for the reference.")
  docUrl?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents an indexed OneLake document reference.")
model KnowledgeBaseIndexedOneLakeReference extends KnowledgeBaseReference {
  @doc("The discriminator value.")
  type: KnowledgeBaseReferenceType.indexedOneLake;

  @doc("The document URL for the reference.")
  docUrl?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents a web document reference.")
model KnowledgeBaseWebReference extends KnowledgeBaseReference {
  @doc("The discriminator value.")
  type: KnowledgeBaseReferenceType.web;

  @doc("The url the reference data originated from.")
  url?: url;

  @doc("The title of the web document.")
  title?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents a remote SharePoint document reference.")
model KnowledgeBaseRemoteSharePointReference extends KnowledgeBaseReference {
  @doc("The discriminator value.")
  type: KnowledgeBaseReferenceType.remoteSharePoint;

  @doc("The url the reference data originated from.")
  webUrl?: url;

  @doc("Information about the sensitivity label applied to the SharePoint document.")
  searchSensitivityLabelInfo?: SharePointSensitivityLabelInfo;
}

@doc("Information about the sensitivity label applied to a SharePoint document.")
model SharePointSensitivityLabelInfo {
  @doc("The display name for the sensitivity label.")
  displayName?: string;

  @doc("The ID of the sensitivity label.")
  sensitivityLabelId?: string;

  @doc("The tooltip that should be displayed for the label in a UI.")
  tooltip?: string;

  @doc("The priority in which the sensitivity label is applied.")
  priority?: int32;

  @doc("The color that the UI should display for the label, if configured.")
  color?: string;

  @doc("Indicates whether the sensitivity label enforces encryption.")
  isEncrypted?: boolean;
}

@doc("The error details.")
model KnowledgeBaseErrorDetail {
  @doc("The error code.")
  @visibility(Lifecycle.Read)
  code?: string;

  @doc("The error message.")
  @visibility(Lifecycle.Read)
  message?: string;

  @doc("The error target.")
  @visibility(Lifecycle.Read)
  target?: string;

  @doc("The error details.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  details?: KnowledgeBaseErrorDetail[];

  @doc("The error additional info.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  additionalInfo?: KnowledgeBaseErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model KnowledgeBaseErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility(Lifecycle.Read)
  type?: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Allows arbitrary JSON via additionalProperties: true."
  @doc("The additional info.")
  @visibility(Lifecycle.Read)
  info?: Record<unknown>;
}

@doc("Successful retrieval response.")
model KnowledgeBaseRetrievalSuccessResponse {
  @doc("The retrieval response is successfully returned.")
  @statusCode
  code: 200;

  @doc("The retrieval response body.")
  @body
  body: KnowledgeBaseRetrievalResponse;
}

@doc("Partial retrieval response.")
model KnowledgeBaseRetrievalPartialResponse {
  @doc("A partial retrieval response is returned.")
  @statusCode
  code: 206;

  @doc("The partial retrieval response body.")
  @body
  body: KnowledgeBaseRetrievalResponse;
}

@doc("Parameters for AI Services.")
model AIServices {
  @doc("The URI of the AI Services endpoint.")
  uri: url;

  @doc("The API key for accessing AI Services.")
  apiKey?: string;
}

@doc("Optional content extraction mode. Default is 'minimal'.")
union KnowledgeSourceContentExtractionMode {
  string,

  @doc("Extracts only essential metadata while deferring most content processing.")
  Minimal: "minimal",

  @doc("Performs the full default content extraction pipeline.")
  Standard: "standard",
}

@doc("Permission types to ingest together with document content.")
union KnowledgeSourceIngestionPermissionOption {
  string,

  @doc("Ingest explicit user identifiers alongside document content.")
  UserIds: "userIds",

  @doc("Ingest group identifiers alongside document content.")
  GroupIds: "groupIds",

  @doc("Ingest RBAC scope information alongside document content.")
  RbacScope: "rbacScope",
}

@doc("Consolidates all general ingestion settings for knowledge sources.")
model KnowledgeSourceIngestionParameters {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("An explicit identity to use for this knowledge source.")
  identity?: SearchIndexerDataIdentity | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Optional vectorizer configuration for vectorizing content.")
  embeddingModel?: KnowledgeSourceVectorizer | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Optional chat completion model for image verbalization or context extraction.")
  chatCompletionModel?: KnowledgeBaseModel | null;

  @doc("Indicates whether image verbalization should be disabled. Default is false.")
  disableImageVerbalization?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Optional schedule for data ingestion.")
  ingestionSchedule?: IndexingSchedule | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Optional list of permission types to ingest together with document content. If specified, it will set the indexer permission options for the data source.")
  ingestionPermissionOptions?: KnowledgeSourceIngestionPermissionOption[] | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Optional content extraction mode. Default is 'minimal'.")
  contentExtractionMode?: KnowledgeSourceContentExtractionMode | null = KnowledgeSourceContentExtractionMode.Minimal;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Optional AI Services configuration for content processing.")
  aiServices?: AIServices | null;
}

@doc("Specifies the vectorization method to be used for knowledge source embedding model.")
@discriminator("kind")
model KnowledgeSourceVectorizer {
  @doc("The name of the kind of vectorization method being configured for use with vector search.")
  kind: VectorSearchVectorizerKind;
}

@doc("Specifies the Azure OpenAI resource used to vectorize a query string.")
model KnowledgeSourceAzureOpenAIVectorizer extends KnowledgeSourceVectorizer {
  @doc("The discriminator value.")
  kind: VectorSearchVectorizerKind.AzureOpenAI;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Maintain compatibility with existing models."
  @doc("Contains the parameters specific to Azure OpenAI embedding vectorization.")
  azureOpenAIParameters?: AzureOpenAIVectorizerParameters;
}

@doc("The current synchronization status of the knowledge source.")
union KnowledgeSourceSynchronizationStatus {
  string,

  @doc("The knowledge source is being provisioned.")
  Creating: "creating",

  @doc("The knowledge source is active and synchronization runs are occurring.")
  Active: "active",

  @doc("The knowledge source is being deleted and synchronization is paused.")
  Deleting: "deleting",
}

@doc("Represents the status and synchronization history of a knowledge source.")
model KnowledgeSourceStatus {
  @doc("The current synchronization status.")
  synchronizationStatus: KnowledgeSourceSynchronizationStatus;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("The synchronization interval (e.g., '1d' for daily). Null if no schedule is configured.")
  synchronizationInterval?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Current synchronization state that spans multiple indexer runs.")
  currentSynchronizationState?: SynchronizationState | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Details of the last completed synchronization. Null on first sync.")
  lastSynchronizationState?: CompletedSynchronizationState | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  @doc("Statistical information about the knowledge source synchronization history. Null on first sync.")
  statistics?: KnowledgeSourceStatistics | null;
}

@doc("Statistical information about knowledge source synchronization history.")
model KnowledgeSourceStatistics {
  @doc("Total number of synchronizations.")
  totalSynchronization: int32;

  @doc("Average synchronization duration in HH:MM:SS format.")
  averageSynchronizationDuration: string;

  @doc("Average items processed per synchronization.")
  averageItemsProcessedPerSynchronization: int32;
}

@doc("Represents the current state of an ongoing synchronization that spans multiple indexer runs.")
model SynchronizationState {
  @doc("The start time of the current synchronization.")
  startTime: utcDateTime;

  @doc("The number of item updates successfully processed in the current synchronization.")
  itemsUpdatesProcessed: int32;

  @doc("The number of item updates that failed in the current synchronization.")
  itemsUpdatesFailed: int32;

  @doc("The number of items skipped in the current synchronization.")
  itemsSkipped: int32;
}

@doc("Represents the completed state of the last synchronization.")
model CompletedSynchronizationState {
  @doc("The start time of the last completed synchronization.")
  startTime: utcDateTime;

  @doc("The end time of the last completed synchronization.")
  endTime: utcDateTime;

  @doc("The number of item updates successfully processed in the last synchronization.")
  itemsUpdatesProcessed: int32;

  @doc("The number of item updates that failed in the last synchronization.")
  itemsUpdatesFailed: int32;

  @doc("The number of items skipped in the last synchronization.")
  itemsSkipped: int32;
}
