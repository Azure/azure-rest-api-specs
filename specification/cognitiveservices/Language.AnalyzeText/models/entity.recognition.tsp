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

@clientName("EntitiesTaskContent", "csharp")
@doc("Supported parameters for an Entity Recognition task.")
model EntitiesTaskParameters is PreBuiltTaskParameters {
  @doc("(Optional) parameter to provide the string index type used to interpret string offsets. Defaults to TextElements (Graphemes).")
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  @added(Versions.v2023_04_15_preview)
  @doc("(Optional) request parameter that limits the output to the requested entity types included in this list. We will apply inclusionList before exclusionList")
  inclusionList?: Array<EntityCategory>;

  @added(Versions.v2023_04_15_preview)
  @doc("(Optional) request parameter that filters out any entities that are included the excludeList. When a user specifies an excludeList, they cannot get a prediction returned with an entity in that list. We will apply inclusionList before exclusionList")
  exclusionList?: Array<EntityCategory>;

  @added(Versions.v2023_04_15_preview)
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
  @typeChangedFrom(Versions.v2023_04_15_preview, Array<EntitiesDocumentResult>)
  documents: Array<EntitiesDocumentResultWithMetadataDetectedLanguage>;
}

@doc("Contains the entity recognition task result for the document.")
model EntitiesDocumentResult is DocumentResult {
  @doc("Recognized entities in the document.")
  entities: Array<Entity>;
}

@doc("Contains the entity recognition task result for the document with detected language.")
@added(Versions.v2023_04_15_preview)
model EntitiesDocumentResultWithDetectedLanguage {
  ...EntitiesDocumentResult;
  ...DocumentDetectedLanguage;
}

@doc("Contains the entity recognition task result for the document with metadata and detected language.")
@added(Versions.v2023_04_15_preview)
model EntitiesDocumentResultWithMetadataDetectedLanguage
  is EntitiesDocumentResultWithMetadata {
  ...DocumentDetectedLanguage;
}

@doc("Defines the detected entity object containing the entity category and entity text detected, etc.")
@clientName("NamedEntity", "csharp")
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
@added(Versions.v2023_04_15_preview)
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
@clientName("EntityInferenceConfig", "csharp")
@doc("The class that houses the inference options allowed for named entity recognition.")
model EntityInferenceOptions {
  @doc("Option to include/exclude the detected entity values to be normalized and included in the metadata. The numeric and temporal entity types support value normalization.")
  excludeNormalizedValues?: boolean = false;
}

@added(Versions.v2023_04_15_preview)
@discriminator("policyKind")
@doc("The abstract base class for entity OverlapPolicy.")
model BaseEntityOverlapPolicy {
  @doc("The entity OverlapPolicy object kind.")
  policyKind: policyKind = policyKind.matchLongest;
}

@doc("Kinds of overlap policies supported.")
@added(Versions.v2023_04_15_preview)
union policyKind {
  string,

  @doc("Represents MatchLongestEntityPolicyType")
  matchLongest: "matchLongest",

  @doc("Represents AllowOverlapEntityPolicyType")
  allowOverlap: "allowOverlap",
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Match longest overlap policy. No overlapping entities as far as it is possible. 1. If there are overlapping entities, the longest one will be returned. 2. If the set of characters predicted for 2 or more entities are exactly the same, select the entity that has the higher confidence score.3. If the entity scores are identical, return all entities that are still present after applying the previous rules. 3. If there is partial overlap (as in Hello Text Analytics) follow the above steps starting from 1.")
model MatchLongestEntityPolicyType extends BaseEntityOverlapPolicy {
  @doc("The entity OverlapPolicy object kind.")
  policyKind: policyKind.matchLongest;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the allow overlap policy. Will apply no post processing logic for the entities. Whatever the model predicts is what will be returned to the user. This allows the user to get a full view of every single model's possible values and apply their own custom logic on entity selection")
model AllowOverlapEntityPolicyType extends BaseEntityOverlapPolicy {
  @doc("The entity OverlapPolicy object kind.")
  policyKind: policyKind.allowOverlap;
}

@doc("Entity documents result with metadata.")
@added(Versions.v2023_04_15_preview)
model EntitiesDocumentResultWithMetadata is DocumentResult {
  @doc("Recognized entities in the document.")
  entities: Array<EntityWithMetadata>;
}

@doc("Entity tag object which contains the name of the tags abd any associated confidence score. Entity Tags are used to express some similarities/affinity between entities.")
@added(Versions.v2023_04_15_preview)
model EntityTag {
  @doc("Name of the tag. Entity Tag names will be unique globally.")
  name: string;

  @doc("Detection score between 0 and 1 of the extracted entity.")
  confidenceScore?: float64;
}

@doc("Entity object with tags.")
@added(Versions.v2023_04_15_preview)
model EntityWithTags is Entity {
  @doc("An entity type is the lowest (or finest) granularity at which the entity has been detected. The type maps to the specific metadata attributes associated with the entity detected.")
  type: string;

  @doc("List of entity tags. Tags are to express some similarities/affinity between entities.")
  tags: Array<EntityTag>;
}

@doc("Entity object with tags and metadata.")
@added(Versions.v2023_04_15_preview)
model EntityWithMetadata is EntityWithTags {
  @doc("The entity metadata object.")
  metadata?: BaseMetadata;
}

@added(Versions.v2023_04_15_preview)
@doc("The Age Unit of measurement")
union AgeUnit {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description, please use decorator @doc to add it."
  Unspecified: "Unspecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Year' should have a documentation or description, please use decorator @doc to add it."
  Year: "Year",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Month' should have a documentation or description, please use decorator @doc to add it."
  Month: "Month",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Week' should have a documentation or description, please use decorator @doc to add it."
  Week: "Week",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Day' should have a documentation or description, please use decorator @doc to add it."
  Day: "Day",
}

//todo: add enum member descriptions
@added(Versions.v2023_04_15_preview)
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

@added(Versions.v2023_04_15_preview)
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
  KilometersPerMillisecond: "KilometersPerMillisecond,",
}
@added(Versions.v2023_04_15_preview)
@doc("The area unit of measurement.")
union AreaUnit {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description, please use decorator @doc to add it."
  Unspecified: "Unspecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareKilometer' should have a documentation or description, please use decorator @doc to add it."
  SquareKilometer: "SquareKilometer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareHectometer' should have a documentation or description, please use decorator @doc to add it."
  SquareHectometer: "SquareHectometer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareDecameter' should have a documentation or description, please use decorator @doc to add it."
  SquareDecameter: "SquareDecameter",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareDecimeter' should have a documentation or description, please use decorator @doc to add it."
  SquareDecimeter: "SquareDecimeter",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareMeter' should have a documentation or description, please use decorator @doc to add it."
  SquareMeter: "SquareMeter",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareCentimeter' should have a documentation or description, please use decorator @doc to add it."
  SquareCentimeter: "SquareCentimeter",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareMillimeter' should have a documentation or description, please use decorator @doc to add it."
  SquareMillimeter: "SquareMillimeter",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareInch' should have a documentation or description, please use decorator @doc to add it."
  SquareInch: "SquareInch",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareFoot' should have a documentation or description, please use decorator @doc to add it."
  SquareFoot: "SquareFoot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareMile' should have a documentation or description, please use decorator @doc to add it."
  SquareMile: "SquareMile",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SquareYard' should have a documentation or description, please use decorator @doc to add it."
  SquareYard: "SquareYard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Acre' should have a documentation or description, please use decorator @doc to add it."
  Acre: "Acre",
}

@added(Versions.v2023_04_15_preview)
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

@added(Versions.v2023_04_15_preview)
@doc("The information (data) Unit of measurement.")
union InformationUnit {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description: " description ", please use decorator @doc to add it."
  Unspecified: "Unspecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Bit' should have a documentation or description: " description ", please use decorator @doc to add it."
  Bit: "Bit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Kilobit' should have a documentation or description: " description ", please use decorator @doc to add it."
  Kilobit: "Kilobit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Megabit' should have a documentation or description: " description ", please use decorator @doc to add it."
  Megabit: "Megabit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Gigabit' should have a documentation or description: " description ", please use decorator @doc to add it."
  Gigabit: "Gigabit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Terabit' should have a documentation or description: " description ", please use decorator @doc to add it."
  Terabit: "Terabit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Petabit' should have a documentation or description: " description ", please use decorator @doc to add it."
  Petabit: "Petabit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Byte' should have a documentation or description: " description ", please use decorator @doc to add it."
  Byte: "Byte",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Kilobyte' should have a documentation or description: " description ", please use decorator @doc to add it."
  Kilobyte: "Kilobyte",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Megabyte' should have a documentation or description: " description ", please use decorator @doc to add it."
  Megabyte: "Megabyte",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Gigabyte' should have a documentation or description: " description ", please use decorator @doc to add it."
  Gigabyte: "Gigabyte",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Terabyte' should have a documentation or description: " description ", please use decorator @doc to add it."
  Terabyte: "Terabyte",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Petabyte' should have a documentation or description: " description ", please use decorator @doc to add it."
  Petabyte: "Petabyte",
}

@added(Versions.v2023_04_15_preview)
@doc("The temperature Unit of measurement.")
union TemperatureUnit {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description: " description ", please use decorator @doc to add it."
  Unspecified: "Unspecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Fahrenheit' should have a documentation or description: " description ", please use decorator @doc to add it."
  Fahrenheit: "Fahrenheit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Kelvin' should have a documentation or description: " description ", please use decorator @doc to add it."
  Kelvin: "Kelvin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Rankine' should have a documentation or description: " description ", please use decorator @doc to add it."
  Rankine: "Rankine",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Celsius' should have a documentation or description: " description ", please use decorator @doc to add it."
  Celsius: "Celsius",
}

@added(Versions.v2023_04_15_preview)
@doc("The weight Unit of measurement.")
union WeightUnit {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description: " description ", please use decorator @doc to add it."
  Unspecified: "Unspecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Kilogram' should have a documentation or description: " description ", please use decorator @doc to add it."
  Kilogram: "Kilogram",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Gram' should have a documentation or description: " description ", please use decorator @doc to add it."
  Gram: "Gram",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Milligram' should have a documentation or description: " description ", please use decorator @doc to add it."
  Milligram: "Milligram",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Gallon' should have a documentation or description: " description ", please use decorator @doc to add it."
  Gallon: "Gallon",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'MetricTon' should have a documentation or description: " description ", please use decorator @doc to add it."
  MetricTon: "MetricTon",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Ton' should have a documentation or description: " description ", please use decorator @doc to add it."
  Ton: "Ton",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Pound' should have a documentation or description: " description ", please use decorator @doc to add it."
  Pound: "Pound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Ounce' should have a documentation or description: " description ", please use decorator @doc to add it."
  Ounce: "Ounce",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Grain' should have a documentation or description: " description ", please use decorator @doc to add it."
  Grain: "Grain",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'PennyWeight' should have a documentation or description: " description ", please use decorator @doc to add it."
  PennyWeight: "PennyWeight",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'LongTonBritish' should have a documentation or description: " description ", please use decorator @doc to add it."
  LongTonBritish: "LongTonBritish",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ShortTonUS' should have a documentation or description: " description ", please use decorator @doc to add it."
  ShortTonUS: "ShortTonUS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ShortHundredWeightUS' should have a documentation or description: " description ", please use decorator @doc to add it."
  ShortHundredWeightUS: "ShortHundredWeightUS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Stone' should have a documentation or description: " description ", please use decorator @doc to add it."
  Stone: "Stone",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Dram' should have a documentation or description: " description ", please use decorator @doc to add it."
  Dram: "Dram",
}

@added(Versions.v2023_04_15_preview)
@doc("The type of the extracted number entity.")
union NumberKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Integer' should have a documentation or description: " description ", please use decorator @doc to add it."
  Integer: "Integer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Decimal' should have a documentation or description: " description ", please use decorator @doc to add it."
  Decimal: "Decimal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Power' should have a documentation or description: " description ", please use decorator @doc to add it."
  Power: "Power",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Fraction' should have a documentation or description: " description ", please use decorator @doc to add it."
  Fraction: "Fraction",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Percent' should have a documentation or description: " description ", please use decorator @doc to add it."
  Percent: "Percent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unspecified' should have a documentation or description: " description ", please use decorator @doc to add it."
  Unspecified: "Unspecified",
}

@added(Versions.v2023_04_15_preview)
@doc("The reference point that the ordinal number denotes.")
union RelativeTo {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Current: "Current",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  End: "End",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Start: "Start",
}

@added(Versions.v2023_04_15_preview)
@doc("The range inclusiveness of this property property.")
union RangeInclusivity {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NoneInclusive: "NoneInclusive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LeftInclusive: "LeftInclusive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  RightInclusive: "RightInclusive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LeftRightInclusive: "LeftRightInclusive",
}

@added(Versions.v2023_04_15_preview)
@doc("An optional modifier of a date/time instance.")
union TemporalModifier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AfterApprox' should have a documentation or description: " description ", please use decorator @doc to add it."
  AfterApprox: "AfterApprox",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Before' should have a documentation or description: " description ", please use decorator @doc to add it."
  Before: "Before",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'BeforeStart' should have a documentation or description: " description ", please use decorator @doc to add it."
  BeforeStart: "BeforeStart",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Approx' should have a documentation or description: " description ", please use decorator @doc to add it."
  Approx: "Approx",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ReferenceUndefined' should have a documentation or description: " description ", please use decorator @doc to add it."
  ReferenceUndefined: "ReferenceUndefined",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'SinceEnd' should have a documentation or description: " description ", please use decorator @doc to add it."
  SinceEnd: "SinceEnd",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AfterMid' should have a documentation or description: " description ", please use decorator @doc to add it."
  AfterMid: "AfterMid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Start' should have a documentation or description: " description ", please use decorator @doc to add it."
  Start: "Start",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'After' should have a documentation or description: " description ", please use decorator @doc to add it."
  After: "After",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'BeforeEnd' should have a documentation or description: " description ", please use decorator @doc to add it."
  BeforeEnd: "BeforeEnd",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Until' should have a documentation or description: " description ", please use decorator @doc to add it."
  Until: "Until",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'End' should have a documentation or description: " description ", please use decorator @doc to add it."
  End: "End",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Less' should have a documentation or description: " description ", please use decorator @doc to add it."
  Less: "Less",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Since' should have a documentation or description: " description ", please use decorator @doc to add it."
  Since: "Since",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AfterStart' should have a documentation or description: " description ", please use decorator @doc to add it."
  AfterStart: "AfterStart",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'BeforeApprox' should have a documentation or description: " description ", please use decorator @doc to add it."
  BeforeApprox: "BeforeApprox",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Mid' should have a documentation or description: " description ", please use decorator @doc to add it."
  Mid: "Mid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'More' should have a documentation or description: " description ", please use decorator @doc to add it."
  More: "More",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
union RangeKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Number: "Number",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Speed: "Speed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Weight: "Weight",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Length: "Length",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Volume: "Volume",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Area: "Area",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Age: "Age",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Information: "Information",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Temperature: "Temperature",
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Currency: "Currency",
}

@added(Versions.v2023_04_15_preview)
@doc("The abstract base class for entity Metadata.")
@discriminator("metadataKind")
model BaseMetadata {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind;
}

@added(Versions.v2023_04_15_preview)
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

@added(Versions.v2023_04_15_preview)
@doc("Represents Metadata for quantities.")
model QuantityMetadata {
  @doc("The numeric value that the extracted text denotes.")
  value: float64;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Age entity Metadata model.")
model AgeMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.AgeMetadata;

  @doc("Unit of measure for age.")
  unit: AgeUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Volume entity Metadata model.")
model VolumeMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.VolumeMetadata;

  @doc("Unit of measure for volume.")
  unit: VolumeUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Speed entity Metadata model.")
model SpeedMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.SpeedMetadata;

  @doc("Unit of measure for speed.")
  unit: SpeedUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Area entity Metadata model.")
model AreaMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.AreaMetadata;

  @doc("Unit of measure for area.")
  unit: AreaUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Length entity Metadata model.")
model LengthMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.LengthMetadata;

  @doc("Unit of measure for length.")
  unit: LengthUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Information (data) entity Metadata model.")
model InformationMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.InformationMetadata;

  @doc("Unit of measure for information.")
  unit: InformationUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Information entity Metadata model.")
model TemperatureMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.TemperatureMetadata;

  @doc("Unit of measure for temperature.")
  unit: TemperatureUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Weight ) entity Metadata model.")
model WeightMetadata extends BaseMetadata {
  ...QuantityMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.WeightMetadata;

  @doc("Unit of measure for weight.")
  unit: WeightUnit;
}

@added(Versions.v2023_04_15_preview)
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

@added(Versions.v2023_04_15_preview)
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
@added(Versions.v2023_04_15_preview)
model BaseTemporalMetadata {
  @doc("List of date values.")
  dateValues?: Array<DateValue>;
}

@added(Versions.v2023_04_15_preview)
@doc("A Metadata for date entity instances.")
model DateMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.DateMetadata;
}

@added(Versions.v2023_04_15_preview)
@doc("A Metadata for datetime entity instances.")
model DateTimeMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.DateTimeMetadata;
}

@added(Versions.v2023_04_15_preview)
@doc("A Metadata for temporal set entity instances.")
model TemporalSetMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.TemporalSetMetadata;
}

@added(Versions.v2023_04_15_preview)
@doc("A Metadata for time entity instances.")
model TimeMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;

  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.TimeMetadata;
}

@added(Versions.v2023_04_15_preview)
@doc("A metadata for numeric entity instances.")
model NumberMetadata extends BaseMetadata {
  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.NumberMetadata;

  @doc("Kind of the number type.")
  numberKind: NumberKind;

  @doc("A numeric representation of what the extracted text denotes.")
  value: float64;
}

@added(Versions.v2023_04_15_preview)
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

@added(Versions.v2023_04_15_preview)
@doc("represents the Metadata of a date and/or time span.")
model TemporalSpanMetadata extends BaseMetadata {
  @doc("Kind of the metadata.")
  metadataKind: MetadataKind.TemporalSpanMetadata;

  @doc("List of temporal spans detected.")
  spanValues?: TemporalSpanValues[];
}

@doc("Temporal span object.")
@added(Versions.v2023_04_15_preview)
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

@added(Versions.v2023_04_15_preview)
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
