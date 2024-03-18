import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum AnalyzeTextTaskKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SentimentAnalysis,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityRecognition,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PiiEntityRecognition,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KeyPhraseExtraction,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LanguageDetection,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityLinking,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_15_preview)
  DynamicClassification,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum AnalyzeTextLROTaskKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SentimentAnalysis,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityRecognition,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PiiEntityRecognition,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KeyPhraseExtraction,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityLinking,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Healthcare,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomEntityRecognition,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomSingleLabelClassification,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomMultiLabelClassification,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ExtractiveSummarization,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  AbstractiveSummarization,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_15_preview)
  CustomHealthcare,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_15_preview)
  CustomSentimentAnalysis,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_15_preview)
  CustomAbstractiveSummarization,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum AnalyzeTextTaskResultsKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SentimentAnalysisResults,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityRecognitionResults,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PiiEntityRecognitionResults,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KeyPhraseExtractionResults,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LanguageDetectionResults,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityLinkingResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_15_preview)
  DynamicClassificationResults,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum AnalyzeTextLROResultsKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SentimentAnalysisLROResults,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityRecognitionLROResults,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PiiEntityRecognitionLROResults,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  KeyPhraseExtractionLROResults,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  EntityLinkingLROResults,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  HealthcareLROResults,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomEntityRecognitionLROResults,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomSingleLabelClassificationLROResults,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CustomMultiLabelClassificationLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  ExtractiveSummarizationLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_01)
  AbstractiveSummarizationLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_15_preview)
  CustomHealthcareLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_15_preview)
  CustomSentimentAnalysisLROResults,

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  @added(Versions.v2023_04_15_preview)
  CustomAbstractiveSummarizationLROResults,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
@discriminator("kind")
model AnalyzeTextLROTask is TaskIdentifier {
  @doc("The kind of task to perform.")
  kind: AnalyzeTextLROTaskKind;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@discriminator("kind")
model AnalyzeTextTaskResult {
  @doc("The kind of task result.")
  kind: AnalyzeTextTaskResultsKind;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextJobsInput {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  displayName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  analysisInput: MultiLanguageAnalysisInput;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  tasks: Array<AnalyzeTextLROTask>;

  @added(Versions.v2023_04_15_preview)
  @doc("Default language to use for records requesting automatic language detection.")
  defaultLanguage?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextPreBuiltResult {
  @doc("Errors by document id.")
  errors: Array<AnalyzeTextDocumentError>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  statistics?: RequestStatistics;

  @doc("This field indicates which model is used for scoring.")
  modelVersion: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@resource("analyze-text/jobs")
model AnalyzeTextJobState {
  ...JobState;
  ...TasksState;
  ...AnalyzeTextJobStatistics;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model Pagination {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  nextLink?: url;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextJobErrors {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  errors: Array<Error>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextJobStatistics {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  statistics?: RequestStatistics;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model TasksState {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  tasks: Tasks;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model Tasks {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  completed: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  failed: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  inProgress: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  total: int64;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  items?: Array<AnalyzeTextLROResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum Status {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  notStarted,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  running,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  succeeded,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  failed,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  cancelled,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  cancelling,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
@discriminator("kind")
model AnalyzeTextLROResult is TaskState {
  ...TaskIdentifier;
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROResultsKind;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model DocumentResponse {}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model DocumentResult {
  @doc("Unique, non-empty document identifier.")
  id: string;

  @doc("Warnings encountered while processing document.")
  warnings: Array<DocumentWarning>;

  @doc("if showStats=true was specified in the request this field will contain information about the document payload.")
  statistics?: DocumentStatistics;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextDocumentError {
  @doc("Document Id.")
  id: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type"
  @doc("Document Error.")
  error: Error;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model DocumentWarning {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  code: Code;

  @doc("Warning message.")
  message: string;

  @doc("A JSON pointer reference indicating the target object.")
  targetRef?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum Code {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LongWordsInDocument,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DocumentTruncated,
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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@added(Versions.v2023_04_15_preview)
model DocumentDetectedLanguage {
  @doc("If 'language' is set to 'auto' for the document in the request this field will contain a 2 letter ISO 639-1 representation of the language detected for this document.")
  detectedLanguage?: DetectedLanguage;
}

@doc("Error response.")
@error
model ErrorResponse {
  #suppress "@azure-tools/typespec-azure-core/bad-record-type"
  @doc("The error object.")
  error: Error;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type"
@doc("An object containing more specific information about the error. As per Microsoft One API guidelines - https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#7102-error-condition-responses.")
model InnerErrorModel is Record<unknown> {
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
enum StringIndexType {
  @doc("Returned offset and length values will correspond to TextElements (Graphemes and Grapheme clusters) confirming to the Unicode 8.0.0 standard. Use this option if your application is written in .Net Framework or .Net Core and you will be using StringInfo.")
  TextElements_v8,

  @doc("Returned offset and length values will correspond to Unicode code points. Use this option if your application is written in a language that support Unicode, for example Python.")
  UnicodeCodePoint,

  @doc("Returned offset and length values will correspond to UTF-16 code units. Use this option if your application is written in a language that support Unicode, for example Java, JavaScript.")
  Utf16CodeUnit,
}

@doc("Returns the current state of the task.")
model TaskState {
  @doc("The last updated time in UTC for the task.")
  lastUpdateDateTime: utcDateTime;

  @doc("The status of the task at the mentioned last update time.")
  status: TaskStatus;
}

@doc("The status of the task at the mentioned last update time.")
enum TaskStatus {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'notStarted' should have a documentation or description, please use decorator @doc to add it."
  notStarted,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'running' should have a documentation or description, please use decorator @doc to add it."
  running,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'succeeded' should have a documentation or description, please use decorator @doc to add it."
  succeeded,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'failed' should have a documentation or description, please use decorator @doc to add it."
  failed,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'cancelled' should have a documentation or description, please use decorator @doc to add it."
  cancelled,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'cancelling' should have a documentation or description, please use decorator @doc to add it."
  cancelling,
}

@doc("The status of the task at the mentioned last update time.")
@lroStatus
enum State {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'notStarted' should have a documentation or description, please use decorator @doc to add it."
  notStarted,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'running' should have a documentation or description, please use decorator @doc to add it."
  running,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'succeeded' should have a documentation or description, please use decorator @doc to add it."
  @lroSucceeded
  succeeded,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'partiallyCompleted' should have a documentation or description, please use decorator @doc to add it."
  partiallyCompleted,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'failed' should have a documentation or description, please use decorator @doc to add it."
  @lroFailed
  failed,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'cancelled' should have a documentation or description, please use decorator @doc to add it."
  @lroCanceled
  cancelled,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'cancelling' should have a documentation or description, please use decorator @doc to add it."
  cancelling,
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

@doc("Query parameters for the AnalyzeText operation.")
model AnalyzeTextQueryParameters {
  ...Azure.Core.Foundations.ApiVersionParameter;

  @doc("(Optional) if set to true, response will contain request and document level statistics.")
  @query
  showStats?: boolean;
}

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

  #suppress "@azure-tools/typespec-azure-core/bad-record-type"
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
  @projectedName("client", "confidence")
  confidenceScore?: float64;

  @doc("ID of the QnA result.")
  @projectedName("client", "qnaId")
  id?: int32;

  @doc("Source of QnA result.")
  source?: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "KnowledgeBaseAnswer.metadata should not use ': Record<unknown>'. Use ': Record<string>' instead."
  @doc("Metadata associated with the answer, useful to categorize or filter question answers.")
  metadata?: Record<unknown>;

  @doc("Dialog associated with Answer.")
  dialog?: KnowledgeBaseAnswerDialog;

  @doc("Answer span object of QnA with respect to user's question.")
  @projectedName("client", "shortAnswer")
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
  @projectedName("client", "confidenceThreshold")
  confidenceScoreThreshold?: float64;

  @doc("Context object with previous QnA's information.")
  @projectedName("client", "answerContext")
  context?: KnowledgeBaseAnswerContext;

  @doc("Type of ranker to be used.")
  @projectedName("client", "rankerKind")
  rankerType?: RankerKind;

  @doc("Filter QnAs based on given metadata list and knowledge base sources.")
  filters?: QueryFilters;

  @doc("To configure Answer span prediction feature.")
  @projectedName("client", "shortAnswerOptions")
  answerSpanRequest?: ShortAnswerOptions;

  @doc("(Optional) Flag to enable Query over Unstructured Sources.")
  includeUnstructuredSources?: boolean;
}

@doc("Type of ranker to be used")
enum RankerKind {
  @doc("Default ranker.")
  Default: "Default ranker",

  @doc("Question only ranker.")
  Question: "Question only ranker",
}

@doc("Context object with previous QnA's information.")
model KnowledgeBaseAnswerContext {
  @doc("Previous turn top answer result QnA ID.")
  previousQnaId: int32;

  @doc("Previous user query.")
  @projectedName("client", "previousQuestion")
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
enum LogicalOperationKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AND' should have a documentation or description, please use decorator @doc to add it."
  AND,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'OR' should have a documentation or description, please use decorator @doc to add it."
  OR,
}

@doc("To configure Answer span prediction feature.")
model ShortAnswerOptions {
  @doc("Enable or disable Answer Span prediction.")
  enable: boolean;

  @doc("Minimum threshold score required to include an answer span, value ranges from 0 to 1.")
  @maxValue(1)
  @minValue(0)
  @projectedName("client", "confidenceThreshold")
  confidenceScoreThreshold?: float64;

  @doc("Number of Top answers to be considered for span prediction from 1 to 10.")
  @maxValue(10)
  @minValue(1)
  @projectedName("client", "top")
  topAnswersWithSpan?: int32;
}

//todo: add enum member descriptions
@doc("Human-readable error code.")
enum InnerErrorCode {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidRequest' should have a documentation or description, please use decorator @doc to add it."
  InvalidRequest,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidParameterValue' should have a documentation or description, please use decorator @doc to add it."
  InvalidParameterValue,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'KnowledgeBaseNotFound' should have a documentation or description, please use decorator @doc to add it."
  KnowledgeBaseNotFound,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchNotFound' should have a documentation or description, please use decorator @doc to add it."
  AzureCognitiveSearchNotFound,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchThrottling' should have a documentation or description, please use decorator @doc to add it."
  AzureCognitiveSearchThrottling,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ExtractionFailure' should have a documentation or description, please use decorator @doc to add it."
  ExtractionFailure,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidRequestBodyFormat' should have a documentation or description, please use decorator @doc to add it."
  InvalidRequestBodyFormat,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'EmptyRequest' should have a documentation or description, please use decorator @doc to add it."
  EmptyRequest,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'MissingInputDocuments' should have a documentation or description, please use decorator @doc to add it."
  MissingInputDocuments,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidDocument' should have a documentation or description, please use decorator @doc to add it."
  InvalidDocument,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ModelVersionIncorrect' should have a documentation or description, please use decorator @doc to add it."
  ModelVersionIncorrect,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidDocumentBatch' should have a documentation or description, please use decorator @doc to add it."
  InvalidDocumentBatch,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'UnsupportedLanguageCode' should have a documentation or description, please use decorator @doc to add it."
  UnsupportedLanguageCode,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidCountryHint' should have a documentation or description, please use decorator @doc to add it."
  InvalidCountryHint,
}

//todo: add enum member descriptions
@doc("Human-readable error code.")
enum ErrorCode {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidRequest' should have a documentation or description, please use decorator @doc to add it."
  InvalidRequest,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidArgument' should have a documentation or description, please use decorator @doc to add it."
  InvalidArgument,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unauthorized' should have a documentation or description, please use decorator @doc to add it."
  Unauthorized,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Forbidden' should have a documentation or description, please use decorator @doc to add it."
  Forbidden,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'NotFound' should have a documentation or description, please use decorator @doc to add it."
  NotFound,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ProjectNotFound' should have a documentation or description, please use decorator @doc to add it."
  ProjectNotFound,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'OperationNotFound' should have a documentation or description, please use decorator @doc to add it."
  OperationNotFound,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchNotFound' should have a documentation or description, please use decorator @doc to add it."
  AzureCognitiveSearchNotFound,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchIndexNotFound' should have a documentation or description, please use decorator @doc to add it."
  AzureCognitiveSearchIndexNotFound,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'TooManyRequests' should have a documentation or description, please use decorator @doc to add it."
  TooManyRequests,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchThrottling' should have a documentation or description, please use decorator @doc to add it."
  AzureCognitiveSearchThrottling,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchIndexLimitReached' should have a documentation or description, please use decorator @doc to add it."
  AzureCognitiveSearchIndexLimitReached,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InternalServerError' should have a documentation or description, please use decorator @doc to add it."
  InternalServerError,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ServiceUnavailable' should have a documentation or description, please use decorator @doc to add it."
  ServiceUnavailable,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Timeout' should have a documentation or description, please use decorator @doc to add it."
  Timeout,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'QuotaExceeded' should have a documentation or description, please use decorator @doc to add it."
  QuotaExceeded,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Conflict' should have a documentation or description, please use decorator @doc to add it."
  Conflict,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Warning' should have a documentation or description, please use decorator @doc to add it."
  Warning,
}

#suppress "@azure-tools/typespec-azure-core/use-extensible-enum"
@doc("Predicted sentiment")
@fixed
enum Sentiment {
  @doc("Positive statement")
  positive,

  @doc("Neutral statement")
  neutral,

  @doc("Negative statement")
  negative,

  @doc("Mixed statement")
  mixed,
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
enum SummaryLengthBucket {
  @doc("Instructs model to generate shorter length summaries.")
  short,

  @doc("Instructs model to generate medium length summaries.")
  medium,

  @doc("Instructs model to generate longer length summaries.")
  long,
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
enum RedactionCharacter {
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

#suppress "@azure-tools/typespec-azure-core/bad-record-type"
@doc("The error object.")
model Error is Record<unknown> {
  @doc("One of a server-defined set of error codes.")
  code: ErrorCode;

  @doc("A human-readable representation of the error.")
  message: string;

  @doc("The target of the error.")
  target?: string;

  @doc("An array of details about specific errors that led to this reported error.")
  details?: Array<Error>;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type"
  @doc("An object containing more specific information than the current object about the error.")
  innererror?: InnerErrorModel;
}
