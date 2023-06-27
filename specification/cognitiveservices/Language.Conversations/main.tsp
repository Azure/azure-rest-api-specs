import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Autorest;
using Azure.Core;
using Azure.Core.Traits;

@doc("The language service conversations API is a suite of natural language processing (NLP) skills that can be used to analyze structured conversations (textual or spoken). The synchronous API in this suite accepts a request and mediates among multiple language projects, such as LUIS Generally Available, Question Answering, Conversational Language Understanding, and then calls the best candidate service to handle the request. At last, it returns a response with the candidate service's response as a payload.\n\n In some cases, this API needs to forward requests and responses between the caller and an upstream service. The asynchronous APIs in this suite enable tasks like Conversation Summarization and Conversational PII detection.")
@service({
  title: "Microsoft Cognitive Language Service - Analyze Conversations",
  version: "2022-05-01",
})
@useAuth(apim_key)
@server(
  "{Endpoint}/language",
  "Single server endpoint",
  {
    @doc("Supported Cognitive Services endpoint (e.g., https://<resource-name>.api.cognitiveservices.azure.com).")
    Endpoint: string,
  }
)
@useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace Azure.AI.Language.Conversations;

@TypeSpec.Rest.resource("language")
model Conversations {
  @key
  id: string;
}

@doc("A subscription key for a Language service resource")
model apim_key
  is ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">;

@doc("These are the [Azure Active Directory OAuth2](https://docs.microsoft.com/azure/active-directory/develop/v1-overview) Flows. When paired with [Azure role-based access](https://docs.microsoft.com/azure/role-based-access-control/overview) control it can be used to control access to Azure Maps REST APIs. Azure role-based access controls are used to designate access to one or more Azure Maps resource account or sub-resources. Any user, group, or service principal can be granted access via a  built-in role or a custom role composed of one or more permissions to Azure Maps REST APIs.\n\nTo implement scenarios, we recommend viewing [authentication concepts](https://aka.ms/amauth). In summary, this security definition provides a solution for modeling application(s) via objects capable of access control on specific APIs and scopes.\n\n#### Notes\n* This security definition **requires** the use of the `x-ms-client-id` header to indicate which Azure Maps resource the application is requesting access to. This can be acquired from the [Maps management API](https://aka.ms/amauthdetails).\n* \nThe `Authorization URL` is specific to the Azure public cloud instance. Sovereign clouds have unique Authorization URLs and Azure Active directory configurations. \n* \nThe Azure role-based access control is configured from the [Azure management plane](https://aka.ms/amrbac) via Azure portal, PowerShell, CLI, Azure SDKs, or REST APIs.\n* \nUsage of the [Azure Maps Web SDK](https://aka.ms/amaadmc) allows for configuration based setup of an application for multiple use cases.\n* Currently, Azure Active Directory [v1.0 or v2.0](https://docs.microsoft.com/azure/active-directory/develop/azure-ad-endpoint-comparison) supports Work, School, and Guests but does not support Personal accounts.")
model AADToken
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
      scopes: ["https://cognitiveservices.azure.com/.default"];
    }
  ]>;

@doc("Enumeration of supported Conversation tasks.")
enum AnalyzeConversationTaskKind {
  Conversation,
}

@doc("Enumeration of supported conversational task results.")
enum AnalyzeConversationTaskResultsKind {
  ConversationResult,
}

@discriminator("kind")
@doc("The base class of a conversation input task.")
model AnalyzeConversationTask {
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

  @doc("Set true to show all intents.")
  @projectedName("json", "show-all-intents")
  showAllIntents?: boolean;

  @doc("The timezone offset for the location of the request.")
  timezoneOffset?: float;

  @doc("Enable spell checking.")
  spellCheck?: boolean;

  @doc("The subscription key to use when enabling Bing spell check")
  @projectedName("json", "bing-spell-check-subscription-key")
  bingSpellCheckSubscriptionKey?: string;
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
  result: ConversationResult;
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

enum extraInformationKind {
  EntitySubtype,
  ListKey,
}

@doc("The concrete entity Subtype model of extra information.")
model EntitySubtype extends BaseExtraInformation {
  @doc("The extra information object kind.")
  extraInformationKind: extraInformationKind.EntitySubtype;

  @doc("The Subtype of an extracted entity type.")
  value: string;
}

@doc("The list key extra data kind.")
model ListKey extends BaseExtraInformation {
  @doc("The list key extra data kind.")
  extraInformationKind: extraInformationKind.ListKey;

  @doc("The canonical form of the extracted entity.")
  key: string;
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
  unit: unit;
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
  timex: TimeExpression;

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

  @doc("represents the resolution of a date and/or time span.")
  begin: TimeExpression;

  @doc("represents the resolution of a date and/or time span.")
  end: TimeExpression;

  @doc("An optional duration value formatted based on the ISO 8601 (https://en.wikipedia.org/wiki/ISO_8601#Durations)")
  duration: string;

  @doc("An optional modifier of a date/time instance.")
  modifier: TemporalModifier;
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

@doc("An extended ISO 8601 date/time representation as described in (https://github.com/Microsoft/Recognizers-Text/blob/master/Patterns/English/English-DateTime.yaml)")
model TimeExpression {}

@doc("It is a wrap up of LUIS Generally Available response.")
model LuisTargetIntentResult extends TargetIntentResult {
  @doc("It is a wrap up of LUIS Generally Available response.")
  targetProjectKind: targetProjectKind.Luis;

  @doc("The actual response from a LUIS Generally Available application.")
  result?: Record<never>;
}

@doc("It is a wrap up a Question Answering KB response.")
model QuestionAnsweringTargetIntentResult extends TargetIntentResult {
  @doc("It is a wrap up a Question Answering KB response.")
  targetProjectKind: targetProjectKind.QuestionAnswering;

  @doc("The generated answer by a Question Answering KB.")
  result?: AnswersResult;
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

enum AreaUnit {
  Unspecified,
  SquareKilometer,
  SquareHectometer,
  SquareDecameter,
  SquareDecimeter,
  SquareMeter,
  SquareCentimeter,
  SquareMillimeter,
  SquareInch,
  SquareFoot,
  SquareMile,
  SquareYard,
  Acre,
}

enum DateTimeSubKind {
  Time,
  Date,
  DateTime,
  Duration,
  Set,
}

enum LengthUnit {
  Unspecified,
  Kilometer,
  Hectometer,
  Decameter,
  Meter,
  Decimeter,
  Centimeter,
  Millimeter,
  Micrometer,
  Nanometer,
  Picometer,
  Mile,
  Yard,
  Inch,
  Foot,
  LightYear,
  Pt,
}

enum InformationUnit {
  Unspecified,
  Bit,
  Kilobit,
  Megabit,
  Gigabit,
  Terabit,
  Petabit,
  Byte,
  Kilobyte,
  Megabyte,
  Gigabyte,
  Terabyte,
  Petabyte,
}

@doc("Enumeration of supported conversational modalities.")
enum Modality {
  transcript,
  text,
}

enum NumberKind {
  Integer,
  Decimal,
  Power,
  Fraction,
  Percent,
  Unspecified,
}

enum projectKind {
  Conversation,
  Orchestration,
}

enum RangeKind {
  Number,
  Speed,
  Weight,
  Length,
  Volume,
  Area,
  Age,
  Information,
  Temperature,
  Currency,
}

enum RelativeTo {
  Current,
  End,
  Start,
}

enum resolutionKind {
  BooleanResolution,
  DateTimeResolution,
  NumberResolution,
  OrdinalResolution,
  SpeedResolution,
  WeightResolution,
  LengthResolution,
  VolumeResolution,
  AreaResolution,
  AgeResolution,
  InformationResolution,
  TemperatureResolution,
  CurrencyResolution,
  NumericRangeResolution,
  TemporalSpanResolution,
}

enum SpeedUnit {
  Unspecified,
  MetersPerSecond,
  KilometersPerHour,
  KilometersPerMinute,
  KilometersPerSecond,
  MilesPerHour,
  Knot,
  FootPerSecond,
  FootPerMinute,
  YardsPerMinute,
  YardsPerSecond,
  MetersPerMillisecond,
  CentimetersPerMillisecond,
  KilometersPerMillisecond,
}

enum targetProjectKind {
  Luis,
  Conversation,
  QuestionAnswering,
  NonLinked,
}

enum TemperatureUnit {
  Unspecified,
  Fahrenheit,
  Kelvin,
  Rankine,
  Celsius,
}

@doc("An optional modifier of a date/time instance.")
enum TemporalModifier {
  AfterApprox,
  Before,
  BeforeStart,
  Approx,
  ReferenceUndefined,
  SinceEnd,
  AfterMid,
  Start,
  After,
  BeforeEnd,
  Until,
  End,
  Less,
  Since,
  AfterStart,
  BeforeApprox,
  Mid,
  More,
}

enum unit {
  Unspecified,
  Year,
  Month,
  Week,
  Day,
}

enum VolumeUnit {
  Unspecified,
  CubicMeter,
  CubicCentimeter,
  CubicMillimeter,
  Hectoliter,
  Decaliter,
  Liter,
  Centiliter,
  Milliliter,
  CubicYard,
  CubicInch,
  CubicFoot,
  CubicMile,
  FluidOunce,
  Teaspoon,
  Tablespoon,
  Pint,
  Quart,
  Cup,
  Gill,
  Pinch,
  FluidDram,
  Barrel,
  Minim,
  Cord,
  Peck,
  Bushel,
  Hogshead,
}

enum WeightUnit {
  Unspecified,
  Kilogram,
  Gram,
  Milligram,
  Gallon,
  MetricTon,
  Ton,
  Pound,
  Ounce,
  Grain,
  PennyWeight,
  LongTonBritish,
  ShortTonUS,
  ShortHundredWeightUS,
  Stone,
  Dram,
}

interface ConversationAnalysis {
  @doc("Analyzes the input conversation utterance.")
  @TypeSpec.Rest.actionSeparator("/:")
  @TypeSpec.Rest.action("analyze-conversations")
  @example(
    "../data-plane/Language/stable/2022-05-01/examples/conversations/SuccessfulAnalyzeConversations.json",
    "Conversation project result"
  )
  @example(
    "../data-plane/Language/stable/2022-05-01/examples/conversations/SuccessfulAnalyzeConversationsArbitration.json",
    "Orchestration result"
  )
  @example(
    "../data-plane/Language/stable/2022-05-01/examples/conversations/SuccessfulAnalyzeConversationsArbitrationDirectTarget.json",
    "Orchestration direct target result"
  )
  analyzeConversation is Azure.Core.StandardResourceOperations.ResourceCollectionAction<
    Conversations,
    {
      @doc("A single conversational task to execute.")
      @body
      body: AnalyzeConversationTask;
    },
    AnalyzeConversationTaskResult
  >;
}
