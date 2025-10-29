import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models-service.tsp";
import "./models-shared.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Search;

@doc("The input contract for the retrieval request.")
@added(Versions.v2025_11_01_preview)
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
@added(Versions.v2025_11_01_preview)
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
@added(Versions.v2025_11_01_preview)
model KnowledgeRetrievalReasoningEffort {
  @doc("The kind of reasoning effort.")
  kind: KnowledgeRetrievalReasoningEffortKind;
}

@doc("Run knowledge retrieval with minimal reasoning effort.")
@added(Versions.v2025_11_01_preview)
model KnowledgeRetrievalMinimalReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  @doc("The discriminator value.")
  kind: KnowledgeRetrievalReasoningEffortKind.minimal;
}

@doc("Run knowledge retrieval with low reasoning effort.")
@added(Versions.v2025_11_01_preview)
model KnowledgeRetrievalLowReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  @doc("The discriminator value.")
  kind: KnowledgeRetrievalReasoningEffortKind.low;
}

@doc("Run knowledge retrieval with medium reasoning effort.")
@added(Versions.v2025_11_01_preview)
model KnowledgeRetrievalMediumReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  @doc("The discriminator value.")
  kind: KnowledgeRetrievalReasoningEffortKind.medium;
}

@doc("Run knowledge retrieval with high reasoning effort.")
@added(Versions.v2025_11_01_preview)
model KnowledgeRetrievalHighReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  @doc("The discriminator value.")
  kind: KnowledgeRetrievalReasoningEffortKind.high;
}

@doc("The amount of effort to use during retrieval.")
@added(Versions.v2025_11_01_preview)
union KnowledgeRetrievalReasoningEffortKind {
  string,

  @doc("Does not perform any source selections, any query planning, or any iterative search.")
  minimal: "minimal",

  @doc("Use low reasoning during retrieval.")
  low: "low",

  @doc("Use a moderate amount of reasoning during retrieval.")
  medium: "medium",

  @doc("Use a high amount of reasoning during retrieval.")
  high: "high",
}

@doc("The output configuration for this retrieval.")
@added(Versions.v2025_11_01_preview)
union KnowledgeRetrievalOutputMode {
  string,

  @doc("Return data from the knowledge sources directly without generative alteration.")
  extractiveData: "extractiveData",

  @doc("Synthesize an answer for the response payload.")
  answerSynthesis: "answerSynthesis",
}

@doc("Base type for knowledge source runtime parameters.")
@discriminator("kind")
@added(Versions.v2025_11_01_preview)
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
@added(Versions.v2025_11_01_preview)
model SearchIndexKnowledgeSourceParams extends KnowledgeSourceParams {
  @doc("The discriminator value.")
  kind: KnowledgeSourceKind.SearchIndex;

  @doc("A filter condition applied to the index (e.g., 'State eq VA').")
  filterAddOn?: string;
}

@doc("Specifies runtime parameters for a azure blob knowledge source")
@added(Versions.v2025_11_01_preview)
model AzureBlobKnowledgeSourceParams extends KnowledgeSourceParams {
  @doc("The discriminator value.")
  kind: KnowledgeSourceKind.AzureBlob;
}

@doc("Specifies runtime parameters for a indexed SharePoint knowledge source")
@added(Versions.v2025_11_01_preview)
model IndexedSharePointKnowledgeSourceParams extends KnowledgeSourceParams {
  @doc("The discriminator value.")
  kind: KnowledgeSourceKind.IndexedSharePoint;
}

@doc("Specifies runtime parameters for a indexed OneLake knowledge source")
@added(Versions.v2025_11_01_preview)
model IndexedOneLakeKnowledgeSourceParams extends KnowledgeSourceParams {
  @doc("The discriminator value.")
  kind: KnowledgeSourceKind.IndexedOneLake;
}

@doc("Specifies runtime parameters for a web knowledge source")
@added(Versions.v2025_11_01_preview)
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
@added(Versions.v2025_11_01_preview)
model RemoteSharePointKnowledgeSourceParams extends KnowledgeSourceParams {
  @doc("The discriminator value.")
  kind: KnowledgeSourceKind.RemoteSharePoint;

  @doc("A filter condition applied to the SharePoint data source. It must be specified in the Keyword Query Language syntax. It will be combined as a conjunction with the filter expression specified in the knowledge source definition.")
  filterExpressionAddOn?: string;
}

@doc("An intended query to execute without model query planning.")
@discriminator("type")
@added(Versions.v2025_11_01_preview)
model KnowledgeRetrievalIntent {
  @doc("The type of the intent.")
  type: KnowledgeRetrievalIntentType;
}

@doc("The kind of knowledge base configuration to use.")
@added(Versions.v2025_11_01_preview)
union KnowledgeRetrievalIntentType {
  string,

  @doc("A natural language semantic query intent.")
  semantic: "semantic",
}

@doc("A semantic query intent.")
@added(Versions.v2025_11_01_preview)
model KnowledgeRetrievalSemanticIntent extends KnowledgeRetrievalIntent {
  @doc("The discriminator value.")
  type: KnowledgeRetrievalIntentType.semantic;

  @doc("The semantic query to execute")
  search: string;
}

@doc("The natural language message style object.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseMessage {
  @doc("The role of the tool response.")
  role?: string;

  @doc("The content of the message.")
  content: KnowledgeBaseMessageContent[];
}

@doc("Specifies the type of the message content.")
@discriminator("type")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseMessageContent {
  @doc("The type of the message")
  type: KnowledgeBaseMessageContentType;
}

@doc("The type of message content.")
@added(Versions.v2025_11_01_preview)
union KnowledgeBaseMessageContentType {
  string,

  @doc("Text message content kind.")
  text: "text",

  @doc("Image message content kind.")
  image: "image",
}

@doc("Text message type.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseMessageTextContent extends KnowledgeBaseMessageContent {
  @doc("The discriminator value.")
  type: KnowledgeBaseMessageContentType.text;

  @doc("The text content.")
  text: string;
}

@doc("Image message type.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseMessageImageContent extends KnowledgeBaseMessageContent {
  @doc("The discriminator value.")
  type: KnowledgeBaseMessageContentType.image;

  @doc("The image content.")
  image: KnowledgeBaseImageContent;
}

@doc("Image content.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseImageContent {
  @doc("The url of the image.")
  url: url;
}

@doc("Base type for activity records.")
@discriminator("type")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseActivityRecord {
  @doc("The ID of the activity record.")
  id: int32;

  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The type of the activity record.")
  type: string;

  @doc("The elapsed time in milliseconds for the retrieval activity.")
  elapsedMs?: int32;

  @doc("The error detail explaining why the operation failed. This property is only included when the activity does not succeed.")
  error?: KnowledgeBaseErrorDetail;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents a retrieval activity record.")
@added(Versions.v2025_11_01_preview)
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
@doc("Represents a search index retrieval activity record.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseSearchIndexActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  @doc("The discriminator value.")
  type: "searchIndex";

  @doc("The search index arguments for the retrieval activity.")
  searchIndexArguments?: KnowledgeBaseSearchIndexActivityArguments;
}

@doc("Represents the arguments the search index retrieval activity was run with.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseSearchIndexActivityArguments {
  @doc("The search string used to query the search index.")
  search?: string;

  @doc("The filter string.")
  filter?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents a azure blob retrieval activity record.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseAzureBlobActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  @doc("The discriminator value.")
  type: "azureBlob";

  @doc("The azure blob arguments for the retrieval activity.")
  azureBlobArguments?: KnowledgeBaseAzureBlobActivityArguments;
}

@doc("Represents the arguments the azure blob retrieval activity was run with.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseAzureBlobActivityArguments {
  @doc("The search string used to query blob contents.")
  search?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents a indexed SharePoint retrieval activity record.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseIndexedSharePointActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  @doc("The discriminator value.")
  type: "indexedSharePoint";

  @doc("The indexed SharePoint arguments for the retrieval activity.")
  indexedSharePointArguments?: KnowledgeBaseIndexedSharePointActivityArguments;
}

@doc("Represents the arguments the indexed SharePoint retrieval activity was run with.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseIndexedSharePointActivityArguments {
  @doc("The search string used to query indexed SharePoint contents.")
  search?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents a indexed OneLake retrieval activity record.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseIndexedOneLakeActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The discriminator value.")
  type: "indexedOneLake";

  @doc("The indexed OneLake arguments for the retrieval activity.")
  indexedOneLakeArguments?: KnowledgeBaseIndexedOneLakeActivityArguments;
}

@doc("Represents the arguments the indexed OneLake retrieval activity was run with.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseIndexedOneLakeActivityArguments {
  @doc("The search string used to query indexed OneLake contents.")
  search?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@doc("Represents a web retrieval activity record.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseWebActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The discriminator value.")
  type: "web";

  @doc("The web arguments for the retrieval activity.")
  webArguments?: KnowledgeBaseWebActivityArguments;
}

@doc("Represents the arguments the web retrieval activity was run with.")
@added(Versions.v2025_11_01_preview)
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
@doc("Represents a remote SharePoint retrieval activity record.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseRemoteSharePointActivityRecord
  extends KnowledgeBaseRetrievalActivityRecord {
  @doc("The discriminator value.")
  type: "remoteSharePoint";

  @doc("The remote SharePoint arguments for the retrieval activity.")
  remoteSharePointArguments?: KnowledgeBaseRemoteSharePointActivityArguments;
}

@doc("Represents the arguments the remote SharePoint retrieval activity was run with.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseRemoteSharePointActivityArguments {
  @doc("The search string used to query the remote SharePoint knowledge source.")
  search?: string;

  @doc("The filter expression add-on for the retrieval activity.")
  filterExpressionAddOn?: string;
}

@doc("Represents an LLM query planning activity record.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseModelQueryPlanningActivityRecord
  extends KnowledgeBaseActivityRecord {
  @doc("The discriminator value.")
  type: "modelQueryPlanning";

  @doc("The number of input tokens for the LLM query planning activity.")
  inputTokens?: int32;

  @doc("The number of output tokens for the LLM query planning activity.")
  outputTokens?: int32;
}

@doc("Represents an LLM answer synthesis activity record.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseModelAnswerSynthesisActivityRecord
  extends KnowledgeBaseActivityRecord {
  @doc("The discriminator value.")
  type: "modelAnswerSynthesis";

  @doc("The number of input tokens for the LLM answer synthesis activity.")
  inputTokens?: int32;

  @doc("The number of output tokens for the LLM answer synthesis activity.")
  outputTokens?: int32;
}

@doc("Represents an agentic reasoning activity record.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseAgenticReasoningActivityRecord
  extends KnowledgeBaseActivityRecord {
  @doc("The discriminator value.")
  type: "agenticReasoning";

  @doc("The number of input tokens for agentic reasoning.")
  reasoningTokens?: int32;

  @doc("The retrieval reasoning effort configuration.")
  retrievalReasoningEffort?: KnowledgeRetrievalReasoningEffort;
}

@doc("Base type for references.")
@discriminator("type")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseReference {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @doc("The type of the reference.")
  type: string;

  @doc("The ID of the reference.")
  id: string;

  @doc("The source activity ID for the reference.")
  activitySource: int32;

  @doc("The source data for the reference.")
  sourceData?: Record<string>;

  @doc("The reranker score for the document reference.")
  rerankerScore?: float32;
}

@doc("Represents an Azure Search document reference.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseSearchIndexReference extends KnowledgeBaseReference {
  @doc("The discriminator value.")
  type: "searchIndex";

  @doc("The document key for the reference.")
  docKey?: string;
}

@doc("Represents an Azure Blob Storage document reference.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseAzureBlobReference extends KnowledgeBaseReference {
  @doc("The discriminator value.")
  type: "azureBlob";

  @doc("The blob URL for the reference.")
  blobUrl?: string;
}

@doc("Represents an indexed SharePoint document reference.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseIndexedSharePointReference extends KnowledgeBaseReference {
  @doc("The discriminator value.")
  type: "indexedSharePoint";

  @doc("The document URL for the reference.")
  docUrl?: string;
}

@doc("Represents an indexed OneLake document reference.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseIndexedOneLakeReference extends KnowledgeBaseReference {
  @doc("The discriminator value.")
  type: "indexedOneLake";

  @doc("The document URL for the reference.")
  docUrl?: string;
}

@doc("Represents a web document reference.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseWebReference extends KnowledgeBaseReference {
  @doc("The discriminator value.")
  type: "web";

  @doc("The url the reference data originated from.")
  url: url;

  @doc("The title of the web document.")
  title?: string;
}

@doc("Represents a remote SharePoint document reference.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseRemoteSharePointReference extends KnowledgeBaseReference {
  @doc("The discriminator value.")
  type: "remoteSharePoint";

  @doc("The url the reference data originated from.")
  webUrl: url;

  @doc("Information about the sensitivity label applied to the SharePoint document.")
  searchSensitivityLabelInfo?: SharePointSensitivityLabelInfo;
}

@doc("Information about the sensitivity label applied to a SharePoint document.")
@added(Versions.v2025_11_01_preview)
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
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseErrorDetail {
  @doc("The error code.")
  code?: string;

  @doc("The error message.")
  message?: string;

  @doc("The error target.")
  target?: string;

  @doc("The error details.")
  details?: KnowledgeBaseErrorDetail[];

  @doc("The error additional info.")
  additionalInfo?: KnowledgeBaseErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
@added(Versions.v2025_11_01_preview)
model KnowledgeBaseErrorAdditionalInfo {
  @doc("The additional info type.")
  type?: string;

  @doc("The additional info.")
  info?: Record<string>;
}

@added(Versions.v2025_11_01_preview)
@doc("Successful retrieval response.")
model KnowledgeBaseRetrievalSuccessResponse {
  @doc("The retrieval response is successfully returned.")
  @statusCode
  code: 200;

  @doc("The retrieval response body.")
  @body
  body: KnowledgeBaseRetrievalResponse;
}

@added(Versions.v2025_11_01_preview)
@doc("Partial retrieval response.")
model KnowledgeBaseRetrievalPartialResponse {
  @doc("A partial retrieval response is returned.")
  @statusCode
  code: 206;

  @doc("The partial retrieval response body.")
  @body
  body: KnowledgeBaseRetrievalResponse;
}
