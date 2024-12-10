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

/** Returns the current state of the task. */
@added(Versions.v2023_04_01)
model TaskState {
  /** The last updated time in UTC for the task. */
  lastUpdateDateTime: utcDateTime;

  /** The status of the task at the mentioned last update time. */
  status: State;
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
  @clientName("showStatistics", "csharp")
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

/** The base class of a conversation input task. */
@discriminator("kind")
@resource("language")
model AnalyzeConversationTask {
  /** The base class of a conversation input task. */
  @key
  @visibility("read", "create", "query")
  kind: AnalyzeConversationTaskKind;
}

/** The base class of a conversation input task result. */
@discriminator("kind")
model AnalyzeConversationTaskResult {
  /** The base class of a conversation input task result. */
  kind: AnalyzeConversationTaskResultsKind;
}

/** The input for a conversation language understanding task. */
model ConversationalTask extends AnalyzeConversationTask {
  /** Task kind. */
  kind: AnalyzeConversationTaskKind.Conversation;

  /** The input ConversationItem and its optional parameters */
  analysisInput: ConversationAnalysisOptions;

  /** Input parameters necessary for a Conversation language understanding task. */
  parameters: ConversationTaskParameters;
}

/** The input ConversationItem and its optional parameters */
model ConversationAnalysisOptions {
  /** The abstract base for a user input formatted conversation (e.g., Text, Transcript). */
  conversationItem: TextConversationItem;
}

/** The abstract base for a user input formatted conversation (e.g., Text, Transcript). */
model ConversationItemBase {
  /** The ID of a conversation item. */
  id: string;

  /** The participant ID of a conversation item. */
  participantId: string;

  /** The override language of a conversation item in BCP 47 language representation. */
  language?: string;

  /** Enumeration of supported conversational modalities. */
  modality?: InputModality;

  /** Role of the participant. */
  @added(Versions.v2023_04_01)
  role?: role;
}

/** The text modality of an input conversation. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type"
model TextConversationItem is ConversationItemBase {
  /** The text input */
  text: string;
}

/** This is the parameter set of either the Orchestration project itself or one of the target services. */
@discriminator("targetProjectKind")
model AnalysisParameters {
  /** The type of a target service */
  targetProjectKind: targetProjectKind;

  /** The API version to use when call a specific target service. */
  apiVersion?: string;
}

/** A wrap up of non-linked intent response. */
model NoneLinkedTargetIntentResult extends TargetIntentResult {
  /** The actual response from a Conversation project. */
  targetProjectKind: targetProjectKind.NonLinked;

  /** The actual response from a Conversation project. */
  result?: ConversationResult;
}

/** This is a set of request parameters for Customized Conversation projects. */
model ConversationParameters extends AnalysisParameters {
  /** This is a set of request parameters for Customized Conversation projects. */
  targetProjectKind: targetProjectKind.Conversation;

  /** The option to set to call a Conversation project. */
  callingOptions?: ConversationCallingOptions;
}

/** The option to set to call a Conversation project. */
model ConversationCallingOptions {
  /** The language of the query in BCP 47 language representation. */
  language?: string;

  /** If true, the service will return more detailed information. */
  verbose?: boolean;

  /** If true, the query will be saved for customers to further review in authoring, to improve the model quality. */
  isLoggingEnabled?: boolean;
}

/** This is the base class of an intent prediction */
@discriminator("targetProjectKind")
model TargetIntentResult {
  /** This is the base class of an intent prediction */
  targetProjectKind: targetProjectKind;

  /** The API version used to call a target service. */
  apiVersion?: string;

  /** The prediction score and it ranges from 0.0 to 1.0. */
  @minValue(0)
  @maxValue(1)
  confidenceScore: float64;
}

/** A wrap up of Conversation project response. */
model ConversationTargetIntentResult extends TargetIntentResult {
  /** A wrap up of Conversation project response. */
  targetProjectKind: targetProjectKind.Conversation;

  /** The actual response from a Conversation project. */
  result?: ConversationResult;
}

/** The response returned by a Conversation project. */
model ConversationResult {
  /** The same query given in request. */
  query: string;

  /** The detected language from the query in BCP 47 language representation. */
  detectedLanguage?: string;

  /** The predicted result for the query. */
  prediction?: ConversationPrediction;
}

/** Represents the prediction section of a Conversation project. */
model ConversationPrediction extends BasePrediction {
  /** Represents the prediction section of a Conversation project. */
  projectKind: projectKind.Conversation;

  /** The intent classification results. */
  intents: Array<ConversationIntent>;

  /** The entity extraction results. */
  entities: Array<ConversationEntity>;
}

/** The intent classification result of a Conversation project. */
model ConversationIntent {
  /** A predicted class. */
  category: string;

  /** The confidence score of the class from 0.0 to 1.0. */
  @minValue(0)
  @maxValue(1)
  confidenceScore: float32;
}

/** The entity extraction result of a Conversation project. */
model ConversationEntity {
  /** The entity category. */
  category: string;

  /** The predicted entity text. */
  text: string;

  /** The starting index of this entity in the query. */
  offset: int32;

  /** The length of the text. */
  length: int32;

  /** The entity confidence score. */
  confidenceScore: float32;

  /** The collection of entity resolution objects. */
  resolutions?: Array<BaseResolution>;

  /** The collection of entity extra information objects. */
  extraInformation?: Array<BaseExtraInformation>;
}

/** The abstract base object for entity extra information. */
@discriminator("extraInformationKind")
model BaseExtraInformation {
  /** The extra information object kind. */
  extraInformationKind: ExtraInformationKind;
}

/** The concrete entity Subtype model of extra information. */
model EntitySubtype extends BaseExtraInformation {
  /** The extra information object kind. */
  extraInformationKind: ExtraInformationKind.EntitySubtype;

  /** The Subtype of an extracted entity type. */
  value?: string;

  @doc("List of entity tags. Tags express similarities between entity categories for the extracted entity type.")
  @added(Versions.v2024_11_15_preview)
  tags?: Array<EntityTag>;
}

/** The list key extra data kind. */
model ListKey extends BaseExtraInformation {
  /** The list key extra data kind. */
  extraInformationKind: ExtraInformationKind.ListKey;

  /** The canonical form of the extracted entity. */
  key?: string;
}

/** The regex key extra data kind. */
@added(Versions.v2023_04_01)
model RegexKey extends BaseExtraInformation {
  /** The regex key extra data kind. */
  extraInformationKind: ExtraInformationKind.RegexKey;

  /** The key of the regex pattern used in extracting the entity. */
  key?: string;

  /** The .NET regex pattern used in extracting the entity. Please visit https://docs.microsoft.com/dotnet/standard/base-types/regular-expressions for more information about .NET regular expressions. */
  regexPattern?: string;
}

/** The abstract base class for entity resolutions. */
@doc("Tags express similarities between entity categories for the extracted entity type.")
@added(Versions.v2024_11_15_preview)
model EntityTag {
  @doc("The name of the tag.")
  name: string;

  @doc("The confidence score of the tag for the extracted entity between 0.0 and 1.0.")
  confidenceScore?: float64;
}

@doc("The abstract base class for entity resolutions.")
@discriminator("resolutionKind")
model BaseResolution {
  /** The entity resolution object kind. */
  resolutionKind: ResolutionKind;
}

/** Represents resolutions for quantities. */
model QuantityResolution {
  /** The numeric value that the extracted text denotes. */
  value: float64;
}

/** Represents the Age entity resolution model. */
model AgeResolution extends BaseResolution {
  /** Represents the Age entity resolution model. */
  resolutionKind: ResolutionKind.AgeResolution;

  ...QuantityResolution;

  /** The Age Unit of measurement */
  unit: AgeUnit;
}

/** Represents the volume entity resolution model. */
model VolumeResolution extends BaseResolution {
  /** Represents the volume entity resolution model. */
  resolutionKind: ResolutionKind.VolumeResolution;

  ...QuantityResolution;

  /** The Volume Unit of measurement */
  unit: VolumeUnit;
}

/** Represents the speed entity resolution model. */
model SpeedResolution extends BaseResolution {
  /** Represents the speed entity resolution model. */
  resolutionKind: ResolutionKind.SpeedResolution;

  ...QuantityResolution;

  /** The speed Unit of measurement */
  unit: SpeedUnit;
}

/** Represents the area entity resolution model. */
model AreaResolution extends BaseResolution {
  /** Represents the area entity resolution model. */
  resolutionKind: ResolutionKind.AreaResolution;

  ...QuantityResolution;

  /** The area Unit of measurement */
  unit: AreaUnit;
}
/** Represents the length entity resolution model. */
model LengthResolution extends BaseResolution {
  /** Represents the length entity resolution model. */
  resolutionKind: ResolutionKind.LengthResolution;

  ...QuantityResolution;

  /** The length Unit of measurement */
  unit: LengthUnit;
}

/** Represents the information (data) entity resolution model. */
model InformationResolution extends BaseResolution {
  /** Represents the information (data) entity resolution model. */
  resolutionKind: ResolutionKind.InformationResolution;

  ...QuantityResolution;

  /** The information (data) Unit of measurement. */
  unit: InformationUnit;
}

/** Represents the temperature entity resolution model. */
model TemperatureResolution extends BaseResolution {
  /** Represents the temperature entity resolution model. */
  resolutionKind: ResolutionKind.TemperatureResolution;

  ...QuantityResolution;

  /** The temperature Unit of measurement. */
  unit: TemperatureUnit;
}

/** Represents the weight entity resolution model. */
model WeightResolution extends BaseResolution {
  /** Represents the weight entity resolution model. */
  resolutionKind: ResolutionKind.WeightResolution;

  ...QuantityResolution;

  /** The weight Unit of measurement. */
  unit: WeightUnit;
}

/** Represents the currency entity resolution model. */
model CurrencyResolution extends BaseResolution {
  /** Represents the currency entity resolution model. */
  resolutionKind: ResolutionKind.CurrencyResolution;

  /** The alphabetic code based on another ISO standard, ISO 3166, which lists the codes for country names. The first two letters of the ISO 4217 three-letter code are the same as the code for the country name, and, where possible, the third letter corresponds to the first letter of the currency name. */
  @encodedName("application/json", "ISO4217")
  iso4217?: string;

  /** The money amount captured in the extracted entity */
  value: float64;

  /** The unit of the amount captured in the extracted entity */
  unit: string;
}

/** A resolution for boolean expressions */
model BooleanResolution extends BaseResolution {
  /** A resolution for boolean expressions */
  resolutionKind: ResolutionKind.BooleanResolution;

  /** A resolution for boolean expressions */
  value: boolean;
}

/** A resolution for datetime entity instances. */
model DateTimeResolution extends BaseResolution {
  /** A resolution for datetime entity instances. */
  resolutionKind: ResolutionKind.DateTimeResolution;

  /** An extended ISO 8601 date/time representation as described in (https://github.com/Microsoft/Recognizers-Text/blob/master/Patterns/English/English-DateTime.yaml) */
  timex: string;

  /** The DateTime SubKind */
  dateTimeSubKind: DateTimeSubKind;

  /** The actual time that the extracted text denote. */
  value: string;

  /** An optional modifier of a date/time instance. */
  modifier?: TemporalModifier;
}

/** A resolution for numeric entity instances. */
model NumberResolution extends BaseResolution {
  /** A resolution for numeric entity instances. */
  resolutionKind: ResolutionKind.NumberResolution;

  /** The type of the extracted number entity. */
  numberKind: NumberKind;

  /** A numeric representation of what the extracted text denotes. */
  value: float64;
}

/** A resolution for ordinal numbers entity instances. */
model OrdinalResolution extends BaseResolution {
  /** A resolution for ordinal numbers entity instances. */
  resolutionKind: ResolutionKind.OrdinalResolution;

  /** The offset with respect to the reference (e.g., offset = -1 indicates the second to last) */
  offset: string;

  /** The reference point that the ordinal number denotes. */
  relativeTo: RelativeTo;

  /** A simple arithmetic expression that the ordinal denotes. */
  value: string;
}

/** represents the resolution of a date and/or time span. */
model TemporalSpanResolution extends BaseResolution {
  /** represents the resolution of a date and/or time span. */
  resolutionKind: ResolutionKind.TemporalSpanResolution;

  /** represents the resolution of a date and/or time span. An extended ISO 8601 date/time representation as described in (https://github.com/Microsoft/Recognizers-Text/blob/master/Patterns/English/English-DateTime.yaml) */
  begin?: string;

  /** represents the resolution of a date and/or time span. An extended ISO 8601 date/time representation as described in (https://github.com/Microsoft/Recognizers-Text/blob/master/Patterns/English/English-DateTime.yaml) */
  end?: string;

  /** An optional duration value formatted based on the ISO 8601 (https://en.wikipedia.org/wiki/ISO_8601#Durations) */
  duration?: string;

  /** An optional modifier of a date/time instance. */
  modifier?: TemporalModifier;

  /** An optional triplet containing the beginning, the end, and the duration all stated as ISO 8601 formatted strings. */
  @added(Versions.v2023_04_01)
  timex?: string;
}

/** represents the resolution of numeric intervals. */
model NumericRangeResolution extends BaseResolution {
  /** represents the resolution of numeric intervals. */
  resolutionKind: ResolutionKind.NumericRangeResolution;

  /** The kind of range that the resolution object represents. */
  rangeKind: RangeKind;

  /** The beginning value of  the interval. */
  minimum: float64;

  /** The ending value of the interval. */
  maximum: float64;
}

/** It is a wrap up a Question Answering KB response. */
@added(Versions.v2023_04_01)
@resource("language/analyze-conversations/jobs")
model AnalyzeConversationJobsInput {
  /** Display name for the analysis job. */
  displayName?: string;

  /** Analysis Input */
  @key
  @visibility("read", "create", "query")
  analysisInput: MultiLanguageConversationAnalysisInput;

  /** Set of tasks to execute on the input conversation. */
  tasks: Array<AnalyzeConversationLROTask>;
}

/** Base class for a long-running conversation input task. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@discriminator("kind")
@added(Versions.v2023_04_01)
model AnalyzeConversationLROTask is TaskIdentifier {
  /** Enumeration of supported analysis tasks on a collection of conversations. */
  kind: AnalyzeConversationLROTaskKind;
}

/** Contains the status of the submitted job for analyzing a conversation, along with related statistics. */
@added(Versions.v2023_04_01)
@resource("analyze-conversations/jobs")
model AnalyzeConversationJobState {
  ...JobState;
  ...ConversationTasksState;
  ...AnalyzeConversationJobStatistics;
}

/** Contains the statistics for the submitted job. */
@added(Versions.v2023_04_01)
model AnalyzeConversationJobStatistics {
  /** Contains the statistics for the submitted job. */
  statistics?: ConversationRequestStatistics;
}

/** Contains the state for the tasks that are being executed as part of the submitted job for analyzing a conversation. */
@added(Versions.v2023_04_01)
model ConversationTasksState {
  /** Contains the state for the tasks that are being executed as part of the submitted job for analyzing a conversation. */
  tasks: Tasks;
}

/** Contains the state for the tasks that are being executed as part of the submitted job for analyzing a conversation. */
@added(Versions.v2023_04_01)
model Tasks {
  /** Count of tasks that finished successfully. */
  completed: int32;

  /** Count of tasks that failed. */
  failed: int32;

  /** Count of tasks that are currently in progress. */
  inProgress: int32;

  /** Total count of tasks submitted as part of the job. */
  total: int32;

  /** List of results from tasks (if available). */
  items?: Array<AnalyzeConversationJobResult>;
}

/** Container for results of all tasks in the conversation job. */
@discriminator("kind")
@added(Versions.v2023_04_01)
model AnalyzeConversationJobResult {
  ...TaskState;
  ...TaskIdentifier;

  /** discriminator kind */
  kind: AnalyzeConversationResultsKind;
}

/** Multi Language Conversation Analysis Input */
@added(Versions.v2023_04_01)
model MultiLanguageConversationAnalysisInput {
  /** Array of conversation items */
  conversations: Array<Conversation>;
}

/** Complete ordered set of utterances (spoken or written) by one or more speakers to be used for analysis. */
@added(Versions.v2023_04_01)
@discriminator("modality")
model Conversation {
  /** Unique identifier for the conversation. */
  id: string;

  /** Language of the conversation item in BCP-47 format. */
  language: string;

  /** modality */
  modality: InputModality;

  /** domain */
  domain?: ConversationDomain;
}

/** model for text conversation */
@added(Versions.v2023_04_01)
model TextConversation extends Conversation {
  /** modality discriminator */
  modality: InputModality.text;

  /** Ordered list of text conversation items in the conversation. */
  conversationItems: Array<TextConversationItem>;
}

/** model for transcript conversation */
@added(Versions.v2023_04_01)
model TranscriptConversation extends Conversation {
  /** modality discriminator */
  modality: InputModality.transcript;

  /** Ordered list of transcript conversation items in the conversation. */
  conversationItems: Array<TranscriptConversationItem>;
}

/** Additional properties for supporting transcript conversation. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type"
@added(Versions.v2023_04_01)
model TranscriptConversationItem is ConversationItemBase {
  /** Inverse text normalization (ITN) representation of input. The inverse-text-normalized form is the recognized text from Microsoft's speech-to-text API, with phone numbers, numbers, abbreviations, and other transformations applied. */
  itn: string;

  /** Inverse-text-normalized format with profanity masking applied. */
  maskedItn: string;

  /** Display form of the recognized text from the speech-to-text API, with punctuation and capitalization added. */
  text: string;

  /** Lexical form of the recognized text from the speech-to-text API, with the actual words recognized. */
  lexical: string;

  /** List of word-level audio timing information. */
  wordLevelTimings?: Array<WordLevelTiming>;

  /** Audio timing at the conversation item level. This still can help with AI quality if word-level audio timings are not available. */
  conversationItemLevelTiming?: ConversationItemLevelTiming;
}

/** Transcript content response that the service generates, with all necessary personally identifiable information redacted. */
@added(Versions.v2023_04_01)
model RedactedTranscriptContent {
  /** Redacted output for input in inverse-text-normalized format. */
  itn?: string;

  /** Redacted output for input in masked inverse-text-normalized format. */
  maskedItn?: string;

  /** Redacted output for input in text (Microsoft's speech-to-text 'display') format. */
  text?: string;

  /** Redacted output for input in lexical format. */
  lexical?: string;

  /** List of redacted audio segments. */
  audioTimings?: Array<AudioTiming>;
}

/** Word-level timing information that the speech-to-text API generates. The words in this object should have 1:1 correspondence with the lexical input to allow for audio redaction. */
@added(Versions.v2023_04_01)
model WordLevelTiming is AudioTiming {
  /** Recognized word. */
  word?: string;
}

/** Audio timing information. */
@added(Versions.v2023_04_01)
model AudioTiming {
  /** Offset from the start of speech audio, in ticks. 1 tick = 100 nanoseconds. */
  offset?: int64;

  /** Duration of word articulation, in ticks. 1 tick = 100 nanoseconds. */
  duration?: int64;
}

/** Shared attributes for all conversational task results. */
@added(Versions.v2023_04_01)
model ConversationResultBase {
  /** Unique, non-empty conversation identifier. */
  id: string;

  /** Warnings encountered in processing the document. */
  warnings: Array<InputWarning>;

  /** If showStats=true was specified in the request this field will contain information about the conversation payload. */
  statistics?: ConversationStatistics;
}

/** If showStats=true was specified in the request, this field contains information about the conversation payload. */
@added(Versions.v2023_04_01)
model ConversationStatistics {
  /** Number of text units for the request. */
  transactionsCount: int32;
}

/** if showStats=true was specified in the request, this field contains information about the request payload. */
@added(Versions.v2023_04_01)
model ConversationRequestStatistics is RequestStatistics {
  /** Number of conversations submitted in the request. */
  conversationsCount: int32;

  /** Number of conversation documents. This excludes documents that are empty, over the size limit, or in unsupported languages. */
  validConversationsCount: int32;

  /** Number of invalid documents. This includes documents that are empty, over the size limit, or in unsupported languages. */
  erroneousConversationsCount: int32;
}

/** Audio timing at the conversation item level. */
@added(Versions.v2023_04_01)
model ConversationItemLevelTiming is AudioTiming;

/** Input parameters necessary for a Conversation task. */
model ConversationTaskParameters {
  /** The name of the project to use. */
  projectName: string;

  /** The name of the deployment to use. */
  deploymentName: string;

  /** If true, the service will return more detailed information in the response. */
  verbose?: boolean;

  /** If true, the service will keep the query for further review. */
  isLoggingEnabled?: boolean;

  /** Specifies the method used to interpret string offsets.  Defaults to Text Elements (Graphemes) according to Unicode v8.0.0. For additional information see https://aka.ms/text-analytics-offsets. */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  /** The name of a target project to forward the request to. */
  directTarget?: string;

  /** A dictionary representing the parameters for each target project. */
  targetProjectParameters?: Record<AnalysisParameters>;
}

/** The results of a Conversation task. */
model ConversationalTaskResult extends AnalyzeConversationTaskResult {
  /** The results of a Conversation task. */
  kind: AnalyzeConversationTaskResultsKind.ConversationResult;

  /** Represents a conversation analysis response. */
  result: AnalyzeConversationResult;
}

/** Represents a conversation analysis response. */
model AnalyzeConversationResult {
  /** The conversation utterance given by the caller. */
  query: string;

  /** The system detected language for the query in BCP 47 language representation.. */
  detectedLanguage?: string;

  /** The prediction result of a conversation project. */
  prediction: BasePrediction;
}

/** This is the base class of prediction */
@discriminator("projectKind")
model BasePrediction {
  /** The type of the project. */
  projectKind: projectKind;

  /** The intent with the highest score. */
  topIntent?: string;
}

/** This represents the prediction result of an Orchestration project. */
model OrchestrationPrediction extends BasePrediction {
  /** This represents the prediction result of an Orchestration project. */
  projectKind: projectKind.Orchestration;

  /** A dictionary that contains all intents. A key is an intent name and a value is its confidence score and target type. The top intent's value also contains the actual response from the target project. */
  intents: Record<TargetIntentResult>;
}
