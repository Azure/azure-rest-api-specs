import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

/** The language service conversations API is a suite of natural language processing (NLP) skills that can be used to analyze structured conversations (textual or spoken). The synchronous API in this suite accepts a request and mediates among multiple language projects, such as LUIS Generally Available, Question Answering, Conversational Language Understanding, and then calls the best candidate service to handle the request. At last, it returns a response with the candidate service's response as a payload.\n\n In some cases, this API needs to forward requests and responses between the caller and an upstream service. The asynchronous APIs in this suite enable tasks like Conversation Summarization and Conversational PII detection. */
@useAuth(
  TypeSpec.Http.ApiKeyAuth<
    TypeSpec.Http.ApiKeyLocation.header,
    "Ocp-Apim-Subscription-Key"
  >
)
@service({
  title: "Microsoft Cognitive Language Service - Analyze Conversations",
})
@server(
  "{Endpoint}/language",
  "Single server endpoint",
  {
    /** Supported Cognitive Services endpoint (e.g., https://<resource-name>.api.cognitiveservices.azure.com). */
    Endpoint: string,
  }
)
@versioned(Versions)
namespace Language.Conversations;

/** Analyze Conversations Service Versions */
enum Versions {
  /** Version 2022-05-01 */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2022_05_01: "2022-05-01",

  /** Version 2023-04-01 */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_04_01: "2023-04-01",

  /** Version 2023-11-15-preview */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_11_15_preview: "2023-11-15-preview",
}

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

/** Enumeration of supported Conversation tasks. */
union AnalyzeConversationTaskKind {
  string,

  /** Conversation task kind */
  Conversation: "Conversation",
}

/** Enumeration of supported conversational task results. */
union AnalyzeConversationTaskResultsKind {
  string,

  /** Conversation result task kind */
  ConversationResult: "ConversationResult",
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

/** The input for a custom conversation task. */
model ConversationalTask extends AnalyzeConversationTask {
  /** The input for a custom conversation task. */
  kind: AnalyzeConversationTaskKind.Conversation;

  /** The input ConversationItem and its optional parameters */
  analysisInput: ConversationAnalysisOptions;

  /** Input parameters necessary for a Conversation task. */
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

/** Role of the participant. */
@added(Versions.v2023_04_01)
union role {
  string,

  /** The participant is a customer. */
  @added(Versions.v2023_04_01)
  customer: "customer",

  /** The participant is an agent. */
  @added(Versions.v2023_04_01)
  agent: "agent",

  /** The is a generic participant. */
  @added(Versions.v2023_04_01)
  generic: "generic",
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

/** This is a set of request parameters for LUIS Generally Available projects. */
model LuisParameters extends AnalysisParameters {
  /** The type of a target service */
  targetProjectKind: targetProjectKind.Luis;

  /** The utterance to predict. */
  @maxLength(500)
  query?: string;

  /** This customizes how the service calls LUIS Generally Available projects. */
  callingOptions?: LuisCallingOptions;
}

/** This customizes how the service calls LUIS Generally Available projects. */
model LuisCallingOptions {
  /** Enable verbose response. */
  verbose?: boolean;

  /** Save log to add in training utterances later. */
  log?: boolean;

  /** Set true to show all intents. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use camelCase"
  `show-all-intents`?: boolean;

  /** The timezone offset for the location of the request. */
  timezoneOffset?: int32;

  /** Enable spell checking. */
  spellCheck?: boolean;

  /** The subscription key to use when enabling Bing spell check */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use camelCase"
  `bing-spell-check-subscription-key`?: string;
}

/** This is a set of request parameters for Question Answering knowledge bases. */
model QuestionAnsweringParameters extends AnalysisParameters {
  /** This is a set of request parameters for Question Answering knowledge bases. */
  targetProjectKind: targetProjectKind.QuestionAnswering;

  /** The options sent to a Question Answering KB. */
  callingOptions?: AnswersOptions;
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

/** The extra information object kind. */
union ExtraInformationKind {
  string,

  /** Entity subtype extra information kind */
  EntitySubtype: "EntitySubtype",

  /** List key extra information kind */
  ListKey: "ListKey",

  /** Regex key extra information kind */
  @added(Versions.v2023_04_01)
  RegexKey: "RegexKey",
}

/** The concrete entity Subtype model of extra information. */
model EntitySubtype extends BaseExtraInformation {
  /** The extra information object kind. */
  extraInformationKind: ExtraInformationKind.EntitySubtype;

  /** The Subtype of an extracted entity type. */
  value?: string;
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

/** It is a wrap up of LUIS Generally Available response. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type"
model LuisTargetIntentResult extends TargetIntentResult {
  /** Kind of the project. */
  targetProjectKind: targetProjectKind.Luis;

  /** The actual response from a LUIS Generally Available application. */
  result?: LuisResult;
}

/** It is a wrap up a Question Answering KB response. */
model QuestionAnsweringTargetIntentResult extends TargetIntentResult {
  /** It is a wrap up a Question Answering KB response. */
  targetProjectKind: targetProjectKind.QuestionAnswering;

  /** The generated answer by a Question Answering KB. */
  result?: AnswersResult;
}

/** It is the response from a LUIS Generally Available application. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type"
model LuisResult is Record<unknown>;

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

/** Enumeration of supported analysis tasks on a collection of conversations. */
@added(Versions.v2023_04_01)
union AnalyzeConversationLROTaskKind {
  string,

  /** Conversational Summarization Task */
  ConversationalSummarizationTask: "ConversationalSummarizationTask",

  /** Conversational PII Task */
  @added(Versions.v2023_11_15_preview)
  ConversationalPIITask: "ConversationalPIITask",

  /** Custom Conversational Summarization Task */
  @added(Versions.v2023_11_15_preview)
  CustomConversationalSummarizationTask: "CustomConversationalSummarizationTask",

  /** Conversational Sentiment Task */
  @added(Versions.v2023_11_15_preview)
  ConversationalSentimentTask: "ConversationalSentimentTask",
}

/** Enumeration of results for supported conversation analysis Results. */
@added(Versions.v2023_04_01)
union AnalyzeConversationResultsKind {
  string,

  /** Conversational Summarization Results */
  @added(Versions.v2023_04_01)
  ConversationalSummarizationResults: "ConversationalSummarizationResults",

  /** Conversational PII Results */
  @added(Versions.v2023_11_15_preview)
  ConversationalPIIResults: "ConversationalPIIResults",

  /** Custom Conversational Summarization Results */
  @added(Versions.v2023_11_15_preview)
  CustomConversationalSummarizationResults: "CustomConversationalSummarizationResults",

  /** Conversational Sentiment Results */
  @added(Versions.v2023_11_15_preview)
  ConversationalSentimentResults: "ConversationalSentimentResults",
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

/** Enumeration of supported conversational domains. */
@added(Versions.v2023_04_01)
union ConversationDomain {
  string,

  /** Enumeration of supported conversational domains. */
  finance: "finance",

  /** Enumeration of supported conversational domains. */
  healthcare: "healthcare",

  /** Enumeration of supported conversational domains. */
  generic: "generic",
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

/** Task definition for conversational sentiment. */
@added(Versions.v2023_11_15_preview)
model AnalyzeConversationalSentimentTask extends AnalyzeConversationLROTask {
  /** discriminator kind */
  kind: AnalyzeConversationLROTaskKind.ConversationalSentimentTask;

  /** Supported parameters for a conversational sentiment task. */
  parameters?: ConversationalSentimentTaskParameters;
}

/** Supported parameters for a conversational sentiment task. */
@added(Versions.v2023_11_15_preview)
model ConversationalSentimentTaskParameters is PreBuiltTaskParameters {
  /** For transcript conversations, this parameter provides information regarding which content type should be used for sentiment analysis. The details of the sentiment analysis - like the offset, length and the text itself - will correspond to the text type selected here. */
  @added(Versions.v2023_11_15_preview)
  predictionSource?: TranscriptContentType;
}

/** Result from the sentiment analysis operation performed on a list of conversations. */
@added(Versions.v2023_11_15_preview)
model AnalyzeConversationSentimentResult extends AnalyzeConversationJobResult {
  /** discriminator kind */
  kind: AnalyzeConversationResultsKind.ConversationalSentimentResults;

  /** The result from sentiment analysis operation for each conversation. */
  results: ConversationSentimentResults;
}

/** The result from sentiment analysis operation for each conversation. */
@added(Versions.v2023_11_15_preview)
model ConversationSentimentResults is PreBuiltResult {
  /** Array of ConversationSentimentResults */
  conversations: Array<ConversationSentimentResultsConversation>;
}

/** The result from sentiment analysis operation for each conversation. */
@added(Versions.v2023_11_15_preview)
model ConversationSentimentResultsConversation {
  ...ConversationResultBase;
  ...ConversationSentimentResult;
}

/** The result from sentiment analysis operation for each conversation item. */
@added(Versions.v2023_11_15_preview)
model ConversationSentimentResult {
  /** Enumeration of Sentiment operation results for all the conversation items in a conversation. */
  conversationItems: Array<ConversationSentimentItemResult>;
}

/** Sentiment operation results for a conversation items */
@added(Versions.v2023_11_15_preview)
model ConversationSentimentItemResult {
  /** The identifier for the conversation item */
  id: string;

  /** The identifier for the speaker */
  participantId: string;

  /** Predicted sentiment */
  sentiment: TextSentiment;

  /** Represents the confidence scores between 0 and 1 across all sentiment classes: positive, neutral, negative. */
  confidenceScores: SentimentConfidenceScores;
}

/** Text that has been categorized into pre-defined classes or types such as: person, location, event, product, and organization. */
@added(Versions.v2023_11_15_preview)
model Entity {
  /** Entity text as appears in the request. */
  text: string;

  /** Entity type. */
  category: string;

  /** (Optional) Entity sub type. */
  subcategory?: string;

  /** Start position for the entity text. Use of different 'stringIndexType' values can affect the offset returned. */
  offset: int32;

  /** Length for the entity text. Use of different 'stringIndexType' values can affect the length returned. */
  length: int32;

  /** Confidence score between 0 and 1 of the extracted entity. */
  confidenceScore: float64;
}

/** Result from the personally identifiable information detection and redaction operation performed on a list of conversations. */
@added(Versions.v2023_11_15_preview)
model AnalyzeConversationConversationPiiResult
  extends AnalyzeConversationJobResult {
  /** discriminator kind */
  kind: AnalyzeConversationResultsKind.ConversationalPIIResults;

  /** results */
  results: ConversationPiiResults;
}

/** The result from PII detection and redaction operation for each conversation. */
@added(Versions.v2023_11_15_preview)
model ConversationPiiResults is PreBuiltResult {
  /** array of conversations */
  conversations: Array<ConversationalPiiResultWithResultBase>;
}

/** Conversation PII result item */
@added(Versions.v2023_11_15_preview)
model ConversationalPiiResultWithResultBase {
  ...ConversationResultBase;
  ...ConversationPiiResult;
}

/** The result from PII detection and redaction operation for each conversation. */
@added(Versions.v2023_11_15_preview)
model ConversationPiiResult {
  /** List of conversationItems */
  conversationItems: Array<ConversationPiiItemResult>;
}

/** The result from PII detection and redaction operation for each conversation. */
@added(Versions.v2023_11_15_preview)
model ConversationPiiItemResult {
  /** Id of the result */
  id: string;

  /** Transcript content response that the service generates, with all necessary personally identifiable information redacted. */
  redactedContent: RedactedTranscriptContent;

  /** Array of Entities */
  entities: Array<Entity>;
}

/** Task definition for a PII redaction in conversations. */
@added(Versions.v2023_11_15_preview)
model AnalyzeConversationPiiTask extends AnalyzeConversationLROTask {
  /** discriminator kind */
  kind: AnalyzeConversationLROTaskKind.ConversationalPIITask;

  /** parameters */
  parameters?: ConversationPiiTaskParameters;
}

/** Supported parameters for a conversational pii task. */
@added(Versions.v2023_11_15_preview)
model ConversationPiiTaskParameters is PreBuiltTaskParameters {
  /** Array of ConversationPIICategories */
  @added(Versions.v2023_11_15_preview)
  piiCategories?: Array<ConversationPiiCategories>;

  /** Flag to indicate if response should include audio stream offset and duration for any detected entities to be redacted. By default, audio timing of redacted entities are not included. */
  redactAudioTiming?: boolean;

  /** For transcript conversations, this parameter provides information regarding which content type (ITN, Text, Lexical, Masked ITN) should be used for entity detection. The details of the entities detected - like the offset, length and the text itself - will correspond to the text type selected here. */
  @added(Versions.v2023_11_15_preview)
  redactionSource?: TranscriptContentType;

  /** Optional parameter to use a Custom Character to be used for redaction in PII responses. Default character will be * as before. We allow specific ascii characters for redaction. */
  @added(Versions.v2023_11_15_preview)
  redactionCharacter?: redactionCharacter = redactionCharacter.asterisk;

  /** List of categories that need to be excluded instead of included. */
  @added(Versions.v2023_11_15_preview)
  excludePiiCategories?: Array<ConversationPiiCategoriesExclude>;
}

/** Describes the PII categories to return for detection. If not provided, 'default' categories will be returned which will vary with the language. */
@added(Versions.v2023_11_15_preview)
union ConversationPiiCategories {
  string,

  /** Address category */
  Address: "Address",

  /** Credit card number category */
  CreditCardNumber: "CreditCardNumber",

  /** Email category */
  Email: "Email",

  /** Person category */
  Person: "Person",

  /** Numeric identifier category */
  NumericIdentifier: "NumericIdentifier",

  /** Phone number category */
  PhoneNumber: "PhoneNumber",

  /** US social security number category */
  USSocialSecurityNumber: "USSocialSecurityNumber",

  /** Miscellaneous category */
  Miscellaneous: "Miscellaneous",

  /** All categories */
  All: "All",

  /** Default categories */
  Default: "Default",
}

/** Describes the PII categories to exclude for detection. If not provided, 'default' categories will be returned which will vary with the language. */
@added(Versions.v2023_11_15_preview)
union ConversationPiiCategoriesExclude {
  string,

  /** Address category */
  Address: "Address",

  /** Credit card number category */
  CreditCardNumber: "CreditCardNumber",

  /** Email category */
  Email: "Email",

  /** Person category */
  Person: "Person",

  /** Numeric identifier category */
  NumericIdentifier: "NumericIdentifier",

  /** Phone number category */
  PhoneNumber: "PhoneNumber",

  /** US social security number category */
  USSocialSecurityNumber: "USSocialSecurityNumber",
}

/** Enumeration of supported transcript content types. */
@added(Versions.v2023_11_15_preview)
union TranscriptContentType {
  string,

  /** Lexical content type */
  lexical: "lexical",

  /** ITN content type */
  itn: "itn",

  /** Masked ITN content type */
  maskedItn: "maskedItn",

  /** Text content type */
  text: "text",
}

/** Task definition for custom conversational summarization. */
@added(Versions.v2023_11_15_preview)
model AnalyzeCustomConversationSummarizationTask
  extends AnalyzeConversationLROTask {
  /** discriminator kind */
  kind: AnalyzeConversationLROTaskKind.CustomConversationalSummarizationTask;

  /** parameters */
  parameters?: CustomConversationSummarizationTaskParameters;
}

/** Task definition for conversational summarization. */
@added(Versions.v2023_04_01)
model AnalyzeConversationSummarizationTask extends AnalyzeConversationLROTask {
  /** discriminator kind */
  kind: AnalyzeConversationLROTaskKind.ConversationalSummarizationTask;

  /** parameters */
  parameters?: ConversationSummarizationTaskParameters;
}

/** Supported parameters for a conversational summarization task. */
@added(Versions.v2023_04_01)
model ConversationSummarizationTaskParametersBase
  is AbstractiveSummarizationTaskParametersBase {
  /** Array of Summary Aspects */
  summaryAspects: Array<SummaryAspect>;
}

/** Supported parameters for pre-build conversational summarization task. */
@added(Versions.v2023_04_01)
model ConversationSummarizationTaskParameters is PreBuiltTaskParameters {
  ...ConversationSummarizationTaskParametersBase;
}

/** Supported parameters for a custom conversation summarization task. */
@added(Versions.v2023_11_15_preview)
model CustomConversationSummarizationTaskParameters is CustomTaskParameters {
  ...ConversationSummarizationTaskParametersBase;
}

/** Supported parameters for a conversational summarization task. */
@added(Versions.v2023_04_01)
union SummaryAspect {
  string,

  /** Summary of issues in transcripts of web chats and service calls between customer-service agents and customers. */
  issue: "issue",

  /** Summary of resolutions in transcripts of web chats and service calls between customer-service agents and customers. */
  resolution: "resolution",

  /** Chapter title of any conversation. It's usually one phrase or several phrases naturally combined. Long conversations tend to have more chapters. You can find the chapter boundary from the summary context. */
  chapterTitle: "chapterTitle",

  /** Generic narrative summary of any conversation. It generally converts the conversational language into formal written language, compresses the text length, and keeps the salient information. */
  narrative: "narrative",

  /** A concise one-paragraph summary to provide a quick overview. */
  @added(Versions.v2023_11_15_preview)
  recap: "recap",

  /** Action items and tasks that arose during a meeting. */
  @added(Versions.v2023_11_15_preview)
  followUpTasks: "follow-up tasks",
}

/** Result for the summarization task on the conversation. */
@added(Versions.v2023_04_01)
model AnalyzeConversationSummarizationResult
  extends AnalyzeConversationJobResult {
  /** discriminator kind */
  kind: AnalyzeConversationResultsKind.ConversationalSummarizationResults;

  /** results */
  results: SummaryResult;
}

/** Result for the custom summarization task on the conversation. */
@added(Versions.v2023_11_15_preview)
model AnalyzeCustomConversationSummarizationResult
  extends AnalyzeConversationJobResult {
  /** discriminator kind */
  kind: AnalyzeConversationResultsKind.CustomConversationalSummarizationResults;

  /** Custom Summary Result */
  results: CustomSummaryResult;
}

/** Summary Results Base */
@added(Versions.v2023_04_01)
model SummaryResultBase {
  /** array of conversations */
  conversations: Array<ConversationsSummaryResult>;
}

/** Summary Results */
@added(Versions.v2023_04_01)
model SummaryResult {
  ...SummaryResultBase;
  ...PreBuiltResult;
}

/** Custom Summary Results */
@added(Versions.v2023_11_15_preview)
model CustomSummaryResult {
  ...SummaryResultBase;
  ...CustomResult;
}

/** Conversations Summary Result */
@added(Versions.v2023_04_01)
model ConversationsSummaryResult {
  ...ConversationResultBase;

  /** array of summaries */
  summaries: Array<SummaryResultItem>;
}

/** Summary Result Item */
@added(Versions.v2023_04_01)
model SummaryResultItem {
  /** aspect */
  aspect: string;

  /** text */
  text: string;

  /** Context list of the summary. */
  contexts?: Array<ItemizedSummaryContext>;
}

/** Context of the summary with a conversation item ID. */
@added(Versions.v2023_04_01)
model ItemizedSummaryContext is SummaryContext {
  /** Reference to the ID of ConversationItem. */
  conversationItemId: string;
}

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

/** The area unit of measurement. */
union AreaUnit {
  string,

  /** Unspecified area unit */
  Unspecified: "Unspecified",

  /** Square kilometer area unit */
  SquareKilometer: "SquareKilometer",

  /** Square hectometer area unit */
  SquareHectometer: "SquareHectometer",

  /** Square decameter area unit */
  SquareDecameter: "SquareDecameter",

  /** Square decimeter area unit */
  SquareDecimeter: "SquareDecimeter",

  /** Square meter area unit */
  SquareMeter: "SquareMeter",

  /** Square centimeter area unit */
  SquareCentimeter: "SquareCentimeter",

  /** Square millimeter area unit */
  SquareMillimeter: "SquareMillimeter",

  /** Square inch area unit */
  SquareInch: "SquareInch",

  /** Square foot area unit */
  SquareFoot: "SquareFoot",

  /** Square mile area unit */
  SquareMile: "SquareMile",

  /** Square yard area unit */
  SquareYard: "SquareYard",

  /** Acre area unit */
  Acre: "Acre",
}

/** The Datetime SubKind. */
union DateTimeSubKind {
  string,

  /** Time subkind */
  Time: "Time",

  /** Date subkind */
  Date: "Date",

  /** DateTime subkind */
  DateTime: "DateTime",

  /** Duration subkind */
  Duration: "Duration",

  /** Set subkind */
  Set: "Set",
}

/** The length unit of measurement. */
union LengthUnit {
  string,

  /** Unspecified length unit */
  Unspecified: "Unspecified",

  /** Kilometer length unit */
  Kilometer: "Kilometer",

  /** Hectometer length unit */
  Hectometer: "Hectometer",

  /** Decameter length unit */
  Decameter: "Decameter",

  /** Meter length unit */
  Meter: "Meter",

  /** Decimeter length unit */
  Decimeter: "Decimeter",

  /** Centimeter length unit */
  Centimeter: "Centimeter",

  /** Millimeter length unit */
  Millimeter: "Millimeter",

  /** Micrometer length unit */
  Micrometer: "Micrometer",

  /** Nanometer length unit */
  Nanometer: "Nanometer",

  /** Picometer length unit */
  Picometer: "Picometer",

  /** Mile length unit */
  Mile: "Mile",

  /** Yard length unit */
  Yard: "Yard",

  /** Inch length unit */
  Inch: "Inch",

  /** Foot length unit */
  Foot: "Foot",

  /** Light year length unit */
  LightYear: "LightYear",

  /** Point length unit */
  Pt: "Pt",
}

/** The information (data) Unit of measurement. */
union InformationUnit {
  string,

  /** Unspecified information unit */
  Unspecified: "Unspecified",

  /** Bit information unit */
  Bit: "Bit",

  /** Kilobit information unit */
  Kilobit: "Kilobit",

  /** Megabit information unit */
  Megabit: "Megabit",

  /** Gigabit information unit */
  Gigabit: "Gigabit",

  /** Terabit information unit */
  Terabit: "Terabit",

  /** Petabit information unit */
  Petabit: "Petabit",

  /** Byte information unit */
  Byte: "Byte",

  /** Kilobyte information unit */
  Kilobyte: "Kilobyte",

  /** Megabyte information unit */
  Megabyte: "Megabyte",

  /** Gigabyte information unit */
  Gigabyte: "Gigabyte",

  /** Terabyte information unit */
  Terabyte: "Terabyte",

  /** Petabyte information unit */
  Petabyte: "Petabyte",
}

/** Enumeration of supported conversational modalities. */
union InputModality {
  string,

  /** Transcript input modality */
  transcript: "transcript",

  /** Text input modality */
  text: "text",
}

/** The type of the extracted number entity. */
union NumberKind {
  string,

  /** Integer number */
  Integer: "Integer",

  /** Decimal number */
  Decimal: "Decimal",

  /** Power number */
  Power: "Power",

  /** Fraction number */
  Fraction: "Fraction",

  /** Percent number */
  Percent: "Percent",

  /** Unspecified number kind */
  Unspecified: "Unspecified",
}

/** The type of the project. */
union projectKind {
  string,

  /** Conversation type */
  Conversation: "Conversation",

  /** Orchestration type */
  Orchestration: "Orchestration",
}

/** The kind of range that the resolution object represents. */
union RangeKind {
  string,

  /** Number range */
  Number: "Number",

  /** Speed range */
  Speed: "Speed",

  /** Weight range */
  Weight: "Weight",

  /** Length range */
  Length: "Length",

  /** Volume range */
  Volume: "Volume",

  /** Area range */
  Area: "Area",

  /** Age range */
  Age: "Age",

  /** Information range */
  Information: "Information",

  /** Temperature range */
  Temperature: "Temperature",

  /** Currency range */
  Currency: "Currency",
}

/** The reference point that the ordinal number denotes. */
union RelativeTo {
  string,

  /** Current state */
  Current: "Current",

  /** End state */
  End: "End",

  /** Start state */
  Start: "Start",
}

/** The entity resolution object kind. */
union ResolutionKind {
  string,

  /** Resolution of a boolean entity */
  BooleanResolution: "BooleanResolution",

  /** Resolution of a date/time entity */
  DateTimeResolution: "DateTimeResolution",

  /** Resolution of a number entity */
  NumberResolution: "NumberResolution",

  /** Resolution of an ordinal entity */
  OrdinalResolution: "OrdinalResolution",

  /** Resolution of a speed entity */
  SpeedResolution: "SpeedResolution",

  /** Resolution of a weight entity */
  WeightResolution: "WeightResolution",

  /** Resolution of a length entity */
  LengthResolution: "LengthResolution",

  /** Resolution of a volume entity */
  VolumeResolution: "VolumeResolution",

  /** Resolution of an area entity */
  AreaResolution: "AreaResolution",

  /** Resolution of an age entity */
  AgeResolution: "AgeResolution",

  /** Resolution of an information entity */
  InformationResolution: "InformationResolution",

  /** Resolution of a temperature entity */
  TemperatureResolution: "TemperatureResolution",

  /** Resolution of a currency entity */
  CurrencyResolution: "CurrencyResolution",

  /** Resolution of a numeric range entity */
  NumericRangeResolution: "NumericRangeResolution",

  /** Resolution of a temporal span entity */
  TemporalSpanResolution: "TemporalSpanResolution",
}

/** The speed Unit of measurement */
union SpeedUnit {
  string,

  /** Unspecified speed unit */
  Unspecified: "Unspecified",

  /** Meters per second speed unit */
  MetersPerSecond: "MetersPerSecond",

  /** Kilometers per hour speed unit */
  KilometersPerHour: "KilometersPerHour",

  /** Kilometers per minute speed unit */
  KilometersPerMinute: "KilometersPerMinute",

  /** Kilometers per second speed unit */
  KilometersPerSecond: "KilometersPerSecond",

  /** Miles per hour speed unit */
  MilesPerHour: "MilesPerHour",

  /** Knot speed unit */
  Knot: "Knot",

  /** Foot per second speed unit */
  FootPerSecond: "FootPerSecond",

  /** Foot per minute speed unit */
  FootPerMinute: "FootPerMinute",

  /** Yards per minute speed unit */
  YardsPerMinute: "YardsPerMinute",

  /** Yards per second speed unit */
  YardsPerSecond: "YardsPerSecond",

  /** Meters per millisecond speed unit */
  MetersPerMillisecond: "MetersPerMillisecond",

  /** Centimeters per millisecond speed unit */
  CentimetersPerMillisecond: "CentimetersPerMillisecond",

  /** Kilometers per millisecond speed unit */
  KilometersPerMillisecond: "KilometersPerMillisecond",
}

/** The type of a target service. */
union targetProjectKind {
  string,

  /** Luis target service type */
  Luis: "Luis",

  /** Conversation target service type */
  Conversation: "Conversation",

  /** QuestionAnswering target service type */
  QuestionAnswering: "QuestionAnswering",

  /** NonLinked target service type */
  NonLinked: "NonLinked",
}

/** The temperature Unit of measurement. */
union TemperatureUnit {
  string,

  /** Unspecified temperature unit */
  Unspecified: "Unspecified",

  /** Fahrenheit temperature unit */
  Fahrenheit: "Fahrenheit",

  /** Kelvin temperature unit */
  Kelvin: "Kelvin",

  /** Rankine temperature unit */
  Rankine: "Rankine",

  /** Celsius temperature unit */
  Celsius: "Celsius",
}

/** An optional modifier of a date/time instance. */
union TemporalModifier {
  string,

  /** AfterApprox temporal modifier */
  AfterApprox: "AfterApprox",

  /** Before temporal modifier */
  Before: "Before",

  /** BeforeStart temporal modifier */
  BeforeStart: "BeforeStart",

  /** Approx temporal modifier */
  Approx: "Approx",

  /** ReferenceUndefined temporal modifier */
  ReferenceUndefined: "ReferenceUndefined",

  /** SinceEnd temporal modifier */
  SinceEnd: "SinceEnd",

  /** AfterMid temporal modifier */
  AfterMid: "AfterMid",

  /** Start temporal modifier */
  Start: "Start",

  /** After temporal modifier */
  After: "After",

  /** BeforeEnd temporal modifier */
  BeforeEnd: "BeforeEnd",

  /** Until temporal modifier */
  Until: "Until",

  /** End temporal modifier */
  End: "End",

  /** Less temporal modifier */
  Less: "Less",

  /** Since temporal modifier */
  Since: "Since",

  /** AfterStart temporal modifier */
  AfterStart: "AfterStart",

  /** BeforeApprox temporal modifier */
  BeforeApprox: "BeforeApprox",

  /** Mid temporal modifier */
  Mid: "Mid",

  /** More temporal modifier */
  More: "More",
}

/** The Age Unit of measurement */
union AgeUnit {
  string,

  /** Unspecified age unit */
  Unspecified: "Unspecified",

  /** Year age unit */
  Year: "Year",

  /** Month age unit */
  Month: "Month",

  /** Week age unit */
  Week: "Week",

  /** Day age unit */
  Day: "Day",
}

/** The Volume Unit of measurement */
union VolumeUnit {
  string,

  /** Unspecified volume unit. */
  Unspecified: "Unspecified",

  /** Volume unit in cubic meters. */
  CubicMeter: "CubicMeter",

  /** Volume unit in cubic centimeters. */
  CubicCentimeter: "CubicCentimeter",

  /** Volume unit in cubic millimeters. */
  CubicMillimeter: "CubicMillimeter",

  /** Volume unit in hectoliters. */
  Hectoliter: "Hectoliter",

  /** Volume unit in decaliters. */
  Decaliter: "Decaliter",

  /** Volume unit in liters. */
  Liter: "Liter",

  /** Volume unit in centiliters. */
  Centiliter: "Centiliter",

  /** Volume unit in milliliters. */
  Milliliter: "Milliliter",

  /** Volume unit in cubic yards. */
  CubicYard: "CubicYard",

  /** Volume unit in cubic inches. */
  CubicInch: "CubicInch",

  /** Volume unit in cubic feet. */
  CubicFoot: "CubicFoot",

  /** Volume unit in cubic miles. */
  CubicMile: "CubicMile",

  /** Volume unit in fluid ounces. */
  FluidOunce: "FluidOunce",

  /** Volume unit in teaspoons. */
  Teaspoon: "Teaspoon",

  /** Volume unit in tablespoons. */
  Tablespoon: "Tablespoon",

  /** Volume unit in pints. */
  Pint: "Pint",

  /** Volume unit in quarts. */
  Quart: "Quart",

  /** Volume unit in cups. */
  Cup: "Cup",

  /** Volume unit in gills. */
  Gill: "Gill",

  /** Volume unit in pinches. */
  Pinch: "Pinch",

  /** Volume unit in fluid drams. */
  FluidDram: "FluidDram",

  /** Volume unit in barrels. */
  Barrel: "Barrel",

  /** Volume unit in minims. */
  Minim: "Minim",

  /** Volume unit in cords. */
  Cord: "Cord",

  /** Volume unit in pecks. */
  Peck: "Peck",

  /** Volume unit in bushels. */
  Bushel: "Bushel",

  /** Volume unit in hogsheads. */
  Hogshead: "Hogshead",
}

/** The weight Unit of measurement. */
union WeightUnit {
  string,

  /** Unspecified weight unit */
  Unspecified: "Unspecified",

  /** Weight unit in kilograms */
  Kilogram: "Kilogram",

  /** Weight unit in grams */
  Gram: "Gram",

  /** Weight unit in milligrams */
  Milligram: "Milligram",

  /** Volume unit in gallons */
  Gallon: "Gallon",

  /** Weight unit in metric tons */
  MetricTon: "MetricTon",

  /** Weight unit in tons */
  Ton: "Ton",

  /** Weight unit in pounds */
  Pound: "Pound",

  /** Weight unit in ounces */
  Ounce: "Ounce",

  /** Weight unit in grains */
  Grain: "Grain",

  /** Weight unit in pennyweights */
  PennyWeight: "PennyWeight",

  /** Weight unit in long tons (British) */
  LongTonBritish: "LongTonBritish",

  /** Weight unit in short tons (US) */
  ShortTonUS: "ShortTonUS",

  /** Weight unit in short hundredweights (US) */
  ShortHundredWeightUS: "ShortHundredWeightUS",

  /** Weight unit in stones */
  Stone: "Stone",

  /** Weight unit in drams */
  Dram: "Dram",
}

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias languageOperations = ResourceOperations<ServiceTraits, ErrorResponse>;

/** Analyzes the input conversation utterance. */
@post
@route("/:analyze-conversations")
op analyzeConversations is RpcOperation<
  AnalyzeConversationTask,
  AnalyzeConversationTaskResult,
  {},
  ErrorResponse
>;

/** Get the status of an analysis job. A job can consist of one or more tasks. After all tasks succeed, the job transitions to the succeeded state and results are available for each task. */
@added(Versions.v2023_04_01)
@summary("Get analysis status and results")
op analyzeConversationsJobStatus is languageOperations.ResourceRead<
  AnalyzeConversationJobState,
  ShowStatsQueryParameter
>;

/** Analyzes the input conversation utterance. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.v2023_04_01)
@route("/analyze-conversations/jobs")
@pollingOperation(analyzeConversationsJobStatus)
op analyzeConversationsSubmitJob is Foundations.LongRunningOperation<
  AnalyzeConversationJobsInput,
  AcceptedResponse,
  {},
  ErrorResponse
>;

/** Cancel a long-running job for text analysis of conversations. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@added(Versions.v2023_04_01)
@summary("Cancel a long-running Text Analysis conversations job.")
@pollingOperation(analyzeConversationsJobStatus)
@route("/analyze-conversations/jobs/{jobId}:cancel")
@post
op analyzeConversationsCancelJob is Foundations.LongRunningOperation<
  {
    /** The job ID to cancel. */
    @path
    jobId: uuid;
  },
  AcceptedResponse,
  {},
  ErrorResponse
>;
