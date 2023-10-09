import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Language.AnalyzeText;

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model AnalyzeTextEntityRecognitionInput extends AnalyzeTextTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskKind.EntityRecognition;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  analysisInput?: MultiLanguageAnalysisInput;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: EntitiesTaskParameters;
}

@doc("Supported parameters for an Entity Recognition task.")
model EntitiesTaskParameters extends PreBuiltTaskParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  stringIndexType: StringIndexType;

  @added(Versions.v2023_04_15_preview)
  @doc("(Optional) request parameter that limits the output to the requested entity types included in this list. We will apply inclusionList before exclusionList")
  inclusionList?: EntityList;

  @added(Versions.v2023_04_15_preview)
  @doc("(Optional) request parameter that filters out any entities that are included the excludeList. When a user specifies an excludeList, they cannot get a prediction returned with an entity in that list. We will apply inclusionList before exclusionList")
  exclusionList?: EntityList;

  @added(Versions.v2023_04_15_preview)
  @doc("(Optional) describes the type of overlap policy to apply to the ner output.")
  overlapPolicy?: BaseEntityOverlapPolicy;
}

@doc("An object representing the task definition for an Entities Recognition task.")
#suppress "@azure-tools/typespec-azure-core/casing-style"
model EntitiesLROTask extends AnalyzeTextLROTask {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROTaskKind.EntityRecognition;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  parameters?: EntitiesTaskParameters;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntitiesTaskResult extends AnalyzeTextTaskResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextTaskResultsKind.EntityRecognitionResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: Array<EntitiesResult>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntitiesResult extends AnalyzeTextPreBuiltResult {
  @doc("Response by document")
  @typeChangedFrom(Versions.v2023_04_15_preview, Array<EntitiesDocumentResult>)
  documents: Array<EntitiesDocumentResultWithMetadataDetectedLanguage>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntitiesDocumentResult extends DocumentResult {
  @doc("Recognized entities in the document.")
  entities: Array<EntitiesDocumentResult>;
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntitiesDocumentResultWithMetadataDetectedLanguage extends EntitiesDocumentResultWithMetadata {
  ...DocumentDetectedLanguage
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
#suppress "@azure-tools/typespec-azure-core/casing-style"
model EntityRecognitionLROResult extends AnalyzeTextLROResult {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  kind: AnalyzeTextLROResultsKind.EntityRecognitionLROResults;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  results: EntitiesResult;
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum EntityCategory {
  @doc("Specific street-level mentions of locations: house/building numbers, streets, avenues, highways, intersections referenced by name.")
  Address,

  @doc("Numeric values, including digits and number words.")
  Numeric,

  @doc("Age-related values.")
  Age,
  
  @doc("Currency-related values.")
  Currency,
  
  @doc("Numbers without a unit")
  Number,
  
  @doc("Range of Numbers")
  NumberRange,
  
  @doc("Percentage-related values.")
  Percentage,
  
  @doc("Ordinal numbers.")
  Ordinal,
  
  @doc("Temperature-related values.")
  Temperature,
  
  @doc("Dimension of measurements")
  Dimension,
  
  @doc("Length of an object.")
  Length,
  
  @doc("Weight of an object.")
  Weight,
  
  @doc("Height of an object.")
  Height,
  
  @doc("Speed of an object.")
  Speed,
  
  @doc("Area of an object.")
  Area,
  
  @doc("Volume of an object.")
  Volume,
  
  @doc("Unit of measure for digital information.")
  Information,
  
  @doc("Items relating to time.")
  Temporal,
  
  @doc("Calendar dates.")
  Date,
  
  @doc("Times of day.")
  Time,
  
  @doc("Calendar dates with time.")
  DateTime,
  
  @doc("Range of dates.")
  DateRange,
  
  @doc("Range of times.")
  TimeRange,
  
  @doc("Range of date and time.")
  DateTimeRange,
  
  @doc("Duration of time.")
  Duration,
  
  @doc("Set of time-related values.")
  SetTemporal,
  
  @doc("Social, sports, business, political, educational, natural, historical, criminal, violent, legal, military events with a timed period.")
  Event,
  
  @doc("Sports event-related values.")
  SportsEvent,
  
  @doc("Cultural event-related values.")
  CulturalEvent,
  
  @doc("Natural event-related values.")
  NaturalEvent,
  
  @doc("Particular point or place in physical space.")
  Location,
  
  @doc("Cities, countries/regions, states.")
  GPE,
  
  @doc("City-related values.")
  City,
  
  @doc("State-related values.")
  State,
  
  @doc("Country or region-related values.")
  CountryRegion,
  
  @doc("Continent-related values.")
  Continent,
  
  @doc("Manmade structures.")
  Structural,
  
  @doc("Airports.")
  Airport,
  
  @doc("Geographic and natural features such as rivers, oceans, and deserts.")
  Geological,
  
  @doc("Corporations, agencies, and other groups of people defined by some established organizational structure. These labels can include companies, political parties/movements, musical bands, sport clubs, government bodies, and public organizations. Nationalities or religions are not ORGANIZATION.")
  Organization,
  
  @doc("Medical companies and groups.")
  OrganizationMedical,
  
  @doc("Stock exchange groups.")
  OrganizationStockExchange,
  
  @doc("Sports-related organizations.")
  OrganizationSports,
  
  @doc("First, last, and middle names, names of fictional characters, and aliases. Titles, such as “Mr.” or “President”, are not considered part of the named entity.")
  Person,
  
  @doc("Human roles classified by a group membership.")
  PersonType,
  
  @doc("Email addresses.")
  Email,
  
  @doc("URLs to websites.")
  URL,
  
  @doc("network IP addresses.")
  IP,
  
  @doc("Phone numbers (US and EU phone numbers only).")
  PhoneNumber,
  
  @doc("Single or group of commercial, consumable objects, electronics, vehicles, food groups.")
  Product,
  
  @doc("Computing products.")
  ComputingProduct,
  
  @doc("A capability, skill, or expertise.")
  Skill,
}

alias EntityList = Array<EntityCategory>;

@added(Versions.v2023_04_15_preview)
@discriminator("policyKind")
@doc("The abstract base class for entity OverlapPolicy.")
model BaseEntityOverlapPolicy {
  @doc("The entity OverlapPolicy object kind.")
  policyKind: EntityOverlapPolicyKind;
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum EntityOverlapPolicyKind {
  @doc("Represents MatchLongestEntityPolicyType")
  matchLongest,

  @doc("Represents AllowOverlapEntityPolicyType")
  allowOverlap,
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Match longest overlap policy. No overlapping entities as far as it is possible. 1. If there are overlapping entities, the longest one will be returned. 2. If the set of characters predicted for 2 or more entities are exactly the same, select the entity that has the higher confidence score.3. If the entity scores are identical, return all entities that are still present after applying the previous rules. 3. If there is partial overlap (as in Hello Text Analytics) follow the above steps starting from 1.")
model MatchLongestEntityPolicyType extends BaseEntityOverlapPolicy {
  @doc("The entity OverlapPolicy object kind.")
  policyKind: EntityOverlapPolicyKind.matchLongest;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the allow overlap policy. Will apply no post processing logic for the entities. Whatever the model predicts is what will be returned to the user. This allows the user to get a full view of every single model's possible values and apply their own custom logic on entity selection")
model AllowOverlapEntityPolicyType extends BaseEntityOverlapPolicy {
  @doc("The entity OverlapPolicy object kind.")
  policyKind: EntityOverlapPolicyKind.allowOverlap;
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntitiesDocumentResultWithMetadata extends DocumentResult {
  @doc("Recognized entities in the document.")
  entities: Array<EntityWithMetadata>;
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntityTag {
  @doc("Tags are to express some similarities/affinity between entities. Entity Tags will be unique globally.")
  name: string;

  @doc("Detection score between 0 and 1 of the extracted entity.")
  confidenceScore?: float64;
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntityWithTags extends Entity {
  @doc("An entity type is the lowest (or finest) granularity at which the entity has been detected. The type maps to the specific metadata attributes associated with the entity detected.")
  type: string;

  @doc("List of entity tags. Tags are to express some similarities/affinity between entities.")
  tags: Array<EntityTag>;
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model EntityWithMetadata extends EntityWithTags {
  @doc("The entity metadata object.")
  metadata?: BaseMetadata;
}

@added(Versions.v2023_04_15_preview)
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
@added(Versions.v2023_04_15_preview)
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

@added(Versions.v2023_04_15_preview)
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

@added(Versions.v2023_04_15_preview)
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

@added(Versions.v2023_04_15_preview)
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

@added(Versions.v2023_04_15_preview)
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

@added(Versions.v2023_04_15_preview)
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

@added(Versions.v2023_04_15_preview)
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

@added(Versions.v2023_04_15_preview)
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

@added(Versions.v2023_04_15_preview)
@doc("The reference point that the ordinal number denotes.")
enum OrdinalRelativeTo {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Current,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  End,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Start,
}

@added(Versions.v2023_04_15_preview)
@doc("The range inclusiveness of this property property.")
enum RangeInclusivity {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NoneInclusive,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LeftInclusive,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  RightInclusive,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LeftRightInclusive,
}

@added(Versions.v2023_04_15_preview)
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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum NumericRangeKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Number,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Speed,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Weight,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Length,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Volume,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Area,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Age,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Information,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Temperature,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  Currency,
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
enum MetadataKind {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DateMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  DateTimeMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TimeMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TemporalSetMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NumberMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  OrdinalMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  SpeedMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  WeightMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  LengthMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  VolumeMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AreaMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  AgeMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  InformationMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TemperatureMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  CurrencyMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  NumericRangeMetadata,
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  TemporalSpanMetadata,
}

@added(Versions.v2023_04_15_preview)
@doc("Represents Metadata for quantities.")
model QuantityMetadata {
  @doc("The numeric value that the extracted text denotes.")
  value: float64;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Age entity Metadata model.")
model AgeMetadata  extends BaseMetadata {
  ...QuantityMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.AgeMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  unit: AgeUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Volume entity Metadata model.")
model VolumeMetadata  extends BaseMetadata {
  ...QuantityMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.VolumeMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  unit: VolumeUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Speed entity Metadata model.")
model SpeedMetadata  extends BaseMetadata {
  ...QuantityMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.SpeedMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  unit: SpeedUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Area entity Metadata model.")
model AreaMetadata  extends BaseMetadata {
  ...QuantityMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.AreaMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  unit: AreaUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Length entity Metadata model.")
model LengthMetadata  extends BaseMetadata {
  ...QuantityMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.LengthMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  unit: LengthUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Information (data) entity Metadata model.")
model InformationMetadata  extends BaseMetadata {
  ...QuantityMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.InformationMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  unit: InformationUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Information entity Metadata model.")
model TemperatureMetadata  extends BaseMetadata {
  ...QuantityMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.TemperatureMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  unit: TemperatureUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Weight ) entity Metadata model.")
model WeightMetadata  extends BaseMetadata {
  ...QuantityMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.WeightMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  unit: WeightUnit;
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the Currency ) entity Metadata model.")
model CurrencyMetadata  extends BaseMetadata {
  ...QuantityMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.CurrencyMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  unit: string;

  @doc("The alphabetic code based on another ISO standard, ISO 3166, which lists the codes for country names. The first two letters of the ISO 4217 three-letter code are the same as the code for the country name, and, where possible, the third letter corresponds to the first letter of the currency name.")
  iso4217?: string
}

@added(Versions.v2023_04_15_preview)
@doc("Represents the date value.")
model DateValue {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  timex: utcDateTime;

  @doc("The actual time that the extracted text denote.")
  value: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  modifier?: TemporalModifier
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model BaseTemporalMetadata {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  dateValues: Array<DateValue>
}

@added(Versions.v2023_04_15_preview)
@doc("A Metadata for date entity instances.")
model DateMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.DateMetadata;
}

@added(Versions.v2023_04_15_preview)
@doc("A Metadata for datetime entity instances.")
model DateTimeMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;
  
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.DateTimeMetadata;
}

@added(Versions.v2023_04_15_preview)
@doc("A Metadata for temporal set entity instances.")
model TemporalSetMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;
  
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.TemporalSetMetadata;
}

@added(Versions.v2023_04_15_preview)
@doc("A Metadata for time entity instances.")
model TimeMetadata extends BaseMetadata {
  ...BaseTemporalMetadata;
  
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.TimeMetadata;
}

@added(Versions.v2023_04_15_preview)
@doc("A metadata for numeric entity instances.")
model NumberMetadata extends BaseMetadata {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.NumberMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  numberKind: NumberKind;

  @doc("A numeric representation of what the extracted text denotes.")
  value: float64;
}

@added(Versions.v2023_04_15_preview)
@doc("A metadata for numeric entity instances.")
model OrdinalMetadata extends BaseMetadata {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.OrdinalMetadata;

  @doc("The offset With respect to the reference (e.g., offset = -1 in \"show me the second to last\"")
  offset: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  relativeTo: OrdinalRelativeTo;

  @doc("A simple arithmetic expression that the ordinal denotes.")
  value: string;
}

@added(Versions.v2023_04_15_preview)
@doc("represents the Metadata of a date and/or time span.")
model TemporalSpanMetadata extends BaseMetadata {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.TemporalSpanMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  spanValues: TemporalSpanValues;
}

@added(Versions.v2023_04_15_preview)
#suppress "@azure-tools/typespec-azure-core/documentation-required"
model TemporalSpanValues {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  begin?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  end?: utcDateTime;

  @doc("An optional duration value formatted based on the ISO 8601 (https://en.wikipedia.org/wiki/ISO_8601#Durations)")
  duration?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  modifier?: TemporalModifier;

  @doc("An optional triplet containing the beginning, the end, and the duration all stated as ISO 8601 formatted strings.")
  timex?: string
}

@added(Versions.v2023_04_15_preview)
@doc("represents the Metadata of numeric intervals.")
model NumericRangeMetadata extends BaseMetadata {
  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  metadataKind: MetadataKind.NumericRangeMetadata;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  rangeKind: NumericRangeKind;

  @doc("The beginning value of  the interval.")
  minimum: float64;

  @doc("The ending value of the interval.")
  maximum: float64;

  #suppress "@azure-tools/typespec-azure-core/documentation-required"
  rangeInclusivity?: RangeInclusivity;
}

