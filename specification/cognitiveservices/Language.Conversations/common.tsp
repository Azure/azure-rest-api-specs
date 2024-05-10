import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.Conversations;

/** Error response. */
@error
model ErrorResponse is Azure.Core.Foundations.ErrorResponseBase<Error>;

/** The error object. */
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
@added(Versions.v2023_04_01)
model TaskState {
  /** The last updated time in UTC for the task. */
  lastUpdateDateTime: utcDateTime;

  /** The status of the task at the mentioned last update time. */
  status: State;
}

/** The status of the task at the mentioned last update time. */
@lroStatus
@added(Versions.v2023_04_01)
union State {
  string,

  /** Not started state */
  notStarted: "notStarted",

  /** Running state */
  running: "running",

  /** Succeeded state */
  @lroSucceeded
  succeeded: "succeeded",

  /** Partially completed state */
  partiallyCompleted: "partiallyCompleted",

  /** Failed state */
  @lroFailed
  failed: "failed",

  /** Cancelled state */
  @lroCanceled
  cancelled: "cancelled",

  /** Cancelling state */
  cancelling: "cancelling",
}

/** Base task object. */
@added(Versions.v2023_04_01)
model TaskIdentifier {
  /** task name */
  taskName?: string;
}

/** Base parameters object for a text analysis task. */
@added(Versions.v2023_04_01)
model TaskParameters {
  /** logging opt out */
  loggingOptOut?: boolean = false;
}

/** Parameters object for a text analysis task using pre-built models. */
@added(Versions.v2023_04_01)
model PreBuiltTaskParameters is TaskParameters {
  /** model version */
  modelVersion?: string = "latest";
}

alias ShowStatsQueryParameter = QueryParametersTrait<{
  /** (Optional) if set to true, response will contain request and document level statistics. */
  @query
  showStats?: boolean;
}>;

/** job state */
@added(Versions.v2023_04_01)
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
  errors: Array<Error>;
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

  /** statistics */
  statistics?: RequestStatistics;

  /** This field indicates which model is used for scoring. */
  modelVersion: string;
}

/** Represents List of Question Answers. */
model AnswersResult {
  /** Represents Answer Result list. */
  answers?: Array<KnowledgeBaseAnswer>;
}

/** Represents knowledge base answer. */
model KnowledgeBaseAnswer {
  /** List of questions associated with the answer. */
  questions?: Array<string>;

  /** Answer text. */
  answer?: string;

  /** Answer confidence score, value ranges from 0 to 1. */
  @minValue(0)
  @maxValue(1)
  confidenceScore?: float64;

  /** ID of the QnA result. */
  id?: int32;

  /** Source of QnA result. */
  source?: string;

  /** Metadata associated with the answer, useful to categorize or filter question answers. */
  metadata?: Record<string>;

  /** Dialog associated with Answer. */
  dialog?: KnowledgeBaseAnswerDialog;

  /** Answer span object of QnA with respect to user's question. */
  answerSpan?: AnswerSpan;
}

/** Dialog associated with Answer. */
model KnowledgeBaseAnswerDialog {
  /** To mark if a prompt is relevant only with a previous question or not. If true, do not include this QnA as search result for queries without context; otherwise, if false, ignores context and includes this QnA in search result. */
  isContextOnly?: boolean;

  /** List of prompts associated with the answer. */
  @maxItems(20)
  prompts?: Array<KnowledgeBaseAnswerPrompt>;
}

/** Prompt for an answer. */
model KnowledgeBaseAnswerPrompt {
  /** Index of the prompt - used in ordering of the prompts. */
  displayOrder?: int32;

  /** QnA ID corresponding to the prompt. */
  qnaId?: int32;

  /** Text displayed to represent a follow up question prompt. */
  @maxLength(200)
  displayText?: string;
}

/** Answer span object of QnA. */
model AnswerSpan {
  /** Predicted text of answer span. */
  text?: string;

  /** Predicted score of answer span, value ranges from 0 to 1. */
  @minValue(0)
  @maxValue(1)
  confidenceScore?: float64;

  /** The answer span offset from the start of answer. */
  offset?: int32;

  /** The length of the answer span. */
  length?: int32;
}

/** Parameters to query a knowledge base. */
model AnswersOptions {
  /** Exact QnA ID to fetch from the knowledge base, this field takes priority over question. */
  qnaId?: int32;

  /** User question to query against the knowledge base. */
  question?: string;

  /** Max number of answers to be returned for the question. */
  top?: int32;

  /** Unique identifier for the user. */
  userId?: string;

  /** Minimum threshold score for answers, value ranges from 0 to 1. */
  @maxValue(1)
  @minValue(0)
  confidenceScoreThreshold?: float64;

  /** Context object with previous QnA's information. */
  context?: KnowledgeBaseAnswerContext;

  /** Type of ranker to be used. */
  rankerType?: RankerKind;

  /** Filter QnAs based on given metadata list and knowledge base sources. */
  filters?: QueryFilters;

  /** To configure Answer span prediction feature. */
  answerSpanRequest?: ShortAnswerOptions;

  /** (Optional) Flag to enable Query over Unstructured Sources. */
  includeUnstructuredSources?: boolean;
}

/** Type of ranker to be used */
union RankerKind {
  string,

  /** Default ranker. */
  Default: "Default",

  /** Question only ranker. */
  QuestionOnly: "QuestionOnly",
}

/** To configure Answer span prediction feature. */
model ShortAnswerOptions {
  /** Enable or disable Answer Span prediction. */
  enable?: boolean = true;

  /** Minimum threshold score required to include an answer span, value ranges from 0 to 1. */
  @maxValue(1)
  @minValue(0)
  confidenceScoreThreshold?: float64;

  /** Number of Top answers to be considered for span prediction from 1 to 10. */
  @maxValue(10)
  @minValue(1)
  topAnswersWithSpan?: int32;
}

/** Context object with previous QnA's information. */
model KnowledgeBaseAnswerContext {
  /** Previous turn top answer result QnA ID. */
  previousQnaId: int32;

  /** Previous user query. */
  previousUserQuery?: string;
}

/** filters over knowledge base. */
model QueryFilters {
  /** filters over knowledge base. */
  metadataFilter?: MetadataFilter;

  /** filters over knowledge base. */
  sourceFilter?: SourceFilter;

  /** Logical operation used to join metadata filter with source filter. */
  logicalOperation?: LogicalOperationKind = LogicalOperationKind.AND;
}

/** Find QnAs that are associated with the given list of metadata. */
model MetadataFilter {
  /** List of metadata. */
  metadata?: Array<MetadataRecord>;

  /** Operation used to join metadata filters. */
  logicalOperation?: LogicalOperationKind = LogicalOperationKind.AND;
}

/** Object to provide the key value pair for each metadata. */
model MetadataRecord {
  /** Metadata Key from Metadata dictionary used in the QnA. */
  key: string;

  /** Metadata Value from Metadata dictionary used in the QnA. */
  value: string;
}

/** Find QnAs that are associated with any of the given list of sources in knowledge base. */
model SourceFilter is Array<string>;

/** Set to 'OR' or 'AND' for using corresponding logical operation. */
union LogicalOperationKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AND' should have a documentation or description, please use decorator @doc to add it."
  AND: "AND",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'OR' should have a documentation or description, please use decorator @doc to add it."
  OR: "OR",
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

/** Predicted sentiment */
@added(Versions.v2023_04_01)
union TextSentiment {
  string,

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
@added(Versions.v2023_04_01)
model SentimentConfidenceScores {
  /** Confidence score for positive sentiment */
  positive: float64;

  /** Confidence score for neutral sentiment */
  neutral: float64;

  /** Confidence score for negative sentiment */
  negative: float64;
}

/** Enum that defines the length of the output summaries. */
@added(Versions.v2024_05_01)
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
  /** It controls the approximate number of sentences in the output summaries. */
  sentenceCount?: int32;

  /** String index type */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  /** (NOTE: Recommended to use summaryLength over sentenceCount) Controls the approximate length of the output summaries. */
  @added(Versions.v2024_05_01)
  summaryLength?: SummaryLengthBucket;
}

/** The context of the summary. */
@added(Versions.v2023_04_01)
model SummaryContext {
  /** Start position for the context. Use of different 'stringIndexType' values can affect the offset returned. */
  offset: int32;

  /** The length of the context. Use of different 'stringIndexType' values can affect the length returned. */
  length: int32;
}

/** Parameters object for a text analysis task using custom models. */
model CustomTaskParameters {
  ...TaskParameters;

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

/** Long running operation template to match Azure Language. */
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "template"
@post
op LanguageLongRunningOperation<
  TParams extends TypeSpec.Reflection.Model,
  TStatusResult extends TypeSpec.Reflection.Model,
  TStatusError = Foundations.Error,
  Traits extends TypeSpec.Reflection.Model = {},
  TErrorResponse = ErrorResponse
> is Foundations.Operation<
  TParams &
    Azure.Core.Traits.Private.TraitProperties<
      Traits,
      Azure.Core.Traits.TraitLocation.Parameters
    >,
  Azure.Core.Foundations.AcceptedResponse &
    Foundations.LongRunningStatusLocation<TStatusResult> &
    Azure.Core.Traits.Private.TraitProperties<
      Traits,
      Azure.Core.Traits.TraitLocation.Response
    >,
  Traits,
  TErrorResponse
>;

/** Long running operation template to match Azure Language. */
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "template"
@post
op LanguageLongRunningResourceCancel<
  TParams extends TypeSpec.Reflection.Model,
  Traits extends TypeSpec.Reflection.Model = {},
  TErrorResponse = ErrorResponse
> is Foundations.ResourceOperation<
  TParams,
  Azure.Core.Traits.Private.TraitProperties<Traits, TraitLocation.Parameters>,
  Foundations.AcceptedResponse<Foundations.LongRunningStatusLocation &
    Azure.Core.Traits.Private.TraitProperties<Traits, TraitLocation.Response>>,
  Traits,
  TErrorResponse
>;

/** Long running operation template to match Azure Language. */
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "template"
@get
op LanguageLongRunningResourceRead<
  Resource extends TypeSpec.Reflection.Model,
  Traits extends TypeSpec.Reflection.Model = {},
  TErrorResponse = ErrorResponse
> is Foundations.ResourceOperation<
  Resource,
  Azure.Core.Traits.Private.TraitProperties<
    Traits,
    TraitLocation.Parameters,
    TraitContext.Read
  >,
  Resource &
    Azure.Core.Traits.Private.TraitProperties<
      Traits,
      TraitLocation.Response,
      TraitContext.Read
    >,
  Traits,
  TErrorResponse
>;
