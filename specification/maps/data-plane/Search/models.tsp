import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./common/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace MapsSearch;

/**
 * The `GeoJSON` object type used at the root of successful responses from the forward
 * geocoding, reverse geocoding, and autocomplete operations (including their batch
 * variants). The only value is `FeatureCollection`, as defined in
 * [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946). `Get Polygon` is the one exception:
 * its response root is a `GeoJSON Feature`, see `FeatureTypeEnum`.
 */
union FeatureCollectionEnum {
  string,

  /**
   * The `GeoJSON FeatureCollection` object type. Appears as the root of every successful
   * geocoding, reverse geocoding, and autocomplete response body. `Get Polygon` uses a
   * `Feature` root instead.
   */
  FeatureCollection: "FeatureCollection",
}

/**
 * The `GeoJSON` object type for `Feature` objects. Tags each entry inside the `features`
 * array of a `FeatureCollection` response (geocoding, reverse geocoding, autocomplete) and
 * appears at the root of the `Get Polygon` response. The only value is `Feature`, as
 * defined in [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
 */
union FeatureTypeEnum {
  string,

  /**
   * The `GeoJSON Feature` object type. Appears on every Feature inside a `FeatureCollection`
   * response, and at the root of the `Get Polygon` response.
   */
  Feature: "Feature",
}

/**
 * The level of confidence that the geocoded location result is a match. Use this value together
 * with the match codes to obtain more complete information about the match.
 *
 * The confidence of a geocoded location is based on many factors, including the relative
 * importance of the geocoded location and the user's location, if specified.
 */
union ConfidenceEnum {
  string,

  /**
   * If the confidence is set to `High`, one or more strong matches were found. Multiple `High`
   * confidence matches are sorted in ranked order by importance when applicable. For example,
   * landmarks have importance but addresses do not.
   *
   * If a request includes a location or a view, then the ranking may change accordingly. For
   * example, a location query for "Paris" returns both "Paris, France" and "Paris, TX" with
   * `High` confidence. "Paris, France" is always ranked first due to importance, unless a user
   * location indicates that the user is in or very close to Paris, TX, or the map view indicates
   * that the user is searching in that area.
   */
  High: "High",

  /**
   * In some situations, the returned match may not be at the same level as the information
   * provided in the request. For example, a request may specify address information and the
   * geocode service may only be able to match a postal code. In this case, if the geocode
   * service has confidence that the postal code matches the data, the confidence is set to
   * `Medium` and the match code is set to `UpHierarchy` to indicate that the service could not
   * match all of the information and had to search up-hierarchy.
   *
   * If the location information in the query is ambiguous, and there is no additional information
   * to rank the locations (such as user location or the relative importance of the location), the
   * confidence is set to `Medium`. For example, a location query for "148th Ave, Bellevue" may
   * return both "148th Ave SE" and "148th Ave NE" with `Medium` confidence.
   *
   * If the location information in the query does not provide enough information to geocode a
   * specific location, a less precise location value may be returned and the confidence is set to
   * `Medium`. For example, if an address is provided but a match is not found for the house
   * number, the geocode result with a `RoadBlock` entity type may be returned.
   */
  Medium: "Medium",

  /**
   * Low confidence in the match.
   */
  Low: "Low",
}

/**
 * A match-code value indicating how the geocoding service produced a particular location
 * result. The `matchCodes` field on a feature is an array of these values; combine them with
 * `confidence` and `type` to evaluate match quality.
 */
union MatchCodesEnum {
  string,

  /**
   * The geocoding service produced this candidate without broadening the query: the result
   * matches the query at the specificity that was requested.
   */
  Good: "Good",

  /**
   * The location is one of a set of possible matches. For example, when querying for the
   * street address "128 Main St.", the response may return two locations for "128 North Main
   * St." and "128 South Main St." because there is not enough information to determine which
   * option to choose.
   */
  Ambiguous: "Ambiguous",

  /**
   * The location represents a move up the geographic hierarchy. This occurs when a match for
   * the location request was not found, so a less precise result is returned.
   */
  UpHierarchy: "UpHierarchy",
}

/**
 * The method that was used to compute the geocode point.
 */
union CalculationMethodEnum {
  string,

  /**
   * The geocode point was matched to a point on a road using interpolation.
   */
  Interpolation: "Interpolation",

  /**
   * The geocode point was matched to a point on a road using interpolation with an additional
   * offset to shift the point to the side of the street.
   */
  InterpolationOffset: "InterpolationOffset",

  /**
   * The geocode point was matched to the center of a parcel.
   */
  Parcel: "Parcel",

  /**
   * The geocode point was matched to the rooftop of a building.
   */
  Rooftop: "Rooftop",
}

/**
 * The intended use for a geocode point. A geocode point returned by the service carries one or
 * more usage types that indicate how a client application should consume the point: for
 * example, displaying the location on a map versus routing a vehicle to it.
 */
union UsageTypeEnum {
  string,

  /**
   * The geocode point is suitable for displaying the location on a map. For a feature with
   * non-trivial extent (such as a park or building), the `Display` point is typically near the
   * visual center of the feature.
   */
  Display: "Display",

  /**
   * The geocode point is suitable as the destination of a route. For a feature with
   * non-trivial extent (such as a park or building), the `Route` point is typically positioned
   * at a vehicle-accessible entrance rather than at the visual center.
   */
  Route: "Route",
}

/**
 * The geographic hierarchy level requested when calling `Get Polygon`. The value is supplied
 * as the `resultType` query parameter and selects which level of the administrative or postal
 * hierarchy the returned `Boundary` polygon outlines. Defaults to `countryRegion` when not
 * specified.
 */
union BoundaryResultTypeEnum {
  string,

  /**
   * A country or region.
   */
  countryRegion: "countryRegion",

  /**
   * First administrative level within the country/region, such as a state or a province.
   */
  adminDistrict: "adminDistrict",

  /**
   * Second administrative level within the country/region, such as a county.
   */
  adminDistrict2: "adminDistrict2",

  /**
   * The smallest postal code category, such as a zip code.
   */
  postalCode: "postalCode",

  /**
   * The next largest postal code category after `postalCode` that is created by aggregating
   * `postalCode` areas.
   */
  postalCode2: "postalCode2",

  /**
   * The next largest postal code category after `postalCode2` that is created by aggregating
   * `postalCode2` areas.
   */
  postalCode3: "postalCode3",

  /**
   * The next largest postal code category after `postalCode3` that is created by aggregating
   * `postalCode3` areas.
   */
  postalCode4: "postalCode4",

  /**
   * A locally recognized area within a populated place, often with informal or culturally
   * defined boundaries.
   */
  neighborhood: "neighborhood",

  /**
   * A concentrated area of human settlement, such as a city, town or village.
   */
  locality: "locality",
}

/**
 * The level of detail used for the `Boundary` polygon returned by `Get Polygon`. Supplied as
 * the `resolution` query parameter, the value selects how many points outline the boundary,
 * in ascending order: `small`, `medium`, `large`, `huge`. Higher levels use the same number
 * of points as the next lower level or more. Defaults to `medium` when not specified.
 */
union ResolutionEnum {
  string,

  /**
   * Returns the boundary geometry with the fewest points.
   */
  small: "small",

  /**
   * Returns the boundary geometry with the same number of points as `small` or more.
   */
  medium: "medium",

  /**
   * Returns the boundary geometry with the same number of points as `medium` or more.
   */
  large: "large",

  /**
   * Returns the boundary geometry with the same number of points as `large` or more.
   */
  huge: "huge",
}

/**
 * An entity type returned by the `Get Reverse Geocoding` operation. Supplied as one or more
 * values in the `resultTypes` query parameter to restrict the response to specific kinds of
 * locations; when the parameter is omitted, all entity types are eligible. When entities of
 * more than one type match a coordinate, only the most specific is returned. Listed from
 * most specific to least specific: `Address`, `Neighborhood`, `PopulatedPlace`, `Postcode1`,
 * `AdminDivision1`, `AdminDivision2`, `CountryRegion`.
 */
union ReverseGeocodingResultTypeEnum {
  string,

  /**
   * A specific street address.
   */
  Address: "Address",

  /**
   * A locally recognized area within a populated place, often with informal or culturally
   * defined boundaries.
   */
  Neighborhood: "Neighborhood",

  /**
   * A concentrated area of human settlement, such as a city, town or village.
   */
  PopulatedPlace: "PopulatedPlace",

  /**
   * The smallest postal code category, such as a zip code.
   */
  Postcode1: "Postcode1",

  /**
   * First administrative level within the country/region, such as a state or a province.
   */
  AdminDivision1: "AdminDivision1",

  /**
   * Second administrative level within the country/region, such as a county.
   */
  AdminDivision2: "AdminDivision2",

  /**
   * A country or region.
   */
  CountryRegion: "CountryRegion",
}

/**
 * An entity type returned by the `Get Reverse Geocoding Batch` operation. Supplied as one or
 * more values in the per-batch-item `resultTypes` field to restrict the response for that
 * item to specific kinds of locations; when the field is omitted, all entity types are
 * eligible. When entities of more than one type match a coordinate, only the most specific
 * is returned. Listed from most specific to least specific: `Address`, `Neighborhood`,
 * `PopulatedPlace`, `Postcode1`, `AdminDivision1`, `AdminDivision2`, `CountryRegion`.
 */
union ResultTypeEnum {
  string,

  /**
   * A specific street address.
   */
  Address: "Address",

  /**
   * A locally recognized area within a populated place, often with informal or culturally
   * defined boundaries.
   */
  Neighborhood: "Neighborhood",

  /**
   * A concentrated area of human settlement, such as a city, town or village.
   */
  PopulatedPlace: "PopulatedPlace",

  /**
   * The smallest postal code category, such as a zip code.
   */
  Postcode1: "Postcode1",

  /**
   * First administrative level within the country/region, such as a state or a province.
   */
  AdminDivision1: "AdminDivision1",

  /**
   * Second administrative level within the country/region, such as a county.
   */
  AdminDivision2: "AdminDivision2",

  /**
   * A country or region.
   */
  CountryRegion: "CountryRegion",
}

/**
 * A coarse classification of an autocomplete suggestion into one of two groups. Used by
 * `Get Autocomplete` both as an input filter via the `resultTypeGroups` query parameter
 * (restricting which kinds of suggestions are returned) and as an output classifier via
 * the `typeGroup` field on each `AutocompleteProperties` (identifying which group a
 * returned suggestion belongs to). The `Address` group covers individual addresses and
 * street segments; the `Place` group covers all other entity types (administrative
 * regions, populated places, natural features, and points of interest).
 */
union AutocompleteResultTypeGroupsEnum {
  string,

  /**
   * Suggestions that resolve to a specific address or a road segment. Constituent types in
   * `AutocompleteResultTypeEnum`: `Address`, `RoadBlock`.
   */
  Address: "Address",

  /**
   * Suggestions that resolve to named places, including administrative regions, populated
   * places, neighborhoods, natural features, and points of interest. Constituent types in
   * `AutocompleteResultTypeEnum`: every member except `Address` and `RoadBlock`. Examples
   * include `AdminDivision1`, `Neighborhood`, and `PopulatedPlace`.
   */
  Place: "Place",
}

/**
 * A classification of autocomplete suggestions used by `Get Autocomplete` both as an input
 * filter (via the `resultTypes` query parameter) and as an output label (via the `type`
 * field on each `AutocompleteProperties`). The members define a gazetteer-style taxonomy
 * spanning addresses, road segments, administrative regions, populated places, natural
 * features, and points of interest. This taxonomy is partitioned into two broader groups
 * by `AutocompleteResultTypeGroupsEnum`: `Address`, which covers addresses and road
 * segments; and `Place`, which covers all other result types.
 */
union AutocompleteResultTypeEnum {
  string,

  /**
   * A specific street address.
   */
  Address: "Address",

  /**
   * First administrative level within the country/region, such as a state or a province.
   */
  AdminDivision1: "AdminDivision1",

  /**
   * Second administrative level within the country/region, such as a county.
   */
  AdminDivision2: "AdminDivision2",

  /**
   * Third administrative level within the country/region, such as a district, parish, or
   * municipality.
   */
  AdminDivision3: "AdminDivision3",

  /**
   * A building that houses government offices or public administrative functions.
   */
  AdministrativeBuilding: "AdministrativeBuilding",

  /**
   * A facility where aircraft regularly take off and land, with facilities for passengers
   * and cargo.
   */
  Airport: "Airport",

  /**
   * A passenger terminal building within an airport.
   */
  AirportTerminal: "AirportTerminal",

  /**
   * An entertainment facility featuring rides, games, and themed attractions.
   */
  AmusementPark: "AmusementPark",

  /**
   * A place where archaeological remains or cultural artifacts of an ancient civilization are
   * preserved.
   */
  AncientSite: "AncientSite",

  /**
   * A public facility where aquatic plants and animals are exhibited and studied.
   */
  Aquarium: "Aquarium",

  /**
   * A group or chain of islands.
   */
  Archipelago: "Archipelago",

  /**
   * A natural depression in the land surface, often surrounded by higher terrain.
   */
  Basin: "Basin",

  /**
   * A site of a historically significant land battle.
   */
  Battlefield: "Battlefield",

  /**
   * A body of water partially enclosed by land, smaller than a gulf and larger than a cove.
   */
  Bay: "Bay",

  /**
   * A shore of sand, pebble, or other unconsolidated sediment along a body of water.
   */
  Beach: "Beach",

  /**
   * A structure carrying a road, railway, or path across an obstacle such as a river,
   * valley, or another road.
   */
  Bridge: "Bridge",

  /**
   * A building used for general business or commercial activities that doesn't fit a more
   * specific category.
   */
  BusinessStructure: "BusinessStructure",

  /**
   * A site with shelters or facilities for temporary occupation, such as a campground or
   * seasonal settlement.
   */
  Camp: "Camp",

  /**
   * An artificial watercourse used for transportation, irrigation, or drainage.
   */
  Canal: "Canal",

  /**
   * A facility used for gambling and games of chance.
   */
  Casino: "Casino",

  /**
   * A historically fortified building or complex of buildings, typically associated with noble
   * or royal residence.
   */
  Castle: "Castle",

  /**
   * A natural underground chamber or passage formed in rock.
   */
  Cave: "Cave",

  /**
   * A burial place or graveyard.
   */
  Cemetery: "Cemetery",

  /**
   * A navigable waterway between two land bodies or the main flow path of a larger water
   * body.
   */
  Channel: "Channel",

  /**
   * A building used for public Christian worship.
   */
  Church: "Church",

  /**
   * A high, steep face of rock or earth, often overlooking a coast or valley.
   */
  Cliff: "Cliff",

  /**
   * A named stretch of land bordering the sea.
   */
  Coast: "Coast",

  /**
   * A facility hosting community activities, meetings, and social services.
   */
  CommunityCenter: "CommunityCenter",

  /**
   * One of the Earth's major landmasses.
   */
  Continent: "Continent",

  /**
   * A country or region.
   */
  CountryRegion: "CountryRegion",

  /**
   * A circular depression formed by volcanic activity or meteorite impact.
   */
  Crater: "Crater",

  /**
   * An area distinguished by shared cultural characteristics, such as language, ethnicity, or
   * heritage.
   */
  CulturalRegion: "CulturalRegion",

  /**
   * A barrier constructed across a stream or river to impound water.
   */
  Dam: "Dam",

  /**
   * A landform of alluvial deposits formed where a river meets a larger body of water.
   */
  Delta: "Delta",

  /**
   * A large arid region with sparse vegetation due to limited precipitation.
   */
  Desert: "Desert",

  /**
   * An area of land drained by a river system and its tributaries.
   */
  DrainageBasin: "DrainageBasin",

  /**
   * A mound or ridge of wind-blown sand.
   */
  Dune: "Dune",

  /**
   * A structure that houses a specialized facility, such as a utility plant or service
   * installation.
   */
  FacilityStructure: "FacilityStructure",

  /**
   * A facility where passengers and vehicles board and disembark ferries.
   */
  FerryTerminal: "FerryTerminal",

  /**
   * A building that houses a bank, credit union, or other financial services institution.
   */
  FinancialStructure: "FinancialStructure",

  /**
   * A building that houses firefighters, equipment, and emergency response vehicles.
   */
  FireStation: "FireStation",

  /**
   * A large area of land dominated by trees.
   */
  Forest: "Forest",

  /**
   * A defensive military structure or earthworks.
   */
  Fort: "Fort",

  /**
   * A cultivated area for displaying ornamental or scientifically curated plants.
   */
  Garden: "Garden",

  /**
   * A hot spring that periodically erupts jets of water and steam.
   */
  Geyser: "Geyser",

  /**
   * A persistent mass of ice that moves slowly under its own weight.
   */
  Glacier: "Glacier",

  /**
   * A field laid out for playing golf.
   */
  GolfCourse: "GolfCourse",

  /**
   * A metropolitan area or conurbation that contains and extends beyond a populated place.
   */
  GreaterPopulatedPlace: "GreaterPopulatedPlace",

  /**
   * A college, university, or similar institution of post-secondary education.
   */
  HigherEducationFacility: "HigherEducationFacility",

  /**
   * A site of historical significance, often preserved as a cultural heritage location.
   */
  HistoricalSite: "HistoricalSite",

  /**
   * A medical facility providing inpatient and outpatient care.
   */
  Hospital: "Hospital",

  /**
   * A natural spring where geothermally heated groundwater emerges at the surface.
   */
  HotSpring: "HotSpring",

  /**
   * A natural mass or surface layer of frozen water covering land or water.
   */
  Ice: "Ice",

  /**
   * A territory recognized as the homeland of an indigenous people or community.
   */
  IndigenousPeoplesReserve: "IndigenousPeoplesReserve",

  /**
   * A building or installation used for manufacturing, production, or other industrial
   * operations.
   */
  IndustrialStructure: "IndustrialStructure",

  /**
   * A landmass surrounded by water, smaller than a continent.
   */
  Island: "Island",

  /**
   * A narrow strip of land connecting two larger landmasses and separating two bodies of
   * water.
   */
  Isthmus: "Isthmus",

  /**
   * An inland body of standing water surrounded by land.
   */
  Lake: "Lake",

  /**
   * A named land region that doesn't fit a more specific geographic category.
   */
  LandArea: "LandArea",

  /**
   * A natural land feature that doesn't fit a more specific category, such as a `Mountain`,
   * `Valley`, or `Plateau`.
   */
  Landform: "Landform",

  /**
   * A notable building of architectural, cultural, or historical significance that serves as
   * a recognizable landmark.
   */
  LandmarkBuilding: "LandmarkBuilding",

  /**
   * A building that houses a collection of books and other media available for public use.
   */
  Library: "Library",

  /**
   * A coastal or harbor structure displaying a navigation light to guide ships.
   */
  Lighthouse: "Lighthouse",

  /**
   * A harbor facility providing moorings and services for small boats and yachts.
   */
  Marina: "Marina",

  /**
   * A place where goods are bought and sold, typically at retail.
   */
  Market: "Market",

  /**
   * A building used for medical or health-related services other than a `Hospital`, such as
   * a clinic or medical office.
   */
  MedicalStructure: "MedicalStructure",

  /**
   * A station on a subway, underground, or other urban rapid-transit rail system.
   */
  MetroStation: "MetroStation",

  /**
   * An installation operated by armed forces for training, supply, or operations.
   */
  MilitaryBase: "MilitaryBase",

  /**
   * A complex operated by a religious group to provide community services and propagate faith.
   */
  Mission: "Mission",

  /**
   * A commemorative structure or statue erected to honor a person, event, or idea.
   */
  Monument: "Monument",

  /**
   * A building used for public Islamic worship.
   */
  Mosque: "Mosque",

  /**
   * A landform that rises significantly above its surroundings, typically with steep slopes
   * and a defined summit.
   */
  Mountain: "Mountain",

  /**
   * A connected series of mountains forming a continuous range.
   */
  MountainRange: "MountainRange",

  /**
   * A station that serves multiple transportation modes, such as combined rail, bus, or
   * metro services.
   */
  MultiModalStation: "MultiModalStation",

  /**
   * A facility where objects of artistic, scientific, or historical interest are preserved
   * and exhibited.
   */
  Museum: "Museum",

  /**
   * A structure related to maritime or nautical activity, such as a pier, dock, or buoy.
   */
  NauticalStructure: "NauticalStructure",

  /**
   * A locally recognized area within a populated place, often with informal or culturally
   * defined boundaries.
   */
  Neighborhood: "Neighborhood",

  /**
   * A fertile area in a desert sustained by a natural water source.
   */
  Oasis: "Oasis",

  /**
   * A vantage point or lookout providing scenic views of the surrounding area.
   */
  ObservationPoint: "ObservationPoint",

  /**
   * One of the major divisions of Earth's global ocean.
   */
  Ocean: "Ocean",

  /**
   * A building used primarily for professional or administrative office space.
   */
  OfficeBuilding: "OfficeBuilding",

  /**
   * A suggestion that doesn't fit any other defined type.
   */
  Other: "Other",

  /**
   * An area maintained for public recreation or scenic enjoyment.
   */
  Park: "Park",

  /**
   * A multi-level structure dedicated to vehicle parking.
   */
  ParkingStructure: "ParkingStructure",

  /**
   * A navigable route through or over a mountain range or similar obstruction.
   */
  Pass: "Pass",

  /**
   * A landmass projecting into a body of water and nearly surrounded by it.
   */
  Peninsula: "Peninsula",

  /**
   * An extensive area of relatively flat or gently undulating land.
   */
  Plain: "Plain",

  /**
   * A celestial body orbiting a star, typically used to represent the Earth as the root of
   * the geographic hierarchy.
   */
  Planet: "Planet",

  /**
   * An elevated area of relatively level land with steep slopes on one or more sides.
   */
  Plateau: "Plateau",

  /**
   * A recreational area equipped for children's play.
   */
  Playground: "Playground",

  /**
   * An open area used for playing organized sports.
   */
  PlayingField: "PlayingField",

  /**
   * A geographic pole, such as the North or South Pole.
   */
  Pole: "Pole",

  /**
   * A self-governing political entity, such as an independent or dependent state or territory.
   */
  PoliticalUnit: "PoliticalUnit",

  /**
   * A concentrated area of human settlement, such as a city, town or village.
   */
  PopulatedPlace: "PopulatedPlace",

  /**
   * A maritime facility with terminals for loading and unloading waterborne cargo or
   * passengers.
   */
  Port: "Port",

  /**
   * The smallest postal code category, such as a zip code.
   */
  Postcode1: "Postcode1",

  /**
   * A prominent elevated landform projecting into a lowland or body of water.
   */
  Promontory: "Promontory",

  /**
   * A track or course laid out for racing vehicles, animals, or athletes.
   */
  RaceTrack: "RaceTrack",

  /**
   * A facility where passengers board and disembark trains.
   */
  RailwayStation: "RailwayStation",

  /**
   * A submerged or partially submerged ridge of rock, sand, or coral near the water surface.
   */
  Reef: "Reef",

  /**
   * A building used for religious worship or practice that doesn't fit a more specific
   * category, such as `Church`, `Mosque`, or `Temple`.
   */
  ReligiousStructure: "ReligiousStructure",

  /**
   * A protected tract of land set aside for conservation, wildlife, or other restricted use.
   */
  Reserve: "Reserve",

  /**
   * A building used primarily for human residence, such as an apartment or housing complex.
   */
  ResidentialStructure: "ResidentialStructure",

  /**
   * A natural watercourse flowing to a lower elevation, typically toward a sea, lake, or
   * another river.
   */
  River: "River",

  /**
   * A street segment without a specific house number, returned when the geocoding service
   * cannot locate an exact house number for the query. Despite its name, this value does not
   * indicate a physical road closure.
   */
  RoadBlock: "RoadBlock",

  /**
   * A destroyed or decayed structure that no longer serves its original function.
   */
  Ruin: "Ruin",

  /**
   * A facility used as a base for scientific research, often in remote or extreme
   * environments.
   */
  ScientificResearchBase: "ScientificResearchBase",

  /**
   * A large body of salt water partially enclosed by land, smaller than an ocean.
   */
  Sea: "Sea",

  /**
   * An area of water designated for seaplanes to take off and land.
   */
  SeaplaneLandingArea: "SeaplaneLandingArea",

  /**
   * A structure or site that memorializes a person or commemorates a sacred event or concept.
   */
  Shrine: "Shrine",

  /**
   * A recreational area developed for skiing and other winter sports.
   */
  SkiArea: "SkiArea",

  /**
   * A natural source where groundwater flows from the earth's surface.
   */
  Spring: "Spring",

  /**
   * A large venue with tiered seating for spectator sports or events.
   */
  Stadium: "Stadium",

  /**
   * A region defined for statistical or census purposes, such as a metropolitan statistical
   * area or census tract.
   */
  StatisticalDistrict: "StatisticalDistrict",

  /**
   * A building dedicated to religious worship.
   */
  Temple: "Temple",

  /**
   * A venue for presenting plays, films, or other live or recorded performances.
   */
  Theater: "Theater",

  /**
   * A scenic or heritage railway operated primarily for tourism rather than regular transit.
   */
  TouristRailway: "TouristRailway",

  /**
   * A building that serves tourists, such as a visitor center or tourist information office.
   */
  TouristStructure: "TouristStructure",

  /**
   * The starting point of a hiking, biking, or recreational trail.
   */
  Trailhead: "Trailhead",

  /**
   * A structure that supports transportation infrastructure, such as a toll plaza, weigh
   * station, or transit shelter.
   */
  TransportationStructure: "TransportationStructure",

  /**
   * An underground or underwater passage for road, rail, or pedestrian transit.
   */
  Tunnel: "Tunnel",

  /**
   * An elongated low-lying area between hills or mountains, often containing a watercourse.
   */
  Valley: "Valley",

  /**
   * A mountain or hill formed by volcanic activity, typically with a crater at its summit.
   */
  Volcano: "Volcano",

  /**
   * A path or paved surface designated for pedestrian use.
   */
  Walkway: "Walkway",

  /**
   * A constructed barrier forming a continuous vertical boundary, often used for defense,
   * separation, or commemoration.
   */
  Wall: "Wall",

  /**
   * A point where a stream or river drops vertically or steeply.
   */
  Waterfall: "Waterfall",

  /**
   * A body of water that doesn't fit a more specific category, such as a `Lake`, `River`,
   * or `Sea`.
   */
  WaterFeature: "WaterFeature",

  /**
   * An area of land saturated with water and supporting aquatic vegetation, such as a marsh
   * or swamp.
   */
  Wetland: "Wetland",

  /**
   * A facility where wine is produced and often offered for tasting or sale.
   */
  Winery: "Winery",

  /**
   * A facility where wild animals are kept for public exhibition and study.
   */
  Zoo: "Zoo",
}

/**
 * The successful response body returned by `Get Geocoding` and `Get Reverse Geocoding`, and
 * the per-batch-item success shape carried inside `GeocodingBatchResponse.batchItems`.
 * Encoded as a [`GeoJSON FeatureCollection`](https://www.rfc-editor.org/rfc/rfc7946) whose
 * `features` array contains one `Feature` per geocoded location.
 */
model GeocodingResponse {
  /**
   * The `GeoJSON` object type of a successful `Get Geocoding` or `Get Reverse Geocoding`
   * response body. Always `FeatureCollection`, as defined in
   * [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type?: FeatureCollectionEnum;

  /**
   * The array of `GeoJSON Feature` objects returned by the query. Each `Feature` represents a
   * single geocoded location: its address components, match-quality indicators, and geocode
   * points are exposed via `properties`, and its primary coordinate via `geometry`.
   */
  features?: FeaturesItem[];

  /**
   * Contains the URL to fetch the next page of results if the response is paginated. This is
   * useful when the response is too large to be returned in a single call, allowing users to
   * navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * A single entry in the `features` array of a `GeocodingResponse`, conforming to the
 * [`GeoJSON Feature`](https://www.rfc-editor.org/rfc/rfc7946#section-3.2) object shape.
 * Represents one geocoded location: structured data on `properties`, a representative
 * coordinate on `geometry`, and an optional bounding box on `bbox`.
 */
model FeaturesItem {
  /**
   * The `GeoJSON` object type. Always `Feature`, as defined in
   * [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type?: FeatureTypeEnum;

  /**
   * An optional service-assigned identifier for the feature, when one is available.
   */
  id?: string;

  /**
   * Structured data about the geocoded location, including its entity type, match-quality
   * indicators, address components, and one or more geocode points.
   */
  properties?: FeaturesItemProperties;

  /**
   * The primary [`GeoJSON Point`](https://tools.ietf.org/html/rfc7946#section-3.1.2)
   * representing the geocoded location, with coordinates in WGS 84 longitude/latitude order.
   */
  geometry: GeoJsonPoint;

  /**
   * The smallest axis-aligned rectangle that contains the feature's geometry, in WGS 84
   * longitude/latitude order. Encoded as `[westLon, southLat, eastLon, northLat]` per
   * [RFC 7946, Section 5](https://datatracker.ietf.org/doc/html/rfc7946#section-5).
   */
  bbox?: float64[];
}

/**
 * The `properties` payload of a feature in a `GeocodingResponse`. Carries the entity type and
 * match-quality indicators for the geocoded location, its parsed address components, and one or
 * more geocode points that pin the location to specific coordinates.
 */
model FeaturesItemProperties {
  /**
   * The entity type that the geocoded location resolved to. One of: `Address`, `RoadBlock`,
   * `RoadIntersection`, `Neighborhood`, `PopulatedPlace`, `Postcode1`, `AdminDivision1`,
   * `AdminDivision2`, or `CountryRegion`.
   */
  type?: string;

  /**
   * How strongly the geocoded location matches the request. Use together with `matchCodes` for a
   * complete picture of match quality. See `ConfidenceEnum` for the value list and the factors
   * that influence the rating.
   */
  confidence?: ConfidenceEnum;

  /**
   * How the geocoding service produced this result relative to the query: a direct match at the
   * requested specificity (`Good`), one of several candidates (`Ambiguous`), or a fallback to a
   * less precise level of the geographic hierarchy (`UpHierarchy`). Multiple values may be
   * present. For example, an `Ambiguous` plus `UpHierarchy` pairing indicates that the service
   * could not match the requested specificity and found multiple matches at a coarser level. See
   * `MatchCodesEnum` for per-value descriptions; combine with `confidence` for a complete
   * picture of match quality.
   */
  matchCodes?: MatchCodesEnum[];

  /**
   * The address of the geocoded location, parsed into structured fields such as locality, postal
   * code, country/region, and (when available) street name and number.
   */
  address?: Address;

  /**
   * One or more geocode points for the location, each marked with how it was derived
   * (`calculationMethod`) and what it is best suited for (`usageTypes`). For example, `Display`
   * for visual placement on a map, or `Route` for use as a navigation destination.
   */
  geocodePoints?: GeocodePointsItem[];
}

/**
 * The address of a geocoded or autocomplete-suggested location, parsed into structured fields.
 * Sparseness is normal: only the fields that the resolved entity supplies are populated. For
 * example, `streetName` and `streetNumber` appear only for street-level addresses, and
 * `intersection` appears only for road-intersection results.
 */
model Address {
  /**
   * The first line of the address, typically the street name and number. For example,
   * `"15127 NE 24th St"`.
   */
  addressLine?: string;

  /**
   * The locality the address falls within: usually a city, town, or village. For example:
   * `"Redmond"`.
   */
  locality?: string;

  /**
   * The named neighborhood within the locality, when one is identified.
   */
  neighborhood?: string;

  /**
   * The administrative subdivisions that contain the address, ordered from coarsest to finest.
   * The first entry is typically the first-order subdivision (such as a U.S. state or a
   * Canadian province); subsequent entries cover finer divisions where the country, dependency,
   * or region defines them (such as a county at index 1).
   */
  adminDistricts?: AddressAdminDistrictsItem[];

  /**
   * The postal code for the address, when one is defined. Example: `"98052"`.
   */
  postalCode?: string;

  /**
   * The country or region that contains the address, with its display name and ISO 3166-1
   * Alpha-2 country code.
   */
  countryRegion?: AddressCountryRegion;

  /**
   * The full address rendered as a single human-readable string, with the components joined
   * according to the conventions of the address's country or region. Example:
   * `"15127 NE 24th St, Redmond, WA 98052"`.
   */
  formattedAddress?: string;

  /**
   * The street name component of the address, when the resolved entity is a street-level
   * address. Example: `"NE 24th St"`.
   */
  streetName?: string;

  /**
   * The house or building number on the street, when the resolved entity is a street-level
   * address. Example: `"15127"`.
   */
  streetNumber?: string;

  /**
   * The intersecting-street details for the address, populated when the resolved entity is a
   * `RoadIntersection` (such as the corner of two named streets).
   */
  intersection?: Intersection;
}

/**
 * An administrative subdivision that contains an address. For example, a state, province, or
 * county. Returned as one entry in the parent `Address.adminDistricts` array, where entries are
 * ordered from coarsest to finest.
 */
model AddressAdminDistrictsItem {
  /**
   * The full name of the subdivision. For example, `"Washington"` for a U.S. state, or
   * `"King County"` for a county.
   */
  name?: string;

  /**
   * The short or abbreviated form of the subdivision name, when one is defined. For example,
   * `"WA"` for a U.S. state. Finer subdivisions often have no distinct short form, in which case
   * `shortName` repeats `name` (such as `"King County"`).
   */
  shortName?: string;
}

/**
 * The country or region that contains the address, identified by its display name and ISO 3166-1
 * Alpha-2 country code. Either field may be omitted in a given response.
 */
model AddressCountryRegion {
  /**
   * The ISO 3166-1 Alpha-2 country code for the country or region. For example, `"US"` for the
   * United States, or `"GB"` for the United Kingdom.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract"
  ISO?: string;

  /**
   * The display name of the country or region. For example, `"United States"`.
   */
  name?: string;
}

/**
 * Intersection details for an address resolved as a road intersection — the corner where two or
 * more named streets meet. Populated only when the resolved entity is a `RoadIntersection`; the
 * parent `Address.intersection` is otherwise omitted.
 */
model Intersection {
  /**
   * The primary street of the intersection — typically the street the address number references.
   */
  baseStreet?: string;

  /**
   * The first cross street that meets `baseStreet` at the intersection.
   */
  secondaryStreet1?: string;

  /**
   * The second cross street at the intersection, when one is present. Populated only for
   * intersections of three or more streets.
   */
  secondaryStreet2?: string;

  /**
   * A short label describing the form of the intersection. For example, distinguishing an
   * at-grade crossroads from a grade-separated crossing such as a bridge or overpass.
   */
  intersectionType?: string;

  /**
   * A human-readable name for the intersection that combines the cross streets, such as
   * `"5th Avenue & Main Street"`.
   */
  displayName?: string;
}

/**
 * One geocode point for a location: a coordinate plus metadata describing how the point was
 * computed (`calculationMethod`) and what it is best suited for (`usageTypes`). A single feature
 * typically returns separate `Display` and `Route` points so callers can pick the one that fits
 * the task.
 */
model GeocodePointsItem {
  /**
   * The coordinate of this geocode point as a
   * [`GeoJSON Point`](https://tools.ietf.org/html/rfc7946#section-3.1.2), with values in WGS 84
   * longitude/latitude order.
   */
  geometry?: GeoJsonPoint;

  /**
   * How the point was computed. For example, snapped to the rooftop of a building or
   * interpolated along a road centerline. See `CalculationMethodEnum` for the value list.
   */
  calculationMethod?: CalculationMethodEnum;

  /**
   * What the geocode point is best suited for — `Display` for visual placement on a map, or
   * `Route` as a routing destination. A point may carry both. See `UsageTypeEnum` for the
   * per-value details, including how each is positioned for features with non-trivial extent.
   */
  usageTypes?: UsageTypeEnum[];
}

/**
 * The request body for the `Get Geocoding Batch` operation. Carries one or more individual
 * geocoding queries — between 1 and 100, inclusive — that the service processes as a single
 * call and returns as a parallel `batchItems` array on `GeocodingBatchResponse`.
 */
model GeocodingBatchRequestBody {
  /**
   * The geocoding queries to process in this batch. Each entry is one independent
   * forward-geocoding request; the service returns one corresponding entry in
   * `GeocodingBatchResponse.batchItems` per query, in the same order.
   */
  batchItems?: GeocodingBatchRequestItem[];
}

/**
 * One geocoding query inside a `GeocodingBatchRequestBody.batchItems` array. Each item is an
 * independent forward-geocoding request equivalent to a single call to `Get Geocoding`, expressed
 * as fields rather than as URL query parameters. The location can be supplied either as a
 * free-form `query` string or as the structured fields below (`addressLine`, `locality`,
 * `countryRegion`, the `adminDistrict` levels, `postalCode`); these two input modes are mutually
 * exclusive — when `query` is set, the structured fields are ignored.
 */
model GeocodingBatchRequestItem {
  /**
   * An optional caller-supplied identifier echoed back on the matching response entry as
   * `GeocodingBatchResponseItem.optionalId`. Useful for correlating responses to requests by a
   * stable application-side identifier rather than relying on array position alone.
   */
  optionalId?: string;

  /**
   * The maximum number of geocoded results returned for this query. Defaults to 5; minimum 1,
   * maximum 20.
   */
  @maxValue(20)
  @minValue(1)
  top?: int32 = 5;

  /**
   * A free-form string describing the location to geocode, typically an address or landmark
   * name. When set, the structured location fields below (`addressLine`, `locality`,
   * `countryRegion`, the `adminDistrict` levels, `postalCode`) are ignored.
   */
  query?: string;

  /**
   * The street line of the address, typically the street name and number, or any other
   * official street-level address. Ignored when `query` is set.
   */
  addressLine?: string;

  /**
   * An [ISO 3166-1 Alpha-2 region/country
   * code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) that scopes the search to a single
   * country or region. For example, `"FR"` for France. Ignored when `query` is set.
   */
  countryRegion?: string;

  /**
   * A bounding box that scopes the search to a rectangular geographic area. Encoded as
   * `[westLon, southLat, eastLon, northLat]` in WGS 84 longitude/latitude order, with each side
   * ranging from approximately `0.00001` degrees (~1 meter) up to the full global extent
   * (`-180, -90` to `180, 90`).
   */
  bbox?: float64[];

  /**
   * An [ISO 3166-1 Alpha-2 region/country
   * code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) identifying the region whose
   * geopolitical view should be applied to disputed borders and labels in the response. Defaults
   * to `"auto"`, which selects the view based on the request origin. See [Supported
   * Views](https://aka.ms/AzureMapsLocalizationViews) for the available values.
   */
  view?: string = "auto";

  /**
   * A point on the earth, encoded as `[longitude, latitude]` in WGS 84 order, used to bias
   * results toward the user's location. When supplied, results closer to this point are
   * typically more relevant to the user.
   */
  coordinates?: float64[];

  /**
   * The first-order administrative subdivision (such as a state or province) supplied as a name
   * or short code. For example, `"WA"` for Washington. Ignored when `query` is set.
   */
  adminDistrict?: string;

  /**
   * The second-order administrative subdivision (such as a county). For example, `"King"` for
   * King County. Ignored when `query` is set.
   */
  adminDistrict2?: string;

  /**
   * The third-order administrative subdivision (such as a district, parish, or municipality),
   * where the country, dependency, or region defines one. Ignored when `query` is set.
   */
  adminDistrict3?: string;

  /**
   * The locality (city, town, or village) component of the address. For example, `"Seattle"`.
   * Ignored when `query` is set.
   */
  locality?: string;

  /**
   * The postal code component of the address. Ignored when `query` is set.
   */
  postalCode?: string;
}

/**
 * The successful response body returned by `Get Geocoding Batch`. Carries a `summary` of how
 * many of the submitted queries succeeded plus a `batchItems` array containing one response
 * entry per query in the request, in the same order as the request `batchItems` array.
 */
model GeocodingBatchResponse {
  /**
   * Aggregate counts for the batch as a whole, the total submitted queries and how many of
   * them completed successfully.
   */
  summary?: GeocodingBatchResponseSummary;

  /**
   * The per-query results of the batch. Each entry corresponds positionally to the request
   * entry at the same array index in `GeocodingBatchRequestBody.batchItems`. Entries with
   * `error` populated represent queries that failed; entries with `features` populated
   * represent queries that succeeded.
   */
  batchItems?: GeocodingBatchResponseItem[];

  /**
   * Contains the URL to fetch the next page of results if the response is paginated. This is
   * useful when the response is too large to be returned in a single call, allowing users to
   * navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * Carries aggregate counts for a `Get Geocoding Batch` response: the size of the submitted
 * batch and how many of its queries were processed successfully. Used as the type of
 * `GeocodingBatchResponse.summary`.
 */
model GeocodingBatchResponseSummary {
  /**
   * The number of queries in the batch that were processed successfully — those whose response
   * entry in `GeocodingBatchResponse.batchItems` carries `features` rather than `error`.
   */
  successfulRequests?: int32;

  /**
   * The total number of queries submitted in the batch. Subtract `successfulRequests` to derive
   * the number of queries that failed.
   */
  totalRequests?: int32;
}

/**
 * A single entry inside `GeocodingBatchResponse.batchItems`, carrying the result of one of
 * the queries from the corresponding `GeocodingBatchRequestBody.batchItems` entry.
 * Successful queries surface their geocoded `features` here in the same shape as
 * `GeocodingResponse`; failed queries surface diagnostic information via `error` instead.
 * Exactly one of `features` or `error` is populated per entry.
 */
model GeocodingBatchResponseItem {
  /**
   * The caller-supplied identifier echoed back from the corresponding
   * `GeocodingBatchRequestItem.optionalId`. Populated only when the request entry supplied
   * one. Useful for application-side correlation when array position is not sufficient.
   */
  optionalId?: string;

  /**
   * The `GeoJSON` object type of this entry's success body. Always `FeatureCollection`, as
   * defined in [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946). Populated only when the
   * entry succeeded.
   */
  type?: FeatureCollectionEnum;

  /**
   * The array of `GeoJSON Feature` objects geocoded for this batch entry's query. Each
   * `Feature` represents a single geocoded location with details exposed via `properties` and
   * its primary coordinate via `geometry`. Populated only when the entry succeeded.
   */
  features?: FeaturesItem[];

  /**
   * Contains the URL to fetch the next page of results if the response is paginated. This is
   * useful when the response is too large to be returned in a single call, allowing users to
   * navigate through multiple pages of results.
   */
  nextLink?: string;

  /**
   * Diagnostic information for a query that failed inside the batch, the per-entry error
   * path complementing the success path on `features`. Populated only when the entry failed;
   * see `ErrorDetail` for the per-error shape.
   */
  error?: ErrorDetail;
}

/**
 * The successful response body returned by `Get Polygon`. Encoded as a
 * [`GeoJSON Feature`](https://www.rfc-editor.org/rfc/rfc7946#section-3.2) whose `geometry` is
 * a `GeometryCollection` of one or more `Polygon` or `MultiPolygon` shapes describing the
 * outline of the requested geographical area, and whose `properties` carry the area's
 * display name and copyright attribution.
 */
model Boundary {
  /**
   * The `GeoJSON` object type. Always `Feature`, as defined in
   * [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type?: FeatureTypeEnum;

  /**
   * A `GeometryCollection` of one or more `Polygon` or `MultiPolygon` shapes whose coordinates
   * define the outline of the requested area in WGS 84 longitude/latitude order, as defined
   * by [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946#section-3.1.8).
   */
  geometry: GeoJsonGeometryCollection;

  /**
   * Display name and copyright attribution for the returned area. See `BoundaryProperties`
   * for the per-property shape.
   */
  properties?: BoundaryProperties;
}

/**
 * The `properties` payload of a `Boundary`. Carries the display name of the returned
 * geographical area along with copyright attribution, both an API-wide notice and
 * per-geometry data-provider credits.
 */
model BoundaryProperties {
  /**
   * The display name of the geographical area, for example, `"Bellevue"` for a city boundary.
   */
  name?: string;

  /**
   * The Azure Maps API copyright and usage notice that applies to this response. Distinct
   * from the per-geometry data-provider attributions in `geometriesCopyright`.
   */
  copyright?: string;

  /**
   * A URL to Azure Maps copyright and licensing information for the API and its underlying
   * data sources.
   */
  copyrightUrl?: string;

  /**
   * Per-geometry data-provider attribution. Each entry corresponds positionally to the
   * matching shape in the parent `Boundary.geometry.geometries` array — entry `i` describes
   * the source of geometry `i`.
   */
  geometriesCopyright?: GeometryCopyright[];
}

/**
 * A single per-geometry data-provider attribution entry within
 * `BoundaryProperties.geometriesCopyright`. Identifies the source of one geometry in
 * the parent `Boundary.geometry.geometries` array.
 */
model GeometryCopyright {
  /**
   * An identifier for the data provider that supplied this geometry.
   */
  sourceName?: string;

  /**
   * The human-readable attribution string for the data provider. For example, `"TomTom"`.
   * May be a vendor name or a fuller copyright notice.
   */
  copyright?: string;
}

/**
 * The request body for the `Get Reverse Geocoding Batch` operation. Carries one or more
 * individual reverse-geocoding queries — between 1 and 100, inclusive — that the service
 * processes as a single call and returns as a parallel `batchItems` array on
 * `GeocodingBatchResponse`.
 */
model ReverseGeocodingBatchRequestBody {
  /**
   * The reverse-geocoding queries to process in this batch. Each entry is one independent
   * reverse-geocoding request; the service returns one corresponding entry in
   * `GeocodingBatchResponse.batchItems` per query, in the same order.
   */
  batchItems?: ReverseGeocodingBatchRequestItem[];
}

/**
 * One reverse-geocoding query inside a `ReverseGeocodingBatchRequestBody.batchItems` array.
 * Each item is an independent reverse-geocoding request equivalent to a single call to
 * `Get Reverse Geocoding`, expressed as fields rather than as URL query parameters. Specify
 * the location to reverse-geocode via `coordinates`; optionally narrow the entity types via
 * `resultTypes` and the geopolitical view via `view`.
 */
model ReverseGeocodingBatchRequestItem {
  /**
   * An optional caller-supplied identifier echoed back on the matching response entry as
   * `GeocodingBatchResponseItem.optionalId`. Useful for correlating responses to requests by a
   * stable application-side identifier rather than relying on array position alone.
   */
  optionalId?: string;

  /**
   * The location to reverse-geocode, encoded as `[longitude, latitude]` in WGS 84 order. For
   * example, `[-122.138681, 47.630358]` for a point in Redmond, Washington.
   */
  coordinates?: float64[];

  /**
   * Restricts the response to specific kinds of locations. When omitted, all entity types are
   * eligible. See `ResultTypeEnum` for the value list and the most-specific-wins selection
   * behavior when entities of multiple types match.
   */
  resultTypes?: ResultTypeEnum[];

  /**
   * An [ISO 3166-1 Alpha-2 region/country
   * code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) identifying the region whose
   * geopolitical view should be applied to disputed borders and labels in the response. See
   * [Supported Views](https://aka.ms/AzureMapsLocalizationViews) for the available values.
   */
  view?: string;
}

/**
 * The successful response body returned by `Get Autocomplete`. Encoded as a
 * [`GeoJSON FeatureCollection`](https://www.rfc-editor.org/rfc/rfc7946) whose `features`
 * array contains one `Feature` per autocomplete suggestion, ranked from most to least
 * likely.
 */
model AutocompleteResponse {
  /**
   * The `GeoJSON` object type of a successful `Get Autocomplete` response body. Always
   * `FeatureCollection`, as defined in [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type?: FeatureCollectionEnum;

  /**
   * The array of `GeoJSON Feature` objects returned by the query. Each `Feature` represents a
   * single autocomplete suggestion: its classification (`type`, `typeGroup`), parsed address,
   * and optional place name are exposed via `properties`, and its primary coordinate via
   * `geometry`.
   */
  features?: AutocompleteFeature[];

  /**
   * Contains the URL to fetch the next page of results if the response is paginated. This is
   * useful when the response is too large to be returned in a single call, allowing users to
   * navigate through multiple pages of results.
   */
  nextLink?: string;
}

/**
 * A single entry in the `features` array of an `AutocompleteResponse`, conforming to the
 * [`GeoJSON Feature`](https://www.rfc-editor.org/rfc/rfc7946#section-3.2) object shape.
 * Represents one autocomplete suggestion: classification (`type`, `typeGroup`), parsed
 * address, and optional place name are exposed via `properties`, with a representative
 * coordinate on `geometry` when one is available.
 */
model AutocompleteFeature {
  /**
   * The `GeoJSON` object type. Always `Feature`, as defined in
   * [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type: FeatureTypeEnum;

  /**
   * The coordinate of the autocomplete suggestion as a
   * [`GeoJSON Point`](https://tools.ietf.org/html/rfc7946#section-3.1.2), with values in WGS 84
   * longitude/latitude order. May be omitted when the suggestion does not resolve to a single
   * representative coordinate, for example, broad regional or place-name suggestions.
   */
  geometry?: GeoJsonPoint;

  /**
   * Structured data about the autocomplete suggestion, including its classification, parsed
   * address, and (for `Place`-typed suggestions) the place name. See `AutocompleteProperties`
   * for the per-property shape.
   */
  properties: AutocompleteProperties;
}

/**
 * The `properties` payload of an `AutocompleteFeature`. Carries the result's classification
 * (`typeGroup`, `type`), its parsed address, and (for many `Place`-typed results) a separate
 * display name.
 */
model AutocompleteProperties {
  /**
   * The broad classification of the result as either an address or a named place. See
   * `AutocompleteResultTypeGroupsEnum` for the value list.
   */
  typeGroup?: AutocompleteResultTypeGroupsEnum;

  /**
   * The specific entity kind that the result resolves to. For example, an address, a populated
   * place, a park, or a landmark. See `AutocompleteResultTypeEnum` for the full value list,
   * partitioned into the `Address` and `Place` groups by `AutocompleteResultTypeGroupsEnum`.
   */
  type?: AutocompleteResultTypeEnum;

  /**
   * The address of the autocomplete result, parsed into structured fields. `Address`-typed
   * results typically include street-level detail; `Place`-typed results carry locality,
   * administrative districts, and country/region (street-level fields are usually omitted).
   */
  address?: Address;

  /**
   * The display name of the suggested place. Populated for `Place`-typed results when the name
   * is not already represented in the structured `address` (for example, parks, landmarks, or
   * other named features). Omitted for `Address`-typed results and for `Place`-typed results
   * whose name is already included in `address` (such as a populated place whose name appears in
   * `address.locality`).
   */
  name?: string;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error
 * details for failed operations. (This also follows the OData error response
 * format.).
 */
@error
model ErrorResponse {
  /**
   * The error object.
   */
  error?: ErrorDetail;
}

/**
 * The error detail.
 */
model ErrorDetail {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  details?: ErrorDetail[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  additionalInfo?: ErrorAdditionalInfo[];
}
