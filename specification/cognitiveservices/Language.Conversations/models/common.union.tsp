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

/** Enumeration of supported Conversation tasks. */
union AnalyzeConversationTaskKind {
  string,

  /** Conversation task kind */
  Conversation: "Conversation",

  /** Conversation task kind */
  @added(Versions.v2025_05_15_preview)
  ConversationalAI: "ConversationalAI",
}

/** Enumeration of supported conversational task results. */
union AnalyzeConversationTaskResultsKind {
  string,

  /** Conversation result task kind */
  ConversationResult: "ConversationResult",

  /** Conversation result task kind */
  @added(Versions.v2025_05_15_preview)
  ConversationalAIResult: "ConversationalAIResult",
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

  /** Conversation type */
  @added(Versions.v2025_05_15_preview)
  ConversationalAI: "ConversationalAI",
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

/** Enumeration of supported analysis tasks on a collection of conversations. */
@added(Versions.v2023_04_01)
union AnalyzeConversationLROTaskKind {
  string,

  /** Conversational Summarization Task */
  ConversationalSummarizationTask: "ConversationalSummarizationTask",

  /** Conversational PII Task */
  @added(Versions.v2024_05_01)
  ConversationalPIITask: "ConversationalPIITask",

  /** Custom Conversational Summarization Task */
  @added(Versions.v2024_11_15_preview)
  CustomConversationalSummarizationTask: "CustomConversationalSummarizationTask",
}

/** Enumeration of results for supported conversation analysis Results. */
@added(Versions.v2023_04_01)
union AnalyzeConversationResultsKind {
  string,

  /** Conversational Summarization Results */
  @added(Versions.v2023_04_01)
  ConversationalSummarizationResults: "conversationalSummarizationResults",

  /** Conversational PII Results */
  @added(Versions.v2024_05_01)
  ConversationalPIIResults: "conversationalPIIResults",

  /** Custom Conversational Summarization Results */
  @added(Versions.v2024_11_15_preview)
  CustomConversationalSummarizationResults: "customConversationalSummarizationResults",
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

/** Enumeration of supported transcript content types. */
@added(Versions.v2024_05_01)
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

/** Set to 'OR' or 'AND' for using corresponding logical operation. */
union LogicalOperationKind {
  string,

  /** Logical AND */
  AND: "AND",

  /** Logical OR */
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

/** Type of ranker to be used */
union RankerKind {
  string,

  /** Default ranker. */
  Default: "Default",

  /** Question only ranker. */
  QuestionOnly: "QuestionOnly",
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
