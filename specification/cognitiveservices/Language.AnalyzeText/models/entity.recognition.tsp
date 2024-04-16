import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Language.AnalyzeText;

@doc("The entity recognition analyze text input task request.")
model AnalyzeTextEntityRecognitionInput extends AnalyzeTextTask {
  @doc("The kind of task.")
  kind: AnalyzeTextTaskKind.EntityRecognition;

  @doc("The input to be analyzed.")
  analysisInput?: MultiLanguageAnalysisInput;

  @doc("Task parameters.")
  parameters?: EntitiesTaskParameters;
}

@doc("Supported parameters for an Entity Recognition task.")
model EntitiesTaskParameters is PreBuiltTaskParameters {
  @doc("(Optional) parameter to provide the string index type used to interpret string offsets. Defaults to TextElements (Graphemes).")
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  @added(Versions.v2023_11_15_preview)
  @doc("(Optional) request parameter that limits the output to the requested entity types included in this list. We will apply inclusionList before exclusionList")
  inclusionList?: Array<EntityCategory>;

  @added(Versions.v2023_11_15_preview)
  @doc("(Optional) request parameter that filters out any entities that are included the excludeList. When a user specifies an excludeList, they cannot get a prediction returned with an entity in that list. We will apply inclusionList before exclusionList")
  exclusionList?: Array<EntityCategory>;

  @added(Versions.v2023_11_15_preview)
  @doc("(Optional) describes the type of overlap policy to apply to the ner output.")
  overlapPolicy?: BaseEntityOverlapPolicy;

  @added(Versions.v2023_11_15_preview)
  @doc("(Optional) request parameter that allows the user to provide settings for running the inference.")
  inferenceOptions?: EntityInferenceOptions;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("An object representing the task definition for an Entities Recognition task.")
model EntitiesLROTask extends AnalyzeTextLROTask {
  @doc("The kind of task.")
  kind: AnalyzeTextLROTaskKind.EntityRecognition;

  @doc("Task parameters.")
  parameters?: EntitiesTaskParameters;
}

@doc("Contains the entity task ")
model EntitiesTaskResult extends AnalyzeTextTaskResult {
  @doc("kind of the task")
  kind: AnalyzeTextTaskResultsKind.EntityRecognitionResults;

  @doc("Results for entity recognition.")
  results: EntitiesResult;
}

@doc("Contains the entity recognition task result.")
model EntitiesResult is PreBuiltResult {
  @doc("Response by document")
  @typeChangedFrom(Versions.v2023_11_15_preview, Array<EntitiesDocumentResult>)
  documents: Array<EntitiesDocumentResultWithMetadataDetectedLanguage>;
}

@doc("Contains the entity recognition task result for the document.")
model EntitiesDocumentResult is DocumentResult {
  @doc("Recognized entities in the document.")
  entities: Array<Entity>;
}

@doc("Contains the entity recognition task result for the document with detected language.")
@added(Versions.v2023_11_15_preview)
model EntitiesDocumentResultWithDetectedLanguage {
  ...EntitiesDocumentResult;
  ...DocumentDetectedLanguage;
}

@doc("Contains the entity recognition task result for the document with metadata and detected language.")
@added(Versions.v2023_11_15_preview)
model EntitiesDocumentResultWithMetadataDetectedLanguage
  is EntitiesDocumentResultWithMetadata {
  ...DocumentDetectedLanguage;
}

@doc("Defines the detected entity object containing the entity category and entity text detected, etc.")
model Entity {
  @doc("Entity text as appears in the request.")
  text: string;

  @doc("Entity type.")
  category: string;

  @doc("(Optional) Entity sub type.")
  subcategory?: string;

  @doc("Start position for the entity text. Use of different 'stringIndexType' values can affect the offset returned.")
  offset: int32;

  @doc("Length for the entity text. Use of different 'stringIndexType' values can affect the length returned.")
  length: int32;

  @doc("Confidence score between 0 and 1 of the extracted entity.")
  confidenceScore: float64;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Contains the entity recognition job task result.")
model EntityRecognitionLROResult extends AnalyzeTextLROResult {
  @doc("Kind of the task.")
  kind: AnalyzeTextLROResultsKind.EntityRecognitionLROResults;

  @doc("Results for the task.")
  results: EntitiesResult;
}

@doc("Contains all the entity categories detected by entity recognition.")
@added(Versions.v2023_11_15_preview)
union EntityCategory {
  string,

  @doc("Specific street-level mentions of locations: house/building numbers, streets, avenues, highways, intersections referenced by name.")
  Address: "Address",

  @doc("Numeric values, including digits and number words.")
  Numeric: "Numeric",

  @doc("Age-related values.")
  Age: "Age",

  @doc("Currency-related values.")
  Currency: "Currency",

  @doc("Numbers without a unit")
  Number: "Number",

  @doc("Range of Numbers")
  NumberRange: "NumberRange",

  @doc("Percentage-related values.")
  Percentage: "Percentage",

  @doc("Ordinal numbers.")
  Ordinal: "Ordinal",

  @doc("Temperature-related values.")
  Temperature: "Temperature",

  @doc("Dimension of measurements")
  Dimension: "Dimension",

  @doc("Length of an object.")
  Length: "Length",

  @doc("Weight of an object.")
  Weight: "Weight",

  @doc("Height of an object.")
  Height: "Height",

  @doc("Speed of an object.")
  Speed: "Speed",

  @doc("Area of an object.")
  Area: "Area",

  @doc("Volume of an object.")
  Volume: "Volume",

  @doc("Unit of measure for digital information.")
  Information: "Information",

  @doc("Items relating to time.")
  Temporal: "Temporal",

  @doc("Calendar dates.")
  Date: "Date",

  @doc("Times of day.")
  Time: "Time",

  @doc("Calendar dates with time.")
  DateTime: "DateTime",

  @doc("Range of dates.")
  DateRange: "DateRange",

  @doc("Range of times.")
  TimeRange: "TimeRange",

  @doc("Range of date and time.")
  DateTimeRange: "DateTimeRange",

  @doc("Duration of time.")
  Duration: "Duration",

  @doc("Set of time-related values.")
  SetTemporal: "SetTemporal",

  @doc("Social, sports, business, political, educational, natural, historical, criminal, violent, legal, military events with a timed period.")
  Event: "Event",

  @doc("Sports event-related values.")
  SportsEvent: "SportsEvent",

  @doc("Cultural event-related values.")
  CulturalEvent: "CulturalEvent",

  @doc("Natural event-related values.")
  NaturalEvent: "NaturalEvent",

  @doc("Particular point or place in physical space.")
  Location: "Location",

  @doc("Cities, countries/regions, states.")
  GPE: "GPE",

  @doc("City-related values.")
  City: "City",

  @doc("State-related values.")
  State: "State",

  @doc("Country or region-related values.")
  CountryRegion: "CountryRegion",

  @doc("Continent-related values.")
  Continent: "Continent",

  @doc("Manmade structures.")
  Structural: "Structural",

  @doc("Airports.")
  Airport: "Airport",

  @doc("Geographic and natural features such as rivers, oceans, and deserts.")
  Geological: "Geological",

  @doc("Corporations, agencies, and other groups of people defined by some established organizational structure. These labels can include companies, political parties/movements, musical bands, sport clubs, government bodies, and public organizations. Nationalities or religions are not ORGANIZATION.")
  Organization: "Organization",

  @doc("Medical companies and groups.")
  OrganizationMedical: "OrganizationMedical",

  @doc("Stock exchange groups.")
  OrganizationStockExchange: "OrganizationStockExchange",

  @doc("Sports-related organizations.")
  OrganizationSports: "OrganizationSports",

  @doc("First, last, and middle names, names of fictional characters, and aliases. Titles, such as 'Mr.' or 'President', are not considered part of the named entity.")
  Person: "Person",

  @doc("Human roles classified by a group membership.")
  PersonType: "PersonType",

  @doc("Email addresses.")
  Email: "Email",

  @doc("URLs to websites.")
  URL: "URL",

  @doc("network IP addresses.")
  IP: "IP",

  @doc("Phone numbers (US and EU phone numbers only).")
  PhoneNumber: "PhoneNumber",

  @doc("Single or group of commercial, consumable objects, electronics, vehicles, food groups.")
  Product: "Product",

  @doc("Computing products.")
  ComputingProduct: "ComputingProduct",

  @doc("A capability, skill, or expertise.")
  Skill: "Skill",
}

@added(Versions.v2023_11_15_preview)
@doc("The class that houses the inference options allowed for named entity recognition.")
model EntityInferenceOptions {
  @doc("Option to include/exclude the detected entity values to be normalized and included in the metadata. The numeric and temporal entity types support value normalization.")
  excludeNormalizedValues?: boolean = false;
}

@added(Versions.v2023_11_15_preview)
@discriminator("policyKind")
@doc("The abstract base class for entity OverlapPolicy.")
model BaseEntityOverlapPolicy {
  @doc("The entity OverlapPolicy object kind.")
  policyKind: policyKind = policyKind.matchLongest;
}

@doc("Kinds of overlap policies supported.")
@added(Versions.v2023_11_15_preview)
union policyKind {
  string,

  @doc("Represents MatchLongestEntityPolicyType")
  matchLongest: "matchLongest",

  @doc("Represents AllowOverlapEntityPolicyType")
  allowOverlap: "allowOverlap",
}

@added(Versions.v2023_11_15_preview)
@doc("Represents the Match longest overlap policy. No overlapping entities as far as it is possible. 1. If there are overlapping entities, the longest one will be returned. 2. If the set of characters predicted for 2 or more entities are exactly the same, select the entity that has the higher confidence score.3. If the entity scores are identical, return all entities that are still present after applying the previous rules. 3. If there is partial overlap (as in Hello Text Analytics) follow the above steps starting from 1.")
model MatchLongestEntityPolicyType extends BaseEntityOverlapPolicy {
  @doc("The entity OverlapPolicy object kind.")
  policyKind: policyKind.matchLongest;
}

@added(Versions.v2023_11_15_preview)
@doc("Represents the allow overlap policy. Will apply no post processing logic for the entities. Whatever the model predicts is what will be returned to the user. This allows the user to get a full view of every single model's possible values and apply their own custom logic on entity selection")
model AllowOverlapEntityPolicyType extends BaseEntityOverlapPolicy {
  @doc("The entity OverlapPolicy object kind.")
  policyKind: policyKind.allowOverlap;
}

@doc("Entity documents result with metadata.")
@added(Versions.v2023_11_15_preview)
model EntitiesDocumentResultWithMetadata is DocumentResult {
  @doc("Recognized entities in the document.")
  entities: Array<EntityWithMetadata>;
}

@doc("Entity tag object which contains the name of the tags abd any associated confidence score. Entity Tags are used to express some similarities/affinity between entities.")
@added(Versions.v2023_11_15_preview)
model EntityTag {
  @doc("Name of the tag. Entity Tag names will be unique globally.")
  name: string;

  @doc("Detection score between 0 and 1 of the extracted entity.")
  confidenceScore?: float64;
}

@doc("Entity object with tags.")
@added(Versions.v2023_11_15_preview)
model EntityWithTags is Entity {
  @doc("An entity type is the lowest (or finest) granularity at which the entity has been detected. The type maps to the specific metadata attributes associated with the entity detected.")
  type: string;

  @doc("List of entity tags. Tags are to express some similarities/affinity between entities.")
  tags: Array<EntityTag>;
}

@doc("Entity object with tags and metadata.")
@added(Versions.v2023_11_15_preview)
model EntityWithMetadata is EntityWithTags {
  @doc("The entity metadata object.")
  metadata?: BaseMetadata;
}

@added(Versions.v2023_11_15_preview)
@doc("The Age Unit of measurement")
union AgeUnit {
  string,

  @doc("Unspecified time period")
  Unspecified: "Unspecified",

  @doc("Time period of a year")
  Year: "Year",

  @doc("Time period of a month")
  Month: "Month",

  @doc("Time period of a week")
  Week: "Week",

  @doc("Time period of a day")
  Day: "Day",
}

@added(Versions.v2023_11_15_preview)
@doc("The Volume Unit of measurement")
union VolumeUnit {
  string,

  @doc("Unspecified volume unit.")
  Unspecified: "Unspecified",

  @doc("Volume unit in cubic meters.")
  CubicMeter: "CubicMeter",

  @doc("Volume unit in cubic centimeters.")
  CubicCentimeter: "CubicCentimeter",

  @doc("Volume unit in cubic millimeters.")
  CubicMillimeter: "CubicMillimeter",

  @doc("Volume unit in hectoliters.")
  Hectoliter: "Hectoliter",

  @doc("Volume unit in decaliters.")
  Decaliter: "Decaliter",

  @doc("Volume unit in liters.")
  Liter: "Liter",

  @doc("Volume unit in centiliters.")
  Centiliter: "Centiliter",

  @doc("Volume unit in milliliters.")
  Milliliter: "Milliliter",

  @doc("Volume unit in cubic yards.")
  CubicYard: "CubicYard",

  @doc("Volume unit in cubic inches.")
  CubicInch: "CubicInch",

  @doc("Volume unit in cubic feet.")
  CubicFoot: "CubicFoot",

  @doc("Volume unit in cubic miles.")
  CubicMile: "CubicMile",

  @doc("Volume unit in fluid ounces.")
  FluidOunce: "FluidOunce",

  @doc("Volume unit in teaspoons.")
  Teaspoon: "Teaspoon",

  @doc("Volume unit in tablespoons.")
  Tablespoon: "Tablespoon",

  @doc("Volume unit in pints.")
  Pint: "Pint",

  @doc("Volume unit in quarts.")
  Quart: "Quart",

  @doc("Volume unit in cups.")
  Cup: "Cup",

  @doc("Volume unit in gills.")
  Gill: "Gill",

  @doc("Volume unit in pinches.")
  Pinch: "Pinch",

  @doc("Volume unit in fluid drams.")
  FluidDram: "FluidDram",

  @doc("Volume unit in barrels.")
  Barrel: "Barrel",

  @doc("Volume unit in minims.")
  Minim: "Minim",

  @doc("Volume unit in cords.")
  Cord: "Cord",

  @doc("Volume unit in pecks.")
  Peck: "Peck",

  @doc("Volume unit in bushels.")
  Bushel: "Bushel",

  @doc("Volume unit in hogsheads.")
  Hogshead: "Hogshead",
}

@added(Versions.v2023_11_15_preview)
@doc("The speed Unit of measurement")
union SpeedUnit {
  string,

  @doc("Unspecified speed unit.")
  Unspecified: "Unspecified",

  @doc("Speed unit in meters per second.")
  MetersPerSecond: "MetersPerSecond",

  @doc("Speed unit in kilometers per hour.")
  KilometersPerHour: "KilometersPerHour",

  @doc("Speed unit in kilometers per minute.")
  KilometersPerMinute: "KilometersPerMinute",

  @doc("Speed unit in kilometers per second.")
  KilometersPerSecond: "KilometersPerSecond",

  @doc("Speed unit in miles per hour.")
  MilesPerHour: "MilesPerHour",

  @doc("Speed unit in knots.")
  Knots: "Knots",

  @doc("Speed unit in feet per second.")
  FeetPerSecond: "FeetPerSecond",

  @doc("Speed unit in feet per minute.")
  FeetPerMinute: "FeetPerMinute",

  @doc("Speed unit in yards per minute.")
  YardsPerMinute: "YardsPerMinute",

  @doc("Speed unit in yards per second.")
  YardsPerSecond: "YardsPerSecond",

  @doc("Speed unit in meters per millisecond.")
  MetersPerMillisecond: "MetersPerMillisecond",

  @doc("Speed unit in centimeters per millisecond.")
  CentimetersPerMillisecond: "CentimetersPerMillisecond",

  @doc("Speed unit in Kilometers per millisecond.")
  KilometersPerMillisecond: "KilometersPerMillisecond",
}
@added(Versions.v2023_11_15_preview)
@doc("The area unit of measurement.")
union AreaUnit {
  string,

  @doc("Unspecified area unit")
  Unspecified: "Unspecified",

  @doc("Area unit in square kilometers")
  SquareKilometer: "SquareKilometer",

  @doc("Area unit in square hectometers")
  SquareHectometer: "SquareHectometer",

  @doc("Area unit in square decameters")
  SquareDecameter: "SquareDecameter",

  @doc("Area unit in square decimeters")
  SquareDecimeter: "SquareDecimeter",

  @doc("Area unit in square meters")
  SquareMeter: "SquareMeter",

  @doc("Area unit in square centimeters")
  SquareCentimeter: "SquareCentimeter",

  @doc("Area unit in square millimeters")
  SquareMillimeter: "SquareMillimeter",

  @doc("Area unit in square inches")
  SquareInch: "SquareInch",

  @doc("Area unit in square feet")
  SquareFoot: "SquareFoot",

  @doc("Area unit in square miles")
  SquareMile: "SquareMile",

  @doc("Area unit in square yards")
  SquareYard: "SquareYard",

  @doc("Area unit in acres")
  Acre: "Acre",
}

@added(Versions.v2023_11_15_preview)
@doc("The length unit of measurement.")
union LengthUnit {
  string,

  @doc("Unspecified length unit.")
  Unspecified: "Unspecified",

  @doc("Length unit in kilometers.")
  Kilometer: "Kilometer",

  @doc("Length unit in hectometers.")
  Hectometer: "Hectometer",

  @doc("Length unit in decameters.")
  Decameter: "Decameter",

  @doc("Length unit in meters.")
  Meter: "Meter",

  @doc("Length unit in decimeters.")
  Decimeter: "Decimeter",

  @doc("Length unit in centimeters.")
  Centimeter: "Centimeter",

  @doc("Length unit in millimeters.")
  Millimeter: "Millimeter",

  @doc("Length unit in micrometers.")
  Micrometer: "Micrometer",

  @doc("Length unit in nanometers.")
  Nanometer: "Nanometer",

  @doc("Length unit in picometers.")
  Picometer: "Picometer",

  @doc("Length unit in miles.")
  Mile: "Mile",

  @doc("Length unit in yards.")
  Yard: "Yard",

  @doc("Length unit in inches.")
  Inch: "Inch",

  @doc("Length unit in feet.")
  Foot: "Foot",

  @doc("Length unit in light years.")
  LightYear: "LightYear",

  @doc("Length unit in points.")
  Point: "Point",
}

@added(Versions.v2023_11_15_preview)
@doc("The information (data) Unit of measurement.")
union InformationUnit {
  string,

  @doc("Unspecified data size unit")
  Unspecified: "Unspecified",

  @doc("Data size unit in bits")
  Bit: "Bit",

  @doc("Data size unit in kilobits")
  Kilobit: "Kilobit",

  @doc("Data size unit in megabits")
  Megabit: "Megabit",

  @doc("Data size unit in gigabits")
  Gigabit: "Gigabit",

  @doc("Data size unit in terabits")
  Terabit: "Terabit",

  @doc("Data size unit in petabits")
  Petabit: "Petabit",

  @doc("Data size unit in bytes")
  Byte: "Byte",

  @doc("Data size unit in kilobytes")
  Kilobyte: "Kilobyte",

  @doc("Data size unit in megabytes")
  Megabyte: "Megabyte",

  @doc("Data size unit in gigabytes")
  Gigabyte: "Gigabyte",

  @doc("Data size unit in terabytes")
  Terabyte: "Terabyte",

  @doc("Data size unit in petabytes")
  Petabyte: "Petabyte",
}

@added(Versions.v2023_11_15_preview)
@doc("The temperature Unit of measurement.")
union TemperatureUnit {
  string,

  @doc("Unspecified temperature unit")
  Unspecified: "Unspecified",

  @doc("Temperature unit in Fahrenheit")
  Fahrenheit: "Fahrenheit",

  @doc("Temperature unit in Kelvin")
  Kelvin: "Kelvin",

  @doc("Temperature unit in Rankine")
  Rankine: "Rankine",

  @doc("Temperature unit in Celsius")
  Celsius: "Celsius",
}

@added(Versions.v2023_11_15_preview)
@doc("The weight Unit of measurement.")
union WeightUnit {
  string,

  @doc("Unspecified weight unit")
  Unspecified: "Unspecified",

  @doc("Weight unit in kilograms")
  Kilogram: "Kilogram",

  @doc("Weight unit in grams")
  Gram: "Gram",

  @doc("Weight unit in milligrams")
  Milligram: "Milligram",

  @doc("Volume unit in gallons")
  Gallon: "Gallon",

  @doc("Weight unit in metric tons")
  MetricTon: "MetricTon",

  @doc("Weight unit in tons")
  Ton: "Ton",

  @doc("Weight unit in pounds")
  Pound: "Pound",

  @doc("Weight unit in ounces")
  Ounce: "Ounce",

  @doc("Weight unit in grains")
  Grain: "Grain",

  @doc("Weight unit in pennyweights")
  PennyWeight: "PennyWeight",

  @doc("Weight unit in long tons (British)")
  LongTonBritish: "LongTonBritish",

  @doc("Weight unit in short tons (US)")
  ShortTonUS: "ShortTonUS",

  @doc("Weight unit in short hundredweights (US)")
  ShortHundredWeightUS: "ShortHundredWeightUS",

  @doc("Weight unit in stones")
  Stone: "Stone",

  @doc("Weight unit in drams")
  Dram: "Dram",
}

@added(Versions.v2023_11_15_preview)
@doc("The type of the extracted number entity.")
union NumberKind {
  string,

  @doc("Integer number")
  Integer: "Integer",

  @doc("Decimal number")
  Decimal: "Decimal",

  @doc("Power number")
  Power: "Power",

  @doc("Fraction number")
  Fraction: "Fraction",

  @doc("Percent number")
  Percent: "Percent",

  @doc("Unspecified number kind")
  Unspecified: "Unspecified",
}

@added(Versions.v2023_11_15_preview)
@doc("The reference point that the ordinal number denotes.")
union RelativeTo {
  string,

  @doc("Current state or position")
  Current: "Current",

  @doc("End state or position")
  End: "End",

  @doc("Start state or position")
  Start: "Start",
}

@added(Versions.v2023_11_15_preview)
@doc("The range inclusiveness of this property property.")
union RangeInclusivity {
  string,

  @doc("No inclusivity")
  NoneInclusive: "NoneInclusive",

  @doc("Left side inclusive")
  LeftInclusive: "LeftInclusive",

  @doc("Right side inclusive")
  RightInclusive: "RightInclusive",

  @doc("Both sides inclusive")
  LeftRightInclusive: "LeftRightInclusive",
}

@added(Versions.v2023_11_15_preview)
@doc("An optional modifier of a date/time instance.")
union TemporalModifier {
  string,

  @doc("After an approximate time")
  AfterApprox: "AfterApprox",

  @doc("Before a specific time")
  Before: "Before",

  @doc("Before the start of a time period")
  BeforeStart: "BeforeStart",

  @doc("Approximately at a specific time")
  Approx: "Approx",

  @doc("Reference to an undefined time")
  ReferenceUndefined: "ReferenceUndefined",

  @doc("Since the end of a time period")
  SinceEnd: "SinceEnd",

  @doc("After the middle of a time period")
  AfterMid: "AfterMid",

  @doc("At the start of a time period")
  Start: "Start",

  @doc("After a specific time")
  After: "After",

  @doc("Before the end of a time period")
  BeforeEnd: "BeforeEnd",

  @doc("Until a specific time")
  Until: "Until",

  @doc("At the end of a time period")
  End: "End",

  @doc("Less than a specific time")
  Less: "Less",

  @doc("Since a specific time")
  Since: "Since",

  @doc("After the start of a time period")
  AfterStart: "AfterStart",

  @doc("Before an approximate time")
  BeforeApprox: "BeforeApprox",

  @doc("In the middle of a time period")
  Mid: "Mid",

  @doc("More than a specific time")
  More: "More",
}

@doc("The kind of the number range entity.")
union RangeKind {
  string,

  @doc("Number range")
  Number: "Number",

  @doc("Speed range")
  Speed: "Speed",

  @doc("Weight range")
  Weight: "Weight",

  @doc("Length range")
  Length: "Length",

  @doc("Volume range")
  Volume: "Volume",

  @doc("Area range")
  Area: "Area",

  @doc("Age range")
  Age: "Age",

  @doc("Information range")
  Information: "Information",

  @doc("Temperature range")
  Temperature: "Temperature",

  @doc("Currency range")
  Currency: "Currency",
}

@added(Versions.v2023_11_15_preview)
@doc("The abstract base class for entity Metadata.")
@discriminator("metadataKind")
model BaseMetadata {
  @doc("The entity Metadata object kind.")
  metadataKind: MetadataKind;
}

@added(Versions.v2023_11_15_preview)
@doc("The entity Metadata object kind.")
union MetadataKind {
  string,

  @doc("Metadata for date-related values.")
  DateMetadata: "DateMetadata",

  @doc("Metadata for date and time-related values.")
  DateTimeMetadata: "DateTimeMetadata",

  @doc("Metadata for time-related values.")
  TimeMetadata: "TimeMetadata",

  @doc("Metadata for set of time-related values.")
  TemporalSetMetadata: "TemporalSetMetadata",

  @doc("Metadata for numeric values.")
  NumberMetadata: "NumberMetadata",

  @doc("Metadata for ordinal numbers.")
  OrdinalMetadata: "OrdinalMetadata",

  @doc("Metadata for speed-related values.")
  SpeedMetadata: "SpeedMetadata",

  @doc("Metadata for weight-related values.")
  WeightMetadata: "WeightMetadata",

  @doc("Metadata for length-related values.")
  LengthMetadata: "LengthMetadata",

  @doc("Metadata for volume-related values.")
  VolumeMetadata: "VolumeMetadata",

  @doc("Metadata for area-related values.")
  AreaMetadata: "AreaMetadata",

  @doc("Metadata for age-related values.")
  AgeMetadata: "AgeMetadata",

  @doc("Metadata for information-related values.")
  InformationMetadata: "InformationMetadata",

  @doc("Metadata for temperature-related values.")
  TemperatureMetadata: "TemperatureMetadata",

  @doc("Metadata for currency-related values.")
  CurrencyMetadata: "CurrencyMetadata",

  @doc("Metadata for numeric range values.")
  NumericRangeMetadata: "NumericRangeMetadata",

  @doc("Metadata for temporal span values.")
  TemporalSpanMetadata: "TemporalSpanMetadata",
}

@added(Versions.v2023_11_15_preview)
@doc("Represents Metadata for quantities.")
model QuantityMetadata {
  @doc("The numeric value that the extracted text denotes.")
  value: float64;
}

@added(Versions.v2023_11_15_preview)
@doc("Represents the Age entity Metadata model.")
model AgeMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.AgeMetadata;

  @doc("Unit of measure for age.")
  unit: AgeUnit;
}

@added(Versions.v2023_11_15_preview)
@doc("Represents the Volume entity Metadata model.")
model VolumeMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.VolumeMetadata;

  @doc("Unit of measure for volume.")
  unit: VolumeUnit;
}

@added(Versions.v2023_11_15_preview)
@doc("Represents the Speed entity Metadata model.")
model SpeedMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.SpeedMetadata;

  @doc("Unit of measure for speed.")
  unit: SpeedUnit;
}

@added(Versions.v2023_11_15_preview)
@doc("Represents the Area entity Metadata model.")
model AreaMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.AreaMetadata;

  @doc("Unit of measure for area.")
  unit: AreaUnit;
}

@added(Versions.v2023_11_15_preview)
@doc("Represents the Length entity Metadata model.")
model LengthMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.LengthMetadata;

  @doc("Unit of measure for length.")
  unit: LengthUnit;
}

@added(Versions.v2023_11_15_preview)
@doc("Represents the Information (data) entity Metadata model.")
model InformationMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.InformationMetadata;

  @doc("Unit of measure for information.")
  unit: InformationUnit;
}

@added(Versions.v2023_11_15_preview)
@doc("Represents the Information entity Metadata model.")
model TemperatureMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.TemperatureMetadata;

  @doc("Unit of measure for temperature.")
  unit: TemperatureUnit;
}

@added(Versions.v2023_11_15_preview)
@doc("Represents the Weight ) entity Metadata model.")
model WeightMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.WeightMetadata;

  @doc("Unit of measure for weight.")
  unit: WeightUnit;
}

@added(Versions.v2023_11_15_preview)
@doc("Represents the Currency ) entity Metadata model.")
model CurrencyMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.CurrencyMetadata;

  @doc("Currency unit.")
  unit: string;

  @doc("The alphabetic code based on another ISO standard, ISO 3166, which lists the codes for country names. The first two letters of the ISO 4217 three-letter code are the same as the code for the country name, and, where possible, the third letter corresponds to the first letter of the currency name.")
  iso4217?: string;
}

@added(Versions.v2023_11_15_preview)
@doc("Represents the date value.")
model DateValue {
  @doc("An extended ISO 8601 date/time representation as described in (https://github.com/Microsoft/Recognizers-Text/blob/master/Patterns/English/English-DateTime.yaml)")
  timex: string;

  @doc("The actual time that the extracted text denote.")
  value: string;

  @doc("Modifier for datetime to indicate point of reference like before, after etc.")
  modifier?: TemporalModifier;
}

@doc("Base temporal metadata object.")
@added(Versions.v2023_11_15_preview)
model BaseTemporalMetadata {
  @doc("List of date values.")
  dateValues?: Array<DateValue>;
}

@added(Versions.v2023_11_15_preview)
@doc("A Metadata for date entity instances.")
model DateMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.DateMetadata;
}

@added(Versions.v2023_11_15_preview)
@doc("A Metadata for datetime entity instances.")
model DateTimeMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.DateTimeMetadata;
}

@added(Versions.v2023_11_15_preview)
@doc("A Metadata for temporal set entity instances.")
model TemporalSetMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.TemporalSetMetadata;
}

@added(Versions.v2023_11_15_preview)
@doc("A Metadata for time entity instances.")
model TimeMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.TimeMetadata;
}

@added(Versions.v2023_11_15_preview)
@doc("A metadata for numeric entity instances.")
model NumberMetadata extends BaseMetadata {
  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.NumberMetadata;

  @doc("Kind of the number type.")
  numberKind: NumberKind;

  @doc("A numeric representation of what the extracted text denotes.")
  value: float64;
}

@added(Versions.v2023_11_15_preview)
@doc("A metadata for numeric entity instances.")
model OrdinalMetadata extends BaseMetadata {
  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.OrdinalMetadata;

  @doc("The offset With respect to the reference (e.g., offset = -1 in \"show me the second to last\"")
  offset: string;

  @doc("The reference point that the ordinal number denotes.")
  relativeTo: RelativeTo;

  @doc("A simple arithmetic expression that the ordinal denotes.")
  value: string;
}

@added(Versions.v2023_11_15_preview)
@doc("represents the Metadata of a date and/or time span.")
model TemporalSpanMetadata extends BaseMetadata {
  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.TemporalSpanMetadata;

  @doc("List of temporal spans detected.")
  spanValues?: TemporalSpanValues[];
}

@doc("Temporal span object.")
@added(Versions.v2023_11_15_preview)
model TemporalSpanValues {
  @doc("Start value for the span.")
  begin?: string;

  @doc("End value for the span.")
  end?: string;

  @doc("An optional duration value formatted based on the ISO 8601 (https://en.wikipedia.org/wiki/ISO_8601#Durations)")
  duration?: string;

  @doc("Modifier for datetime to indicate point of reference like before, after etc.")
  modifier?: TemporalModifier;

  @doc("An optional triplet containing the beginning, the end, and the duration all stated as ISO 8601 formatted strings.")
  timex?: string;
}

@added(Versions.v2023_11_15_preview)
@doc("represents the Metadata of numeric intervals.")
model NumericRangeMetadata extends BaseMetadata {
  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.NumericRangeMetadata;

  @doc("Kind of numeric ranges supported - like Number, Speed, etc.")
  rangeKind: RangeKind;

  @doc("The beginning value of  the interval.")
  minimum: float64;

  @doc("The ending value of the interval.")
  maximum: float64;

  @doc("The inclusiveness of this range.")
  rangeInclusivity?: RangeInclusivity;
}
