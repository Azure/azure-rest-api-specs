import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.Conversations;

@doc("Error response.")
@error
model ErrorResponse {
  @doc("The error object.")
  error: Error;
}

@doc("The error object.")
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
@added(Versions.v2023_04_01)
model TaskState {
  @doc("The last updated time in UTC for the task.")
  lastUpdateDateTime: utcDateTime;

  @doc("The status of the task at the mentioned last update time.")
  status: State;
}

@doc("The status of the task at the mentioned last update time.")
@lroStatus
@added(Versions.v2023_04_01)
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
@added(Versions.v2023_04_01)
model TaskIdentifier {
  @doc("task name")
  taskName?: string;
}

@doc("Base parameters object for a text analysis task.")
@added(Versions.v2023_04_01)
model TaskParameters {
  @doc("logging opt out")
  loggingOptOut?: boolean = false;
}

@doc("Parameters object for a text analysis task using pre-built models.")
@added(Versions.v2023_04_01)
model PreBuiltTaskParameters is TaskParameters {
  @doc("model version")
  modelVersion?: string = "latest";
}

alias ShowStatsQueryParameter = QueryParametersTrait<{
  @doc("(Optional) if set to true, response will contain request and document level statistics.")
  @query
  showStats?: boolean;
}>;

@doc("job state")
@added(Versions.v2023_04_01)
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
  errors: Array<Error>;
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

  @doc("statistics")
  statistics?: RequestStatistics;

  @doc("This field indicates which model is used for scoring.")
  modelVersion: string;
}

@doc("Represents List of Question Answers.")
model AnswersResult {
  @doc("Represents Answer Result list.")
  answers?: Array<KnowledgeBaseAnswer>;
}

@doc("Represents knowledge base answer.")
model KnowledgeBaseAnswer {
  @doc("List of questions associated with the answer.")
  questions?: Array<string>;

  @doc("Answer text.")
  answer?: string;

  @doc("Answer confidence score, value ranges from 0 to 1.")
  @minValue(0)
  @maxValue(1)
  @clientName("confidence")
  confidenceScore?: float64;

  @doc("ID of the QnA result.")
  @clientName("qnaId")
  id?: int32;

  @doc("Source of QnA result.")
  source?: string;

  @doc("Metadata associated with the answer, useful to categorize or filter question answers.")
  metadata?: Record<string>;

  @doc("Dialog associated with Answer.")
  dialog?: KnowledgeBaseAnswerDialog;

  @doc("Answer span object of QnA with respect to user's question.")
  @clientName("shortAnswer")
  answerSpan?: AnswerSpan;
}

@doc("Dialog associated with Answer.")
model KnowledgeBaseAnswerDialog {
  @doc("To mark if a prompt is relevant only with a previous question or not. If true, do not include this QnA as search result for queries without context; otherwise, if false, ignores context and includes this QnA in search result.")
  isContextOnly?: boolean;

  @doc("List of prompts associated with the answer.")
  @maxItems(20)
  prompts?: Array<KnowledgeBaseAnswerPrompt>;
}

@doc("Prompt for an answer.")
model KnowledgeBaseAnswerPrompt {
  @doc("Index of the prompt - used in ordering of the prompts.")
  displayOrder?: int32;

  @doc("QnA ID corresponding to the prompt.")
  qnaId?: int32;

  @doc("Text displayed to represent a follow up question prompt.")
  @maxLength(200)
  displayText?: string;
}

@doc("Answer span object of QnA.")
model AnswerSpan {
  @doc("Predicted text of answer span.")
  text?: string;

  @doc("Predicted score of answer span, value ranges from 0 to 1.")
  @minValue(0)
  @maxValue(1)
  confidenceScore?: float64;

  @doc("The answer span offset from the start of answer.")
  offset?: int32;

  @doc("The length of the answer span.")
  length?: int32;
}

@doc("Parameters to query a knowledge base.")
model AnswersOptions {
  @doc("Exact QnA ID to fetch from the knowledge base, this field takes priority over question.")
  qnaId?: int32;

  @doc("User question to query against the knowledge base.")
  question?: string;

  @doc("Max number of answers to be returned for the question.")
  top?: int32;

  @doc("Unique identifier for the user.")
  userId?: string;

  @doc("Minimum threshold score for answers, value ranges from 0 to 1.")
  @maxValue(1)
  @minValue(0)
  @clientName("confidenceThreshold")
  confidenceScoreThreshold?: float64;

  @doc("Context object with previous QnA's information.")
  @clientName("answerContext")
  context?: KnowledgeBaseAnswerContext;

  @doc("Type of ranker to be used.")
  @clientName("rankerKind")
  rankerType?: RankerKind;

  @doc("Filter QnAs based on given metadata list and knowledge base sources.")
  filters?: QueryFilters;

  @doc("To configure Answer span prediction feature.")
  @clientName("shortAnswerOptions")
  answerSpanRequest?: ShortAnswerOptions;

  @doc("(Optional) Flag to enable Query over Unstructured Sources.")
  includeUnstructuredSources?: boolean;
}

@doc("Type of ranker to be used")
union RankerKind {
  string,

  @doc("Default ranker.")
  Default: "Default",

  @doc("Question only ranker.")
  QuestionOnly: "QuestionOnly",
}

@doc("Context object with previous QnA's information.")
model KnowledgeBaseAnswerContext {
  @doc("Previous turn top answer result QnA ID.")
  previousQnaId: int32;

  @doc("Previous user query.")
  @clientName("previousQuestion")
  previousUserQuery?: string;
}

@doc("filters over knowledge base.")
model QueryFilters {
  @doc("filters over knowledge base.")
  metadataFilter?: MetadataFilter;

  @doc("filters over knowledge base.")
  sourceFilter?: SourceFilter;

  @doc("Logical operation used to join metadata filter with source filter.")
  logicalOperation?: LogicalOperationKind = LogicalOperationKind.AND;
}

@doc("Find QnAs that are associated with the given list of metadata.")
model MetadataFilter {
  @doc("List of metadata.")
  metadata?: Array<MetadataRecord>;

  @doc("Operation used to join metadata filters.")
  logicalOperation?: LogicalOperationKind = LogicalOperationKind.AND;
}

@doc("Object to provide the key value pair for each metadata.")
model MetadataRecord {
  @doc("Metadata Key from Metadata dictionary used in the QnA.")
  key: string;

  @doc("Metadata Value from Metadata dictionary used in the QnA.")
  value: string;
}

@doc("Find QnAs that are associated with any of the given list of sources in knowledge base.")
model SourceFilter is Array<string>;

//todo: add enum member descriptions
@doc("Set to 'OR' or 'AND' for using corresponding logical operation.")
union LogicalOperationKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AND' should have a documentation or description, please use decorator @doc to add it."
  AND: "AND",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'OR' should have a documentation or description, please use decorator @doc to add it."
  OR: "OR",
}

@doc("To configure Answer span prediction feature.")
model ShortAnswerOptions {
  @doc("Enable or disable Answer Span prediction.")
  enable: true;

  @doc("Minimum threshold score required to include an answer span, value ranges from 0 to 1.")
  @maxValue(1)
  @minValue(0)
  @clientName("confidenceThreshold")
  confidenceScoreThreshold?: float64;

  @doc("Number of Top answers to be considered for span prediction from 1 to 10.")
  @maxValue(10)
  @minValue(1)
  @clientName("top")
  topAnswersWithSpan?: int32;
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

@doc("Predicted sentiment")
@added(Versions.v2023_04_01)
union TextSentiment {
  string,

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
@added(Versions.v2023_04_01)
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

@doc("Supported parameters for an Abstractive Summarization task.")
@added(Versions.v2023_04_01)
model AbstractiveSummarizationTaskParametersBase {
  @doc("It controls the approximate number of sentences in the output summaries.")
  sentenceCount?: int32;

  @doc("String index type")
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  @added(Versions.v2023_11_15_preview)
  @doc("(NOTE: Recommended to use summaryLength over sentenceCount) Controls the approximate length of the output summaries.")
  summaryLength?: SummaryLengthBucket;
}

@doc("The context of the summary.")
@added(Versions.v2023_04_01)
model SummaryContext {
  @doc("Start position for the context. Use of different 'stringIndexType' values can affect the offset returned.")
  offset: int32;

  @doc("The length of the context. Use of different 'stringIndexType' values can affect the length returned.")
  length: int32;
}

@doc("Parameters object for a text analysis task using custom models.")
model CustomTaskParameters {
  ...TaskParameters;

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
  percent: "%",
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

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "template"
@Foundations.Private.needsRoute
@post
@doc("Long running operation template to match Azure Language.")
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

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "template"
@Foundations.Private.needsRoute
@post
@doc("Long running operation template to match Azure Language.")
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

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "template"
@Foundations.Private.needsRoute
@get
@doc("Long running operation template to match Azure Language.")
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
