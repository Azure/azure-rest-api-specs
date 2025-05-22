import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.Text;

/** The entity recognition analyze text input task request. */
model AnalyzeTextEntityRecognitionInput extends AnalyzeTextTask {
  /** The kind of task. */
  kind: AnalyzeTextTaskKind.EntityRecognition;

  /** The input to be analyzed. */
  analysisInput?: MultiLanguageAnalysisInput;

  /** Task parameters. */
  parameters?: EntitiesTaskParameters;
}

/** Supported parameters for an Entity Recognition task. */
model EntitiesTaskParameters is PreBuiltTaskParameters {
  /** (Optional) parameter to provide the string index type used to interpret string offsets. Defaults to TextElements (Graphemes). */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  /** (Optional) request parameter that limits the output to the requested entity types included in this list. We will apply inclusionList before exclusionList */
  @added(Versions.v2023_11_15_preview)
  inclusionList?: Array<EntityCategory>;

  /** (Optional) request parameter that filters out any entities that are included the excludeList. When a user specifies an excludeList, they cannot get a prediction returned with an entity in that list. We will apply inclusionList before exclusionList */
  @added(Versions.v2023_11_15_preview)
  exclusionList?: Array<EntityCategory>;

  /** (Optional) describes the type of overlap policy to apply to the ner output. */
  @added(Versions.v2023_11_15_preview)
  overlapPolicy?: BaseEntityOverlapPolicy;

  /** (Optional) request parameter that allows the user to provide settings for running the inference. */
  @added(Versions.v2023_11_15_preview)
  inferenceOptions?: EntityInferenceOptions;
}

/** An object representing the task definition for an Entities Recognition task. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model EntitiesLROTask extends AnalyzeTextLROTask {
  /** The kind of task. */
  kind: AnalyzeTextLROTaskKind.EntityRecognition;

  /** Task parameters. */
  parameters?: EntitiesTaskParameters;
}

/** Contains the entity task */
model EntitiesTaskResult extends AnalyzeTextTaskResult {
  /** kind of the task */
  kind: AnalyzeTextTaskResultsKind.EntityRecognitionResults;

  /** Results for entity recognition. */
  results: EntitiesResult;
}

/** Contains the entity recognition task result. */
model EntitiesResult is PreBuiltResult {
  /** Response by document */
  @typeChangedFrom(Versions.v2023_11_15_preview, Array<EntitiesDocumentResult>)
  documents: Array<EntitiesDocumentResultWithMetadataDetectedLanguage>;
}

/** Contains the entity recognition task result for the document. */
model EntitiesDocumentResult is DocumentResult {
  /** Recognized entities in the document. */
  entities: Array<Entity>;
}

/** Contains the entity recognition task result for the document with detected language. */
@added(Versions.v2023_11_15_preview)
model EntitiesDocumentResultWithDetectedLanguage {
  ...EntitiesDocumentResult;
  ...DocumentDetectedLanguage;
}

/** Contains the entity recognition task result for the document with metadata and detected language. */
@added(Versions.v2023_11_15_preview)
model EntitiesDocumentResultWithMetadataDetectedLanguage
  is EntitiesDocumentResultWithMetadata {
  ...DocumentDetectedLanguage;
}

/** Defines the detected entity object containing the entity category and entity text detected, etc. */
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

/** Contains the entity recognition job task result. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
model EntityRecognitionLROResult extends AnalyzeTextLROResult {
  /** Kind of the task. */
  kind: AnalyzeTextLROResultsKind.EntityRecognitionLROResults;

  /** Results for the task. */
  results: EntitiesResult;
}

/** Contains all the entity categories detected by entity recognition. */
@added(Versions.v2023_11_15_preview)
union EntityCategory {
  string,

  /** Specific street-level mentions of locations: house/building numbers, streets, avenues, highways, intersections referenced by name. */
  Address: "Address",

  /** Numeric values, including digits and number words. */
  Numeric: "Numeric",

  /** Age-related values. */
  Age: "Age",

  /** Currency-related values. */
  Currency: "Currency",

  /** Numbers without a unit */
  Number: "Number",

  /** Range of Numbers */
  NumberRange: "NumberRange",

  /** Percentage-related values. */
  Percentage: "Percentage",

  /** Ordinal numbers. */
  Ordinal: "Ordinal",

  /** Temperature-related values. */
  Temperature: "Temperature",

  /** Dimension of measurements */
  Dimension: "Dimension",

  /** Length of an object. */
  Length: "Length",

  /** Weight of an object. */
  Weight: "Weight",

  /** Height of an object. */
  Height: "Height",

  /** Speed of an object. */
  Speed: "Speed",

  /** Area of an object. */
  Area: "Area",

  /** Volume of an object. */
  Volume: "Volume",

  /** Unit of measure for digital information. */
  Information: "Information",

  /** Items relating to time. */
  Temporal: "Temporal",

  /** Calendar dates. */
  Date: "Date",

  /** Times of day. */
  Time: "Time",

  /** Calendar dates with time. */
  DateTime: "DateTime",

  /** Range of dates. */
  DateRange: "DateRange",

  /** Range of times. */
  TimeRange: "TimeRange",

  /** Range of date and time. */
  DateTimeRange: "DateTimeRange",

  /** Duration of time. */
  Duration: "Duration",

  /** Set of time-related values. */
  SetTemporal: "SetTemporal",

  /** Social, sports, business, political, educational, natural, historical, criminal, violent, legal, military events with a timed period. */
  Event: "Event",

  /** Sports event-related values. */
  SportsEvent: "SportsEvent",

  /** Cultural event-related values. */
  CulturalEvent: "CulturalEvent",

  /** Natural event-related values. */
  NaturalEvent: "NaturalEvent",

  /** Particular point or place in physical space. */
  Location: "Location",

  /** Cities, countries/regions, states. */
  GPE: "GPE",

  /** City-related values. */
  City: "City",

  /** State-related values. */
  State: "State",

  /** Country or region-related values. */
  CountryRegion: "CountryRegion",

  /** Continent-related values. */
  Continent: "Continent",

  /** Manmade structures. */
  Structural: "Structural",

  /** Airports. */
  Airport: "Airport",

  /** Geographic and natural features such as rivers, oceans, and deserts. */
  Geological: "Geological",

  /** Corporations, agencies, and other groups of people defined by some established organizational structure. These labels can include companies, political parties/movements, musical bands, sport clubs, government bodies, and public organizations. Nationalities or religions are not ORGANIZATION. */
  Organization: "Organization",

  /** Medical companies and groups. */
  OrganizationMedical: "OrganizationMedical",

  /** Stock exchange groups. */
  OrganizationStockExchange: "OrganizationStockExchange",

  /** Sports-related organizations. */
  OrganizationSports: "OrganizationSports",

  /** First, last, and middle names, names of fictional characters, and aliases. Titles, such as 'Mr.' or 'President', are not considered part of the named entity. */
  Person: "Person",

  /** Human roles classified by a group membership. */
  PersonType: "PersonType",

  /** Email addresses. */
  Email: "Email",

  /** URLs to websites. */
  URL: "URL",

  /** network IP addresses. */
  IP: "IP",

  /** Phone numbers (US and EU phone numbers only). */
  PhoneNumber: "PhoneNumber",

  /** Single or group of commercial, consumable objects, electronics, vehicles, food groups. */
  Product: "Product",

  /** Computing products. */
  ComputingProduct: "ComputingProduct",

  /** A capability, skill, or expertise. */
  Skill: "Skill",
}

/** The class that houses the inference options allowed for named entity recognition. */
@added(Versions.v2023_11_15_preview)
model EntityInferenceOptions {
  /** Option to include/exclude the detected entity values to be normalized and included in the metadata. The numeric and temporal entity types support value normalization. */
  excludeNormalizedValues?: boolean = false;
}

/** The abstract base class for entity OverlapPolicy. */
@added(Versions.v2023_11_15_preview)
@discriminator("policyKind")
model BaseEntityOverlapPolicy {
  /** The entity OverlapPolicy object kind. */
  policyKind: policyKind = policyKind.matchLongest;
}

/** Kinds of overlap policies supported. */
@added(Versions.v2023_11_15_preview)
union policyKind {
  string,

  /** Represents MatchLongestEntityPolicyType */
  matchLongest: "matchLongest",

  /** Represents AllowOverlapEntityPolicyType */
  allowOverlap: "allowOverlap",
}

/** Represents the Match longest overlap policy. No overlapping entities as far as it is possible. 1. If there are overlapping entities, the longest one will be returned. 2. If the set of characters predicted for 2 or more entities are exactly the same, select the entity that has the higher confidence score.3. If the entity scores are identical, return all entities that are still present after applying the previous rules. 3. If there is partial overlap (as in Hello Text Analytics) follow the above steps starting from 1. */
@added(Versions.v2023_11_15_preview)
model MatchLongestEntityPolicyType extends BaseEntityOverlapPolicy {
  /** The entity OverlapPolicy object kind. */
  policyKind: policyKind.matchLongest;
}

/** Represents the allow overlap policy. Will apply no post processing logic for the entities. Whatever the model predicts is what will be returned to the user. This allows the user to get a full view of every single model's possible values and apply their own custom logic on entity selection */
@added(Versions.v2023_11_15_preview)
model AllowOverlapEntityPolicyType extends BaseEntityOverlapPolicy {
  /** The entity OverlapPolicy object kind. */
  policyKind: policyKind.allowOverlap;
}

/** Entity documents result with metadata. */
@added(Versions.v2023_11_15_preview)
model EntitiesDocumentResultWithMetadata is DocumentResult {
  /** Recognized entities in the document. */
  entities: Array<EntityWithMetadata>;
}

/** Entity tag object which contains the name of the tags abd any associated confidence score. Entity Tags are used to express some similarities/affinity between entities. */
@added(Versions.v2023_11_15_preview)
model EntityTag {
  /** Name of the tag. Entity Tag names will be unique globally. */
  name: string;

  /** Detection score between 0 and 1 of the extracted entity. */
  confidenceScore?: float64;
}

/** Entity object with tags. */
@added(Versions.v2023_11_15_preview)
model EntityWithTags is Entity {
  /** An entity type is the lowest (or finest) granularity at which the entity has been detected. The type maps to the specific metadata attributes associated with the entity detected. */
  type: string;

  /** List of entity tags. Tags are to express some similarities/affinity between entities. */
  tags: Array<EntityTag>;
}

/** Entity object with tags and metadata. */
@added(Versions.v2023_11_15_preview)
model EntityWithMetadata is EntityWithTags {
  /** The entity metadata object. */
  metadata?: BaseMetadata;
}

/** The Age Unit of measurement */
@added(Versions.v2023_11_15_preview)
union AgeUnit {
  string,

  /** Unspecified time period */
  Unspecified: "Unspecified",

  /** Time period of a year */
  Year: "Year",

  /** Time period of a month */
  Month: "Month",

  /** Time period of a week */
  Week: "Week",

  /** Time period of a day */
  Day: "Day",
}

/** The Volume Unit of measurement */
@added(Versions.v2023_11_15_preview)
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

/** The speed Unit of measurement */
@added(Versions.v2023_11_15_preview)
union SpeedUnit {
  string,

  /** Unspecified speed unit. */
  Unspecified: "Unspecified",

  /** Speed unit in meters per second. */
  MetersPerSecond: "MetersPerSecond",

  /** Speed unit in kilometers per hour. */
  KilometersPerHour: "KilometersPerHour",

  /** Speed unit in kilometers per minute. */
  KilometersPerMinute: "KilometersPerMinute",

  /** Speed unit in kilometers per second. */
  KilometersPerSecond: "KilometersPerSecond",

  /** Speed unit in miles per hour. */
  MilesPerHour: "MilesPerHour",

  /** Speed unit in knots. */
  Knots: "Knots",

  /** Speed unit in feet per second. */
  FeetPerSecond: "FeetPerSecond",

  /** Speed unit in feet per minute. */
  FeetPerMinute: "FeetPerMinute",

  /** Speed unit in yards per minute. */
  YardsPerMinute: "YardsPerMinute",

  /** Speed unit in yards per second. */
  YardsPerSecond: "YardsPerSecond",

  /** Speed unit in meters per millisecond. */
  MetersPerMillisecond: "MetersPerMillisecond",

  /** Speed unit in centimeters per millisecond. */
  CentimetersPerMillisecond: "CentimetersPerMillisecond",

  /** Speed unit in Kilometers per millisecond. */
  KilometersPerMillisecond: "KilometersPerMillisecond",
}
/** The area unit of measurement. */
@added(Versions.v2023_11_15_preview)
union AreaUnit {
  string,

  /** Unspecified area unit */
  Unspecified: "Unspecified",

  /** Area unit in square kilometers */
  SquareKilometer: "SquareKilometer",

  /** Area unit in square hectometers */
  SquareHectometer: "SquareHectometer",

  /** Area unit in square decameters */
  SquareDecameter: "SquareDecameter",

  /** Area unit in square decimeters */
  SquareDecimeter: "SquareDecimeter",

  /** Area unit in square meters */
  SquareMeter: "SquareMeter",

  /** Area unit in square centimeters */
  SquareCentimeter: "SquareCentimeter",

  /** Area unit in square millimeters */
  SquareMillimeter: "SquareMillimeter",

  /** Area unit in square inches */
  SquareInch: "SquareInch",

  /** Area unit in square feet */
  SquareFoot: "SquareFoot",

  /** Area unit in square miles */
  SquareMile: "SquareMile",

  /** Area unit in square yards */
  SquareYard: "SquareYard",

  /** Area unit in acres */
  Acre: "Acre",
}

/** The length unit of measurement. */
@added(Versions.v2023_11_15_preview)
union LengthUnit {
  string,

  /** Unspecified length unit. */
  Unspecified: "Unspecified",

  /** Length unit in kilometers. */
  Kilometer: "Kilometer",

  /** Length unit in hectometers. */
  Hectometer: "Hectometer",

  /** Length unit in decameters. */
  Decameter: "Decameter",

  /** Length unit in meters. */
  Meter: "Meter",

  /** Length unit in decimeters. */
  Decimeter: "Decimeter",

  /** Length unit in centimeters. */
  Centimeter: "Centimeter",

  /** Length unit in millimeters. */
  Millimeter: "Millimeter",

  /** Length unit in micrometers. */
  Micrometer: "Micrometer",

  /** Length unit in nanometers. */
  Nanometer: "Nanometer",

  /** Length unit in picometers. */
  Picometer: "Picometer",

  /** Length unit in miles. */
  Mile: "Mile",

  /** Length unit in yards. */
  Yard: "Yard",

  /** Length unit in inches. */
  Inch: "Inch",

  /** Length unit in feet. */
  Foot: "Foot",

  /** Length unit in light years. */
  LightYear: "LightYear",

  /** Length unit in points. */
  Point: "Point",
}

/** The information (data) Unit of measurement. */
@added(Versions.v2023_11_15_preview)
union InformationUnit {
  string,

  /** Unspecified data size unit */
  Unspecified: "Unspecified",

  /** Data size unit in bits */
  Bit: "Bit",

  /** Data size unit in kilobits */
  Kilobit: "Kilobit",

  /** Data size unit in megabits */
  Megabit: "Megabit",

  /** Data size unit in gigabits */
  Gigabit: "Gigabit",

  /** Data size unit in terabits */
  Terabit: "Terabit",

  /** Data size unit in petabits */
  Petabit: "Petabit",

  /** Data size unit in bytes */
  Byte: "Byte",

  /** Data size unit in kilobytes */
  Kilobyte: "Kilobyte",

  /** Data size unit in megabytes */
  Megabyte: "Megabyte",

  /** Data size unit in gigabytes */
  Gigabyte: "Gigabyte",

  /** Data size unit in terabytes */
  Terabyte: "Terabyte",

  /** Data size unit in petabytes */
  Petabyte: "Petabyte",
}

/** The temperature Unit of measurement. */
@added(Versions.v2023_11_15_preview)
union TemperatureUnit {
  string,

  /** Unspecified temperature unit */
  Unspecified: "Unspecified",

  /** Temperature unit in Fahrenheit */
  Fahrenheit: "Fahrenheit",

  /** Temperature unit in Kelvin */
  Kelvin: "Kelvin",

  /** Temperature unit in Rankine */
  Rankine: "Rankine",

  /** Temperature unit in Celsius */
  Celsius: "Celsius",
}

/** The weight Unit of measurement. */
@added(Versions.v2023_11_15_preview)
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

/** The type of the extracted number entity. */
@added(Versions.v2023_11_15_preview)
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

/** The reference point that the ordinal number denotes. */
@added(Versions.v2023_11_15_preview)
union RelativeTo {
  string,

  /** Current state or position */
  Current: "Current",

  /** End state or position */
  End: "End",

  /** Start state or position */
  Start: "Start",
}

/** The range inclusiveness of this property property. */
@added(Versions.v2023_11_15_preview)
union RangeInclusivity {
  string,

  /** No inclusivity */
  NoneInclusive: "NoneInclusive",

  /** Left side inclusive */
  LeftInclusive: "LeftInclusive",

  /** Right side inclusive */
  RightInclusive: "RightInclusive",

  /** Both sides inclusive */
  LeftRightInclusive: "LeftRightInclusive",
}

/** An optional modifier of a date/time instance. */
@added(Versions.v2023_11_15_preview)
union TemporalModifier {
  string,

  /** After an approximate time */
  AfterApprox: "AfterApprox",

  /** Before a specific time */
  Before: "Before",

  /** Before the start of a time period */
  BeforeStart: "BeforeStart",

  /** Approximately at a specific time */
  Approx: "Approx",

  /** Reference to an undefined time */
  ReferenceUndefined: "ReferenceUndefined",

  /** Since the end of a time period */
  SinceEnd: "SinceEnd",

  /** After the middle of a time period */
  AfterMid: "AfterMid",

  /** At the start of a time period */
  Start: "Start",

  /** After a specific time */
  After: "After",

  /** Before the end of a time period */
  BeforeEnd: "BeforeEnd",

  /** Until a specific time */
  Until: "Until",

  /** At the end of a time period */
  End: "End",

  /** Less than a specific time */
  Less: "Less",

  /** Since a specific time */
  Since: "Since",

  /** After the start of a time period */
  AfterStart: "AfterStart",

  /** Before an approximate time */
  BeforeApprox: "BeforeApprox",

  /** In the middle of a time period */
  Mid: "Mid",

  /** More than a specific time */
  More: "More",
}

/** The kind of the number range entity. */
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

/** The abstract base class for entity Metadata. */
@added(Versions.v2023_11_15_preview)
@discriminator("metadataKind")
model BaseMetadata {
  /** The entity Metadata object kind. */
  metadataKind: MetadataKind;
}

/** The entity Metadata object kind. */
@added(Versions.v2023_11_15_preview)
union MetadataKind {
  string,

  /** Metadata for date-related values. */
  DateMetadata: "DateMetadata",

  /** Metadata for date and time-related values. */
  DateTimeMetadata: "DateTimeMetadata",

  /** Metadata for time-related values. */
  TimeMetadata: "TimeMetadata",

  /** Metadata for set of time-related values. */
  TemporalSetMetadata: "TemporalSetMetadata",

  /** Metadata for numeric values. */
  NumberMetadata: "NumberMetadata",

  /** Metadata for ordinal numbers. */
  OrdinalMetadata: "OrdinalMetadata",

  /** Metadata for speed-related values. */
  SpeedMetadata: "SpeedMetadata",

  /** Metadata for weight-related values. */
  WeightMetadata: "WeightMetadata",

  /** Metadata for length-related values. */
  LengthMetadata: "LengthMetadata",

  /** Metadata for volume-related values. */
  VolumeMetadata: "VolumeMetadata",

  /** Metadata for area-related values. */
  AreaMetadata: "AreaMetadata",

  /** Metadata for age-related values. */
  AgeMetadata: "AgeMetadata",

  /** Metadata for information-related values. */
  InformationMetadata: "InformationMetadata",

  /** Metadata for temperature-related values. */
  TemperatureMetadata: "TemperatureMetadata",

  /** Metadata for currency-related values. */
  CurrencyMetadata: "CurrencyMetadata",

  /** Metadata for numeric range values. */
  NumericRangeMetadata: "NumericRangeMetadata",

  /** Metadata for temporal span values. */
  TemporalSpanMetadata: "TemporalSpanMetadata",
}

/** Represents Metadata for quantities. */
@added(Versions.v2023_11_15_preview)
model QuantityMetadata {
  /** The numeric value that the extracted text denotes. */
  value: float64;
}

/** Represents the Age entity Metadata model. */
@added(Versions.v2023_11_15_preview)
model AgeMetadata extends BaseMetadata {
  ...QuantityMetadata;

  /** Kind of the metadata. */
  metadataKind: MetadataKind.AgeMetadata;

  /** Unit of measure for age. */
  unit: AgeUnit;
}

/** Represents the Volume entity Metadata model. */
@added(Versions.v2023_11_15_preview)
model VolumeMetadata extends BaseMetadata {
  ...QuantityMetadata;

  /** Kind of the metadata. */
  metadataKind: MetadataKind.VolumeMetadata;

  /** Unit of measure for volume. */
  unit: VolumeUnit;
}

/** Represents the Speed entity Metadata model. */
@added(Versions.v2023_11_15_preview)
model SpeedMetadata extends BaseMetadata {
  ...QuantityMetadata;

  /** Kind of the metadata. */
  metadataKind: MetadataKind.SpeedMetadata;

  /** Unit of measure for speed. */
  unit: SpeedUnit;
}

/** Represents the Area entity Metadata model. */
@added(Versions.v2023_11_15_preview)
model AreaMetadata extends BaseMetadata {
  ...QuantityMetadata;

  /** Kind of the metadata. */
  metadataKind: MetadataKind.AreaMetadata;

  /** Unit of measure for area. */
  unit: AreaUnit;
}

/** Represents the Length entity Metadata model. */
@added(Versions.v2023_11_15_preview)
model LengthMetadata extends BaseMetadata {
  ...QuantityMetadata;

  /** Kind of the metadata. */
  metadataKind: MetadataKind.LengthMetadata;

  /** Unit of measure for length. */
  unit: LengthUnit;
}

/** Represents the Information (data) entity Metadata model. */
@added(Versions.v2023_11_15_preview)
model InformationMetadata extends BaseMetadata {
  ...QuantityMetadata;

  /** Kind of the metadata. */
  metadataKind: MetadataKind.InformationMetadata;

  /** Unit of measure for information. */
  unit: InformationUnit;
}

/** Represents the Information entity Metadata model. */
@added(Versions.v2023_11_15_preview)
model TemperatureMetadata extends BaseMetadata {
  ...QuantityMetadata;

  /** Kind of the metadata. */
  metadataKind: MetadataKind.TemperatureMetadata;

  /** Unit of measure for temperature. */
  unit: TemperatureUnit;
}

/** Represents the Weight ) entity Metadata model. */
@added(Versions.v2023_11_15_preview)
model WeightMetadata extends BaseMetadata {
  ...QuantityMetadata;

  /** Kind of the metadata. */
  metadataKind: MetadataKind.WeightMetadata;

  /** Unit of measure for weight. */
  unit: WeightUnit;
}

/** Represents the Currency ) entity Metadata model. */
@added(Versions.v2023_11_15_preview)
model CurrencyMetadata extends BaseMetadata {
  ...QuantityMetadata;

  /** Kind of the metadata. */
  metadataKind: MetadataKind.CurrencyMetadata;

  /** Currency unit. */
  unit: string;

  /** The alphabetic code based on another ISO standard, ISO 3166, which lists the codes for country names. The first two letters of the ISO 4217 three-letter code are the same as the code for the country name, and, where possible, the third letter corresponds to the first letter of the currency name. */
  iso4217?: string;
}

/** Represents the date value. */
@added(Versions.v2023_11_15_preview)
model DateValue {
  /** An extended ISO 8601 date/time representation as described in (https://github.com/Microsoft/Recognizers-Text/blob/master/Patterns/English/English-DateTime.yaml) */
  timex: string;

  /** The actual time that the extracted text denote. */
  value: string;

  /** Modifier for datetime to indicate point of reference like before, after etc. */
  modifier?: TemporalModifier;
}

/** Base temporal metadata object. */
@added(Versions.v2023_11_15_preview)
model BaseTemporalMetadata {
  /** List of date values. */
  dateValues?: Array<DateValue>;
}

/** A Metadata for date entity instances. */
@added(Versions.v2023_11_15_preview)
model DateMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;

  /** Kind of the metadata. */
  metadataKind: MetadataKind.DateMetadata;
}

/** A Metadata for datetime entity instances. */
@added(Versions.v2023_11_15_preview)
model DateTimeMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;

  /** Kind of the metadata. */
  metadataKind: MetadataKind.DateTimeMetadata;
}

/** A Metadata for temporal set entity instances. */
@added(Versions.v2023_11_15_preview)
model TemporalSetMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;

  /** Kind of the metadata. */
  metadataKind: MetadataKind.TemporalSetMetadata;
}

/** A Metadata for time entity instances. */
@added(Versions.v2023_11_15_preview)
model TimeMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;

  /** Kind of the metadata. */
  metadataKind: MetadataKind.TimeMetadata;
}

/** A metadata for numeric entity instances. */
@added(Versions.v2023_11_15_preview)
model NumberMetadata extends BaseMetadata {
  /** Kind of the metadata. */
  metadataKind: MetadataKind.NumberMetadata;

  /** Kind of the number type. */
  numberKind: NumberKind;

  /** A numeric representation of what the extracted text denotes. */
  value: float64;
}

/** A metadata for numeric entity instances. */
@added(Versions.v2023_11_15_preview)
model OrdinalMetadata extends BaseMetadata {
  /** Kind of the metadata. */
  metadataKind: MetadataKind.OrdinalMetadata;

  /** The offset with respect to the reference (e.g., offset = -1 indicates the second to last) */
  offset: string;

  /** The reference point that the ordinal number denotes. */
  relativeTo: RelativeTo;

  /** A simple arithmetic expression that the ordinal denotes. */
  value: string;
}

/** represents the Metadata of a date and/or time span. */
@added(Versions.v2023_11_15_preview)
model TemporalSpanMetadata extends BaseMetadata {
  /** Kind of the metadata. */
  metadataKind: MetadataKind.TemporalSpanMetadata;

  /** List of temporal spans detected. */
  spanValues?: TemporalSpanValues[];
}

/** Temporal span object. */
@added(Versions.v2023_11_15_preview)
model TemporalSpanValues {
  /** Start value for the span. */
  begin?: string;

  /** End value for the span. */
  end?: string;

  /** An optional duration value formatted based on the ISO 8601 (https://en.wikipedia.org/wiki/ISO_8601#Durations) */
  duration?: string;

  /** Modifier for datetime to indicate point of reference like before, after etc. */
  modifier?: TemporalModifier;

  /** An optional triplet containing the beginning, the end, and the duration all stated as ISO 8601 formatted strings. */
  timex?: string;
}

/** represents the Metadata of numeric intervals. */
@added(Versions.v2023_11_15_preview)
model NumericRangeMetadata extends BaseMetadata {
  /** Kind of the metadata. */
  metadataKind: MetadataKind.NumericRangeMetadata;

  /** Kind of numeric ranges supported - like Number, Speed, etc. */
  rangeKind: RangeKind;

  /** The beginning value of  the interval. */
  minimum: float64;

  /** The ending value of the interval. */
  maximum: float64;

  /** The inclusiveness of this range. */
  rangeInclusivity?: RangeInclusivity;
}
