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

@useAuth(apim_key)
@service({
  title: "Microsoft Cognitive Language Service - Analyze Conversations",
})
@server(
  "{endpoint}/language",
  "Single server endpoint",
  {
    @doc("Supported Cognitive Services endpoint (e.g., https://<resource-name>.api.cognitiveservices.azure.com).")
    endpoint: string,
  }
)
@versioned(Versions)
namespace Language.Conversations;

@doc("Analyze Conversations Service Versions")
enum Versions {
  @doc("Version 2022-05-01")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2022_05_01: "2022-05-01",
}

@doc("Resource model")
@TypeSpec.Rest.resource("language")
model Conversations {
  @key
  @doc("id")
  @visibility("create")
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
  @doc("Conversation task")
  Conversation,
}

@doc("Enumeration of supported conversational task results.")
enum AnalyzeConversationTaskResultsKind {
  @doc("Conversational task result.")
  ConversationResult,
}

@discriminator("kind")
@doc("The base class of a conversation input task.")
model AnalyzeConversationTask {
  @doc("The base class of a conversation input task.")
  kind: AnalyzeConversationTaskKind.Conversation;
}

@doc("The base class of a conversation input task result.")
@discriminator("kind")
model AnalyzeConversationTaskResult {
  @doc("The base class of a conversation input task result.")
  kind: AnalyzeConversationTaskResultsKind.ConversationResult;
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
  timezoneOffset?: float32;

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

@doc("The extra information object kind.")
enum extraInformationKind {
  @doc("Entity Subtype.")
  EntitySubtype,
  @doc("List key.")
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

@doc("The area unit of measurement.")
enum AreaUnit {
  @doc("Unspecified unit of area.")
  Unspecified,
  @doc("SI unit of area.")
  SquareKilometer,
  @doc("SI unit of area.")
  SquareHectometer,
  @doc("SI unit of area.")
  SquareDecameter,
  @doc("SI unit of area.")
  SquareDecimeter,
  @doc("SI unit of area.")
  SquareMeter,
  @doc("SI unit of area.")
  SquareCentimeter,
  @doc("SI unit of area.")
  SquareMillimeter,
  @doc("Imperial unit of area.")
  SquareInch,
  @doc("Imperial unit of area.")
  SquareFoot,
  @doc("Imperial unit of area.")
  SquareMile,
  @doc("Imperial unit of area.")
  SquareYard,
  @doc("Imperial unit of area.")
  Acre,
}

@doc("Datetime entity kind.")
enum DateTimeSubKind {
  @doc("Datetime unit.")
  Time,
  @doc("Datetime unit.")
  Date,
  @doc("Datetime unit.")
  DateTime,
  @doc("Datetime unit.")
  Duration,
  @doc("Datetime unit.")
  Set,
}

@doc("THe length unit of measurement.")
enum LengthUnit {
  @doc("THe length unit of measurement.")
  Unspecified,
  @doc("THe length unit of measurement.")
  Kilometer,
  @doc("THe length unit of measurement.")
  Hectometer,
  @doc("THe length unit of measurement.")
  Decameter,
  @doc("THe length unit of measurement.")
  Meter,
  @doc("THe length unit of measurement.")
  Decimeter,
  @doc("THe length unit of measurement.")
  Centimeter,
  @doc("THe length unit of measurement.")
  Millimeter,
  @doc("THe length unit of measurement.")
  Micrometer,
  @doc("THe length unit of measurement.")
  Nanometer,
  @doc("THe length unit of measurement.")
  Picometer,
  @doc("THe length unit of measurement.")
  Mile,
  @doc("THe length unit of measurement.")
  Yard,
  @doc("THe length unit of measurement.")
  Inch,
  @doc("THe length unit of measurement.")
  Foot,
  @doc("THe length unit of measurement.")
  LightYear,
  @doc("THe length unit of measurement.")
  Pt,
}

@doc("The information (data) Unit of measurement.")
enum InformationUnit {
  @doc("The information (data) Unit of measurement.")
  Unspecified,
  @doc("The information (data) Unit of measurement.")
  Bit,
  @doc("The information (data) Unit of measurement.")
  Kilobit,
  @doc("The information (data) Unit of measurement.")
  Megabit,
  @doc("The information (data) Unit of measurement.")
  Gigabit,
  @doc("The information (data) Unit of measurement.")
  Terabit,
  @doc("The information (data) Unit of measurement.")
  Petabit,
  @doc("The information (data) Unit of measurement.")
  Byte,
  @doc("The information (data) Unit of measurement.")
  Kilobyte,
  @doc("The information (data) Unit of measurement.")
  Megabyte,
  @doc("The information (data) Unit of measurement.")
  Gigabyte,
  @doc("The information (data) Unit of measurement.")
  Terabyte,
  @doc("The information (data) Unit of measurement.")
  Petabyte,
}

@doc("Enumeration of supported conversational modalities.")
enum Modality {
  @doc("Transcript conversational modality.")
  transcript,
  @doc("Text conversational modality.")
  text,
}

@doc("The type of the extracted number entity.")
enum NumberKind {
  @doc("The type of the extracted number entity.")
  Integer,
  @doc("The type of the extracted number entity.")
  Decimal,
  @doc("The type of the extracted number entity.")
  Power,
  @doc("The type of the extracted number entity.")
  Fraction,
  @doc("The type of the extracted number entity.")
  Percent,
  @doc("The type of the extracted number entity.")
  Unspecified,
}

@doc("The type of the project.")
enum projectKind {
  @doc("The type of the project.")
  Conversation,
  @doc("The type of the project.")
  Orchestration,
}

@doc("The kind of range that the resolution object represents.")
enum RangeKind {
  @doc("The kind of range that the resolution object represents.")
  Number,
  @doc("The kind of range that the resolution object represents.")
  Speed,
  @doc("The kind of range that the resolution object represents.")
  Weight,
  @doc("The kind of range that the resolution object represents.")
  Length,
  @doc("The kind of range that the resolution object represents.")
  Volume,
  @doc("The kind of range that the resolution object represents.")
  Area,
  @doc("The kind of range that the resolution object represents.")
  Age,
  @doc("The kind of range that the resolution object represents.")
  Information,
  @doc("The kind of range that the resolution object represents.")
  Temperature,
  @doc("The kind of range that the resolution object represents.")
  Currency,
}

@doc("The reference point that the ordinal number denotes.")
enum RelativeTo {
  @doc("The reference point that the ordinal number denotes.")
  Current,
  @doc("The reference point that the ordinal number denotes.")
  End,
  @doc("The reference point that the ordinal number denotes.")
  Start,
}

@doc("The entity resolution object kind.")
enum resolutionKind {
  @doc("The entity resolution object kind.")
  BooleanResolution,
  @doc("The entity resolution object kind.")
  DateTimeResolution,
  @doc("The entity resolution object kind.")
  NumberResolution,
  @doc("The entity resolution object kind.")
  OrdinalResolution,
  @doc("The entity resolution object kind.")
  SpeedResolution,
  @doc("The entity resolution object kind.")
  WeightResolution,
  @doc("The entity resolution object kind.")
  LengthResolution,
  @doc("The entity resolution object kind.")
  VolumeResolution,
  @doc("The entity resolution object kind.")
  AreaResolution,
  @doc("The entity resolution object kind.")
  AgeResolution,
  @doc("The entity resolution object kind.")
  InformationResolution,
  @doc("The entity resolution object kind.")
  TemperatureResolution,
  @doc("The entity resolution object kind.")
  CurrencyResolution,
  @doc("The entity resolution object kind.")
  NumericRangeResolution,
  @doc("The entity resolution object kind.")
  TemporalSpanResolution,
}

@doc("The speed Unit of measurement")
enum SpeedUnit {
  @doc("The speed Unit of measurement")
  Unspecified,
  @doc("The speed Unit of measurement")
  MetersPerSecond,
  @doc("The speed Unit of measurement")
  KilometersPerHour,
  @doc("The speed Unit of measurement")
  KilometersPerMinute,
  @doc("The speed Unit of measurement")
  KilometersPerSecond,
  @doc("The speed Unit of measurement")
  MilesPerHour,
  @doc("The speed Unit of measurement")
  Knot,
  @doc("The speed Unit of measurement")
  FootPerSecond,
  @doc("The speed Unit of measurement")
  FootPerMinute,
  @doc("The speed Unit of measurement")
  YardsPerMinute,
  @doc("The speed Unit of measurement")
  YardsPerSecond,
  @doc("The speed Unit of measurement")
  MetersPerMillisecond,
  @doc("The speed Unit of measurement")
  CentimetersPerMillisecond,
  @doc("The speed Unit of measurement")
  KilometersPerMillisecond,
}

@doc("The type of a target service.")
enum targetProjectKind {
  @doc("The type of a target service.")
  Luis,
  @doc("The type of a target service.")
  Conversation,
  @doc("The type of a target service.")
  QuestionAnswering,
  @doc("The type of a target service.")
  NonLinked,
}

@doc("The temperature Unit of measurement.")
enum TemperatureUnit {
  @doc("The temperature Unit of measurement.")
  Unspecified,
  @doc("The temperature Unit of measurement.")
  Fahrenheit,
  @doc("The temperature Unit of measurement.")
  Kelvin,
  @doc("The temperature Unit of measurement.")
  Rankine,
  @doc("The temperature Unit of measurement.")
  Celsius,
}

@doc("An optional modifier of a date/time instance.")
enum TemporalModifier {
  @doc("An optional modifier of a date/time instance.")
  AfterApprox,
  @doc("An optional modifier of a date/time instance.")
  Before,
  @doc("An optional modifier of a date/time instance.")
  BeforeStart,
  @doc("An optional modifier of a date/time instance.")
  Approx,
  @doc("An optional modifier of a date/time instance.")
  ReferenceUndefined,
  @doc("An optional modifier of a date/time instance.")
  SinceEnd,
  @doc("An optional modifier of a date/time instance.")
  AfterMid,
  @doc("An optional modifier of a date/time instance.")
  Start,
  @doc("An optional modifier of a date/time instance.")
  After,
  @doc("An optional modifier of a date/time instance.")
  BeforeEnd,
  @doc("An optional modifier of a date/time instance.")
  Until,
  @doc("An optional modifier of a date/time instance.")
  End,
  @doc("An optional modifier of a date/time instance.")
  Less,
  @doc("An optional modifier of a date/time instance.")
  Since,
  @doc("An optional modifier of a date/time instance.")
  AfterStart,
  @doc("An optional modifier of a date/time instance.")
  BeforeApprox,
  @doc("An optional modifier of a date/time instance.")
  Mid,
  @doc("An optional modifier of a date/time instance.")
  More,
}

@doc("The Age Unit of measurement")
enum unit {
  @doc("The Age Unit of measurement")
  Unspecified,
  @doc("The Age Unit of measurement")
  Year,
  @doc("The Age Unit of measurement")
  Month,
  @doc("The Age Unit of measurement")
  Week,
  @doc("The Age Unit of measurement")
  Day,
}

@doc("The Volume Unit of measurement")
enum VolumeUnit {
  @doc("The Volume Unit of measurement")
  Unspecified,
  @doc("The Volume Unit of measurement")
  CubicMeter,
  @doc("The Volume Unit of measurement")
  CubicCentimeter,
  @doc("The Volume Unit of measurement")
  CubicMillimeter,
  @doc("The Volume Unit of measurement")
  Hectoliter,
  @doc("The Volume Unit of measurement")
  Decaliter,
  @doc("The Volume Unit of measurement")
  Liter,
  @doc("The Volume Unit of measurement")
  Centiliter,
  @doc("The Volume Unit of measurement")
  Milliliter,
  @doc("The Volume Unit of measurement")
  CubicYard,
  @doc("The Volume Unit of measurement")
  CubicInch,
  @doc("The Volume Unit of measurement")
  CubicFoot,
  @doc("The Volume Unit of measurement")
  CubicMile,
  @doc("The Volume Unit of measurement")
  FluidOunce,
  @doc("The Volume Unit of measurement")
  Teaspoon,
  @doc("The Volume Unit of measurement")
  Tablespoon,
  @doc("The Volume Unit of measurement")
  Pint,
  @doc("The Volume Unit of measurement")
  Quart,
  @doc("The Volume Unit of measurement")
  Cup,
  @doc("The Volume Unit of measurement")
  Gill,
  @doc("The Volume Unit of measurement")
  Pinch,
  @doc("The Volume Unit of measurement")
  FluidDram,
  @doc("The Volume Unit of measurement")
  Barrel,
  @doc("The Volume Unit of measurement")
  Minim,
  @doc("The Volume Unit of measurement")
  Cord,
  @doc("The Volume Unit of measurement")
  Peck,
  @doc("The Volume Unit of measurement")
  Bushel,
  @doc("The Volume Unit of measurement")
  Hogshead,
}

@doc("The weight Unit of measurement.")
enum WeightUnit {
  @doc("The weight Unit of measurement.")
  Unspecified,
  @doc("The weight Unit of measurement.")
  Kilogram,
  @doc("The weight Unit of measurement.")
  Gram,
  @doc("The weight Unit of measurement.")
  Milligram,
  @doc("The weight Unit of measurement.")
  Gallon,
  @doc("The weight Unit of measurement.")
  MetricTon,
  @doc("The weight Unit of measurement.")
  Ton,
  @doc("The weight Unit of measurement.")
  Pound,
  @doc("The weight Unit of measurement.")
  Ounce,
  @doc("The weight Unit of measurement.")
  Grain,
  @doc("The weight Unit of measurement.")
  PennyWeight,
  @doc("The weight Unit of measurement.")
  LongTonBritish,
  @doc("The weight Unit of measurement.")
  ShortTonUS,
  @doc("The weight Unit of measurement.")
  ShortHundredWeightUS,
  @doc("The weight Unit of measurement.")
  Stone,
  @doc("The weight Unit of measurement.")
  Dram,
}

@doc("Analyzes the input conversation utterance.")
@TypeSpec.Rest.actionSeparator("/:")
@TypeSpec.Rest.action("analyze-conversations")
//removed examples due to bug
// @example(
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
op analyzeConversation is Azure.Core.StandardResourceOperations.ResourceCollectionAction<
  Conversations,
  AnalyzeConversationTask,
  AnalyzeConversationTaskResult
>;
