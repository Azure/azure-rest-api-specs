import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@typespec/events";
import "@typespec/sse";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models-service.tsp";
import "./models-shared.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.Events;
using TypeSpec.SSE;

namespace Search;

/** The input contract for the retrieval request. */
model KnowledgeBaseRetrievalRequest {
  /** A list of chat message style input. */
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_04_01)
  messages?: KnowledgeBaseMessage[];

  /** A list of intended queries to execute without model query planning. */
  intents?: KnowledgeRetrievalIntent[];

  /** The maximum runtime in seconds. */
  maxRuntimeInSeconds?: int32;

  /** Limits the maximum size of the content in the output. */
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_04_01)
  maxOutputSize?: int32;

  /** Limits the maximum number of documents in the output. */
  @added(Versions.v2026_05_01_preview)
  maxOutputDocuments?: int32;

  /** Limits the maximum size of the content in the output. */
  @added(Versions.v2026_04_01)
  maxOutputSizeInTokens?: int32;

  /** The retrieval reasoning effort configuration. */
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_04_01)
  retrievalReasoningEffort?: KnowledgeRetrievalReasoningEffort;

  /** Indicates retrieval results should include activity information. */
  includeActivity?: boolean;

  /** The output configuration for this retrieval. */
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_04_01)
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

  /** The sensitivity label information for the overall response. */
  @added(Versions.v2026_05_01_preview)
  responseSensitivityLabelInfo?: PurviewSensitivityLabelInfo;
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
@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_04_01)
model KnowledgeRetrievalLowReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  /** The discriminator value. */
  kind: KnowledgeRetrievalReasoningEffortKind.low;
}

/** Run knowledge retrieval with medium reasoning effort. */
@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_04_01)
model KnowledgeRetrievalMediumReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  /** The discriminator value. */
  kind: KnowledgeRetrievalReasoningEffortKind.medium;
}

/** Automatically select the reasoning effort during retrieval. The service seeds every request at the cheapest tier and escalates only as far as needed, up to the service's maximum available tier. */
@added(Versions.v2026_08_01_preview)
model KnowledgeRetrievalAutoReasoningEffort
  extends KnowledgeRetrievalReasoningEffort {
  /** The discriminator value. */
  kind: KnowledgeRetrievalReasoningEffortKind.auto;
}

/** The amount of effort to use during retrieval. */
union KnowledgeRetrievalReasoningEffortKind {
  string,

  /** Does not perform any source selections, query planning, or iterative search. */
  minimal: "minimal",

  /** Use low reasoning during retrieval. */
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_04_01)
  low: "low",

  /** Use a moderate amount of reasoning during retrieval. */
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_04_01)
  medium: "medium",

  /** Automatically select the reasoning effort during retrieval, escalating from the cheapest tier only as far as needed. */
  @added(Versions.v2026_08_01_preview)
  auto: "auto",
}

/** The output configuration for this retrieval. */
@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_04_01)
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
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_04_01)
  alwaysQuerySource?: boolean;

  /** Indicates that this knowledge source should be excluded from the request's candidate set and never queried at retrieval time. The exclusion is request-local and does not modify knowledge base membership. Cannot be combined with alwaysQuerySource on the same knowledge source. */
  @added(Versions.v2026_08_01_preview)
  neverQuerySource?: boolean;

  /** Indicates that the entire retrieval request should fail if retrieval from this knowledge source encounters an error. Defaults to false. */
  @added(Versions.v2026_05_01_preview)
  failOnError?: boolean;

  /** The reranker threshold all retrieved documents must meet to be included in the response. */
  rerankerThreshold?: float32;

  /** Overrides the knowledge source's stored inclusionMode for this retrieve call only. When omitted, the stored knowledge source value applies. */
  @added(Versions.v2026_08_01_preview)
  inclusionMode?: KnowledgeSourceInclusionMode;

  /** Limits the maximum number of documents returned from this knowledge source. */
  @added(Versions.v2026_05_01_preview)
  maxOutputDocuments?: int32;

  /** The type of the knowledge source. */
  kind: KnowledgeSourceKind;

  /** Indicates whether image serving should be enabled for this knowledge source at retrieval time. When true, images extracted during ingestion are delivered to downstream models. */
  @added(Versions.v2026_05_01_preview)
  enableImageServing?: boolean;
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
@added(Versions.v2026_05_01_preview)
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
@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_04_01)
model RemoteSharePointKnowledgeSourceParams extends KnowledgeSourceParams {
  /** The discriminator value. */
  kind: KnowledgeSourceKind.RemoteSharePoint;

  /** A filter condition applied to the SharePoint data source. It must be specified in the Keyword Query Language syntax. It will be combined as a conjunction with the filter expression specified in the knowledge source definition. */
  filterExpressionAddOn?: string;
}

/** Specifies runtime parameters for a WorkIQ knowledge source */
#suppress "@azure-tools/typespec-azure-core/casing-style" "WorkIQ is a product name where IQ is an acronym."
@added(Versions.v2026_05_01_preview)
model WorkIQKnowledgeSourceParams extends KnowledgeSourceParams {
  /** The discriminator value. */
  kind: KnowledgeSourceKind.WorkIQ;
}

/** Specifies runtime parameters for a Fabric Data Agent knowledge source */
@added(Versions.v2026_05_01_preview)
model FabricDataAgentKnowledgeSourceParams extends KnowledgeSourceParams {
  /** The discriminator value. */
  kind: KnowledgeSourceKind.FabricDataAgent;
}

/** Specifies runtime parameters for a Fabric Ontology knowledge source */
@added(Versions.v2026_05_01_preview)
model FabricOntologyKnowledgeSourceParams extends KnowledgeSourceParams {
  /** The discriminator value. */
  kind: KnowledgeSourceKind.FabricOntology;
}

/** Specifies runtime parameters for a Fabric semantic model knowledge source */
@added(Versions.v2026_08_01_preview)
model FabricSemanticModelKnowledgeSourceParams extends KnowledgeSourceParams {
  /** The discriminator value. */
  kind: KnowledgeSourceKind.FabricSemanticModel;
}

/** Specifies runtime parameters for an MCP server knowledge source */
@added(Versions.v2026_05_01_preview)
model McpServerKnowledgeSourceParams extends KnowledgeSourceParams {
  /** The discriminator value. */
  kind: KnowledgeSourceKind.McpServer;
}

/** Specifies runtime parameters for a File knowledge source */
@added(Versions.v2026_05_01_preview)
model FileKnowledgeSourceParams extends KnowledgeSourceParams {
  /** The discriminator value. */
  kind: KnowledgeSourceKind.File;
}

/** Specifies runtime parameters for an indexed SQL knowledge source */
@added(Versions.v2026_05_01_preview)
model IndexedSqlKnowledgeSourceParams extends KnowledgeSourceParams {
  /** The discriminator value. */
  kind: KnowledgeSourceKind.IndexedSql;
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
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_04_01)
  indexedSharePoint: "indexedSharePoint",

  /** Indexed OneLake retrieval activity. */
  indexedOneLake: "indexedOneLake",

  /** Web retrieval activity. */
  web: "web",

  /** Remote SharePoint retrieval activity. */
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_04_01)
  remoteSharePoint: "remoteSharePoint",

  /** WorkIQ retrieval activity. */
  @added(Versions.v2026_05_01_preview)
  workIQ: "workIQ",

  /** Fabric Data Agent retrieval activity. */
  @added(Versions.v2026_05_01_preview)
  fabricDataAgent: "fabricDataAgent",

  /** Fabric Ontology retrieval activity. */
  @added(Versions.v2026_05_01_preview)
  fabricOntology: "fabricOntology",

  /** Fabric semantic model retrieval activity. */
  @added(Versions.v2026_08_01_preview)
  fabricSemanticModel: "fabricSemanticModel",

  /** MCP server retrieval activity. */
  @added(Versions.v2026_05_01_preview)
  mcpServer: "mcpServer",

  /** File retrieval activity. */
  @added(Versions.v2026_05_01_preview)
  file: "file",

  /** Indexed SQL retrieval activity. */
  @added(Versions.v2026_05_01_preview)
  indexedSql: "indexedSql",

  /** LLM query planning activity. */
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_04_01)
  modelQueryPlanning: "modelQueryPlanning",

  /** LLM answer synthesis activity. */
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_04_01)
  modelAnswerSynthesis: "modelAnswerSynthesis",

  /** LLM web summarization activity. */
  @added(Versions.v2026_04_01)
  modelWebSummarization: "modelWebSummarization",

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

  /** A warning message surfacing potential configuration issues observed during the activity, such as documents dropped due to score thresholding, token limit truncation, or timeout conditions. */
  @added(Versions.v2026_05_01_preview)
  warning?: string;
}

/** Common fields for retrieval activity records. Used via spread in concrete retrieval models. */
model KnowledgeBaseRetrievalActivityRecord {
  /** The knowledge source for the retrieval activity. */
  knowledgeSourceName?: string;

  /** The query time for this retrieval activity. */
  queryTime?: utcDateTime;

  /** The count of documents retrieved that were sufficiently relevant to pass the reranker threshold. */
  count?: int32;

  /** Statistics about image serving for this retrieval activity */
  @added(Versions.v2026_05_01_preview)
  imageServing?: ImageServingStatistics;
}

/** Represents a search index retrieval activity record. */
model KnowledgeBaseSearchIndexActivityRecord
  extends KnowledgeBaseActivityRecord {
  ...KnowledgeBaseRetrievalActivityRecord;

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
model KnowledgeBaseAzureBlobActivityRecord extends KnowledgeBaseActivityRecord {
  ...KnowledgeBaseRetrievalActivityRecord;

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
@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_04_01)
model KnowledgeBaseIndexedSharePointActivityRecord
  extends KnowledgeBaseActivityRecord {
  ...KnowledgeBaseRetrievalActivityRecord;

  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.indexedSharePoint;

  /** The indexed SharePoint arguments for the retrieval activity. */
  indexedSharePointArguments?: KnowledgeBaseIndexedSharePointActivityArguments;
}

/** Represents the arguments the indexed SharePoint retrieval activity was run with. */
@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_04_01)
model KnowledgeBaseIndexedSharePointActivityArguments {
  /** The search string used to query indexed SharePoint contents. */
  search?: string;
}

/** Represents a indexed OneLake retrieval activity record. */
model KnowledgeBaseIndexedOneLakeActivityRecord
  extends KnowledgeBaseActivityRecord {
  ...KnowledgeBaseRetrievalActivityRecord;

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
model KnowledgeBaseWebActivityRecord extends KnowledgeBaseActivityRecord {
  ...KnowledgeBaseRetrievalActivityRecord;

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
@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_04_01)
model KnowledgeBaseRemoteSharePointActivityRecord
  extends KnowledgeBaseActivityRecord {
  ...KnowledgeBaseRetrievalActivityRecord;

  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.remoteSharePoint;

  /** The remote SharePoint arguments for the retrieval activity. */
  remoteSharePointArguments?: KnowledgeBaseRemoteSharePointActivityArguments;
}

/** Represents the arguments the remote SharePoint retrieval activity was run with. */
@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_04_01)
model KnowledgeBaseRemoteSharePointActivityArguments {
  /** The search string used to query the remote SharePoint knowledge source. */
  search?: string;

  /** The filter expression add-on for the retrieval activity. */
  filterExpressionAddOn?: string;
}

/** Represents a WorkIQ retrieval activity record. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "WorkIQ is a product name where IQ is an acronym."
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseWorkIQActivityRecord extends KnowledgeBaseActivityRecord {
  ...KnowledgeBaseRetrievalActivityRecord;

  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.workIQ;

  /** The WorkIQ arguments for the retrieval activity. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "WorkIQ is a product name where IQ is an acronym."
  workIQArguments?: KnowledgeBaseWorkIQActivityArguments;
}

/** Represents the arguments the WorkIQ retrieval activity was run with. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "WorkIQ is a product name where IQ is an acronym."
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseWorkIQActivityArguments {
  /** The search string used to query the WorkIQ knowledge source. */
  search?: string;
}

/** Represents a Fabric Data Agent retrieval activity record. */
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseFabricDataAgentActivityRecord
  extends KnowledgeBaseActivityRecord {
  ...KnowledgeBaseRetrievalActivityRecord;

  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.fabricDataAgent;

  /** The Fabric Data Agent arguments for the retrieval activity. */
  fabricDataAgentArguments?: KnowledgeBaseFabricDataAgentActivityArguments;
}

/** Represents the arguments the Fabric Data Agent retrieval activity was run with. */
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseFabricDataAgentActivityArguments {
  /** The search string used to query the Fabric Data Agent knowledge source. */
  search?: string;
}

/** Represents a Fabric Ontology retrieval activity record. */
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseFabricOntologyActivityRecord
  extends KnowledgeBaseActivityRecord {
  ...KnowledgeBaseRetrievalActivityRecord;

  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.fabricOntology;

  /** The Fabric Ontology arguments for the retrieval activity. */
  fabricOntologyArguments?: KnowledgeBaseFabricOntologyActivityArguments;
}

/** Represents the arguments the Fabric Ontology retrieval activity was run with. */
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseFabricOntologyActivityArguments {
  /** The search string used to query the Fabric Ontology knowledge source. */
  search?: string;
}

/** Represents a Fabric semantic model retrieval activity record. */
@added(Versions.v2026_08_01_preview)
model KnowledgeBaseFabricSemanticModelActivityRecord
  extends KnowledgeBaseActivityRecord {
  ...KnowledgeBaseRetrievalActivityRecord;

  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.fabricSemanticModel;

  /** The Fabric semantic model arguments for the retrieval activity. */
  fabricSemanticModelArguments?: KnowledgeBaseFabricSemanticModelActivityArguments;
}

/** Represents the arguments the Fabric semantic model retrieval activity was run with. */
@added(Versions.v2026_08_01_preview)
model KnowledgeBaseFabricSemanticModelActivityArguments {
  /** The search string used to query the Fabric semantic model knowledge source. */
  search?: string;
}

/** Represents an MCP server retrieval activity record. */
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseMcpServerActivityRecord extends KnowledgeBaseActivityRecord {
  ...KnowledgeBaseRetrievalActivityRecord;

  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.mcpServer;

  /** The MCP server arguments for the retrieval activity. */
  mcpServerArguments?: KnowledgeBaseMcpServerActivityArguments;
}

/** Represents the arguments the MCP server retrieval activity was run with. */
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseMcpServerActivityArguments {
  /** The name of the MCP server tool used for the retrieval activity. */
  toolName?: string;

  /** The arguments passed to the MCP server tool. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Allows arbitrary JSON via additionalProperties: true."
  toolArguments?: Record<unknown>;
}

/** Represents a File retrieval activity record. */
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseFileActivityRecord extends KnowledgeBaseActivityRecord {
  ...KnowledgeBaseRetrievalActivityRecord;

  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.file;

  /** The File arguments for the retrieval activity. */
  fileArguments?: KnowledgeBaseFileActivityArguments;
}

/** Represents the arguments the File retrieval activity was run with. */
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseFileActivityArguments {
  /** The search string used to query file contents. */
  search?: string;
}

/** Represents an indexed SQL retrieval activity record. */
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseIndexedSqlActivityRecord
  extends KnowledgeBaseActivityRecord {
  ...KnowledgeBaseRetrievalActivityRecord;

  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.indexedSql;

  /** The indexed SQL arguments for the retrieval activity. */
  indexedSqlArguments?: KnowledgeBaseIndexedSqlActivityArguments;
}

/** Represents the arguments the indexed SQL retrieval activity was run with. */
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseIndexedSqlActivityArguments {
  /** The search string used to query indexed SQL contents. */
  search?: string;
}

/** Represents the model used for a knowledge base LLM activity, including its model name and deployment identifier. */
@added(Versions.v2026_08_01_preview)
model KnowledgeBaseActivityRecordModel {
  /** The name of the model used for the activity. */
  modelName?: string;

  /** The deployment identifier of the model used for the activity. */
  deploymentId?: string;
}

/** Represents an LLM query planning activity record. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_04_01)
model KnowledgeBaseModelQueryPlanningActivityRecord
  extends KnowledgeBaseActivityRecord {
  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.modelQueryPlanning;

  /** The number of input tokens for the LLM query planning activity. */
  inputTokens?: int32;

  /** The number of output tokens for the LLM query planning activity. */
  outputTokens?: int32;

  /** The name of the model used for the LLM query planning activity. */
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_08_01_preview)
  modelName?: string;

  /** The model used for the LLM query planning activity. */
  @added(Versions.v2026_08_01_preview)
  `model`?: KnowledgeBaseActivityRecordModel;
}

/** Represents an LLM answer synthesis activity record. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_04_01)
model KnowledgeBaseModelAnswerSynthesisActivityRecord
  extends KnowledgeBaseActivityRecord {
  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.modelAnswerSynthesis;

  /** The number of input tokens for the LLM answer synthesis activity. */
  inputTokens?: int32;

  /** The number of output tokens for the LLM answer synthesis activity. */
  outputTokens?: int32;

  /** The name of the model used for the LLM answer synthesis activity. */
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_08_01_preview)
  modelName?: string;

  /** The model used for the LLM answer synthesis activity. */
  @added(Versions.v2026_08_01_preview)
  `model`?: KnowledgeBaseActivityRecordModel;
}

/** Represents an LLM web summarization activity record. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@added(Versions.v2026_04_01)
model KnowledgeBaseModelWebSummarizationActivityRecord
  extends KnowledgeBaseActivityRecord {
  /** The discriminator value. */
  type: KnowledgeBaseActivityRecordType.modelWebSummarization;

  /** The number of input tokens for the LLM web summarization activity. */
  inputTokens?: int32;

  /** The number of output tokens for the LLM web summarization activity. */
  outputTokens?: int32;

  /** The name of the model used for the LLM web summarization activity. */
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_08_01_preview)
  modelName?: string;

  /** The model used for the LLM web summarization activity. */
  @added(Versions.v2026_08_01_preview)
  `model`?: KnowledgeBaseActivityRecordModel;
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
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_04_01)
  indexedSharePoint: "indexedSharePoint",

  /** Indexed OneLake document reference. */
  indexedOneLake: "indexedOneLake",

  /** Web document reference. */
  web: "web",

  /** Remote SharePoint document reference. */
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_04_01)
  remoteSharePoint: "remoteSharePoint",

  /** Work IQ document reference. */
  @added(Versions.v2026_05_01_preview)
  workIQ: "workIQ",

  /** Fabric Data Agent document reference. */
  @added(Versions.v2026_05_01_preview)
  fabricDataAgent: "fabricDataAgent",

  /** Fabric Ontology document reference. */
  @added(Versions.v2026_05_01_preview)
  fabricOntology: "fabricOntology",

  /** Fabric semantic model document reference. */
  @added(Versions.v2026_08_01_preview)
  fabricSemanticModel: "fabricSemanticModel",

  /** MCP server document reference. */
  @added(Versions.v2026_05_01_preview)
  mcpServer: "mcpServer",

  /** File document reference. */
  @added(Versions.v2026_05_01_preview)
  file: "file",

  /** Indexed SQL document reference. */
  @added(Versions.v2026_05_01_preview)
  indexedSql: "indexedSql",
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

  /** The sensitivity label information for the reference. */
  @added(Versions.v2026_05_01_preview)
  searchSensitivityLabelInfo?: PurviewSensitivityLabelInfo;

  /** A Search-owned URL that points at the backing document for this reference, usable as a citation target. */
  @added(Versions.v2026_08_01_preview)
  citationUrl?: url;
}

/** Represents an Azure Blob Storage document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
model KnowledgeBaseAzureBlobReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.azureBlob;

  /** The blob URL for the reference. */
  blobUrl?: string;

  /** The sensitivity label information for the reference. */
  @added(Versions.v2026_05_01_preview)
  searchSensitivityLabelInfo?: PurviewSensitivityLabelInfo;

  /** A Search-owned URL that points at the backing document for this reference, usable as a citation target. */
  @added(Versions.v2026_08_01_preview)
  citationUrl?: url;
}

/** Represents an indexed SharePoint document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_04_01)
model KnowledgeBaseIndexedSharePointReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.indexedSharePoint;

  /** The document URL for the reference. */
  docUrl?: string;

  /** The sensitivity label information for the reference. */
  @added(Versions.v2026_05_01_preview)
  searchSensitivityLabelInfo?: PurviewSensitivityLabelInfo;

  /** A Search-owned URL that points at the backing document for this reference, usable as a citation target. */
  @added(Versions.v2026_08_01_preview)
  citationUrl?: url;
}

/** Represents an indexed OneLake document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
model KnowledgeBaseIndexedOneLakeReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.indexedOneLake;

  /** The document URL for the reference. */
  docUrl?: string;

  /** The sensitivity label information for the reference. */
  @added(Versions.v2026_05_01_preview)
  searchSensitivityLabelInfo?: PurviewSensitivityLabelInfo;

  /** A Search-owned URL that points at the backing document for this reference, usable as a citation target. */
  @added(Versions.v2026_08_01_preview)
  citationUrl?: url;
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
@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_04_01)
model KnowledgeBaseRemoteSharePointReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.remoteSharePoint;

  /** The url the reference data originated from. */
  webUrl?: url;

  /** Information about the sensitivity label applied to the SharePoint document. */
  @renamedFrom(Versions.v2026_04_01, "searchSensitivityLabelInfo")
  @removed(Versions.v2026_04_01)
  searchSensitivityLabelInfoRemoved?: SharePointSensitivityLabelInfo;

  /** The sensitivity label information for the reference. */
  @added(Versions.v2026_05_01_preview)
  searchSensitivityLabelInfo?: PurviewSensitivityLabelInfo;
}

/** Represents a WorkIQ document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
#suppress "@azure-tools/typespec-azure-core/casing-style" "WorkIQ is a product name where IQ is an acronym."
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseWorkIQReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.workIQ;

  /** The attributions for the reference. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "WorkIQ is a product name where IQ is an acronym."
  @removed(Versions.v2026_08_01_preview)
  attributions?: WorkIQAttribution[];
}

/** Attribution information for a WorkIQ reference. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "WorkIQ is a product name where IQ is an acronym."
@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_08_01_preview)
model WorkIQAttribution {
  /** The URL for the attribution. */
  seeMoreWebUrl?: url;
}

/** Represents a Fabric Data Agent document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseFabricDataAgentReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.fabricDataAgent;

  /** The Fabric workspace ID. */
  workspaceId?: string;

  /** The Fabric Data Agent ID. */
  dataAgentId?: string;
}

/** Represents a Fabric Ontology document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseFabricOntologyReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.fabricOntology;

  /** The Fabric workspace ID. */
  workspaceId?: string;

  /** The ontology ID within the workspace. */
  ontologyId?: string;
}

/** Represents a Fabric semantic model document reference. Structured retrieval results (executed DAX query, column types, mime type, and result payload) are surfaced through the untyped `sourceData` bag under a `fabricSemanticModelResults` array. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@added(Versions.v2026_08_01_preview)
model KnowledgeBaseFabricSemanticModelReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.fabricSemanticModel;

  /** The Fabric artifact ID of the semantic model or report that produced this reference. */
  artifactId?: string;
}

/** Represents an MCP server document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseMcpServerReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.mcpServer;

  /** The name of the MCP server tool that produced the reference. */
  toolName?: string;

  /** The title of the MCP server tool result. */
  title?: string;
}

/** Represents a file document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseFileReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.file;

  /** The document name for the reference. */
  docName?: string;
}

/** Represents an Azure SQL document reference. */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "Existing"
@added(Versions.v2026_05_01_preview)
model KnowledgeBaseIndexedSqlReference extends KnowledgeBaseReference {
  /** The discriminator value. */
  type: KnowledgeBaseReferenceType.indexedSql;

  /** The document URL for the reference. */
  docUrl?: string;

  /** A Search-owned URL that points at the backing document for this reference, usable as a citation target. */
  @added(Versions.v2026_08_01_preview)
  citationUrl?: url;
}

/** Information about the sensitivity label applied to a SharePoint document. */
@removed(Versions.v2026_04_01)
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

/** Information about the sensitivity label applied to a document */
@added(Versions.v2026_05_01_preview)
model PurviewSensitivityLabelInfo {
  /** The display name for the sensitivity label. */
  displayName?: string;

  /** The ID of the sensitivity label. */
  sensitivityLabelId?: string;

  /** The tooltip that should be displayed for the label in a UI. */
  toolTip?: string;

  /** The priority in which the sensitivity label is applied. */
  priority?: int32;

  /** The color that the UI should display for the label, if configured. */
  color?: string;

  /** Indicates whether the sensitivity label enforces encryption. */
  isEncrypted?: boolean;
}

/** Statistics about image serving during a retrieval activity. */
@added(Versions.v2026_05_01_preview)
model ImageServingStatistics {
  /** The number of images retrieved from the asset store. */
  imagesRetrieved?: int32;

  /** The number of images sent to the downstream model. */
  imagesSentToModel?: int32;

  /** The total size in bytes of images sent to the model. */
  totalImageSizeBytes?: int64;

  /** Indicates whether image verbalization was used instead of direct image serving. */
  verbalizationUsed?: boolean;

  /** The set of images the model selected to be served to the downstream model for this retrieval activity. */
  @added(Versions.v2026_08_01_preview)
  servedImages?: ServedImage[];
}

/** Describes a single image that the model selected to be served during a retrieval activity. */
@added(Versions.v2026_08_01_preview)
model ServedImage {
  /** The image label extracted from the source document by Content Understanding enrichment. Corresponds to the figure numbering in the original document. */
  imageId?: string;

  /** The relative path to the image within the asset store. */
  imagePath?: string;

  /** The size in bytes of this image as sent to the model. */
  sizeBytes?: int64;
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

/**
 * Server-sent events response for streaming knowledge base retrieval, added in version
 * 2026-08-01-preview. Each server-sent event's data payload uses this shape; the connection stays
 * open and multiple events may be sent before the stream ends.
 */
@added(Versions.v2026_08_01_preview)
model KnowledgeBaseRetrievalEventStreamResponse {
  /** The retrieval response is successfully returned. */
  @statusCode
  code: 200;

  /** The response is streamed as server-sent events. */
  @header("Content-Type")
  contentType: "text/event-stream";

  /** The retrieval response body. */
  @body
  body: KnowledgeBaseRetrievalResponse;
}

/**
 * The set of server-sent events emitted while streaming a knowledge base retrieval, added in
 * version 2026-08-01-preview. Each event's `data:` payload is JSON-encoded using the type
 * associated with its event name below. The stream ends after the terminal `response.completed`
 * event (or an `error` event, if the retrieval fails before completing).
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "@events SSE union is delivered as a server-sent event stream and cannot be represented as an OpenAPI v2 union."
@added(Versions.v2026_08_01_preview)
@events
union KnowledgeBaseRetrievalStreamEvents {
  /** The retrieval stream has started; no activity or answer content has been produced yet. */
  `retrieval.started`: KnowledgeBaseRetrievalStartedEvent,

  /** An individual activity (e.g. a search index or web retrieval step) has started executing. */
  `activity.started`: KnowledgeBaseActivityStartedEvent,

  /** An individual activity has finished executing, successfully or not. */
  `activity.completed`: KnowledgeBaseActivityRecord,

  /** An incremental chunk of generated answer text, to be appended to the in-progress answer. */
  `answer.delta`: KnowledgeBaseAnswerDeltaEvent,

  /** The answer message has finished streaming and is now complete. */
  `answer.completed`: KnowledgeBaseMessage,

  /** The references used to produce the response are available. */
  `references.completed`: KnowledgeBaseReference[],

  /** The retrieval failed before the stream could complete normally. */
  error: KnowledgeBaseStreamErrorEvent,

  /** The retrieval has completed successfully; this is the final event of the stream. */
  @terminalEvent
  `response.completed`: KnowledgeBaseRetrievalResponse,
}

// NOTE: The event payload types below (KnowledgeBaseRetrievalStartedEvent,
// KnowledgeBaseActivityStartedEvent, KnowledgeBaseAnswerDeltaEvent, KnowledgeBaseStreamErrorEvent)
// do not exist anywhere else in the spec today. They are stubbed out here with a minimal,
// best-guess shape so that KnowledgeBaseRetrievalStreamEvents compiles and can be reviewed as a
// whole. Their fields are NOT final -- they need to be reviewed/fleshed out with the KB
// retrieval runtime owners before this ships.

/** TODO(shape TBD): Emitted once the retrieval stream begins, before any activity or answer content is produced. */
@added(Versions.v2026_08_01_preview)
model KnowledgeBaseRetrievalStartedEvent {
  /** TODO(shape TBD): placeholder field; replace once the runtime defines what this event should carry (e.g. a correlation/request id). */
  requestId?: string;
}

/** TODO(shape TBD): Emitted when an individual activity (e.g. a search index or web retrieval step) begins executing. */
@added(Versions.v2026_08_01_preview)
model KnowledgeBaseActivityStartedEvent {
  /** The ID of the activity record, matching the `id` on the corresponding `activity.completed` event. */
  id: int32;

  /** The type of the activity that has started. */
  type: KnowledgeBaseActivityRecordType;
}

/** TODO(shape TBD): Emitted for each incremental chunk of generated answer text, before the final `answer.completed` event. */
@added(Versions.v2026_08_01_preview)
model KnowledgeBaseAnswerDeltaEvent {
  /** TODO(shape TBD): the incremental text fragment to append to the in-progress answer. Needs confirmation of naming/shape against the runtime's actual delta emission (e.g. does it need an index, role, or content-part type like KnowledgeBaseMessageContent?). */
  delta: string;
}

/** TODO(shape TBD): Emitted in place of `response.completed` if the retrieval fails before the stream can complete normally. */
@added(Versions.v2026_08_01_preview)
model KnowledgeBaseStreamErrorEvent {
  /** The error detail explaining why the retrieval stream failed. */
  error: KnowledgeBaseErrorDetail;
}

/** Parameters for AI Services. */
model AIServices {
  /** The URI of the AI Services endpoint. */
  uri: url;

  /** The API key for accessing AI Services. */
  apiKey?: string;
}

/** Configuration for an asset store used to store extracted assets such as images. */
@added(Versions.v2026_05_01_preview)
model AssetStore {
  /** The connection string for the asset store. */
  connectionString: string;

  /** The name of the blob container within the asset store where extracted assets (for example, images) are stored. */
  containerName: string;
}

/** Configuration for freshness-aware retrieval. When set, newer documents receive a ranking boost during retrieval. */
@added(Versions.v2026_05_01_preview)
model FreshnessPolicy {
  /** ISO 8601 duration for the freshness boosting window (e.g. 'P90D' for 90 days). Documents newer than this duration receive a ranking boost during retrieval. */
  boostingDuration?: string;
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
@added(Versions.v2026_05_01_preview)
@removed(Versions.v2026_04_01)
union KnowledgeSourceIngestionPermissionOption {
  string,

  /** Ingest explicit user identifiers alongside document content. */
  UserIds: "userIds",

  /** Ingest group identifiers alongside document content. */
  GroupIds: "groupIds",

  /** Ingest RBAC scope information alongside document content. */
  RbacScope: "rbacScope",

  /** Ingest Microsoft Purview sensitivity labels alongside document content. */
  @added(Versions.v2026_05_01_preview)
  SensitivityLabels: "sensitivityLabels",
}

/** Specifies the network access mode for knowledge source ingestion. Default is 'public'. */
@added(Versions.v2026_08_01_preview)
union KnowledgeSourceNetworkAccessMode {
  string,

  /** Ingestion runs in the standard, publicly reachable execution environment. This is the default. */
  Public: "public",

  /** Ingestion runs in a private execution environment so it can reach data sources and dependencies over a private network (private endpoint / shared private link). */
  Private: "private",
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
  @added(Versions.v2026_05_01_preview)
  @removed(Versions.v2026_04_01)
  ingestionPermissionOptions?:
    | KnowledgeSourceIngestionPermissionOption[]
    | null;

  /** Optional content extraction mode. Default is 'minimal'. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  contentExtractionMode?:
    | KnowledgeSourceContentExtractionMode
    | null = KnowledgeSourceContentExtractionMode.Minimal;

  /** Optional AI Services configuration for content processing. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Pre-existing API contract"
  aiServices?: AIServices | null;

  /** Optional asset store configuration for storing extracted assets such as images. */
  @added(Versions.v2026_05_01_preview)
  assetStore?: AssetStore;

  /** Optional freshness policy for biasing retrieval toward newer documents. */
  @added(Versions.v2026_05_01_preview)
  freshnessPolicy?: FreshnessPolicy;

  /** Optional network access mode for ingestion. Set to 'private' to run ingestion in a private execution environment that can reach data sources and dependencies over a private network. Default is 'public'. This is a create-time setting and cannot be changed after the knowledge source is created. */
  @added(Versions.v2026_08_01_preview)
  networkAccessMode?: KnowledgeSourceNetworkAccessMode = KnowledgeSourceNetworkAccessMode.Public;
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
  /** Identifies the Knowledge Source kind directly from the Status response. */
  @added(Versions.v2026_04_01)
  kind?: KnowledgeSourceKind;

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

/** Represents a document-level indexing error encountered during a knowledge source synchronization run. */
@added(Versions.v2026_04_01)
model KnowledgeSourceSynchronizationError {
  /** The unique identifier for the failed document or item within the synchronization run. */
  docId?: string;

  /** HTTP-like status code representing the failure category (e.g., 400). */
  statusCode?: int32;

  /** Name of the ingestion or processing component reporting the error. */
  name?: string;

  /** Human-readable, customer-visible error message. */
  errorMessage: string;

  /** Additional contextual information about the failure. */
  details?: string;

  /** A link to relevant troubleshooting documentation. */
  documentationLink?: string;
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

  /** Collection of document-level indexing errors encountered during the current synchronization run. Returned only when errors are present. */
  @added(Versions.v2026_04_01)
  errors?: KnowledgeSourceSynchronizationError[];
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
