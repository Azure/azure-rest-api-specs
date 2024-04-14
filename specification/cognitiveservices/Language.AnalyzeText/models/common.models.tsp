import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.AnalyzeText;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("These are the [Azure Active Directory OAuth2](https://docs.microsoft.com/azure/active-directory/develop/v1-overview) Flows. When paired with [Azure role-based access](https://docs.microsoft.com/azure/role-based-access-control/overview) control it can be used to control access to Azure Maps REST APIs. Azure role-based access controls are used to designate access to one or more Azure Maps resource account or sub-resources. Any user, group, or service principal can be granted access via a  built-in role or a custom role composed of one or more permissions to Azure Maps REST APIs.\n\nTo implement scenarios, we recommend viewing [authentication concepts](https://aka.ms/amauth). In summary, this security definition provides a solution for modeling application(s) via objects capable of access control on specific APIs and scopes.\n\n#### Notes\n* This security definition **requires** the use of the `x-ms-client-id` header to indicate which Azure Maps resource the application is requesting access to. This can be acquired from the [Maps management API](https://aka.ms/amauthdetails).\n* \nThe `Authorization URL` is specific to the Azure public cloud instance. Sovereign clouds have unique Authorization URLs and Azure Active directory configurations. \n* \nThe Azure role-based access control is configured from the [Azure management plane](https://aka.ms/amrbac) via Azure portal, PowerShell, CLI, Azure SDKs, or REST APIs.\n* \nUsage of the [Azure Maps Web SDK](https://aka.ms/amaadmc) allows for configuration based setup of an application for multiple use cases.\n* Currently, Azure Active Directory [v1.0 or v2.0](https://docs.microsoft.com/azure/active-directory/develop/azure-ad-endpoint-comparison) supports Work, School, and Guests but does not support Personal accounts.")
model AADToken
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
      scopes: ["https://cognitiveservices.azure.com/.default"];
    }
  ]>;

@doc("The kind of the analyze-text tasks supported.")
union AnalyzeTextTaskKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SentimentAnalysis: "SentimentAnalysis",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityRecognition: "EntityRecognition",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PiiEntityRecognition: "PiiEntityRecognition",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KeyPhraseExtraction: "KeyPhraseExtraction",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LanguageDetection: "LanguageDetection",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityLinking: "EntityLinking",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_11_15_preview)
  DynamicClassification: "DynamicClassification",
}

@doc("The kind of the long running analyze text tasks supported.")
union AnalyzeTextLROTaskKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SentimentAnalysis: "SentimentAnalysis",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityRecognition: "EntityRecognition",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PiiEntityRecognition: "PiiEntityRecognition",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KeyPhraseExtraction: "KeyPhraseExtraction",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityLinking: "EntityLinking",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Healthcare: "Healthcare",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomEntityRecognition: "CustomEntityRecognition",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomSingleLabelClassification: "CustomSingleLabelClassification",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomMultiLabelClassification: "CustomMultiLabelClassification",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ExtractiveSummarization: "ExtractiveSummarization",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  AbstractiveSummarization: "AbstractiveSummarization",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_11_15_preview)
  CustomHealthcare: "CustomHealthcare",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_11_15_preview)
  CustomSentimentAnalysis: "CustomSentimentAnalysis",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_11_15_preview)
  CustomAbstractiveSummarization: "CustomAbstractiveSummarization",
}

@doc("The kind of the response object returned by the analyze-text task.")
union AnalyzeTextTaskResultsKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SentimentAnalysisResults: "SentimentAnalysisResults",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityRecognitionResults: "EntityRecognitionResults",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PiiEntityRecognitionResults: "PiiEntityRecognitionResults",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KeyPhraseExtractionResults: "KeyPhraseExtractionResults",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LanguageDetectionResults: "LanguageDetectionResults",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityLinkingResults: "EntityLinkingResults",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_11_15_preview)
  DynamicClassificationResults: "DynamicClassificationResults",
}

@doc("The kind of the response object returned by the analyze-text long running task.")
union AnalyzeTextLROResultsKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SentimentAnalysisLROResults: "SentimentAnalysisLROResults",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityRecognitionLROResults: "EntityRecognitionLROResults",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PiiEntityRecognitionLROResults: "PiiEntityRecognitionLROResults",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KeyPhraseExtractionLROResults: "KeyPhraseExtractionLROResults",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityLinkingLROResults: "EntityLinkingLROResults",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HealthcareLROResults: "HealthcareLROResults",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomEntityRecognitionLROResults: "CustomEntityRecognitionLROResults",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomSingleLabelClassificationLROResults: "CustomSingleLabelClassificationLROResults",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomMultiLabelClassificationLROResults: "CustomMultiLabelClassificationLROResults",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ExtractiveSummarizationLROResults: "ExtractiveSummarizationLROResults",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  AbstractiveSummarizationLROResults: "AbstractiveSummarizationLROResults",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_11_15_preview)
  CustomHealthcareLROResults: "CustomHealthcareLROResults",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_11_15_preview)
  CustomSentimentAnalysisLROResults: "CustomSentimentAnalysisLROResults",

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_11_15_preview)
  CustomAbstractiveSummarizationLROResults: "CustomAbstractiveSummarizationLROResults",
}

@doc("Collection of input documents to be analyzed by the service.")
model MultiLanguageAnalysisInput {
  @doc("The input documents to be analyzed.")
  documents?: Array<MultiLanguageInput>;
}

@discriminator("kind")
@doc("Collection of documents to analyze and a single task to execute.")
model AnalyzeTextTask {
  @doc("The kind of task to perform.")
  kind: AnalyzeTextTaskKind;
}
#suppress "@azure-tools/typespec-azure-core/casing-style"
@discriminator("kind")
@doc("The long running task to be performed by the service on the input documents.")
model AnalyzeTextLROTask is TaskIdentifier {
  @doc("The kind of task to perform.")
  kind: AnalyzeTextLROTaskKind;
}

@discriminator("kind")
@doc("The result object for the analyze task.")
model AnalyzeTextTaskResult {
  @doc("The kind of task result.")
  kind: AnalyzeTextTaskResultsKind;
}

@doc("The input object for the analyze text LRO.")
model AnalyzeTextJobsInput {
  @doc("Name for the task.")
  displayName?: string;

  @doc("Contains the input to be analyzed.")
  analysisInput: MultiLanguageAnalysisInput;

  @doc("List of tasks to be performed as part of the LRO.")
  tasks: Array<AnalyzeTextLROTask>;

  @added(Versions.v2023_11_15_preview)
  @doc("Default language to use for records requesting automatic language detection.")
  defaultLanguage?: string;
}

@doc("The input object for the prebuilt/default result.")
model AnalyzeTextPreBuiltResult {
  @doc("Errors by document id.")
  errors: Array<AnalyzeTextDocumentError>;

  @doc("if showStats=true was specified in the request this field will contain information about the request payload.")
  statistics?: RequestStatistics;

  @doc("This field indicates which model is used for analysis.")
  modelVersion: string;
}

@doc("The object containing the analyze job LRO job state.")
@resource("analyze-text/jobs")
model AnalyzeTextJobState {
  ...JobState;
  ...TasksState;
  ...AnalyzeTextJobStatistics;
}

@doc("Contains the pagination information.")
model Pagination {
  @doc("The nextLink for getting the next paginated response.")
  nextLink?: string;
}

@doc("Contains the analyze text LRO errors")
model AnalyzeTextJobErrors {
  @doc("Collection of errors encountered during processing.")
  errors: Array<Error>;
}

@doc("Contains the analyze text job statistics returned only when showStats=true.")
model AnalyzeTextJobStatistics {
  @doc("if showStats=true was specified in the request this field will contain information about the request payload.")
  statistics?: RequestStatistics;
}

@doc("Contains the analyze text job tasks.")
model TasksState {
  @doc("List of tasks.")
  tasks: Tasks;
}

@doc("Container for the tasks status for the LRO job.")
model Tasks {
  @doc("Count of completed tasks.")
  completed: int32;

  @doc("Count of failed tasks.")
  failed: int32;

  @doc("Count of inprogress tasks.")
  inProgress: int32;

  @doc("Count of total tasks.")
  total: int32;

  @doc("Enumerable of Analyze text job results.")
  items?: Array<AnalyzeTextLROResult>;
}

@doc("List of job statuses.")
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  notStarted: "notStarted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  running: "running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  succeeded: "succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  failed: "failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  cancelled: "cancelled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  cancelling: "cancelling",
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the AnalyzeText long running operation result object.")
@discriminator("kind")
model AnalyzeTextLROResult {
  ...TaskState;
  ...TaskIdentifier;

  @doc("Kind of the task.")
  kind: AnalyzeTextLROResultsKind;
}

@doc("Base object defining the Analyze Text response.")
model DocumentResponse {}

@doc("Contains the result object for the processed document.")
model DocumentResult {
  @doc("Unique, non-empty document identifier.")
  id: string;

  @doc("Warnings encountered while processing document.")
  warnings: Array<DocumentWarning>;

  @doc("if showStats=true was specified in the request this field will contain information about the document payload.")
  statistics?: DocumentStatistics;
}

@doc("Contains the error object with errors encountered for the processed document.")
model AnalyzeTextDocumentError {
  @doc("Document Id.")
  id: string;

  @doc("Document Error.")
  error: Error;
}

@doc("Contains the warnings object with warnings encountered for the processed document.")
model DocumentWarning {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  code: WarningCodeValue;

  @doc("Warning message.")
  message: string;

  @doc("A JSON pointer reference indicating the target object.")
  targetRef?: string;
}

@doc("Defines the list of the warning codes.")
union WarningCodeValue {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LongWordsInDocument: "LongWordsInDocument",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DocumentTruncated: "DocumentTruncated",
}

@doc("if showStats=true was specified in the request this field will contain information about the document payload.")
model DocumentStatistics {
  @doc("Number of text elements recognized in the document.")
  charactersCount: int32;

  @doc("Number of transactions for the document.")
  transactionsCount: int32;
}

@doc("Contains an input document to be analyzed by the service.")
model MultiLanguageInput {
  @doc("A unique, non-empty document identifier.")
  id: string;

  @doc("The input text to process.")
  text: string;

  @doc("(Optional) This is the 2 letter ISO 639-1 representation of a language. For example, use \"en\" for English; \"es\" for Spanish etc. If not set, use \"en\" for English as default. (Following only applies to 2023-04-15-preview and above) For Auto Language Detection, use \"auto\". If not set, use \"en\" for English as default.")
  language?: string;
}

@doc("Defines the detected language for the document.")
@added(Versions.v2023_11_15_preview)
model DocumentDetectedLanguage {
  @doc("If 'language' is set to 'auto' for the document in the request this field will contain a 2 letter ISO 639-1 representation of the language detected for this document.")
  detectedLanguage?: DetectedLanguage;
}

@doc("Error response.")
@error
model ErrorResponse {
  @doc("The error object.")
  error: Error;
}

@doc("An object containing more specific information about the error. As per Microsoft One API guidelines - https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#7102-error-condition-responses.")
model InnerErrorModel {
  @doc("One of a server-defined set of error codes.")
  code: InnerErrorCode;

  @doc("Error message.")
  message: string;

  @doc("Error details.")
  details?: Record<string>;

  @doc("Error target.")
  target?: string;

  @doc("An object containing more specific information than the current object about the error.")
  innererror?: InnerErrorModel;
}

@doc("Specifies the method used to interpret string offsets.  Defaults to Text Elements (Graphemes) according to Unicode v8.0.0. For additional information see https://aka.ms/text-analytics-offsets.")
union StringIndexType {
  string,

  @doc("Returned offset and length values will correspond to TextElements (Graphemes and Grapheme clusters) confirming to the Unicode 8.0.0 standard. Use this option if your application is written in .Net Framework or .Net Core and you will be using StringInfo.")
  TextElements_v8: "TextElements_v8",

  @doc("Returned offset and length values will correspond to Unicode code points. Use this option if your application is written in a language that support Unicode, for example Python.")
  UnicodeCodePoint: "UnicodeCodePoint",

  @doc("Returned offset and length values will correspond to UTF-16 code units. Use this option if your application is written in a language that support Unicode, for example Java, JavaScript.")
  Utf16CodeUnit: "Utf16CodeUnit",
}

@doc("Returns the current state of the task.")
model TaskState {
  @doc("The last updated time in UTC for the task.")
  lastUpdateDateTime: utcDateTime;

  @doc("The status of the task at the mentioned last update time.")
  status: State;
}

@doc("The status of the task at the mentioned last update time.")
@lroStatus
union State {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'notStarted' should have a documentation or description, please use decorator @doc to add it."
  notStarted: "notStarted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'running' should have a documentation or description, please use decorator @doc to add it."
  running: "running",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'succeeded' should have a documentation or description, please use decorator @doc to add it."
  @lroSucceeded
  succeeded: "succeeded",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'partiallyCompleted' should have a documentation or description, please use decorator @doc to add it."
  partiallyCompleted: "partiallyCompleted",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'failed' should have a documentation or description, please use decorator @doc to add it."
  @lroFailed
  failed: "failed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'cancelled' should have a documentation or description, please use decorator @doc to add it."
  @lroCanceled
  cancelled: "cancelled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'cancelling' should have a documentation or description, please use decorator @doc to add it."
  cancelling: "cancelling",
}

@doc("Base task object.")
model TaskIdentifier {
  @doc("task name")
  taskName?: string;
}

@doc("Base parameters object for a text analysis task.")
model TaskParameters {
  @doc("logging opt out")
  loggingOptOut?: boolean = false;
}

@doc("Parameters object for a text analysis task using pre-built models.")
model PreBuiltTaskParameters is TaskParameters {
  @doc("model version")
  modelVersion?: string = "latest";
}

alias ShowStatsQueryParameter = QueryParametersTrait<{
  @doc("(Optional) if set to true, response will contain request and document level statistics.")
  @query
  showStats?: boolean;
}>;

alias AnalyzeTextJobQueryParameters = QueryParametersTrait<{
  @doc("(Optional) if set to true, response will contain request and document level statistics.")
  @query
  showStats?: boolean;

  @doc("The maximum number of resources to return from the collection.")
  @query
  top?: int32;

  @doc("An offset into the collection of the first resource to be returned.")
  @query
  skip?: int32;
}>;

alias AnalyzeTextQueryParameters = {
  @doc("(Optional) if set to true, response will contain request and document level statistics.")
  @query
  showStats?: boolean;
};

@doc("job state")
model JobState {
  @doc("display name")
  displayName?: string;

  @doc("Date and time job created")
  createdDateTime: utcDateTime;

  @doc("Date and time job expires")
  expirationDateTime?: utcDateTime;

  @doc("job ID")
  @key
  @visibility("read")
  jobId: uuid;

  @doc("last updated date and time")
  lastUpdatedDateTime: utcDateTime;

  @doc("status")
  status: State;

  @doc("errors")
  errors?: Array<Error>;

  @doc("next link")
  nextLink?: string;
}

@doc("job errors")
model JobErrors {
  @doc("errors")
  errors?: Array<Error>;
}

@doc("Contains details of errors encountered during a job execution.")
model DocumentError {
  @doc("The ID of the input document.")
  id: string;

  @doc("Error encountered.")
  error: Error;
}

@doc("Contains details of warnings encountered during a job execution.")
model InputWarning {
  @doc("Warning code.")
  code: string;

  @doc("Warning message.")
  message: string;

  @doc("A JSON pointer reference indicating the target object.")
  targetRef?: string;
}

@doc("if showStats=true was specified in the request this field will contain information about the request payload.")
model RequestStatistics {
  @doc("Number of documents submitted in the request.")
  documentsCount: int32;

  @doc("Number of valid documents. This excludes empty, over-size limit or non-supported languages documents.")
  validDocumentsCount: int32;

  @doc("Number of invalid documents. This includes empty, over-size limit or non-supported languages documents.")
  erroneousDocumentsCount: int32;

  @doc("Number of transactions for the request.")
  transactionsCount: int64;
}

@doc("Pre built result")
model PreBuiltResult {
  @doc("Errors by document id.")
  errors: Array<DocumentError>;

  @doc("if showStats=true was specified in the request this field will contain information about the request payload.")
  statistics?: RequestStatistics;

  @doc("This field indicates which model is used for scoring.")
  modelVersion: string;
}

//todo: add enum member descriptions
@doc("Human-readable error code.")
union InnerErrorCode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidRequest' should have a documentation or description, please use decorator @doc to add it."
  InvalidRequest: "InvalidRequest",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidParameterValue' should have a documentation or description, please use decorator @doc to add it."
  InvalidParameterValue: "InvalidParameterValue",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'KnowledgeBaseNotFound' should have a documentation or description, please use decorator @doc to add it."
  KnowledgeBaseNotFound: "KnowledgeBaseNotFound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchNotFound' should have a documentation or description, please use decorator @doc to add it."
  AzureCognitiveSearchNotFound: "AzureCognitiveSearchNotFound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchThrottling' should have a documentation or description, please use decorator @doc to add it."
  AzureCognitiveSearchThrottling: "AzureCognitiveSearchThrottling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ExtractionFailure' should have a documentation or description, please use decorator @doc to add it."
  ExtractionFailure: "ExtractionFailure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidRequestBodyFormat' should have a documentation or description, please use decorator @doc to add it."
  InvalidRequestBodyFormat: "InvalidRequestBodyFormat",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'EmptyRequest' should have a documentation or description, please use decorator @doc to add it."
  EmptyRequest: "EmptyRequest",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'MissingInputDocuments' should have a documentation or description, please use decorator @doc to add it."
  MissingInputDocuments: "MissingInputDocuments",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidDocument' should have a documentation or description, please use decorator @doc to add it."
  InvalidDocument: "InvalidDocument",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ModelVersionIncorrect' should have a documentation or description, please use decorator @doc to add it."
  ModelVersionIncorrect: "ModelVersionIncorrect",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidDocumentBatch' should have a documentation or description, please use decorator @doc to add it."
  InvalidDocumentBatch: "InvalidDocumentBatch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'UnsupportedLanguageCode' should have a documentation or description, please use decorator @doc to add it."
  UnsupportedLanguageCode: "UnsupportedLanguageCode",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidCountryHint' should have a documentation or description, please use decorator @doc to add it."
  InvalidCountryHint: "InvalidCountryHint",
}

//todo: add enum member descriptions
@doc("Human-readable error code.")
union ErrorCode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidRequest' should have a documentation or description, please use decorator @doc to add it."
  InvalidRequest: "InvalidRequest",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidArgument' should have a documentation or description, please use decorator @doc to add it."
  InvalidArgument: "InvalidArgument",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unauthorized' should have a documentation or description, please use decorator @doc to add it."
  Unauthorized: "Unauthorized",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Forbidden' should have a documentation or description, please use decorator @doc to add it."
  Forbidden: "Forbidden",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'NotFound' should have a documentation or description, please use decorator @doc to add it."
  NotFound: "NotFound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ProjectNotFound' should have a documentation or description, please use decorator @doc to add it."
  ProjectNotFound: "ProjectNotFound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'OperationNotFound' should have a documentation or description, please use decorator @doc to add it."
  OperationNotFound: "OperationNotFound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchNotFound' should have a documentation or description, please use decorator @doc to add it."
  AzureCognitiveSearchNotFound: "AzureCognitiveSearchNotFound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchIndexNotFound' should have a documentation or description, please use decorator @doc to add it."
  AzureCognitiveSearchIndexNotFound: "AzureCognitiveSearchIndexNotFound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'TooManyRequests' should have a documentation or description, please use decorator @doc to add it."
  TooManyRequests: "TooManyRequests",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchThrottling' should have a documentation or description, please use decorator @doc to add it."
  AzureCognitiveSearchThrottling: "AzureCognitiveSearchThrottling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchIndexLimitReached' should have a documentation or description, please use decorator @doc to add it."
  AzureCognitiveSearchIndexLimitReached: "AzureCognitiveSearchIndexLimitReached",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InternalServerError' should have a documentation or description, please use decorator @doc to add it."
  InternalServerError: "InternalServerError",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ServiceUnavailable' should have a documentation or description, please use decorator @doc to add it."
  ServiceUnavailable: "ServiceUnavailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Timeout' should have a documentation or description, please use decorator @doc to add it."
  Timeout: "Timeout",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'QuotaExceeded' should have a documentation or description, please use decorator @doc to add it."
  QuotaExceeded: "QuotaExceeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Conflict' should have a documentation or description, please use decorator @doc to add it."
  Conflict: "Conflict",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Warning' should have a documentation or description, please use decorator @doc to add it."
  Warning: "Warning",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
@doc("Predicted sentiment for document (Negative, Neutral, Positive, or Mixed).")
union DocumentSentimentValue {
  @doc("Positive statement")
  positive: "positive",

  @doc("Neutral statement")
  neutral: "neutral",

  @doc("Negative statement")
  negative: "negative",

  @doc("Mixed statement")
  mixed: "mixed",
}

@doc("Represents the confidence scores between 0 and 1 across all sentiment classes: positive, neutral, negative.")
model SentimentConfidenceScores {
  @doc("Confidence score for positive sentiment")
  positive: float64;

  @doc("Confidence score for neutral sentiment")
  neutral: float64;

  @doc("Confidence score for negative sentiment")
  negative: float64;
}

@added(Versions.v2023_11_15_preview)
@doc("Enum that defines the length of the output summaries.")
union SummaryLengthBucket {
  string,

  @doc("Instructs model to generate shorter length summaries.")
  short: "short",

  @doc("Instructs model to generate medium length summaries.")
  medium: "medium",

  @doc("Instructs model to generate longer length summaries.")
  long: "long",
}

@added(Versions.v2023_04_01)
@doc("Supported parameters for an Abstractive Summarization task.")
model AbstractiveSummarizationTaskParametersBase {
  @doc("Controls the approximate number of sentences in the output summaries.")
  sentenceCount?: int32;

  @doc("String index type")
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  @added(Versions.v2023_11_15_preview)
  @doc("(NOTE: Recommended to use summaryLength over sentenceCount) Controls the approximate length of the output summaries.")
  summaryLength?: SummaryLengthBucket;
}

@doc("The context of the summary.")
model SummaryContext {
  @doc("Start position for the context. Use of different 'stringIndexType' values can affect the offset returned.")
  offset: int32;

  @doc("The length of the context. Use of different 'stringIndexType' values can affect the length returned.")
  length: int32;
}

@doc("Parameters object for a text analysis task using custom models.")
model CustomTaskParameters is TaskParameters {
  @doc("This field indicates the project name for the model.")
  projectName: string;

  @doc("This field indicates the deployment name for the model.")
  deploymentName: string;
}

@doc("Custom Task Results")
model CustomResult {
  @doc("Errors by document id.")
  errors: Array<DocumentError>;

  @doc("if showStats=true was specified in the request this field will contain information about the request payload.")
  statistics?: RequestStatistics;

  @doc("This field indicates the project name for the model.")
  projectName: string;

  @doc("This field indicates the deployment name for the model.")
  deploymentName: string;
}

@doc("Optional parameter to use a Custom Character to be used for redaction in PII responses. Default character will be * as before. We allow specific ascii characters for redaction.")
union redactionCharacter {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  exclamationPoint: "!",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  numberSign: "#",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  dollar: "$",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  perCent: "%",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  ampersand: "&",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  asterisk: "*",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  plus: "+",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  minus: "-",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  equals: "=",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  questionMark: "?",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  atSign: "@",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  caret: "^",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  underscore: "_",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  tilde: "~",
}

@doc("The error response object returned when the service encounters some errors during processing the request.")
model Error {
  @doc("One of a server-defined set of error codes.")
  code: ErrorCode;

  @doc("A human-readable representation of the error.")
  message: string;

  @doc("The target of the error.")
  target?: string;

  @doc("An array of details about specific errors that led to this reported error.")
  details?: Array<Error>;

  @doc("An object containing more specific information than the current object about the error.")
  innererror?: InnerErrorModel;
}
