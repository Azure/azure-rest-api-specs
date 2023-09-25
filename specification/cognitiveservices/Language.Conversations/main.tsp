import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
// import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
// import "@azure-tools/typespec-autorest";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
// using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@useAuth(
  TypeSpec.Http.ApiKeyAuth<
    TypeSpec.Http.ApiKeyLocation.header,
    "Ocp-Apim-Subscription-Key"
  >
)
@doc("The language service conversations API is a suite of natural language processing (NLP) skills that can be used to analyze structured conversations (textual or spoken). The synchronous API in this suite accepts a request and mediates among multiple language projects, such as LUIS Generally Available, Question Answering, Conversational Language Understanding, and then calls the best candidate service to handle the request. At last, it returns a response with the candidate service's response as a payload.\n\n In some cases, this API needs to forward requests and responses between the caller and an upstream service. The asynchronous APIs in this suite enable tasks like Conversation Summarization and Conversational PII detection.")
@service({
  title: "Microsoft Cognitive Language Service - Analyze Conversations",
})
@server(
  "{Endpoint}",
  "Single server endpoint",
  {
    @doc("Supported Cognitive Services endpoint (e.g., https://<resource-name>.api.cognitiveservices.azure.com).")
    Endpoint: string,
  }
)
@versioned(Versions)
namespace Language.Conversations;

@doc("Analyze Conversations Service Versions")
enum Versions {
  @doc("Version 2022-05-01")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2022_05_01: "2022-05-01",

  @doc("Version 2023-04-01")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_04_01: "2023-04-01",

  @doc("Version 2023-04-15-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_04_15_preview: "2023-04-15-preview",
}

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

//todo: add enum member descriptions
@doc("Enumeration of supported Conversation tasks.")
enum AnalyzeConversationTaskKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Conversation' should have a documentation or description, please use decorator @doc to add it."
  Conversation,
}

//todo: add enum member descriptions
@doc("Enumeration of supported conversational task results.")
enum AnalyzeConversationTaskResultsKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ConversationResult' should have a documentation or description, please use decorator @doc to add it."
  ConversationResult,
}

@discriminator("kind")
@doc("The base class of a conversation input task.")
@resource("language")
model AnalyzeConversationTask {
  @key
  @doc("The base class of a conversation input task.")
  kind: AnalyzeConversationTaskKind;
}

@doc("The base class of a conversation input task result.")
@discriminator("kind")
model AnalyzeConversationTaskResult {
  @doc("The base class of a conversation input task result.")
  kind: AnalyzeConversationTaskResultsKind;
}

@doc("The input for a custom conversation task.")
model ConversationalTask extends AnalyzeConversationTask {
  @doc("The input for a custom conversation task.")
  kind: AnalyzeConversationTaskKind.Conversation;

  @doc("The input ConversationItem and its optional parameters")
  analysisInput: ConversationAnalysisOptions;

  @doc("Input parameters necessary for a Conversation task.")
  parameters: ConversationTaskParameters;
}

@doc("The input ConversationItem and its optional parameters")
model ConversationAnalysisOptions {
  @doc("The abstract base for a user input formatted conversation (e.g., Text, Transcript).")
  conversationItem: ConversationItemBase;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "ConversationItemBase should not use 'extends Record<unknown>'. Use 'extends Record<string>' instead."
@doc("The abstract base for a user input formatted conversation (e.g., Text, Transcript).")
model ConversationItemBase extends Record<unknown> {
  @doc("The ID of a conversation item.")
  id: string;

  @doc("The participant ID of a conversation item.")
  participantId: string;

  @doc("The override language of a conversation item in BCP 47 language representation.")
  language?: string;

  @doc("Enumeration of supported conversational modalities.")
  modality?: Modality;
}

@doc("The text modality of an input conversation.")
model TextConversationItem extends ConversationItemBase {
  @doc("The text input")
  text: string;
}

@doc("This is the parameter set of either the Orchestration project itself or one of the target services.")
@discriminator("targetProjectKind")
model AnalysisParameters {
  @doc("The type of a target service")
  targetProjectKind: targetProjectKind;

  @doc("The API version to use when call a specific target service.")
  apiVersion?: string;
}

@doc("A wrap up of non-linked intent response.")
model NoneLinkedTargetIntentResult extends TargetIntentResult {
  @doc("The actual response from a Conversation project.")
  targetProjectKind: targetProjectKind.NonLinked;

  @doc("The actual response from a Conversation project.")
  result?: ConversationResult;
}
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "LuisParameters should not use 'extends Record<unknown>'. Use 'extends Record<string>' instead."
@doc("This is a set of request parameters for LUIS Generally Available projects.")
model LuisParameters extends Record<unknown> {
  ...AnalysisParameters;

  @doc("The utterance to predict.")
  @maxLength(500)
  query?: string;

  @doc("This customizes how the service calls LUIS Generally Available projects.")
  callingOptions?: LuisCallingOptions;
}

@doc("This customizes how the service calls LUIS Generally Available projects.")
model LuisCallingOptions {
  @doc("Enable verbose response.")
  verbose?: boolean;


  @doc("Save log to add in training utterances later.")
  log?: boolean;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use camelCase"
  @doc("Set true to show all intents.")
  `show-all-intents`?: boolean;

  @doc("The timezone offset for the location of the request.")
  timezoneOffset?: float32;

  @doc("Enable spell checking.")
  spellCheck?: boolean;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use camelCase"
  @doc("The subscription key to use when enabling Bing spell check")
  `bing-spell-check-subscription-key`?: string;
}

@doc("This is a set of request parameters for Customized Conversation projects.")
model ConversationParameters extends AnalysisParameters {
  @doc("This is a set of request parameters for Customized Conversation projects.")
  targetProjectKind: targetProjectKind.Conversation;

  @doc("The option to set to call a Conversation project.")
  callingOptions?: ConversationCallingOptions;
}

@doc("The option to set to call a Conversation project.")
model ConversationCallingOptions {
  @doc("The language of the query in BCP 47 language representation.")
  language?: string;

  @doc("If true, the service will return more detailed information.")
  verbose?: boolean;

  @doc("If true, the query will be saved for customers to further review in authoring, to improve the model quality.")
  isLoggingEnabled?: boolean;
}

@doc("This is a set of request parameters for Question Answering knowledge bases.")
model QuestionAnsweringParameters extends AnalysisParameters {
  @doc("This is a set of request parameters for Question Answering knowledge bases.")
  targetProjectKind: targetProjectKind.QuestionAnswering;

  @doc("The options sent to a Question Answering KB.")
  callingOptions?: AnswersOptions;
}

@doc("This is the base class of an intent prediction")
@discriminator("targetProjectKind")
model TargetIntentResult {
  @doc("This is the base class of an intent prediction")
  targetProjectKind: targetProjectKind;

  @doc("The API version used to call a target service.")
  apiVersion?: string;

  @doc("The prediction score and it ranges from 0.0 to 1.0.")
  @minValue(0)
  @maxValue(1)
  @projectedName("client", "confidence")
  confidenceScore: float64;
}

@doc("A wrap up of Conversation project response.")
model ConversationTargetIntentResult extends TargetIntentResult {
  @doc("A wrap up of Conversation project response.")
  targetProjectKind: targetProjectKind.Conversation;

  @doc("The actual response from a Conversation project.")
  result?: ConversationResult;
}

@doc("The response returned by a Conversation project.")
model ConversationResult {
  @doc("The same query given in request.")
  query: string;

  @doc("The detected language from the query in BCP 47 language representation.")
  detectedLanguage?: string;

  @doc("The predicted result for the query.")
  prediction?: ConversationPrediction;
}

@doc("Represents the prediction section of a Conversation project.")
model ConversationPrediction extends BasePrediction {
  @doc("Represents the prediction section of a Conversation project.")
  projectKind: projectKind.Conversation;

  @doc("The intent classification results.")
  intents: Array<ConversationIntent>;

  @doc("The entity extraction results.")
  entities: Array<ConversationEntity>;
}

@doc("The intent classification result of a Conversation project.")
model ConversationIntent {
  @doc("A predicted class.")
  category: string;

  @doc("The confidence score of the class from 0.0 to 1.0.")
  @minValue(0)
  @maxValue(1)
  @projectedName("client", "confidence")
  confidenceScore: float32;
}

@doc("The entity extraction result of a Conversation project.")
model ConversationEntity {
  @doc("The entity category.")
  category: string;

  @doc("The predicted entity text.")
  text: string;

  @doc("The starting index of this entity in the query.")
  offset: int32;

  @doc("The length of the text.")
  length: int32;

  @doc("The entity confidence score.")
  @projectedName("client", "confidence")
  confidenceScore: float32;

  @doc("The collection of entity resolution objects.")
  resolutions?: Array<BaseResolution>;

  @doc("The collection of entity extra information objects.")
  extraInformation?: Array<BaseExtraInformation>;
}

@doc("The abstract base object for entity extra information.")
@discriminator("extraInformationKind")
model BaseExtraInformation {
  @doc("The extra information object kind.")
  extraInformationKind: extraInformationKind;
}

//todo: add enum member descriptions
@doc("The extra information object kind.")
enum extraInformationKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'EntitySubtype' should have a documentation or description, please use decorator @doc to add it."
  EntitySubtype,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ListKey' should have a documentation or description, please use decorator @doc to add it."
  ListKey,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'RegexKey' should have a documentation or description, please use decorator @doc to add it."
  RegexKey,
}

@doc("The concrete entity Subtype model of extra information.")
model EntitySubtype extends BaseExtraInformation {
  @doc("The extra information object kind.")
  extraInformationKind: extraInformationKind.EntitySubtype;

  @doc("The Subtype of an extracted entity type.")
  value?: string;
}

@doc("The list key extra data kind.")
model ListKey extends BaseExtraInformation {
  @doc("The list key extra data kind.")
  extraInformationKind: extraInformationKind.ListKey;

  @doc("The canonical form of the extracted entity.")
  key?: string;
}

@doc("The regex key extra data kind.")
@added(Versions.v2023_04_01)
model RegexKey extends BaseExtraInformation {
  @doc("The regex key extra data kind.")
  extraInformationKind: extraInformationKind.RegexKey;

  @doc("The key of the regex pattern used in extracting the entity.")
  key?: string;

  @doc("The .NET regex pattern used in extracting the entity. Please visit https://docs.microsoft.com/dotnet/standard/base-types/regular-expressions for more information about .NET regular expressions.")
  regexPattern?: string;
}

@doc("The abstract base class for entity resolutions.")
@discriminator("resolutionKind")
model BaseResolution {
  @doc("The entity resolution object kind.")
  resolutionKind: resolutionKind;
}

@doc("Represents resolutions for quantities.")
model QuantityResolution {
  @doc("The numeric value that the extracted text denotes.")
  value: float64;
}

@doc("Represents the Age entity resolution model.")
model AgeResolution extends BaseResolution {
  @doc("Represents the Age entity resolution model.")
  resolutionKind: resolutionKind.AgeResolution;

  ...QuantityResolution;

  @doc("The Age Unit of measurement")
  unit: AgeUnit;
}

@doc("Represents the volume entity resolution model.")
model VolumeResolution extends BaseResolution {
  @doc("Represents the volume entity resolution model.")
  resolutionKind: resolutionKind.VolumeResolution;

  ...QuantityResolution;

  @doc("The Volume Unit of measurement")
  unit: VolumeUnit;
}

@doc("Represents the speed entity resolution model.")
model SpeedResolution extends BaseResolution {
  @doc("Represents the speed entity resolution model.")
  resolutionKind: resolutionKind.SpeedResolution;

  ...QuantityResolution;

  @doc("The speed Unit of measurement")
  unit: SpeedUnit;
}

@doc("Represents the area entity resolution model.")
model AreaResolution extends BaseResolution {
  @doc("Represents the area entity resolution model.")
  resolutionKind: resolutionKind.AreaResolution;

  ...QuantityResolution;

  @doc("The area Unit of measurement")
  unit: AreaUnit;
}
@doc("Represents the length entity resolution model.")
model LengthResolution extends BaseResolution {
  @doc("Represents the length entity resolution model.")
  resolutionKind: resolutionKind.LengthResolution;

  ...QuantityResolution;

  @doc("The length Unit of measurement")
  unit: LengthUnit;
}

@doc("Represents the information (data) entity resolution model.")
model InformationResolution extends BaseResolution {
  @doc("Represents the information (data) entity resolution model.")
  resolutionKind: resolutionKind.InformationResolution;

  ...QuantityResolution;

  @doc("The information (data) Unit of measurement.")
  unit: InformationUnit;
}

@doc("Represents the temperature entity resolution model.")
model TemperatureResolution extends BaseResolution {
  @doc("Represents the temperature entity resolution model.")
  resolutionKind: resolutionKind.TemperatureResolution;

  ...QuantityResolution;

  @doc("The temperature Unit of measurement.")
  unit: TemperatureUnit;
}

@doc("Represents the weight entity resolution model.")
model WeightResolution extends BaseResolution {
  @doc("Represents the weight entity resolution model.")
  resolutionKind: resolutionKind.WeightResolution;

  ...QuantityResolution;

  @doc("The weight Unit of measurement.")
  unit: WeightUnit;
}

@doc("Represents the currency entity resolution model.")
model CurrencyResolution extends BaseResolution {
  @doc("Represents the currency entity resolution model.")
  resolutionKind: resolutionKind.CurrencyResolution;

  @doc("The alphabetic code based on another ISO standard, ISO 3166, which lists the codes for country names. The first two letters of the ISO 4217 three-letter code are the same as the code for the country name, and, where possible, the third letter corresponds to the first letter of the currency name.")
  @projectedName("json", "ISO4217")
  iso4217?: string;

  @doc("The money amount captured in the extracted entity")
  value: float64;

  @doc("The unit of the amount captured in the extracted entity")
  unit: string;
}

@doc("A resolution for boolean expressions")
model BooleanResolution extends BaseResolution {
  @doc("A resolution for boolean expressions")
  resolutionKind: resolutionKind.BooleanResolution;

  @doc("A resolution for boolean expressions")
  value: boolean;
}

@doc("A resolution for datetime entity instances.")
model DateTimeResolution extends BaseResolution {
  @doc("A resolution for datetime entity instances.")
  resolutionKind: resolutionKind.DateTimeResolution;

  @doc("An extended ISO 8601 date/time representation as described in (https://github.com/Microsoft/Recognizers-Text/blob/master/Patterns/English/English-DateTime.yaml)")
  timex: utcDateTime;

  @doc("The DateTime SubKind")
  dateTimeSubKind: DateTimeSubKind;

  @doc("The actual time that the extracted text denote.")
  value: string;

  @doc("An optional modifier of a date/time instance.")
  modifier?: TemporalModifier;
}

@doc("A resolution for numeric entity instances.")
model NumberResolution extends BaseResolution {
  @doc("A resolution for numeric entity instances.")
  resolutionKind: resolutionKind.NumberResolution;

  @doc("The type of the extracted number entity.")
  numberKind: NumberKind;

  @doc("A numeric representation of what the extracted text denotes.")
  value: float64;
}

@doc("A resolution for ordinal numbers entity instances.")
model OrdinalResolution extends BaseResolution {
  @doc("A resolution for ordinal numbers entity instances.")
  resolutionKind: resolutionKind.OrdinalResolution;

  @doc("The offset With respect to the reference (e.g., offset = -1 in \"show me the second to last\"")
  offset: string;

  @doc("The reference point that the ordinal number denotes.")
  relativeTo: RelativeTo;

  @doc("A simple arithmetic expression that the ordinal denotes.")
  value: string;
}

@doc("represents the resolution of a date and/or time span.")
model TemporalSpanResolution extends BaseResolution {
  @doc("represents the resolution of a date and/or time span.")
  resolutionKind: resolutionKind.TemporalSpanResolution;

  @doc("represents the resolution of a date and/or time span. An extended ISO 8601 date/time representation as described in (https://github.com/Microsoft/Recognizers-Text/blob/master/Patterns/English/English-DateTime.yaml)")
  begin?: utcDateTime;

  @doc("represents the resolution of a date and/or time span. An extended ISO 8601 date/time representation as described in (https://github.com/Microsoft/Recognizers-Text/blob/master/Patterns/English/English-DateTime.yaml)")
  end?: utcDateTime;

  @doc("An optional duration value formatted based on the ISO 8601 (https://en.wikipedia.org/wiki/ISO_8601#Durations)")
  duration?: duration;

  @doc("An optional modifier of a date/time instance.")
  modifier?: TemporalModifier;

  @doc("An optional triplet containing the beginning, the end, and the duration all stated as ISO 8601 formatted strings.")
  @added(Versions.v2023_04_01)
  timex?: string;
}

@doc("represents the resolution of numeric intervals.")
model NumericRangeResolution extends BaseResolution {
  @doc("represents the resolution of numeric intervals.")
  resolutionKind: resolutionKind.NumericRangeResolution;

  @doc("The kind of range that the resolution object represents.")
  rangeKind: RangeKind;

  @doc("The beginning value of  the interval.")
  minimum: float64;

  @doc("The ending value of the interval.")
  maximum: float64;
}

@doc("It is a wrap up of LUIS Generally Available response.")
model LuisTargetIntentResult extends TargetIntentResult {
  @doc("It is a wrap up of LUIS Generally Available response.")
  targetProjectKind: targetProjectKind.Luis;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "LuisTargetIntentResult.result should not use ': Record<unknown>'. Use ': Record<string>' instead."
  @doc("The actual response from a LUIS Generally Available application.")
  result?: Record<unknown>;
}

@doc("It is a wrap up a Question Answering KB response.")
model QuestionAnsweringTargetIntentResult extends TargetIntentResult {
  @doc("It is a wrap up a Question Answering KB response.")
  targetProjectKind: targetProjectKind.QuestionAnswering;

  @doc("The generated answer by a Question Answering KB.")
  result?: AnswersResult;
}

@doc("It is a wrap up a Question Answering KB response.")
@added(Versions.v2023_04_01)
@resource("language/analyze-conversations/jobs")
model AnalyzeConversationJobsInput {
  @doc("Display name for the analysis job.")
  displayName?: string;

  @key
  @doc("Analysis Input")
  analysisInput: MultiLanguageConversationAnalysisInput;

  @doc("Set of tasks to execute on the input conversation.")
  tasks: Array<AnalyzeConversationLroTask>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Base class for a long-running conversation input task.")
@discriminator("kind")
@added(Versions.v2023_04_01)
model AnalyzeConversationLroTask extends TaskIdentifier {
  @doc("Enumeration of supported analysis tasks on a collection of conversations.")
  kind: AnalyzeConversationLROTaskKind;
}

@doc("Enumeration of supported analysis tasks on a collection of conversations.")
@added(Versions.v2023_04_01)
enum AnalyzeConversationLROTaskKind {
  @added(Versions.v2023_04_01)
  @doc("Conversational Summarization Task")
  ConversationalSummarizationTask,

  @added(Versions.v2023_04_15_preview)
  @doc("Conversational PII Task")
  ConversationalPIITask,
  
  @added(Versions.v2023_04_15_preview)
  @doc("Custom Conversational Summarization Task")
  CustomConversationalSummarizationTask,
  
  @added(Versions.v2023_04_15_preview)
  @doc("Conversational Sentiment Task")
  ConversationalSentimentTask,
}

@doc("Enumeration of results for supported conversation analysis Results.")
@added(Versions.v2023_04_01)
enum AnalyzeConversationResultsKind {
  @added(Versions.v2023_04_01)
  @doc("Conversational Summarization Results")
  ConversationalSummarizationResults,
  
  @added(Versions.v2023_04_15_preview)
  @doc("Conversational PII Results")
  ConversationalPIIResults,
  
  @added(Versions.v2023_04_15_preview)
  @doc("Custom Conversational Summarization Results")
  CustomConversationalSummarizationResults,
  
  @added(Versions.v2023_04_15_preview)
  @doc("Conversational Sentiment Results")
  ConversationalSentimentResults
}

@doc("Contains the status of the submitted job for analyzing a conversation, along with related statistics.")
@added(Versions.v2023_04_01)
// @resource("language/analyze-conversations/jobs")
model AnalyzeConversationJobState{
  ...JobState;
  ...ConversationTasksState;
  ...AnalyzeConversationJobStatistics;
}

@doc("Contains the statistics for the submitted job.")
@added(Versions.v2023_04_01)
model AnalyzeConversationJobStatistics {
  @doc("Contains the statistics for the submitted job.")
  statistics?: ConversationRequestStatistics;
}

@doc("Contains the state for the tasks that are being executed as part of the submitted job for analyzing a conversation.")
@added(Versions.v2023_04_01)
model ConversationTasksState {
  @doc("Contains the state for the tasks that are being executed as part of the submitted job for analyzing a conversation.")
  tasks: Tasks;
}

@doc("Contains the state for the tasks that are being executed as part of the submitted job for analyzing a conversation.")
@added(Versions.v2023_04_01)
model Tasks {
  @doc("Count of tasks that finished successfully.")
  completed: int32;

  @doc("Count of tasks that failed.")
  failed: int32;

  @doc("Count of tasks that are currently in progress.")
  inProgress: int32;

  @doc("Total count of tasks submitted as part of the job.")
  total: int32;

  @doc("List of results from tasks (if available).")
  items?: Array<AnalyzeConversationJobResult>;
};


@doc("Container for results of all tasks in the conversation job.")
@discriminator("kind")
@added(Versions.v2023_04_01)
model AnalyzeConversationJobResult extends TaskState {
  ...TaskIdentifier;

  @doc("discriminator kind")
  kind: AnalyzeConversationResultsKind;
}

@doc("Multi Language Conversation Analysis Input")
@added(Versions.v2023_04_01)
model MultiLanguageConversationAnalysisInput {
  @doc("Array of conversation items")
  conversations: Array<Conversation>;
}

@doc("Complete ordered set of utterances (spoken or written) by one or more speakers to be used for analysis.")
@added(Versions.v2023_04_01)
@discriminator("modality")
model Conversation {
  @doc("Unique identifier for the conversation.")
  id: string;

  @doc("Language of the conversation item in BCP-47 format.")
  language: string;

  @doc("modality")
  modality: Modality;

  @doc("domain")
  domain?: ConversationDomain;
}

@doc("Enumeration of supported conversational domains.")
@added(Versions.v2023_04_01)
enum ConversationDomain {
  @doc("Enumeration of supported conversational domains.")
  finance,

  @doc("Enumeration of supported conversational domains.")
  healthcare,

  @doc("Enumeration of supported conversational domains.")
  generic,
}

@doc("model for text conversation")
@added(Versions.v2023_04_01)
model TextConversation extends Conversation {
  @doc("modality discriminator")
  modality: Modality.text;

  @doc("Ordered list of text conversation items in the conversation.")
  conversationItems: Array<TextConversationItem>;
}

@doc("model for transcript conversation")
@added(Versions.v2023_04_01)
model TranscriptConversation extends Conversation {
  @doc("modality discriminator")
  modality: Modality.transcript;

  @doc("Ordered list of transcript conversation items in the conversation.")
  conversationItems: Array<TranscriptConversationItem>;
}

@doc("Additional properties for supporting transcript conversation.")
@added(Versions.v2023_04_01)
model TranscriptConversationItem extends ConversationItemBase {
  @doc("Inverse text normalization (ITN) representation of input. The inverse-text-normalized form is the recognized text from Microsoft's speech-to-text API, with phone numbers, numbers, abbreviations, and other transformations applied.")
  itn: string;

  @doc("Inverse-text-normalized format with profanity masking applied.")
  maskedItn: string;

  @doc("Display form of the recognized text from the speech-to-text API, with punctuation and capitalization added.")
  text: string;

  @doc("Lexical form of the recognized text from the speech-to-text API, with the actual words recognized.")
  lexical: string;

  @doc("Audio timing at the conversation item level. This still can help with AI quality if word-level audio timings are not available.")
  conversationItemLevelTiming?: ConversationItemLevelTiming;
}

@doc("Transcript content response that the service generates, with all necessary personally identifiable information redacted.")
@added(Versions.v2023_04_01)
model RedactedTranscriptContent {
  @doc("Redacted output for input in inverse-text-normalized format.")
  itn?: string;

  @doc("Redacted output for input in masked inverse-text-normalized format.")
  maskedItn?: string;

  @doc("Redacted output for input in text (Microsoft's speech-to-text 'display') format.")
  text?: string;

  @doc("Redacted output for input in lexical format.")
  lexical?: string;

  @doc("List of redacted audio segments.")
  audioTimings?: Array<AudioTiming>;
}

@doc("Word-level timing information that the speech-to-text API generates. The words in this object should have 1:1 correspondence with the lexical input to allow for audio redaction.")
@added(Versions.v2023_04_01)
model WordLevelTiming extends AudioTiming {
  @doc("Recognized word.")
  word?: string;
}

@doc("Audio timing information.")
@added(Versions.v2023_04_01)
model AudioTiming {
  @doc("Offset from the start of speech audio, in ticks. 1 tick = 100 nanoseconds.")
  offset?: int64;

  @doc("Duration of word articulation, in ticks. 1 tick = 100 nanoseconds.")
  duration?: int64;
}

@doc("Shared attributes for all conversational task results.")
@added(Versions.v2023_04_01)
model ConversationResultBase {
  @doc("Unique, non-empty conversation identifier.")
  id: string;

  @doc("Warnings encountered in processing the document.")
  warnings: Array<InputWarning>;

  @doc("If showStats=true was specified in the request this field will contain information about the conversation payload.")
  statistics?: ConversationStatistics;
}

@doc("If showStats=true was specified in the request, this field contains information about the conversation payload.")
@added(Versions.v2023_04_01)
model ConversationStatistics {
  @doc("Number of text units for the request.")
  transactionsCount: int32;
}

@doc("if showStats=true was specified in the request, this field contains information about the request payload.")
@added(Versions.v2023_04_01)
model ConversationRequestStatistics extends RequestStatistics {
  @doc("Number of conversations submitted in the request.")
  conversationsCount: int32;

  @doc("Number of conversation documents. This excludes documents that are empty, over the size limit, or in unsupported languages.")
  validConversationCount: int32;

  @doc("Number of invalid documents. This includes documents that are empty, over the size limit, or in unsupported languages.")
  erroneousConversationsCount: int32;
}

@doc("Audio timing at the conversation item level.")
@added(Versions.v2023_04_01)
model ConversationItemLevelTiming extends AudioTiming {}

@added(Versions.v2023_04_15_preview)
@doc("Task definition for conversational sentiment.")
model AnalyzeConversationalSentimentTask extends AnalyzeConversationLroTask {
  @doc("discriminator kind")
  kind: AnalyzeConversationLROTaskKind.ConversationalSentimentTask,

  @doc("Supported parameters for a conversational sentiment task.")
  properties?: ConversationalSentimentTaskParameters,
}

@added(Versions.v2023_04_15_preview)
@doc("Supported parameters for a conversational sentiment task.")
model ConversationalSentimentTaskParameters extends PreBuiltTaskParameters{
  @doc("For transcript conversations, this parameter provides information regarding which content type should be used for sentiment analysis. The details of the sentiment analysis - like the offset, length and the text itself - will correspond to the text type selected here.")
  predictionSource?: TranscriptContentType;
}

@added(Versions.v2023_04_15_preview)
@doc("Result from the sentiment analysis operation performed on a list of conversations.")
model AnalyzeConversationSentimentResult extends AnalyzeConversationJobResult {
  @doc("discriminator kind")
  kind: AnalyzeConversationResultsKind.ConversationalSentimentResults;

  @doc("The result from sentiment analysis operation for each conversation.")
  results: ConversationSentimentResults
}

@added(Versions.v2023_04_15_preview)
@doc("The result from sentiment analysis operation for each conversation.")
model ConversationSentimentResults extends PreBuiltResult{
  @doc("Array of ConversationSentimentResults")
  conversations: Array<ConversationSentimentResultsConversation>
}

@added(Versions.v2023_04_15_preview)
@doc("The result from sentiment analysis operation for each conversation.")
model ConversationSentimentResultsConversation extends ConversationSentimentResult{
  ...ConversationResultBase;
}

@added(Versions.v2023_04_15_preview)
@doc("The result from sentiment analysis operation for each conversation item.")
model ConversationSentimentResult {
  @doc("Enumeration of Sentiment operation results for all the conversation items in a conversation.")
  conversationItems: Array<ConversationSentimentItemResult>
}

@added(Versions.v2023_04_15_preview)
@doc("Sentiment operation results for a conversation items")
model ConversationSentimentItemResult {
  @doc("The identifier for the conversation item")
  id: string,

  @doc("The identifier for the speaker")
  participantId: string,

  @doc("Predicted sentiment")
  sentiment: Sentiment,

  @doc("Represents the confidence scores between 0 and 1 across all sentiment classes: positive, neutral, negative.")
  confidenceScores: SentimentConfidenceScores,
}

@added(Versions.v2023_04_15_preview)
@doc("Text that has been catorgerized into pre-defined classes or types such as: person, location, event, product, and organization.")
model Entity {
  @doc("Entity text as appears in the request.")
  text: string,

  @doc("Entity type.")
  category: string,

  @doc("(Optional) Entity sub type.")
  subcategory?: string,

  @doc("Start position for the entity text. Use of different 'stringIndexType' values can affect the offset returned.")
  offset: int32,

  @doc("Length for the entity text. Use of different 'stringIndexType' values can affect the length returned.")
  length: int32,

  @doc("Confidence score between 0 and 1 of the extracted entity.")
  confidenceScore: float64,
}

@added(Versions.v2023_04_15_preview)
@doc("Result from the personally identifiable information detection and redaction operation performed on a list of conversations.")
model AnalyzeConversationConversationPiiResult extends AnalyzeConversationJobResult {
  @doc("discriminator kind")
  kind: AnalyzeConversationResultsKind.ConversationalPIIResults;

  @doc("results")
  results: ConversationPiiResults;
}

@added(Versions.v2023_04_15_preview)
@doc("The result from PII detection and redaction operation for each conversation.")
model ConversationPiiResults extends PreBuiltResult{
  @doc("array of conversations")
  conversations: Array<ConversationalPiiResultWithResultBase>;
}

@added(Versions.v2023_04_15_preview)
@doc("Conversation PII result item")
model ConversationalPiiResultWithResultBase extends ConversationPiiResult{
  ...ConversationResultBase;
}

@added(Versions.v2023_04_15_preview)
@doc("The result from PII detection and redaction operation for each conversation.")
model ConversationPiiResult {
  @doc("List of conversationItems")
  conversationItems: Array<ConversationPiiItemResult>;
}

@added(Versions.v2023_04_15_preview)
@doc("The result from PII detection and redaction operation for each conversation.")
model ConversationPiiItemResult {
  @doc("Id of the result")
  id: string,

  @doc("Transcript content response that the service generates, with all necessary personally identifiable information redacted.")
  redactedContent: RedactedTranscriptContent;

  @doc("Array of Entities")
  entities: Array<Entity>
}

@added(Versions.v2023_04_15_preview)
@doc("Supported parameters for a conversational pii task.")
model ConversationPiiTaskParameters extends PreBuiltTaskParameters{
  @doc("Array of ConversationPIICategories")
  piiCategories?: Array<ConversationPIICategories>;

  @doc("Flag to indicate if response should include audio stream offset and duration for any detected entities to be redacted. By default, audio timing of redacted entities are not included.")
  redactAudioTiming?: boolean;

  @doc("For transcript conversations, this parameter provides information regarding which content type (ITN, Text, Lexical, Masked ITN) should be used for entity detection. The details of the entities detected - like the offset, length and the text itself - will correspond to the text type selected here.")
  redactionSource?: TranscriptContentType;

  @doc("Optional parameter to use a Custom Character to be used for redaction in PII responses. Default character will be * as before. We allow specific ascii characters for redaction.")
  redactionCharacter?: RedactionCharacter;

  @doc("List of categories that need to be excluded instead of included.")
  excludePiiCategories?: Array<ConversationPIICategoriesExclude>;
}

@added(Versions.v2023_04_15_preview)
@doc("Describes the PII categories to return for detection. If not provided, 'default' categories will be returned which will vary with the language.")
enum ConversationPIICategories {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Address,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CreditCardNumber,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Email,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Person,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NumericIdentifier,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PhoneNumber,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USSocialSecurityNumber,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Miscellaneous,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  All,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Default,
}

@added(Versions.v2023_04_15_preview)
@doc("Describes the PII categories to exclude for detection. If not provided, 'default' categories will be returned which will vary with the language.")
enum ConversationPIICategoriesExclude {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Address,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CreditCardNumber,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Email,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Person,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NumericIdentifier,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  PhoneNumber,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  USSocialSecurityNumber,
}

@added(Versions.v2023_04_15_preview)
@doc("Enumeration of supported transcript content types.")
enum TranscriptContentType {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  lexical,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  itn,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  maskedItn,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  text,
}

@doc("Task definition for custom conversational summarization.")
@added(Versions.v2023_04_15_preview)
model AnalyzeCustomConversationSummarizationTask extends AnalyzeConversationLroTask {
  @doc("discriminator kind")
  kind: AnalyzeConversationLROTaskKind.CustomConversationalSummarizationTask;

  @doc("parameters")
  parameters?: CustomConversationSummarizationTaskParameters;
}

@doc("Task definition for conversational summarization.")
@added(Versions.v2023_04_01)
model AnalyzeConversationSummarizationTask extends AnalyzeConversationLroTask {
  @doc("discriminator kind")
  kind: AnalyzeConversationLROTaskKind.ConversationalSummarizationTask;

  @doc("parameters")
  parameters?: ConversationSummarizationTaskParametersBase;
}

@doc("Supported parameters for a conversational summarization task.")
@added(Versions.v2023_04_01)
model ConversationSummarizationTaskParametersBase  extends AbstractiveSummarizationTaskParametersBase{

  @doc("Array of Summary Aspects")
  summaryAspects: Array<SummaryAspect>;
}

@doc("Supported parameters for pre-build conversational summarization task.")
@added(Versions.v2023_04_01)
model ConversationSummarizationTaskParameters extends PreBuiltTaskParameters {
  ...ConversationSummarizationTaskParametersBase;
}

@doc("Supported parameters for a custom conversation summarization task.")
@added(Versions.v2023_04_15_preview)
model CustomConversationSummarizationTaskParameters extends CustomTaskParameters{
  ...ConversationSummarizationTaskParametersBase;
}

@doc("Supported parameters for a conversational summarization task.")
@added(Versions.v2023_04_01)
enum SummaryAspect {
  @doc("Summary of issues in transcripts of web chats and service calls between customer-service agents and customers.")
  issue,

  @doc("Summary of resolutions in transcripts of web chats and service calls between customer-service agents and customers.")
  resolution,

  @doc("Chapter title of any conversation. It's usually one phrase or several phrases naturally combined. Long conversations tend to have more chapters. You can find the chapter boundary from the summary context.")
  chapterTitle,

  @doc("Generic narrative summary of any conversation. It generally converts the conversational language into formal written language, compresses the text length, and keeps the salient information.")
  narrative,
}

@doc("Result for the summarization task on the conversation.")
@added(Versions.v2023_04_01)
model AnalyzeConversationSummarizationResult extends AnalyzeConversationJobResult {
  @doc("discriminator kind")
  kind: AnalyzeConversationResultsKind.ConversationalSummarizationResults;

  @doc("results")
  results: SummaryResult;
}

@doc("Result for the custom summarization task on the conversation.")
@added(Versions.v2023_04_15_preview)
model AnalyzeCustomConversationSummarizationResult extends AnalyzeConversationJobResult {
  @doc("discriminator kind")
  kind: AnalyzeConversationResultsKind.CustomConversationalSummarizationResults;

  @doc("Custom Summary Result")
  results: CustomSummaryResult
}

@doc("Summary Results Base")
@added(Versions.v2023_04_01)
model SummaryResultBase {
  @doc("array of conversations")
  conversations: Array<ConversationsSummaryResult>;
}

@doc("Summary Results")
@added(Versions.v2023_04_01)
model SummaryResult extends SummaryResultBase{
  ...PreBuiltResult;
}

@added(Versions.v2023_04_15_preview)
@doc("Custom Summary Results")
model CustomSummaryResult extends SummaryResultBase{
 ...CustomResult;
}

@doc("Conversations Summary Result")
@added(Versions.v2023_04_01)
model ConversationsSummaryResult extends ConversationResultBase {
  @doc("array of summaries")
  summaries: Array<SummaryResultItem>;
}

@doc("Summary Result Item")
@added(Versions.v2023_04_01)
model SummaryResultItem {
  @doc("aspect")
  aspect: string;

  @doc("text")
  text: string;

  @doc("Context list of the summary.")
  contexts?: Array<ItemizedSummaryContext>;
}

@doc("Context of the summary with a conversation item ID.")
@added(Versions.v2023_04_01)
model ItemizedSummaryContext extends SummaryContext {
  @doc("Reference to the ID of ConversationItem.")
  conversationItemId: string;
}

@doc("Input parameters necessary for a Conversation task.")
model ConversationTaskParameters {
  @doc("The name of the project to use.")
  projectName: string;

  @doc("The name of the deployment to use.")
  deploymentName: string;

  @doc("If true, the service will return more detailed information in the response.")
  verbose?: boolean;

  @doc("If true, the service will keep the query for further review.")
  isLoggingEnabled?: boolean;

  @doc("Specifies the method used to interpret string offsets.  Defaults to Text Elements (Graphemes) according to Unicode v8.0.0. For additional information see https://aka.ms/text-analytics-offsets.")
  stringIndexType?: StringIndexType;

  @doc("The name of a target project to forward the request to.")
  directTarget?: string;

  @doc("A dictionary representing the parameters for each target project.")
  targetProjectParameters?: Record<AnalysisParameters>;
}

@doc("The results of a Conversation task.")
model ConversationalTaskResult extends AnalyzeConversationTaskResult {
  @doc("The results of a Conversation task.")
  kind: AnalyzeConversationTaskResultsKind.ConversationResult;

  @doc("Represents a conversation analysis response.")
  result: AnalyzeConversationResult;
}

@doc("Represents a conversation analysis response.")
model AnalyzeConversationResult {
  @doc("The conversation utterance given by the caller.")
  query: string;

  @doc("The system detected language for the query in BCP 47 language representation..")
  detectedLanguage?: string;

  @doc("The prediction result of a conversation project.")
  prediction: BasePrediction;
}

@doc("This is the base class of prediction")
@discriminator("projectKind")
model BasePrediction {
  @doc("The type of the project.")
  projectKind: projectKind;

  @doc("The intent with the highest score.")
  topIntent?: string;
}

@doc("This represents the prediction result of an Orchestration project.")
model OrchestrationPrediction extends BasePrediction {
  @doc("This represents the prediction result of an Orchestration project.")
  projectKind: projectKind.Orchestration;

  @doc("A dictionary that contains all intents. A key is an intent name and a value is its confidence score and target type. The top intent's value also contains the actual response from the target project.")
  intents: Record<TargetIntentResult>;
}

//todo: add enum member descriptions
@doc("The area unit of measurement.")
enum AreaUnit {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description, please use decorator @doc to add it."
  Unspecified,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareKilometer' should have a documentation or description, please use decorator @doc to add it."
  SquareKilometer,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareHectometer' should have a documentation or description, please use decorator @doc to add it."
  SquareHectometer,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareDecameter' should have a documentation or description, please use decorator @doc to add it."
  SquareDecameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareDecimeter' should have a documentation or description, please use decorator @doc to add it."
  SquareDecimeter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareMeter' should have a documentation or description, please use decorator @doc to add it."
  SquareMeter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareCentimeter' should have a documentation or description, please use decorator @doc to add it."
  SquareCentimeter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareMillimeter' should have a documentation or description, please use decorator @doc to add it."
  SquareMillimeter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareInch' should have a documentation or description, please use decorator @doc to add it."
  SquareInch,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareFoot' should have a documentation or description, please use decorator @doc to add it."
  SquareFoot,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareMile' should have a documentation or description, please use decorator @doc to add it."
  SquareMile,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareYard' should have a documentation or description, please use decorator @doc to add it."
  SquareYard,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Acre' should have a documentation or description, please use decorator @doc to add it."
  Acre,
}

//todo: add enum member descriptions
@doc("The Datetime SubKind.")
enum DateTimeSubKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Time' should have a documentation or description, please use decorator @doc to add it."
  Time,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Date' should have a documentation or description, please use decorator @doc to add it."
  Date,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'DateTime' should have a documentation or description, please use decorator @doc to add it."
  DateTime,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Duration' should have a documentation or description, please use decorator @doc to add it."
  Duration,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Set' should have a documentation or description, please use decorator @doc to add it."
  Set,
}

//todo: add enum member descriptions
@doc("The length unit of measurement.")
enum LengthUnit {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description, please use decorator @doc to add it."
  Unspecified,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Kilometer' should have a documentation or description, please use decorator @doc to add it."
  Kilometer,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Hectometer' should have a documentation or description, please use decorator @doc to add it."
  Hectometer,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Decameter' should have a documentation or description, please use decorator @doc to add it."
  Decameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Meter' should have a documentation or description, please use decorator @doc to add it."
  Meter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Decimeter' should have a documentation or description, please use decorator @doc to add it."
  Decimeter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Centimeter' should have a documentation or description, please use decorator @doc to add it."
  Centimeter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Millimeter' should have a documentation or description, please use decorator @doc to add it."
  Millimeter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Micrometer' should have a documentation or description, please use decorator @doc to add it."
  Micrometer,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Nanometer' should have a documentation or description, please use decorator @doc to add it."
  Nanometer,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Picometer' should have a documentation or description, please use decorator @doc to add it."
  Picometer,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Mile' should have a documentation or description, please use decorator @doc to add it."
  Mile,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Yard' should have a documentation or description, please use decorator @doc to add it."
  Yard,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Inch' should have a documentation or description, please use decorator @doc to add it."
  Inch,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Foot' should have a documentation or description, please use decorator @doc to add it."
  Foot,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'LightYear' should have a documentation or description, please use decorator @doc to add it."
  LightYear,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Pt' should have a documentation or description, please use decorator @doc to add it."
  Pt,
}

//todo: add enum member descriptions
@doc("The information (data) Unit of measurement.")
enum InformationUnit {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description, please use decorator @doc to add it."
  Unspecified,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Bit' should have a documentation or description, please use decorator @doc to add it."
  Bit,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Kilobit' should have a documentation or description, please use decorator @doc to add it."
  Kilobit,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Megabit' should have a documentation or description, please use decorator @doc to add it."
  Megabit,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Gigabit' should have a documentation or description, please use decorator @doc to add it."
  Gigabit,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Terabit' should have a documentation or description, please use decorator @doc to add it."
  Terabit,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Petabit' should have a documentation or description, please use decorator @doc to add it."
  Petabit,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Byte' should have a documentation or description, please use decorator @doc to add it."
  Byte,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Kilobyte' should have a documentation or description, please use decorator @doc to add it."
  Kilobyte,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Megabyte' should have a documentation or description, please use decorator @doc to add it."
  Megabyte,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Gigabyte' should have a documentation or description, please use decorator @doc to add it."
  Gigabyte,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Terabyte' should have a documentation or description, please use decorator @doc to add it."
  Terabyte,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Petabyte' should have a documentation or description, please use decorator @doc to add it."
  Petabyte,
}

//todo: add enum member descriptions
@doc("Enumeration of supported conversational modalities.")
enum Modality {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'transcript' should have a documentation or description, please use decorator @doc to add it."
  transcript,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'text' should have a documentation or description, please use decorator @doc to add it."
  text,
}

//todo: add enum member descriptions
@doc("The type of the extracted number entity.")
enum NumberKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Integer' should have a documentation or description, please use decorator @doc to add it."
  Integer,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Decimal' should have a documentation or description, please use decorator @doc to add it."
  Decimal,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Power' should have a documentation or description, please use decorator @doc to add it."
  Power,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Fraction' should have a documentation or description, please use decorator @doc to add it."
  Fraction,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Percent' should have a documentation or description, please use decorator @doc to add it."
  Percent,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description, please use decorator @doc to add it."
  Unspecified,
}

//todo: add enum member descriptions
@doc("The type of the project.")
enum projectKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Conversation' should have a documentation or description, please use decorator @doc to add it."
  Conversation,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Orchestration' should have a documentation or description, please use decorator @doc to add it."
  Orchestration,
}

//todo: add enum member descriptions
@doc("The kind of range that the resolution object represents.")
enum RangeKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Number' should have a documentation or description, please use decorator @doc to add it."
  Number,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Speed' should have a documentation or description, please use decorator @doc to add it."
  Speed,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Weight' should have a documentation or description, please use decorator @doc to add it."
  Weight,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Length' should have a documentation or description, please use decorator @doc to add it."
  Length,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Volume' should have a documentation or description, please use decorator @doc to add it."
  Volume,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Area' should have a documentation or description, please use decorator @doc to add it."
  Area,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Age' should have a documentation or description, please use decorator @doc to add it."
  Age,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Information' should have a documentation or description, please use decorator @doc to add it."
  Information,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Temperature' should have a documentation or description, please use decorator @doc to add it."
  Temperature,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Currency' should have a documentation or description, please use decorator @doc to add it."
  Currency,
}

//todo: add enum member descriptions
@doc("The reference point that the ordinal number denotes.")
enum RelativeTo {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Current' should have a documentation or description, please use decorator @doc to add it."
  Current,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'End' should have a documentation or description, please use decorator @doc to add it."
  End,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Start' should have a documentation or description, please use decorator @doc to add it."
  Start,
}

//todo: add enum member descriptions
@doc("The entity resolution object kind.")
enum resolutionKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'BooleanResolution' should have a documentation or description, please use decorator @doc to add it."
  BooleanResolution,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'DateTimeResolution' should have a documentation or description, please use decorator @doc to add it."
  DateTimeResolution,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'NumberResolution' should have a documentation or description, please use decorator @doc to add it."
  NumberResolution,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'OrdinalResolution' should have a documentation or description, please use decorator @doc to add it."
  OrdinalResolution,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SpeedResolution' should have a documentation or description, please use decorator @doc to add it."
  SpeedResolution,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'WeightResolution' should have a documentation or description, please use decorator @doc to add it."
  WeightResolution,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'LengthResolution' should have a documentation or description, please use decorator @doc to add it."
  LengthResolution,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'VolumeResolution' should have a documentation or description, please use decorator @doc to add it."
  VolumeResolution,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AreaResolution' should have a documentation or description, please use decorator @doc to add it."
  AreaResolution,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AgeResolution' should have a documentation or description, please use decorator @doc to add it."
  AgeResolution,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InformationResolution' should have a documentation or description, please use decorator @doc to add it."
  InformationResolution,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'TemperatureResolution' should have a documentation or description, please use decorator @doc to add it."
  TemperatureResolution,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'CurrencyResolution' should have a documentation or description, please use decorator @doc to add it."
  CurrencyResolution,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'NumericRangeResolution' should have a documentation or description, please use decorator @doc to add it."
  NumericRangeResolution,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'TemporalSpanResolution' should have a documentation or description, please use decorator @doc to add it."
  TemporalSpanResolution,
}

//todo: add enum member descriptions
@doc("The speed Unit of measurement")
enum SpeedUnit {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description, please use decorator @doc to add it."
  Unspecified,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'MetersPerSecond' should have a documentation or description, please use decorator @doc to add it."
  MetersPerSecond,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'KilometersPerHour' should have a documentation or description, please use decorator @doc to add it."
  KilometersPerHour,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'KilometersPerMinute' should have a documentation or description, please use decorator @doc to add it."
  KilometersPerMinute,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'KilometersPerSecond' should have a documentation or description, please use decorator @doc to add it."
  KilometersPerSecond,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'MilesPerHour' should have a documentation or description, please use decorator @doc to add it."
  MilesPerHour,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Knot' should have a documentation or description, please use decorator @doc to add it."
  Knot,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'FootPerSecond' should have a documentation or description, please use decorator @doc to add it."
  FootPerSecond,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'FootPerMinute' should have a documentation or description, please use decorator @doc to add it."
  FootPerMinute,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'YardsPerMinute' should have a documentation or description, please use decorator @doc to add it."
  YardsPerMinute,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'YardsPerSecond' should have a documentation or description, please use decorator @doc to add it."
  YardsPerSecond,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'MetersPerMillisecond' should have a documentation or description, please use decorator @doc to add it."
  MetersPerMillisecond,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'CentimetersPerMillisecond' should have a documentation or description, please use decorator @doc to add it."
  CentimetersPerMillisecond,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'KilometersPerMillisecond' should have a documentation or description, please use decorator @doc to add it."
  KilometersPerMillisecond,
}

//todo: add enum member descriptions
@doc("The type of a target service.")
enum targetProjectKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Luis' should have a documentation or description, please use decorator @doc to add it."
  Luis,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Conversation' should have a documentation or description, please use decorator @doc to add it."
  Conversation,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'QuestionAnswering' should have a documentation or description, please use decorator @doc to add it."
  QuestionAnswering,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'NonLinked' should have a documentation or description, please use decorator @doc to add it."
  NonLinked,
}

//todo: add enum member descriptions
@doc("The temperature Unit of measurement.")
enum TemperatureUnit {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description, please use decorator @doc to add it."
  Unspecified,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Fahrenheit' should have a documentation or description, please use decorator @doc to add it."
  Fahrenheit,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Kelvin' should have a documentation or description, please use decorator @doc to add it."
  Kelvin,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Rankine' should have a documentation or description, please use decorator @doc to add it."
  Rankine,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Celsius' should have a documentation or description, please use decorator @doc to add it."
  Celsius,
}

//todo: add enum member descriptions
@doc("An optional modifier of a date/time instance.")
enum TemporalModifier {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AfterApprox' should have a documentation or description, please use decorator @doc to add it."
  AfterApprox,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Before' should have a documentation or description, please use decorator @doc to add it."
  Before,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'BeforeStart' should have a documentation or description, please use decorator @doc to add it."
  BeforeStart,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Approx' should have a documentation or description, please use decorator @doc to add it."
  Approx,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ReferenceUndefined' should have a documentation or description, please use decorator @doc to add it."
  ReferenceUndefined,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SinceEnd' should have a documentation or description, please use decorator @doc to add it."
  SinceEnd,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AfterMid' should have a documentation or description, please use decorator @doc to add it."
  AfterMid,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Start' should have a documentation or description, please use decorator @doc to add it."
  Start,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'After' should have a documentation or description, please use decorator @doc to add it."
  After,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'BeforeEnd' should have a documentation or description, please use decorator @doc to add it."
  BeforeEnd,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Until' should have a documentation or description, please use decorator @doc to add it."
  Until,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'End' should have a documentation or description, please use decorator @doc to add it."
  End,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Less' should have a documentation or description, please use decorator @doc to add it."
  Less,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Since' should have a documentation or description, please use decorator @doc to add it."
  Since,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AfterStart' should have a documentation or description, please use decorator @doc to add it."
  AfterStart,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'BeforeApprox' should have a documentation or description, please use decorator @doc to add it."
  BeforeApprox,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Mid' should have a documentation or description, please use decorator @doc to add it."
  Mid,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'More' should have a documentation or description, please use decorator @doc to add it."
  More,
}

//todo: add enum member descriptions
@doc("The Age Unit of measurement")
enum AgeUnit {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description, please use decorator @doc to add it."
  Unspecified,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Year' should have a documentation or description, please use decorator @doc to add it."
  Year,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Month' should have a documentation or description, please use decorator @doc to add it."
  Month,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Week' should have a documentation or description, please use decorator @doc to add it."
  Week,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Day' should have a documentation or description, please use decorator @doc to add it."
  Day,
}

//todo: add enum member descriptions
@doc("The Volume Unit of measurement")
enum VolumeUnit {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description, please use decorator @doc to add it."
  Unspecified,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'CubicMeter' should have a documentation or description, please use decorator @doc to add it."
  CubicMeter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'CubicCentimeter' should have a documentation or description, please use decorator @doc to add it."
  CubicCentimeter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'CubicMillimeter' should have a documentation or description, please use decorator @doc to add it."
  CubicMillimeter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Hectoliter' should have a documentation or description, please use decorator @doc to add it."
  Hectoliter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Decaliter' should have a documentation or description, please use decorator @doc to add it."
  Decaliter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Liter' should have a documentation or description, please use decorator @doc to add it."
  Liter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Centiliter' should have a documentation or description, please use decorator @doc to add it."
  Centiliter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Milliliter' should have a documentation or description, please use decorator @doc to add it."
  Milliliter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'CubicYard' should have a documentation or description, please use decorator @doc to add it."
  CubicYard,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'CubicInch' should have a documentation or description, please use decorator @doc to add it."
  CubicInch,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'CubicFoot' should have a documentation or description, please use decorator @doc to add it."
  CubicFoot,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'CubicMile' should have a documentation or description, please use decorator @doc to add it."
  CubicMile,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'FluidOunce' should have a documentation or description, please use decorator @doc to add it."
  FluidOunce,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Teaspoon' should have a documentation or description, please use decorator @doc to add it."
  Teaspoon,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Tablespoon' should have a documentation or description, please use decorator @doc to add it."
  Tablespoon,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Pint' should have a documentation or description, please use decorator @doc to add it."
  Pint,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Quart' should have a documentation or description, please use decorator @doc to add it."
  Quart,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Cup' should have a documentation or description, please use decorator @doc to add it."
  Cup,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Gill' should have a documentation or description, please use decorator @doc to add it."
  Gill,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Pinch' should have a documentation or description, please use decorator @doc to add it."
  Pinch,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'FluidDram' should have a documentation or description, please use decorator @doc to add it."
  FluidDram,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Barrel' should have a documentation or description, please use decorator @doc to add it."
  Barrel,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Minim' should have a documentation or description, please use decorator @doc to add it."
  Minim,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Cord' should have a documentation or description, please use decorator @doc to add it."
  Cord,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Cord' should have a documentation or description, please use decorator @doc to add it."
  Peck,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Bushel' should have a documentation or description, please use decorator @doc to add it."
  Bushel,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Hogshead' should have a documentation or description, please use decorator @doc to add it."
  Hogshead,
}

//todo: add enum member descriptions
@doc("The weight Unit of measurement.")
enum WeightUnit {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description, please use decorator @doc to add it."
  Unspecified,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Kilogram' should have a documentation or description, please use decorator @doc to add it."
  Kilogram,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Gram' should have a documentation or description, please use decorator @doc to add it."
  Gram,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Milligram' should have a documentation or description, please use decorator @doc to add it."
  Milligram,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Gallon' should have a documentation or description, please use decorator @doc to add it."
  Gallon,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'MetricTon' should have a documentation or description, please use decorator @doc to add it."
  MetricTon,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Ton' should have a documentation or description, please use decorator @doc to add it."
  Ton,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Pound' should have a documentation or description, please use decorator @doc to add it."
  Pound,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Ounce' should have a documentation or description, please use decorator @doc to add it."
  Ounce,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Grain' should have a documentation or description, please use decorator @doc to add it."
  Grain,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'PennyWeight' should have a documentation or description, please use decorator @doc to add it."
  PennyWeight,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'LongTonBritish' should have a documentation or description, please use decorator @doc to add it."
  LongTonBritish,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ShortTonUS' should have a documentation or description, please use decorator @doc to add it."
  ShortTonUS,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ShortHundredWeightUS' should have a documentation or description, please use decorator @doc to add it."
  ShortHundredWeightUS,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Stone' should have a documentation or description, please use decorator @doc to add it."
  Stone,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Dram' should have a documentation or description, please use decorator @doc to add it."
  Dram,
}

alias ServiceTraits = NoRepeatableRequests & NoConditionalRequests & NoClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

#suppress "@azure-tools/typespec-azure-core/no-operation-id" "Operation ID is automatically generated by the OpenAPI emitters and should not normally be specified."
@doc("Analyzes the input conversation utterance.")
@actionSeparator("/:")
@action("analyze-conversations")
// @operationId("AnalyzeConversation")
//removed examples due to bug
// @Autorest.example(
//   "../../../../data-plane/Language/stable/2022-05-01/examples/conversations/SuccessfulAnalyzeConversations.json",
//   "Conversation project result"
// )
// @example(
//   "../../../../data-plane/Language/stable/2022-05-01/examples/conversations/SuccessfulAnalyzeConversationsArbitration.json",
//   "Orchestration result"
// )
// @example(
//   "../../../../data-plane/Language/stable/2022-05-01/examples/conversations/SuccessfulAnalyzeConversationsArbitrationDirectTarget.json",
//   "Orchestration direct target result"
// )
op analyzeConversation is Operations.ResourceCollectionAction<
    AnalyzeConversationTask,
    AnalyzeConversationTask,
    AnalyzeConversationTaskResult
  >;

@added(Versions.v2023_04_01)
@route("/language/analyze-conversations/jobs/{jobId}")
op analyzeConversationJobStatus(
  @doc("(Optional) if set to true, response will contain request and document level statistics.")
  @query showStats?: boolean, 
  @query `api-version`: Versions, 
  @path jobId: string): AnalyzeConversationJobState | Azure.Core.Foundations.ErrorResponse;


@added(Versions.v2023_04_01)
model SubmitAccepted {
  @statusCode _: 202;

  @pollingLocation
  @header("Operation-Location") 
  operationLocation: ResourceLocation<ResourceOperationStatus<AnalyzeConversationJobState>>;
};
  
@added(Versions.v2023_04_01)
@route("/language/analyze-conversations/jobs")
@post
@pollingOperation(analyzeConversationJobStatus)
op analyzeConversationSubmitJob(@query `api-version`: Versions, analyzeConversationJobsInput: AnalyzeConversationJobsInput): SubmitAccepted | Azure.Core.Foundations.ErrorResponse;

@added(Versions.v2023_04_01)
@route("/language/analyze-conversations/jobs/{jobId}:cancel")
@post
@pollingOperation(analyzeConversationJobStatus)
op analyzeConversationCancelJob(@query `api-version`: Versions,  @pollingOperationParameter(analyzeConversationJobStatus::parameters.jobId) @path jobId: string): SubmitAccepted | Azure.Core.Foundations.ErrorResponse;

