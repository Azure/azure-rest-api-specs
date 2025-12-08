import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.QuestionAnswering.Authoring;

/** The secret key for your Azure AI Language resource. */
alias AzureKey = ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">;

/**
 * These are the [Azure Active Directory OAuth2](https://learn.microsoft.com/azure/active-directory/develop/v1-overview) Flows.
 * When paired with [Azure role-based access](https://learn.microsoft.com/azure/role-based-access-control/overview) control it can be used to control access to Azure Maps REST APIs.
 * Azure role-based access controls are used to designate access to one or more Azure Language resource account or sub-resources. Any user, group, or service principal can be granted access
 * via a  built-in role or a custom role composed of one or more permissions to Azure Language REST APIs.
 *
 * To implement scenarios, we recommend viewing [authentication concepts](https://aka.ms/amauth).
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
alias AADToken = OAuth2Auth<[
  {
    type: OAuth2FlowType.implicit;
    authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
    scopes: ["https://cognitiveservices.azure.com/.default"];
  }
]>;

alias CommonListParams = {
  /** The maximum number of resources to return from the collection. */
  @query("top")
  top?: int32;

  /** An offset into the collection of the first resource to be returned. */
  @query("skip")
  skip?: int32;

  /** The maximum number of resources to include in a single response. */
  @query
  maxpagesize?: int32;
};

alias ListQnaQueryParams = ListQueryParametersTrait<{
  ...CommonListParams;

  /**
   * Source of the QnA.
   */
  @query("source")
  source?: string;
}>;

alias ListProjectsQueryParams = ListQueryParametersTrait<{
  ...CommonListParams;
}>;

alias ListDeploymentsQueryParams = ListQueryParametersTrait<{
  ...CommonListParams;
}>;

alias ListSynonymsQueryParams = ListQueryParametersTrait<{
  ...CommonListParams;
}>;

alias ListSourcesQueryParams = ListQueryParametersTrait<{
  ...CommonListParams;
}>;

/**
 * Human-readable error code.
 */
union ErrorCode {
  string,

  /** Invalid request error */
  InvalidRequest: "InvalidRequest",

  /** Invalid argument error */
  InvalidArgument: "InvalidArgument",

  /** Unauthorized access error */
  Unauthorized: "Unauthorized",

  /** Forbidden access error */
  Forbidden: "Forbidden",

  /** Not found error */
  NotFound: "NotFound",

  /** Project not found error */
  ProjectNotFound: "ProjectNotFound",

  /** Operation not found error */
  OperationNotFound: "OperationNotFound",

  /** Azure Cognitive Search not found error */
  AzureCognitiveSearchNotFound: "AzureCognitiveSearchNotFound",

  /** Azure Cognitive Search index not found error */
  AzureCognitiveSearchIndexNotFound: "AzureCognitiveSearchIndexNotFound",

  /** Too many requests error */
  TooManyRequests: "TooManyRequests",

  /** Azure Cognitive Search throttling error */
  AzureCognitiveSearchThrottling: "AzureCognitiveSearchThrottling",

  /** Azure Cognitive Search index limit reached error */
  AzureCognitiveSearchIndexLimitReached: "AzureCognitiveSearchIndexLimitReached",

  /** Internal server error */
  InternalServerError: "InternalServerError",

  /** Service unavailable error */
  ServiceUnavailable: "ServiceUnavailable",

  /** Timeout error */
  Timeout: "Timeout",

  /** Quota exceeded error */
  QuotaExceeded: "QuotaExceeded",

  /** Conflict error */
  Conflict: "Conflict",

  /** Warning error */
  Warning: "Warning",
}

/**
 * Human-readable error code.
 */
union InnerErrorCode {
  string,

  /** Invalid request error */
  InvalidRequest: "InvalidRequest",

  /** Invalid parameter value error */
  InvalidParameterValue: "InvalidParameterValue",

  /** Knowledge base not found error */
  KnowledgeBaseNotFound: "KnowledgeBaseNotFound",

  /** Azure Cognitive Search not found error */
  AzureCognitiveSearchNotFound: "AzureCognitiveSearchNotFound",

  /** Azure Cognitive Search throttling error */
  AzureCognitiveSearchThrottling: "AzureCognitiveSearchThrottling",

  /** Extraction failure error */
  ExtractionFailure: "ExtractionFailure",

  /** Invalid request body format error */
  InvalidRequestBodyFormat: "InvalidRequestBodyFormat",

  /** Empty request error */
  EmptyRequest: "EmptyRequest",

  /** Missing input documents error */
  MissingInputDocuments: "MissingInputDocuments",

  /** Invalid document error */
  InvalidDocument: "InvalidDocument",

  /** Model version incorrect error */
  ModelVersionIncorrect: "ModelVersionIncorrect",

  /** Invalid document batch error */
  InvalidDocumentBatch: "InvalidDocumentBatch",

  /** Unsupported language code error */
  UnsupportedLanguageCode: "UnsupportedLanguageCode",

  /** Invalid country hint error */
  InvalidCountryHint: "InvalidCountryHint",
}

/**
 * Job Status.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required"
@lroStatus
union jobStatus {
  string,
  notStarted: "notStarted",
  running: "running",

  @lroSucceeded
  succeeded: "succeeded",

  @lroFailed
  failed: "failed",

  @lroCanceled
  cancelled: "cancelled",

  cancelling: "cancelling",
  partiallyCompleted: "partiallyCompleted",
}

/**
 * Knowledge base Import or Export format.
 */
union format {
  string,

  /**
   * Export or Import QnA assets in JSON format.
   */
  json: "json",

  /**
   * Export or Import knowledge base replica including all assets and metadata in
   * Excel format.
   */
  tsv: "tsv",

  /**
   * Export or Import knowledge base replica including all assets and metadata in
   * Tsv format.
   */
  excel: "excel",
}

/**
 * Kind of the asset of the project.
 */
union AssestKind {
  string,

  /**
   * Question and Answers.
   */
  qnas: "qnas",

  /**
   * Synonyms.
   */
  synonyms: "synonyms",
}

/**
 * Optional query parameters for the export operation.
 * Using a named model enables client-side renaming without breaking wire contract.
 */
model ExportQueryParameters {
  /** Knowledge base Import or Export format. */
  @query("format")
  format?: format = format.json;

  /** Kind of the asset of the project. */
  @query("assetKind")
  assetKind?: AssestKind;
}

/**
 * Optional query parameters for the import operation.
 */
model ImportQueryParameters {
  /** Knowledge base Import or Export format. */
  @query("format")
  format?: format = format.json;

  /** Kind of the asset of the project. */
  @query("assetKind")
  assetKind?: AssestKind;
}

/**
 * Supported source types.
 */
union sourceKind {
  string,

  /**
   * File Source.
   */
  file: "file",

  /**
   * URI Source.
   */
  url: "url",
}

/**
 * Content structure type for sources.
 */
union sourceContentStructureKind {
  string,

  /**
   * Unstructured.
   */
  unstructured: "unstructured",
}

/**
 * Update operation type for assets.
 */
union updateOperationKind {
  string,

  /**
   * Add operation.
   */
  add: "add",

  /**
   * Delete operation.
   */
  delete: "delete",

  /**
   * Replace operation.
   */
  replace: "replace",
}

/**
 * Collection of files containing project assets that need to be imported.
 */
@added(Versions.v2025_05_15_preview)
model ImportFiles {
  /**
   * Collection of files where the fileName is required.
   */
  files: HttpPart<File>[];
}

/**
 * A single file operation for updating sources for a project. Used to add, remove or replace a source from a knowledgebase.
 */
#suppress "@azure-tools/typespec-autorest/unsupported-multipart-type" "known issue Multipart parts can only be represented as primitive types in swagger 2.0. Information is lost for part 'fileOperations'"
@added(Versions.v2025_05_15_preview)
model UpdateSourceFromFileOperationRecord {
  /** Update operation type for assets. */
  operation: updateOperationKind;

  /**
   * Friendly name of the Source. If not provided, would be equal to fileSource
   */
  @maxLength(200)
  @minLength(1)
  fileDisplayName?: string;

  /** This would be name of the file. This links to the fileName of the file being sent in multipart. */
  fileName: string;

  /** Bool value for refresh. */
  refresh?: boolean;
}

/**
 * Collection of files containing project assets that need to be imported.
 */
@added(Versions.v2025_05_15_preview)
model UpdateSourceFiles {
  ...ImportFiles;

  /**
   * Collection of file operations to perform during update of sources.
   */
  fileOperations: HttpPart<UpdateSourceFromFileOperationRecord>[];
}

/**
 * Represents the project.
 */
@resource("authoring/query-knowledgebases/projects")
model QuestionAnsweringProjectMetadata {
  /**
   * Name of the project.
   */
  @key("projectName")
  @visibility(Lifecycle.Read)
  @maxLength(100)
  @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]{0,98}[a-zA-Z0-9]$")
  projectName: string;

  /**
   * Description of the project.
   */
  description?: string;

  /**
   * Language of the text records. This is BCP-47 representation of a language. For
   * example, use "en" for English; "es" for Spanish etc. If not set, use "en" for
   * English as default.
   */
  language?: string;

  /**
   * Resource enabled for multiple languages across projects or not.
   */
  multilingualResource?: boolean;

  /**
   * Configurable settings of the Project.
   */
  settings?: ProjectSettings;

  /**
   * Project creation date-time.
   */
  @visibility(Lifecycle.Read)
  createdDateTime?: utcDateTime;

  /**
   * Represents the project last modified date-time.
   */
  @visibility(Lifecycle.Read)
  lastModifiedDateTime?: utcDateTime;

  /**
   * Represents the project last deployment date-time.
   */
  @visibility(Lifecycle.Read)
  lastDeployedDateTime?: utcDateTime;

  /**
   * Represents if semantic ranking is configured.
   */
  @added(Versions.v2025_05_15_preview)
  configureSemanticRanking?: boolean;
}

/**
 * Configurable settings of the Project.
 */
model ProjectSettings {
  /**
   * Default Answer response when no good match is found in the knowledge base.
   */
  defaultAnswer?: string;
}

/**
 * Error response.
 */
@error
model ErrorResponse is Azure.Core.Foundations.ErrorResponseBase<Error>;

/**
 * The error object.
 */
model Error {
  /**
   * One of a server-defined set of error codes.
   */
  code: ErrorCode;

  /**
   * A human-readable representation of the error.
   */
  message: string;

  /**
   * The target of the error.
   */
  target?: string;

  /**
   * An array of details about specific errors that led to this reported error.
   */
  details?: Error[];

  /**
   * An object containing more specific information than the current object about
   * the error.
   */
  innererror?: InnerErrorModel;
}

/**
 * An object containing more specific information about the error. As per
 * Microsoft One API guidelines -
 * https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#7102-error-condition-responses.
 */
model InnerErrorModel {
  /**
   * One of a server-defined set of error codes.
   */
  code: InnerErrorCode;

  /**
   * Error message.
   */
  message: string;

  /**
   * Error details.
   */
  details?: Record<string>;

  /**
   * Error target.
   */
  target?: string;

  /**
   * An object containing more specific information than the current object about
   * the error.
   */
  innererror?: InnerErrorModel;
}

/**
 * Represents the state of a project deletion job.
 */
@resource("authoring/query-knowledgebases/projects/deletion-jobs")
model QuestionAnsweringAuthoringProjectDeletionJobState {
  ...QuestionAnsweringAuthoringJobState;
}

/**
 * Job state represents the job metadata and any errors.
 */
@resource("sources/jobs")
@parentResource(QuestionAnsweringProjectMetadata)
model QuestionAnsweringAuthoringUpdateSourcesJobState {
  ...QuestionAnsweringAuthoringJobState;
}

/**
 * Job state represents the job metadata and any errors.
 */
@resource("qnas/jobs")
@parentResource(QuestionAnsweringProjectMetadata)
model QuestionAnsweringAuthoringUpdateQnasJobState {
  ...QuestionAnsweringAuthoringJobState;
}

/**
 * Export job status, project metadata, and assets.
 */
@resource("export/jobs")
@parentResource(QuestionAnsweringProjectMetadata)
model QuestionAnsweringAuthoringExportJobState {
  ...QuestionAnsweringAuthoringJobState;
  ...ExportJobResultUrl;
}

/**
 * Import job status, project metadata, and assets.
 */
@resource("import/jobs")
@parentResource(QuestionAnsweringProjectMetadata)
model QuestionAnsweringAuthoringImportJobState {
  ...QuestionAnsweringAuthoringJobState;
}

/**
 * Job state represents the job metadata and any errors.
 */
@resource("jobs")
@parentResource(ProjectDeployment)
model QuestionAnsweringAuthoringProjectDeploymentJobState {
  ...QuestionAnsweringAuthoringJobState;
}

/** Base class for all LRO Job states */
model QuestionAnsweringAuthoringJobState {
  /** The creation date time of the job. */
  createdDateTime: utcDateTime;

  /** The expiration date time of the job. */
  expirationDateTime?: utcDateTime;

  /** The job ID. */
  @key
  @visibility(Lifecycle.Read)
  jobId: string;

  /** The last date time the job was updated. */
  lastUpdatedDateTime: utcDateTime;

  /**
   * Job Status.
   */
  status: jobStatus;

  /**
   * The errors encountered while executing the job.
   */
  errors?: Foundations.Error[];
}

/**
 * URL to download the result of the Export Job.
 */
model ExportJobResultUrl {
  /**
   * URL to download the result of the Export Job.
   */
  resultUrl: string;
}

/**
 * Project assets that need to be imported.
 */
model ImportJobOptions {
  /**
   * Parameters needed to create the project.
   */
  metadata?: QuestionAnsweringProjectMetadata;

  /**
   * All assets for this project.
   */
  assets?: Assets;

  /**
   * Import data File URI.
   */
  fileUri?: string;
}

/**
 * All assets for this project.
 */
model Assets {
  /**
   * Collection of synonyms.
   */
  @maxItems(10000)
  synonyms?: WordAlterations[];

  /**
   * List of QnA records to import.
   */
  qnas?: ImportQnaRecord[];
}

/** Response payload after synonyms updated successfully. */
model UpdateSynonymsWithNoContentResponse {
  @doc("Status code.")
  @statusCode
  _: 204;
}

/** Request payload for updating synonyms. */
model SynonymAssets is Azure.Core.Page<WordAlterations>;

/**
 * Collection of word alterations.
 */
@resource("synonyms")
@parentResource(QuestionAnsweringProjectMetadata)
model WordAlterations {
  /**
   * Collection of word alterations.
   */
  @key
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @maxItems(20)
  alterations: string[];
}

/**
 * Import QnA Record.
 */
model ImportQnaRecord {
  ...RetrieveQnaRecord;
  ...SourceDisplayNameParameter;
}

/**
 * QnA Record with last updated date-time.
 */
@resource("qnas")
@parentResource(QuestionAnsweringProjectMetadata)
model RetrieveQnaRecord {
  ...QnaRecord;
  ...LastUpdatedDateTimeParameter;
}

/**
 * QnA record.
 */
model QnaRecord {
  /**
   * Unique ID for the QnA.
   */
  @key
  @visibility(Lifecycle.Read, Lifecycle.Create)
  id: int32;

  /**
   * Answer text.
   */
  @maxLength(25000)
  @minLength(1)
  answer?: string;

  /**
   * Source from which QnA was indexed e.g.
   * https://docs.microsoft.com/en-us/azure/cognitive-services/QnAMaker/FAQs .
   */
  @maxLength(300)
  source?: string;

  /**
   * List of questions associated with the answer.
   */
  @minItems(1)
  @maxItems(100)
  questions?: string[];

  /**
   * Metadata associated with the answer, useful to categorize or filter question
   * answers.
   */
  metadata?: Record<string>;

  /**
   * Context of a QnA.
   */
  dialog?: QnaDialog;

  /**
   * List of Active Learning suggestions for the QnA.
   */
  activeLearningSuggestions?: SuggestedQuestionsCluster[];
}

/**
 * Dialog associated with QnA Record.
 */
model QnaDialog {
  /**
   * To mark if a prompt is relevant only with a previous question or not. If true,
   * do not include this QnA as answer for queries without context; otherwise,
   * ignores context and includes this QnA in answers.
   */
  isContextOnly?: boolean;

  /**
   * List of prompts associated with the answer.
   */
  @maxItems(20)
  prompts?: QnaPrompt[];
}

/**
 * Prompt for an answer.
 */
model QnaPrompt {
  /**
   * Index of the prompt. It is used for ordering of the prompts.
   */
  displayOrder?: int32;

  /**
   * ID of the QnA corresponding to the prompt.
   */
  qnaId?: int32;

  /**
   * QnA record. Either QnAId or QnA record needs to be present in a Prompt.
   */
  qna?: QnaRecord;

  /**
   * Text displayed to represent a follow up question prompt.
   */
  @maxLength(200)
  displayText?: string;
}

/**
 * Active Learning suggested questions cluster details.
 */
model SuggestedQuestionsCluster {
  /**
   * Question chosen as the head of suggested questions cluster by Active Learning
   * clustering algorithm.
   */
  clusterHead?: string;

  /**
   * List of all suggested questions for the QnA.
   */
  suggestedQuestions?: SuggestedQuestion[];
}

/**
 * Question suggested by the Active Learning feature.
 */
model SuggestedQuestion {
  /**
   * Question suggested by the Active Learning feature.
   */
  question?: string;

  /**
   * The number of times the question was suggested explicitly by the user.
   */
  userSuggestedCount?: int32;

  /**
   * The number of times the question was suggested automatically by the Active
   * Learning algorithm.
   */
  autoSuggestedCount?: int32;
}

/**
 * Last updated date-time parameter.
 */
model LastUpdatedDateTimeParameter {
  /**
   * Date-time when the QnA was last updated.
   */
  lastUpdatedDateTime?: utcDateTime;
}

/** Friendly name of the Source parameter. */
model SourceDisplayNameParameter {
  /**
   * Friendly name of the Source.
   */
  @maxLength(200)
  @minLength(1)
  sourceDisplayName?: string;
}

/**
 * Project deployment details.
 */
@resource("deployments")
@parentResource(QuestionAnsweringProjectMetadata)
model ProjectDeployment {
  /**
   * Name of the deployment.
   */
  @key
  @visibility(Lifecycle.Read)
  deploymentName: string;

  /**
   * Represents the project last deployment date-time.
   */
  lastDeployedDateTime?: utcDateTime;
}

/**
 * Custom source record with last updated date-time.
 */
@resource("sources")
@parentResource(QuestionAnsweringProjectMetadata)
model QnaSourceRecord {
  ...QnaSourceMetadata;
  ...LastUpdatedDateTimeParameter;
}

/**
 * Input source file or url details.
 */
model QnaSourceMetadata {
  /**
   * Friendly name of the Source.
   */
  @maxLength(200)
  @minLength(1)
  displayName?: string;

  /**
   * Unique source identifier. Name of the file if it's a 'file' source; otherwise,
   * the complete URL if it's a 'url' source.
   */
  @key
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  source: string;

  /**
   * URI location for the file or url.
   */
  sourceUri: url;

  /**
   * Supported source types.
   */
  sourceKind: sourceKind;

  /**
   * Content structure type for sources.
   */
  contentStructureKind?: sourceContentStructureKind = sourceContentStructureKind.unstructured;
}

/**
 * Source to be updated.
 */
model UpdateSourceRecord {
  /**
   * Update operation type for assets.
   */
  `op`: updateOperationKind;

  /**
   * Update source record.
   */
  value: UpdateQnaSourceRecord;
}

/**
 * Update source record.
 */
model UpdateQnaSourceRecord {
  ...QnaSourceMetadata;
  ...RefreshSourceOptions;
}

/**
 * Boolean flag used to refresh data from the Source.
 */
model RefreshSourceOptions {
  /**
   * Boolean flag used to refresh data from the Source.
   */
  refresh?: boolean;
}

/** A list of QnAs to be updated. */
model UpdateQnaOptions is UpdateQnaRecord[];

/**
 * QnA record to be updated.
 */
model UpdateQnaRecord {
  /**
   * Update operation type for assets.
   */
  `op`: updateOperationKind;

  /**
   * QnA record.
   */
  value: QnaRecord;
}

/**
 * Feedback for Active Learning.
 */
model ActiveLearningFeedback {
  /**
   * A list of Feedback Records for Active Learning.
   */
  records?: FeedbackRecord[];
}

/**
 * Feedback Record for Active Learning.
 */
model FeedbackRecord {
  /**
   * Unique identifier of the user.
   */
  userId?: string;

  /**
   * User suggested question for the QnA.
   */
  userQuestion?: string;

  /**
   * Unique ID of the QnA.
   */
  qnaId?: int32;
}

/**
 * The request has been accepted for processing, but processing has not yet completed.
 */
model AcceptedResponse is TypeSpec.Http.AcceptedResponse;

/**
 * There is no content to send for this request, but the headers may be useful.
 */
model NoContentResponse is TypeSpec.Http.NoContentResponse;

/**
 * Feedback recorded successfully.
 */
model AddFeedBackNoContentResponse is NoContentResponse;

alias ExportJobResponse = AcceptedResponse;

alias DeleteProjectAcceptedResponse = TypeSpec.Http.AcceptedResponse;
