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

/** These are the [Azure Active Directory OAuth2](https://docs.microsoft.com/azure/active-directory/develop/v1-overview) Flows. When paired with [Azure role-based access](https://docs.microsoft.com/azure/role-based-access-control/overview) control it can be used to control access to Azure Maps REST APIs. Azure role-based access controls are used to designate access to one or more Azure Maps resource account or sub-resources. Any user, group, or service principal can be granted access via a  built-in role or a custom role composed of one or more permissions to Azure Maps REST APIs.\n\nTo implement scenarios, we recommend viewing [authentication concepts](https://aka.ms/amauth). In summary, this security definition provides a solution for modeling application(s) via objects capable of access control on specific APIs and scopes.\n\n#### Notes\n* This security definition **requires** the use of the `x-ms-client-id` header to indicate which Azure Maps resource the application is requesting access to. This can be acquired from the [Maps management API](https://aka.ms/amauthdetails).\n* \nThe `Authorization URL` is specific to the Azure public cloud instance. Sovereign clouds have unique Authorization URLs and Azure Active directory configurations. \n* \nThe Azure role-based access control is configured from the [Azure management plane](https://aka.ms/amrbac) via Azure portal, PowerShell, CLI, Azure SDKs, or REST APIs.\n* \nUsage of the [Azure Maps Web SDK](https://aka.ms/amaadmc) allows for configuration based setup of an application for multiple use cases.\n* Currently, Azure Active Directory [v1.0 or v2.0](https://docs.microsoft.com/azure/active-directory/develop/azure-ad-endpoint-comparison) supports Work, School, and Guests but does not support Personal accounts. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model AADToken
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
      scopes: ["https://cognitiveservices.azure.com/.default"];
    }
  ]>;

/** The kind of the analyze-text tasks supported. */
union AnalyzeTextTaskKind {
  string,

  /** Sentiment analysis task */
  SentimentAnalysis: "SentimentAnalysis",

  /** Entity recognition task */
  EntityRecognition: "EntityRecognition",

  /** PII entity recognition task */
  PiiEntityRecognition: "PiiEntityRecognition",

  /** Key phrase extraction task */
  KeyPhraseExtraction: "KeyPhraseExtraction",

  /** Language detection task */
  LanguageDetection: "LanguageDetection",

  /** Entity linking task */
  EntityLinking: "EntityLinking",

  /** Dynamic classification task */
  @added(Versions.v2023_11_15_preview)
  DynamicClassification: "DynamicClassification",
}

/** The kind of the long running analyze text tasks supported. */
union AnalyzeTextLROTaskKind {
  string,

  /** Sentiment analysis task */
  SentimentAnalysis: "SentimentAnalysis",

  /** Entity recognition task */
  EntityRecognition: "EntityRecognition",

  /** PII entity recognition task */
  PiiEntityRecognition: "PiiEntityRecognition",

  /** Key phrase extraction task */
  KeyPhraseExtraction: "KeyPhraseExtraction",

  /** Entity linking task */
  EntityLinking: "EntityLinking",

  /** Healthcare task */
  Healthcare: "Healthcare",

  /** Custom entity recognition task */
  CustomEntityRecognition: "CustomEntityRecognition",

  /** Custom single label classification task */
  CustomSingleLabelClassification: "CustomSingleLabelClassification",

  /** Custom multi label classification task */
  CustomMultiLabelClassification: "CustomMultiLabelClassification",

  /** Extractive summarization task */
  @added(Versions.v2023_04_01)
  ExtractiveSummarization: "ExtractiveSummarization",

  /** Abstractive summarization task */
  @added(Versions.v2023_04_01)
  AbstractiveSummarization: "AbstractiveSummarization",

  /** Custom healthcare task */
  @added(Versions.v2023_11_15_preview)
  CustomHealthcare: "CustomHealthcare",

  /** Custom sentiment analysis task */
  @added(Versions.v2023_11_15_preview)
  CustomSentimentAnalysis: "CustomSentimentAnalysis",

  /** Custom abstractive summarization task */
  @added(Versions.v2023_11_15_preview)
  CustomAbstractiveSummarization: "CustomAbstractiveSummarization",
}

/** The kind of the response object returned by the analyze-text task. */
union AnalyzeTextTaskResultsKind {
  string,

  /** Sentiment analysis results */
  SentimentAnalysisResults: "SentimentAnalysisResults",

  /** Entity recognition results */
  EntityRecognitionResults: "EntityRecognitionResults",

  /** PII entity recognition results */
  PiiEntityRecognitionResults: "PiiEntityRecognitionResults",

  /** Key phrase extraction results */
  KeyPhraseExtractionResults: "KeyPhraseExtractionResults",

  /** Language detection results */
  LanguageDetectionResults: "LanguageDetectionResults",

  /** Entity linking results */
  EntityLinkingResults: "EntityLinkingResults",

  /** Dynamic classification results */
  @added(Versions.v2023_11_15_preview)
  DynamicClassificationResults: "DynamicClassificationResults",
}

/** The kind of the response object returned by the analyze-text long running task. */
union AnalyzeTextLROResultsKind {
  string,

  /** Sentiment analysis LRO results */
  SentimentAnalysisLROResults: "SentimentAnalysisLROResults",

  /** Entity recognition LRO results */
  EntityRecognitionLROResults: "EntityRecognitionLROResults",

  /** PII entity recognition LRO results */
  PiiEntityRecognitionLROResults: "PiiEntityRecognitionLROResults",

  /** Key phrase extraction LRO results */
  KeyPhraseExtractionLROResults: "KeyPhraseExtractionLROResults",

  /** Entity linking LRO results */
  EntityLinkingLROResults: "EntityLinkingLROResults",

  /** Healthcare LRO results */
  HealthcareLROResults: "HealthcareLROResults",

  /** Custom entity recognition LRO results */
  CustomEntityRecognitionLROResults: "CustomEntityRecognitionLROResults",

  /** Custom single label classification LRO results */
  CustomSingleLabelClassificationLROResults: "CustomSingleLabelClassificationLROResults",

  /** Custom multi label classification LRO results */
  CustomMultiLabelClassificationLROResults: "CustomMultiLabelClassificationLROResults",

  /** Extractive summarization LRO results */
  @added(Versions.v2023_04_01)
  ExtractiveSummarizationLROResults: "ExtractiveSummarizationLROResults",

  /** Abstractive summarization LRO results */
  @added(Versions.v2023_04_01)
  AbstractiveSummarizationLROResults: "AbstractiveSummarizationLROResults",

  /** Custom healthcare LRO results */
  @added(Versions.v2023_11_15_preview)
  CustomHealthcareLROResults: "CustomHealthcareLROResults",

  /** Custom sentiment analysis LRO results */
  @added(Versions.v2023_11_15_preview)
  CustomSentimentAnalysisLROResults: "CustomSentimentAnalysisLROResults",

  /** Custom abstractive summarization LRO results */
  @added(Versions.v2023_11_15_preview)
  CustomAbstractiveSummarizationLROResults: "CustomAbstractiveSummarizationLROResults",
}

/** Collection of input documents to be analyzed by the service. */
model MultiLanguageAnalysisInput {
  /** The input documents to be analyzed. */
  documents?: Array<MultiLanguageInput>;
}

/** Collection of documents to analyze and a single task to execute. */
@discriminator("kind")
model AnalyzeTextTask {
  /** The kind of task to perform. */
  kind: AnalyzeTextTaskKind;
}
/** The long running task to be performed by the service on the input documents. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@discriminator("kind")
model AnalyzeTextLROTask is TaskIdentifier {
  /** The kind of task to perform. */
  kind: AnalyzeTextLROTaskKind;
}

/** The result object for the analyze task. */
@discriminator("kind")
model AnalyzeTextTaskResult {
  /** The kind of task result. */
  kind: AnalyzeTextTaskResultsKind;
}

/** The input object for the analyze text LRO. */
model AnalyzeTextJobsInput {
  /** Name for the task. */
  displayName?: string;

  /** Contains the input to be analyzed. */
  analysisInput: MultiLanguageAnalysisInput;

  /** List of tasks to be performed as part of the LRO. */
  tasks: Array<AnalyzeTextLROTask>;

  /** Default language to use for records requesting automatic language detection. */
  @added(Versions.v2023_11_15_preview)
  defaultLanguage?: string;
}

/** The input object for the prebuilt/default result. */
model AnalyzeTextPreBuiltResult {
  /** Errors by document id. */
  errors: Array<AnalyzeTextDocumentError>;

  /** if showStats=true was specified in the request this field will contain information about the request payload. */
  statistics?: RequestStatistics;

  /** This field indicates which model is used for analysis. */
  modelVersion: string;
}

/** The object containing the analyze job LRO job state. */
@resource("analyze-text/jobs")
model AnalyzeTextJobState {
  ...JobState;
  ...TasksState;
  ...AnalyzeTextJobStatistics;
}

/** Contains the pagination information. */
model Pagination {
  /** The nextLink for getting the next paginated response. */
  nextLink?: string;
}

/** Contains the analyze text LRO errors */
model AnalyzeTextJobErrors {
  /** Collection of errors encountered during processing. */
  errors: Array<Error>;
}

/** Contains the analyze text job statistics returned only when showStats=true. */
model AnalyzeTextJobStatistics {
  /** if showStats=true was specified in the request this field will contain information about the request payload. */
  statistics?: RequestStatistics;
}

/** Contains the analyze text job tasks. */
model TasksState {
  /** List of tasks. */
  tasks: Tasks;
}

/** Container for the tasks status for the LRO job. */
model Tasks {
  /** Count of completed tasks. */
  completed: int32;

  /** Count of failed tasks. */
  failed: int32;

  /** Count of inprogress tasks. */
  inProgress: int32;

  /** Count of total tasks. */
  total: int32;

  /** Enumerable of Analyze text job results. */
  items?: Array<AnalyzeTextLROResult>;
}

/** List of job statuses. */
union Status {
  string,

  /** Not started status */
  notStarted: "notStarted",

  /** Running status */
  running: "running",

  /** Succeeded status */
  succeeded: "succeeded",

  /** Failed status */
  failed: "failed",

  /** Cancelled status */
  cancelled: "cancelled",

  /** Cancelling status */
  cancelling: "cancelling",
}

/** Contains the AnalyzeText long running operation result object. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@discriminator("kind")
model AnalyzeTextLROResult {
  ...TaskState;
  ...TaskIdentifier;

  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind;
}

/** Contains the result object for the processed document. */
model DocumentResult {
  /** Unique, non-empty document identifier. */
  id: string;

  /** Warnings encountered while processing document. */
  warnings: Array<DocumentWarning>;

  /** if showStats=true was specified in the request this field will contain information about the document payload. */
  statistics?: DocumentStatistics;
}

/** Contains the error object with errors encountered for the processed document. */
model AnalyzeTextDocumentError {
  /** Document Id. */
  id: string;

  /** Document Error. */
  error: Error;
}

/** Contains the warnings object with warnings encountered for the processed document. */
model DocumentWarning {
  /** Warning code. */
  code: WarningCodeValue;

  /** Warning message. */
  message: string;

  /** A JSON pointer reference indicating the target object. */
  targetRef?: string;
}

/** Defines the list of the warning codes. */
union WarningCodeValue {
  string,

  /** Long words in document warning */
  LongWordsInDocument: "LongWordsInDocument",

  /** Document truncated warning */
  DocumentTruncated: "DocumentTruncated",
}

/** if showStats=true was specified in the request this field will contain information about the document payload. */
model DocumentStatistics {
  /** Number of text elements recognized in the document. */
  charactersCount: int32;

  /** Number of transactions for the document. */
  transactionsCount: int32;
}

/** Contains an input document to be analyzed by the service. */
model MultiLanguageInput {
  /** A unique, non-empty document identifier. */
  id: string;

  /** The input text to process. */
  text: string;

  /** (Optional) This is the 2 letter ISO 639-1 representation of a language. For example, use \"en\" for English; \"es\" for Spanish etc. If not set, use \"en\" for English as default. (Following only applies to 2023-04-15-preview and above) For Auto Language Detection, use \"auto\". If not set, use \"en\" for English as default. */
  language?: string;
}

/** Defines the detected language for the document. */
@added(Versions.v2023_11_15_preview)
model DocumentDetectedLanguage {
  /** If 'language' is set to 'auto' for the document in the request this field will contain a 2 letter ISO 639-1 representation of the language detected for this document. */
  detectedLanguage?: DetectedLanguage;
}

/** Error response. */
@error
model ErrorResponse is Azure.Core.Foundations.ErrorResponseBase<Error>;

/** An object containing more specific information about the error. As per Microsoft One API guidelines - https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#7102-error-condition-responses. */
model InnerErrorModel {
  /** One of a server-defined set of error codes. */
  code: InnerErrorCode;

  /** Error message. */
  message: string;

  /** Error details. */
  details?: Record<string>;

  /** Error target. */
  target?: string;

  /** An object containing more specific information than the current object about the error. */
  innererror?: InnerErrorModel;
}

/** Specifies the method used to interpret string offsets.  Defaults to Text Elements (Graphemes) according to Unicode v8.0.0. For additional information see https://aka.ms/text-analytics-offsets. */
union StringIndexType {
  string,

  /** Returned offset and length values will correspond to TextElements (Graphemes and Grapheme clusters) confirming to the Unicode 8.0.0 standard. Use this option if your application is written in .Net Framework or .Net Core and you will be using StringInfo. */
  TextElements_v8: "TextElements_v8",

  /** Returned offset and length values will correspond to Unicode code points. Use this option if your application is written in a language that support Unicode, for example Python. */
  UnicodeCodePoint: "UnicodeCodePoint",

  /** Returned offset and length values will correspond to UTF-16 code units. Use this option if your application is written in a language that support Unicode, for example Java, JavaScript. */
  Utf16CodeUnit: "Utf16CodeUnit",
}

/** Returns the current state of the task. */
model TaskState {
  /** The last updated time in UTC for the task. */
  lastUpdateDateTime: utcDateTime;

  /** The status of the task at the mentioned last update time. */
  status: State;
}

/** The status of the task at the mentioned last update time. */
@lroStatus
union State {
  string,

  /** Not started status */
  notStarted: "notStarted",

  /** Running status */
  running: "running",

  /** Succeeded status */
  @lroSucceeded
  succeeded: "succeeded",

  /** Partially completed status */
  partiallyCompleted: "partiallyCompleted",

  /** Failed status */
  @lroFailed
  failed: "failed",

  /** Cancelled status */
  @lroCanceled
  cancelled: "cancelled",

  /** Cancelling status */
  cancelling: "cancelling",
}

/** Base task object. */
model TaskIdentifier {
  /** task name */
  taskName?: string;
}

/** Base parameters object for a text analysis task. */
model TaskParameters {
  /** logging opt out */
  loggingOptOut?: boolean = false;
}

/** Parameters object for a text analysis task using pre-built models. */
model PreBuiltTaskParameters is TaskParameters {
  /** model version */
  modelVersion?: string = "latest";
}

alias ShowStatsQueryParameter = QueryParametersTrait<{
  /** (Optional) if set to true, response will contain request and document level statistics. */
  @query
  showStats?: boolean;
}>;

alias AnalyzeTextJobQueryParameters = QueryParametersTrait<{
  /** (Optional) if set to true, response will contain request and document level statistics. */
  @query
  showStats?: boolean;

  /** The maximum number of resources to return from the collection. */
  @query
  top?: int32;

  /** An offset into the collection of the first resource to be returned. */
  @query
  skip?: int32;
}>;

alias AnalyzeTextQueryParameters = {
  /** (Optional) if set to true, response will contain request and document level statistics. */
  @query
  showStats?: boolean;
};

/** job state */
model JobState {
  /** display name */
  displayName?: string;

  /** Date and time job created */
  createdDateTime: utcDateTime;

  /** Date and time job expires */
  expirationDateTime?: utcDateTime;

  /** job ID */
  @key
  @visibility("read")
  jobId: uuid;

  /** last updated date and time */
  lastUpdatedDateTime: utcDateTime;

  /** status */
  status: State;

  /** errors */
  errors?: Array<Error>;

  /** next link */
  nextLink?: string;
}

/** job errors */
model JobErrors {
  /** errors */
  errors?: Array<Error>;
}

/** Contains details of errors encountered during a job execution. */
model DocumentError {
  /** The ID of the input document. */
  id: string;

  /** Error encountered. */
  error: Error;
}

/** Contains details of warnings encountered during a job execution. */
model InputWarning {
  /** Warning code. */
  code: string;

  /** Warning message. */
  message: string;

  /** A JSON pointer reference indicating the target object. */
  targetRef?: string;
}

/** if showStats=true was specified in the request this field will contain information about the request payload. */
model RequestStatistics {
  /** Number of documents submitted in the request. */
  documentsCount: int32;

  /** Number of valid documents. This excludes empty, over-size limit or non-supported languages documents. */
  validDocumentsCount: int32;

  /** Number of invalid documents. This includes empty, over-size limit or non-supported languages documents. */
  erroneousDocumentsCount: int32;

  /** Number of transactions for the request. */
  transactionsCount: int64;
}

/** Pre built result */
model PreBuiltResult {
  /** Errors by document id. */
  errors: Array<DocumentError>;

  /** if showStats=true was specified in the request this field will contain information about the request payload. */
  statistics?: RequestStatistics;

  /** This field indicates which model is used for scoring. */
  modelVersion: string;
}

/** Human-readable error code. */
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

/** Human-readable error code. */
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

/** Predicted sentiment for document (Negative, Neutral, Positive, or Mixed). */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" // defined as closed enum
union DocumentSentimentValue {
  /** Positive statement */
  positive: "positive",

  /** Neutral statement */
  neutral: "neutral",

  /** Negative statement */
  negative: "negative",

  /** Mixed statement */
  mixed: "mixed",
}

/** Represents the confidence scores between 0 and 1 across all sentiment classes: positive, neutral, negative. */
model SentimentConfidenceScores {
  /** Confidence score for positive sentiment */
  positive: float64;

  /** Confidence score for neutral sentiment */
  neutral: float64;

  /** Confidence score for negative sentiment */
  negative: float64;
}

/** Enum that defines the length of the output summaries. */
@added(Versions.v2023_11_15_preview)
union SummaryLengthBucket {
  string,

  /** Instructs model to generate shorter length summaries. */
  short: "short",

  /** Instructs model to generate medium length summaries. */
  medium: "medium",

  /** Instructs model to generate longer length summaries. */
  long: "long",
}

/** Supported parameters for an Abstractive Summarization task. */
@added(Versions.v2023_04_01)
model AbstractiveSummarizationTaskParametersBase {
  /** Controls the approximate number of sentences in the output summaries. */
  sentenceCount?: int32;

  /** String index type */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  /** (NOTE: Recommended to use summaryLength over sentenceCount) Controls the approximate length of the output summaries. */
  @added(Versions.v2023_11_15_preview)
  summaryLength?: SummaryLengthBucket;
}

/** The context of the summary. */
model SummaryContext {
  /** Start position for the context. Use of different 'stringIndexType' values can affect the offset returned. */
  offset: int32;

  /** The length of the context. Use of different 'stringIndexType' values can affect the length returned. */
  length: int32;
}

/** Parameters object for a text analysis task using custom models. */
model CustomTaskParameters is TaskParameters {
  /** This field indicates the project name for the model. */
  projectName: string;

  /** This field indicates the deployment name for the model. */
  deploymentName: string;
}

/** Custom Task Results */
model CustomResult {
  /** Errors by document id. */
  errors: Array<DocumentError>;

  /** if showStats=true was specified in the request this field will contain information about the request payload. */
  statistics?: RequestStatistics;

  /** This field indicates the project name for the model. */
  projectName: string;

  /** This field indicates the deployment name for the model. */
  deploymentName: string;
}

/** Optional parameter to use a Custom Character to be used for redaction in PII responses. Default character will be * as before. We allow specific ascii characters for redaction. */
union redactionCharacter {
  string,

  /** Exclamation point character */
  exclamationPoint: "!",

  /** Number sign character */
  numberSign: "#",

  /** Dollar sign character */
  dollar: "$",

  /** Percent sign character */
  perCent: "%",

  /** Ampersand character */
  ampersand: "&",

  /** Asterisk character */
  asterisk: "*",

  /** Plus sign character */
  plus: "+",

  /** Minus sign character */
  minus: "-",

  /** Equals sign character */
  equals: "=",

  /** Question mark character */
  questionMark: "?",

  /** At sign character */
  atSign: "@",

  /** Caret character */
  caret: "^",

  /** Underscore character */
  underscore: "_",

  /** Tilde character */
  tilde: "~",
}

/** The error response object returned when the service encounters some errors during processing the request. */
model Error {
  /** One of a server-defined set of error codes. */
  code: ErrorCode;

  /** A human-readable representation of the error. */
  message: string;

  /** The target of the error. */
  target?: string;

  /** An array of details about specific errors that led to this reported error. */
  details?: Array<Error>;

  /** An object containing more specific information than the current object about the error. */
  innererror?: InnerErrorModel;
}
