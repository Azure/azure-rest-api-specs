import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace MapsSearch;


/**
* Specifies the `GeoJSON` type. The only supported object type is
* `FeatureCollection`. For more information, see [RFC
* 7946](https://www.rfc-editor.org/rfc/rfc7946).
*/
    union FeatureCollectionEnum {
        string,

        /**
* Specifies the `GeoJSON` `FeatureCollection` object type.
*/"FeatureCollection": "FeatureCollection"
    }

/**
* The type of a feature must be Feature.
*/
    union FeatureTypeEnum {
        string,

        /**
* Specifies the `GeoJSON` Feature object type.
*/"Feature": "Feature"
    }

/**
* The level of confidence that the geocoded location result is a match. Use this
* value with the match code to determine for more complete information about the
* match.
* 
* The confidence of a geocoded location is based on many factors including the
* relative importance of the geocoded location and the user’s location, if
* specified.
*/
    union ConfidenceEnum {
        string,

        /**
* If the confidence is set to `High`, one or more strong matches were found.
* Multiple `High` confidence matches are sorted in ranked order by importance
* when applicable. For example, landmarks have importance but addresses do not.
* 
* If a request includes a location or a view, then the ranking may change
* appropriately. For example, a location query for "Paris" returns "Paris,
* France" and "Paris, TX" both with `High` confidence. "Paris, France" is always
* ranked first due to importance unless a user location indicates that the user
* is in or very close to Paris, TX or the map view indicates that the user is
* searching in that area.
*/"High": "High", /**
* In some situations, the returned match may not be at the same level as the
* information provided in the request. For example, a request may specify address
* information and the geocode service may only be able to match a postal code. In
* this case, if the geocode service has a confidence that the postal code matches
* the data, the confidence is set to `Medium` and the match code is set to
* `UpHierarchy` to specify that it could not match all of the information and had
* to search up-hierarchy.
* 
* If the location information in the query is ambiguous, and there is no
* additional information to rank the locations (such as user location or the
* relative importance of the location), the confidence is set to `Medium`. For
* example, a location query for "148th Ave, Bellevue" may return "148th Ave SE"
* and "148th Ave NE" both with `Medium` confidence.
* 
* If the location information in the query does not provide enough information to
* geocode a specific location, a less precise location value may be returned and
* the confidence is set to `Medium`. For example, if an address is provided, but
* a match is not found for the house number, the geocode result with a Roadblock
* entity type may be returned.
*/"Medium": "Medium", /**
* Low
*/"Low": "Low"
    }


    union MatchCodesEnum {
        string,

        /**
* Good
*/"Good": "Good", /**
* Ambiguous
*/"Ambiguous": "Ambiguous", /**
* UpHierarchy
*/"UpHierarchy": "UpHierarchy"
    }

/**
* The method that was used to compute the geocode point.
*/
    union CalculationMethodEnum {
        string,

        /**
* The geocode point was matched to a point on a road using interpolation.
*/"Interpolation": "Interpolation", /**
* The geocode point was matched to a point on a road using interpolation with an
* additional offset to shift the point to the side of the street.
*/"InterpolationOffset": "InterpolationOffset", /**
* The geocode point was matched to the center of a parcel.
*/"Parcel": "Parcel", /**
* The geocode point was matched to the rooftop of a building.
*/"Rooftop": "Rooftop"
    }


    union UsageTypeEnum {
        string,

        /**
* Display
*/"Display": "Display", /**
* Route
*/"Route": "Route"
    }


    union BoundaryResultTypeEnum {
        string,

        /**
* Country or region.
*/"countryRegion": "countryRegion", /**
* First administrative level within the country/region level, such as a state or
* a province.
*/"adminDistrict": "adminDistrict", /**
* Second administrative level within the country/region level, such as a county.
*/"adminDistrict2": "adminDistrict2", /**
* The smallest post code category, such as a zip code.
*/"postalCode": "postalCode", /**
* The next largest post code category after postalCode that is created by
* aggregating postalCode areas.
*/"postalCode2": "postalCode2", /**
* The next largest post code category after postalCode2 that is created by
* aggregating postalCode2 areas.
*/"postalCode3": "postalCode3", /**
* The next largest post code category after postalCode3 that is created by
* aggregating postalCode3 areas.
*/"postalCode4": "postalCode4", /**
* A section of a populated place that is typically well-known, but often with
* indistinct boundaries.
*/"neighborhood": "neighborhood", /**
* A concentrated area of human settlement, such as a city, town or village.
*/"locality": "locality"
    }


    union ResolutionEnum {
        string,

        /**
* Return the boundary geometry with the least amount of points.
*/"small": "small", /**
* Return the boundary geometry with more or the same amount of points as small.
*/"medium": "medium", /**
* Return the boundary geometry with more or the same amount of points as medium.
*/"large": "large", /**
* Return the boundary geometry with more or the same amount of points as large.
*/"huge": "huge"
    }


    union ReverseGeocodingResultTypeEnum {
        string,

        /**
* Address
*/"Address": "Address", /**
* Neighborhood
*/"Neighborhood": "Neighborhood", /**
* PopulatedPlace
*/"PopulatedPlace": "PopulatedPlace", /**
* Postcode1
*/"Postcode1": "Postcode1", /**
* AdminDivision1
*/"AdminDivision1": "AdminDivision1", /**
* AdminDivision2
*/"AdminDivision2": "AdminDivision2", /**
* CountryRegion
*/"CountryRegion": "CountryRegion"
    }


    union ResultTypeEnum {
        string,

        /**
* Address
*/"Address": "Address", /**
* Neighborhood
*/"Neighborhood": "Neighborhood", /**
* PopulatedPlace
*/"PopulatedPlace": "PopulatedPlace", /**
* Postcode1
*/"Postcode1": "Postcode1", /**
* AdminDivision1
*/"AdminDivision1": "AdminDivision1", /**
* AdminDivision2
*/"AdminDivision2": "AdminDivision2", /**
* CountryRegion
*/"CountryRegion": "CountryRegion"
    }

/**
* Address or Place
*/
    union AutocompleteResultTypeGroupsEnum {
        string,

        /**
* A specific address location. Supported types are: 
* 
* - Address
* - RoadBlock
* 
* 
*/"Address": "Address", /**
* All other types belong to the Place type group. These may include entities such
* as AdminDivision1, Neighborhood, PopulatedPlace, and more.
*/"Place": "Place"
    }

/**
* Type of suggestion
*/
@added(Versions.v2025_06_01_preview)
    union AutocompleteResultTypeEnum {
        string,

        /**
* Address
*/"Address": "Address", /**
* AdminDivision1
*/"AdminDivision1": "AdminDivision1", /**
* AdminDivision2
*/"AdminDivision2": "AdminDivision2", /**
* AdminDivision3
*/"AdminDivision3": "AdminDivision3", /**
* AdministrativeBuilding
*/"AdministrativeBuilding": "AdministrativeBuilding", /**
* Airport
*/"Airport": "Airport", /**
* AirportTerminal
*/"AirportTerminal": "AirportTerminal", /**
* AmusementPark
*/"AmusementPark": "AmusementPark", /**
* AncientSite
*/"AncientSite": "AncientSite", /**
* Aquarium
*/"Aquarium": "Aquarium", /**
* Archipelago
*/"Archipelago": "Archipelago", /**
* Basin
*/"Basin": "Basin", /**
* Battlefield
*/"Battlefield": "Battlefield", /**
* Bay
*/"Bay": "Bay", /**
* Beach
*/"Beach": "Beach", /**
* Bridge
*/"Bridge": "Bridge", /**
* BusinessStructure
*/"BusinessStructure": "BusinessStructure", /**
* Camp
*/"Camp": "Camp", /**
* Canal
*/"Canal": "Canal", /**
* Casino
*/"Casino": "Casino", /**
* Castle
*/"Castle": "Castle", /**
* Cave
*/"Cave": "Cave", /**
* Cemetery
*/"Cemetery": "Cemetery", /**
* Channel
*/"Channel": "Channel", /**
* Church
*/"Church": "Church", /**
* Cliff
*/"Cliff": "Cliff", /**
* Coast
*/"Coast": "Coast", /**
* CommunityCenter
*/"CommunityCenter": "CommunityCenter", /**
* Continent
*/"Continent": "Continent", /**
* CountryRegion
*/"CountryRegion": "CountryRegion", /**
* Crater
*/"Crater": "Crater", /**
* CulturalRegion
*/"CulturalRegion": "CulturalRegion", /**
* Dam
*/"Dam": "Dam", /**
* Delta
*/"Delta": "Delta", /**
* Desert
*/"Desert": "Desert", /**
* DrainageBasin
*/"DrainageBasin": "DrainageBasin", /**
* Dune
*/"Dune": "Dune", /**
* FacilityStructure
*/"FacilityStructure": "FacilityStructure", /**
* FerryTerminal
*/"FerryTerminal": "FerryTerminal", /**
* FinancialStructure
*/"FinancialStructure": "FinancialStructure", /**
* FireStation
*/"FireStation": "FireStation", /**
* Forest
*/"Forest": "Forest", /**
* Fort
*/"Fort": "Fort", /**
* Garden
*/"Garden": "Garden", /**
* Geyser
*/"Geyser": "Geyser", /**
* Glacier
*/"Glacier": "Glacier", /**
* GolfCourse
*/"GolfCourse": "GolfCourse", /**
* GreaterPopulatedPlace
*/"GreaterPopulatedPlace": "GreaterPopulatedPlace", /**
* HigherEducationFacility
*/"HigherEducationFacility": "HigherEducationFacility", /**
* HistoricalSite
*/"HistoricalSite": "HistoricalSite", /**
* Hospital
*/"Hospital": "Hospital", /**
* HotSpring
*/"HotSpring": "HotSpring", /**
* Ice
*/"Ice": "Ice", /**
* IndigenousPeoplesReserve
*/"IndigenousPeoplesReserve": "IndigenousPeoplesReserve", /**
* IndustrialStructure
*/"IndustrialStructure": "IndustrialStructure", /**
* Island
*/"Island": "Island", /**
* Isthmus
*/"Isthmus": "Isthmus", /**
* Lake
*/"Lake": "Lake", /**
* LandArea
*/"LandArea": "LandArea", /**
* Landform
*/"Landform": "Landform", /**
* LandmarkBuilding
*/"LandmarkBuilding": "LandmarkBuilding", /**
* Library
*/"Library": "Library", /**
* Lighthouse
*/"Lighthouse": "Lighthouse", /**
* Marina
*/"Marina": "Marina", /**
* Market
*/"Market": "Market", /**
* MedicalStructure
*/"MedicalStructure": "MedicalStructure", /**
* MetroStation
*/"MetroStation": "MetroStation", /**
* MilitaryBase
*/"MilitaryBase": "MilitaryBase", /**
* Mission
*/"Mission": "Mission", /**
* Monument
*/"Monument": "Monument", /**
* Mosque
*/"Mosque": "Mosque", /**
* Mountain
*/"Mountain": "Mountain", /**
* MountainRange
*/"MountainRange": "MountainRange", /**
* MultiModalStation
*/"MultiModalStation": "MultiModalStation", /**
* Museum
*/"Museum": "Museum", /**
* NauticalStructure
*/"NauticalStructure": "NauticalStructure", /**
* Neighborhood
*/"Neighborhood": "Neighborhood", /**
* Oasis
*/"Oasis": "Oasis", /**
* ObservationPoint
*/"ObservationPoint": "ObservationPoint", /**
* Ocean
*/"Ocean": "Ocean", /**
* OfficeBuilding
*/"OfficeBuilding": "OfficeBuilding", /**
* Other
*/"Other": "Other", /**
* Park
*/"Park": "Park", /**
* ParkingStructure
*/"ParkingStructure": "ParkingStructure", /**
* Pass
*/"Pass": "Pass", /**
* Peninsula
*/"Peninsula": "Peninsula", /**
* Plain
*/"Plain": "Plain", /**
* Planet
*/"Planet": "Planet", /**
* Plateau
*/"Plateau": "Plateau", /**
* Playground
*/"Playground": "Playground", /**
* PlayingField
*/"PlayingField": "PlayingField", /**
* Pole
*/"Pole": "Pole", /**
* PoliticalUnit
*/"PoliticalUnit": "PoliticalUnit", /**
* PopulatedPlace
*/"PopulatedPlace": "PopulatedPlace", /**
* Port
*/"Port": "Port", /**
* Postcode1
*/"Postcode1": "Postcode1", /**
* Promontory
*/"Promontory": "Promontory", /**
* RaceTrack
*/"RaceTrack": "RaceTrack", /**
* RailwayStation
*/"RailwayStation": "RailwayStation", /**
* Reef
*/"Reef": "Reef", /**
* ReligiousStructure
*/"ReligiousStructure": "ReligiousStructure", /**
* Reserve
*/"Reserve": "Reserve", /**
* ResidentialStructure
*/"ResidentialStructure": "ResidentialStructure", /**
* River
*/"River": "River", /**
* RoadBlock
*/"RoadBlock": "RoadBlock", /**
* Ruin
*/"Ruin": "Ruin", /**
* ScientificResearchBase
*/"ScientificResearchBase": "ScientificResearchBase", /**
* Sea
*/"Sea": "Sea", /**
* SeaplaneLandingArea
*/"SeaplaneLandingArea": "SeaplaneLandingArea", /**
* Shrine
*/"Shrine": "Shrine", /**
* SkiArea
*/"SkiArea": "SkiArea", /**
* Spring
*/"Spring": "Spring", /**
* Stadium
*/"Stadium": "Stadium", /**
* StatisticalDistrict
*/"StatisticalDistrict": "StatisticalDistrict", /**
* Temple
*/"Temple": "Temple", /**
* Theater
*/"Theater": "Theater", /**
* TouristRailway
*/"TouristRailway": "TouristRailway", /**
* TouristStructure
*/"TouristStructure": "TouristStructure", /**
* Trailhead
*/"Trailhead": "Trailhead", /**
* TransportationStructure
*/"TransportationStructure": "TransportationStructure", /**
* Tunnel
*/"Tunnel": "Tunnel", /**
* Valley
*/"Valley": "Valley", /**
* Volcano
*/"Volcano": "Volcano", /**
* Walkway
*/"Walkway": "Walkway", /**
* Wall
*/"Wall": "Wall", /**
* Waterfall
*/"Waterfall": "Waterfall", /**
* WaterFeature
*/"WaterFeature": "WaterFeature", /**
* Wetland
*/"Wetland": "Wetland", /**
* Winery
*/"Winery": "Winery", /**
* Zoo
*/"Zoo": "Zoo"
    }

/**
* Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
* types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
* GeometryCollection, Feature and FeatureCollection.
*/
    enum GeoJsonObjectType {
        /**
* `GeoJSON Point` geometry.
*/"GeoJsonPoint": "Point", /**
* `GeoJSON MultiPoint` geometry.
*/"GeoJsonMultiPoint": "MultiPoint", /**
* `GeoJSON LineString` geometry.
*/"GeoJsonLineString": "LineString", /**
* `GeoJSON MultiLineString` geometry.
*/"GeoJsonMultiLineString": "MultiLineString", /**
* `GeoJSON Polygon` geometry.
*/"GeoJsonPolygon": "Polygon", /**
* `GeoJSON MultiPolygon` geometry.
*/"GeoJsonMultiPolygon": "MultiPolygon", /**
* `GeoJSON GeometryCollection` geometry.
*/"GeoJsonGeometryCollection": "GeometryCollection", /**
* `GeoJSON Feature` object.
*/"GeoJsonFeature": "Feature", /**
* `GeoJSON FeatureCollection` object.
*/"GeoJsonFeatureCollection": "FeatureCollection"
    }




/**
* This object is returned from a successful Geocoding call
*/
model GeocodingResponse {
/**
* Specifies the `GeoJSON` type. The only supported object type is
* `FeatureCollection`. For more information, see [RFC
* 7946](https://www.rfc-editor.org/rfc/rfc7946).
*/
"type"?: FeatureCollectionEnum;
"features"?: FeaturesItem[];
/**
* The is the link to the next page of the features returned. If it's the last
* page, no this field.
*/
"nextLink"?: string;
}


model FeaturesItem {
/**
* The type of a feature must be Feature.
*/
"type"?: FeatureTypeEnum;
/**
* ID for feature returned
*/
"id"?: string;
"properties"?: FeaturesItemProperties;
/**
* A valid `GeoJSON Point` geometry type. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.1.2) for details.
*/
"geometry": GeoJsonPoint;
/**
* Bounding box. Projection used - EPSG:3857. Please refer to [RFC
* 7946](https://datatracker.ietf.org/doc/html/rfc7946#section-5) for details.
*/
"bbox"?: float64[];
}


model FeaturesItemProperties {
/**
* One of: 
* * Address
* * RoadBlock
* * RoadIntersection
* * Neighborhood
* * PopulatedPlace
* * Postcode1
* * AdminDivision1
* * AdminDivision2
* * CountryRegion
*/
"type"?: string;
/**
* The level of confidence that the geocoded location result is a match. Use this
* value with the match code to determine for more complete information about the
* match.
* 
* The confidence of a geocoded location is based on many factors including the
* relative importance of the geocoded location and the user’s location, if
* specified.
*/
"confidence"?: ConfidenceEnum;
/**
* One or more match code values that represent the geocoding level for each
* location in the response.
* 
* For example, a geocoded location with match codes of `Good` and `Ambiguous`
* means that more than one geocode location was found for the location
* information and that the geocode service did not have search up-hierarchy to
* find a match.
* 
* Similarly, a geocoded location with match codes of `Ambiguous` and
* `UpHierarchy` implies that a geocode location could not be found that matched
* all the provided location information, so the geocode service had to search
* up-hierarchy and found multiple matches at that level. An example of up an
* `Ambiguous` and `UpHierarchy` result is when you provide complete address
* information, but the geocode service cannot locate a match for the street
* address and instead returns information for more than one RoadBlock value.
* 
* The possible values are:
* 
* `Good`: The location has only one match or all returned matches are considered
* strong matches. For example, a query for New York returns several Good matches.
* 
* `Ambiguous`: The location is one of a set of possible matches. For example,
* when you query for the street address 128 Main St., the response may return two
* locations for 128 North Main St. and 128 South Main St. because there is not
* enough information to determine which option to choose.
* 
* `UpHierarchy`: The location represents a move up the geographic hierarchy. This
* occurs when a match for the location request was not found, so a less precise
* result is returned. For example, if a match for the requested address cannot be
* found, then a match code of `UpHierarchy` with a RoadBlock entity type may be
* returned.
*/
"matchCodes"?: MatchCodesEnum[];
/**
* The address of the result
*/
"address"?: Address;
/**
* A collection of geocode points that differ in how they were calculated and
* their suggested use.
*/
"geocodePoints"?: GeocodePointsItem[];
}

/**
* The address of the result
*/
model Address {
/**
* AddressLine that includes street name and number
*/
"addressLine"?: string;
/**
* Locality property
*/
"locality"?: string;
/**
* Neighborhood property
*/
"neighborhood"?: string;
/**
* The subdivision name in the country or region for an address. This element is
* typically treated as the first order administrative subdivision, but in some
* cases it also contains the second, third, or fourth order subdivision in a
* country, dependency, or region.
*/
"adminDistricts"?: AddressAdminDistrictsItem[];
/**
* Postal code property
*/
"postalCode"?: string;
/**
* Country or region with its name and ISO code.
*/
"countryRegion"?: AddressCountryRegion;
/**
* Formatted address property
*/
"formattedAddress"?: string;
/**
* The name of the street from formattedAddress
*/
"streetName"?: string;
/**
* The number in the street, if available, from formattedAddress
*/
"streetNumber"?: string;
/**
* The address of the result.
*/
"intersection"?: Intersection;
}


model AddressAdminDistrictsItem {
/**
* The name for the corresponding adminDistrict field, 
* For adminDistrict[0], this could be full name of state such as Washington, 
* For adminDistrict[1], this could be the full name of the county
*/
"name"?: string;
/**
* The short name for the corresponding adminDistrict field, 
* For adminDistrict[0], this could be short name of state such as WA, 
* For adminDistrict[1], this could be the short name of the county
*/
"shortName"?: string;
}

/**
* Country or region with its name and ISO code.
*/
model AddressCountryRegion {
/**
* ISO of country/region
*/
"ISO"?: string;
/**
* name of country/region
*/
"name"?: string;
}

/**
* The address of the result.
*/
model Intersection {
/**
* Primary street for the location.
*/
"baseStreet"?: string;
/**
* The first intersecting street.
*/
"secondaryStreet1"?: string;
/**
* If any, the second intersecting street.
*/
"secondaryStreet2"?: string;
/**
* Type of intersection.
*/
"intersectionType"?: string;
/**
* Complete name of the intersection.
*/
"displayName"?: string;
}


model GeocodePointsItem {
/**
* A valid `GeoJSON Point` geometry type. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.1.2) for details.
*/
"geometry"?: GeoJsonPoint;
/**
* The method that was used to compute the geocode point.
*/
"calculationMethod"?: CalculationMethodEnum;
/**
* The best use for the geocode point.
* Each geocode point is defined as a `Route` point, a `Display` point or both.
* Use `Route` points if you are creating a route to the location. Use `Display`
* points if you are showing the location on a map. For example, if the location
* is a park, a `Route` point may specify an entrance to the park where you can
* enter with a car, and a `Display` point may be a point that specifies the
* center of the park.
*/
"usageTypes"?: UsageTypeEnum[];
}

/**
* A valid `GeoJSON Point` geometry type. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.1.2) for details.
*/
model GeoJsonPoint extends GeoJsonGeometry {
...GeoJsonPointData;
/**
* Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
* types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
* GeometryCollection, Feature and FeatureCollection.
*/
"type": "Point";
}

/**
* A valid `GeoJSON` geometry object. The type must be one of the seven valid
* GeoJSON geometry types - Point, MultiPoint, LineString, MultiLineString,
* Polygon, MultiPolygon and GeometryCollection. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.1) for details.
*/
@discriminator("type")
model GeoJsonGeometry extends GeoJsonObject {
}

/**
* A valid `GeoJSON` object. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3) for details.
*/
@discriminator("type")
model GeoJsonObject {
/**
* Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
* types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
* GeometryCollection, Feature and FeatureCollection.
*/
"type": GeoJsonObjectType;
/**
* Bounding box. Projection used - EPSG:3857. Please refer to [RFC
* 7946](https://datatracker.ietf.org/doc/html/rfc7946#section-5) for details.
*/
"bbox"?: float64[];
}

/**
* Data contained by a `GeoJson Point`.
*/
model GeoJsonPointData {
/**
* A `Position` is an array of numbers with two or more elements. The first two
* elements are _longitude_ and _latitude_, precisely in that order.
* _Altitude/Elevation_ is an optional third element. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.1.1) for details.
*/
"coordinates": float64[];
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
"error"?: ErrorDetail;
}

/**
* The error detail.
*/
model ErrorDetail {
/**
* The error code.
*/
@visibility(Lifecycle.Read)
"code"?: string;
/**
* The error message.
*/
@visibility(Lifecycle.Read)
"message"?: string;
/**
* The error target.
*/
@visibility(Lifecycle.Read)
"target"?: string;
/**
* The error details.
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"details"?: ErrorDetail[];
/**
* The error additional info.
*/
@visibility(Lifecycle.Read)
@identifiers(#[])
"additionalInfo"?: ErrorAdditionalInfo[];
}

/**
* The resource management error additional info.
*/
model ErrorAdditionalInfo {
/**
* The additional info type.
*/
@visibility(Lifecycle.Read)
"type"?: string;
/**
* The additional info.
*/
@visibility(Lifecycle.Read)
"info"?: unknown;
}

/**
* The list of address geocoding queries/requests to process. The list can contain
* a max of 100 queries and must contain at least 1 query.
*/
model GeocodingBatchRequestBody {
/**
* The list of queries to process.
*/
"batchItems"?: GeocodingBatchRequestItem[];
}

/**
* Batch Query object
*/
model GeocodingBatchRequestItem {
/**
* id of the request which would show in corresponding batchItem
*/
"optionalId"?: string;
/**
* Maximum number of responses that will be returned. Default: 5, minimum: 1 and
* maximum: 20.
*/
@maxValue(20)
@minValue(1)
"top"?: int32 = 5;
/**
* A string that contains information about a location, such as an address or
* landmark name.
*/
"query"?: string;
/**
* The official street line of an address relative to the area, as specified by
* the locality, or postalCode, properties. Typical use of this element would be
* to provide a street address or any official address.
* 
* This parameter should not be used when the `query` parameter is included in the
* request.
*/
"addressLine"?: string;
/**
* Signal for the geocoding result to an [ISO 3166-1 Alpha-2 region/country
* code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) that is specified e.g.
* FR.
* 
* This parameter should not be used when the `query` parameter is included in the
* request.
*/
"countryRegion"?: string;
/**
* A rectangular area on the earth defined as a bounding box object. The sides of
* the rectangles are defined by longitude and latitude values. For more
* information, see Location and Area Types. When you specify this parameter, the
* geographical area is taken into account when computing the results of a
* location query.
* 
* Example: [lon1, lat1, lon2, lat2]
*/
"bbox"?: float64[];
/**
* A string that specifies an [ISO 3166-1 Alpha-2 region/country
* code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). This will alter
* Geopolitical disputed borders and labels to align with the specified user
* region.
*/
"view"?: string = "auto";
/**
* A point on the earth specified as a longitude and latitude. When you specify
* this parameter, the user’s location is taken into account and the results
* returned may be more relevant to the user. Example: [lon, lat]
*/
"coordinates"?: float64[];
/**
* The country subdivision portion of an address, such as WA.
* 
* This parameter should not be used when the `query` parameter is included in the
* request.
*/
"adminDistrict"?: string;
/**
* The county for the structured address, such as King.
* 
* This parameter should not be used when the `query` parameter is included in the
* request.
*/
"adminDistrict2"?: string;
/**
* The named area for the structured address.
* 
* This parameter should not be used when the `query` parameter is included in the
* request.
*/
"adminDistrict3"?: string;
/**
* The locality portion of an address, such as Seattle.
* 
* This parameter should not be used when the `query` parameter is included in the
* request.
*/
"locality"?: string;
/**
* The postal code portion of an address.
* 
* This parameter should not be used when the `query` parameter is included in the
* request.
*/
"postalCode"?: string;
}

/**
* This object is returned from a successful Geocoding Batch service call.
*/
model GeocodingBatchResponse {
/**
* Summary for the batch request
*/
"summary"?: GeocodingBatchResponseSummary;
/**
* Array containing the batch results.
*/
"batchItems"?: GeocodingBatchResponseItem[];
/**
* The is the link to the next page of the features returned. If it's the last
* page, no this field.
*/
"nextLink"?: string;
}

/**
* Summary for the batch request
*/
model GeocodingBatchResponseSummary {
/**
* Number of successful requests in the batch
*/
"successfulRequests"?: int32;
/**
* Total number of requests in the batch
*/
"totalRequests"?: int32;
}


model GeocodingBatchResponseItem {
/**
* id of the batchItem which would be the same as the id in the request
*/
"optionalId"?: string;
/**
* Specifies the `GeoJSON` type. The only supported object type is
* `FeatureCollection`. For more information, see [RFC
* 7946](https://www.rfc-editor.org/rfc/rfc7946).
*/
"type"?: FeatureCollectionEnum;
"features"?: FeaturesItem[];
/**
* The is the link to the next page of the features returned. If it's the last
* page, no this field.
*/
"nextLink"?: string;
/**
* The error detail.
*/
"error"?: ErrorDetail;
}

/**
* `GeoJSON GeocodingFeature` object that describe the boundaries of a
* geographical area. Geometry of the feature is described with `GeoJSON
* GeometryCollection`.
* 
* Please note, the service typically returns a GeometryCollection with Polygon or
* MultiPolygon sub-types.
*/
model Boundary {
/**
* The type of a feature must be Feature.
*/
"type"?: FeatureTypeEnum;
/**
* A valid `GeoJSON GeometryCollection` object type. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.1.8) for details.
*/
"geometry": GeoJsonGeometryCollection;
/**
* Properties of a Boundary object.
*/
"properties"?: BoundaryProperties;
}

/**
* A valid `GeoJSON GeometryCollection` object type. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.1.8) for details.
*/
model GeoJsonGeometryCollection extends GeoJsonGeometry {
...GeoJsonGeometryCollectionData;
/**
* Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
* types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
* GeometryCollection, Feature and FeatureCollection.
*/
"type": "GeometryCollection";
}


model GeoJsonGeometryCollectionData {
/**
* Contains a list of valid `GeoJSON` geometry objects. **Note** that coordinates
* in GeoJSON are in x, y order (longitude, latitude).
*/
"geometries": GeoJsonGeometry[];
}

/**
* Properties of a Boundary object.
*/
model BoundaryProperties {
/**
* The name associated with the geographical area.
*/
"name"?: string;
/**
* The copyright string.
*/
"copyright"?: string;
/**
* A URL that lists many of the data providers for Azure Maps and their related
* copyright information.
*/
"copyrightURL"?: string;
/**
* A collection of copyright information for each geometry of the Boundary object
* in the same order they appear.
*/
"geometriesCopyright"?: GeometryCopyright[];
}

/**
* Copyright information of a geometry of a Boundary object.
*/
model GeometryCopyright {
/**
* The name of the data provider
*/
"sourceName"?: string;
/**
* The copyright string for the data provider
*/
"copyright"?: string;
}

/**
* The list of reverse geocoding queries/requests to process. The list can contain
* a max of 100 queries and must contain at least 1 query.
*/
model ReverseGeocodingBatchRequestBody {
/**
* The list of queries to process.
*/
"batchItems"?: ReverseGeocodingBatchRequestItem[];
}

/**
* Batch Query object
*/
model ReverseGeocodingBatchRequestItem {
/**
* id of the request which would show in corresponding batchItem
*/
"optionalId"?: string;
/**
* The coordinates of the location that you want to reverse geocode. Example:
* [lon,lat]
*/
"coordinates"?: float64[];
/**
* Specify entity types that you want in the response. Only the types you specify
* will be returned. If the point cannot be mapped to the entity types you
* specify, no location information is returned in the response.
* Default value is all possible entities.
* A comma separated list of entity types selected from the following options.
* 
* - Address
* - Neighborhood
* - PopulatedPlace
* - Postcode1
* - AdminDivision1
* - AdminDivision2
* - CountryRegion
* 
* These entity types are ordered from the most specific entity to the least
* specific entity. When entities of more than one entity type are found, only the
* most specific entity is returned. For example, if you specify Address and
* AdminDistrict1 as entity types and entities were found for both types, only the
* Address entity information is returned in the response.
*/
"resultTypes"?: ResultTypeEnum[];
/**
* A string that specifies an [ISO 3166-1 Alpha-2 region/country
* code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). This will alter
* Geopolitical disputed borders and labels to align with the specified user
* region.
*/
"view"?: string;
}

/**
* This object is returned from a successful autocomplete call.
*/
@added(Versions.v2025_06_01_preview)
model AutocompleteResponse {
/**
* Specifies the `GeoJSON` type. The only supported object type is
* `FeatureCollection`. For more information, see [RFC
* 7946](https://www.rfc-editor.org/rfc/rfc7946).
*/
"type"?: FeatureCollectionEnum;
"features"?: AutocompleteFeature[];
/**
* The is the link to the next page of the features returned. If it's the last
* page, no this field.
*/
"nextLink"?: string;
}

/**
* Features of Autocomplete Result
*/
@added(Versions.v2025_06_01_preview)
model AutocompleteFeature {
/**
* Specifies the `GeoJSON` type. The only supported object type is Feature. For
* more information, see [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
*/
"type": FeatureTypeEnum;
/**
* A valid `GeoJSON Point` geometry type. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.1.2) for details.
*/
"geometry"?: GeoJsonPoint;
/**
* Properties of Autocomplete Result
*/
"properties": AutocompleteProperties;
}

/**
* Properties of Autocomplete Result
*/
@added(Versions.v2025_06_01_preview)
model AutocompleteProperties {
/**
* Address or Place
*/
"typeGroup"?: AutocompleteResultTypeGroupsEnum;
/**
* Type of suggestion
*/
"type"?: AutocompleteResultTypeEnum;
/**
* The address of the result
*/
"address"?: Address;
/**
* The name of the place. This field will not appear if the returned type is
* Address.
*/
"name"?: string;
}

/**
* A valid `GeoJSON MultiPoint` geometry type. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.1.3) for details.
*/
model GeoJsonMultiPoint extends GeoJsonGeometry {
...GeoJsonMultiPointData;
/**
* Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
* types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
* GeometryCollection, Feature and FeatureCollection.
*/
"type": "MultiPoint";
}

/**
* Data contained by a `GeoJson MultiPoint`.
*/
model GeoJsonMultiPointData {
/**
* Coordinates for the `GeoJson MultiPoint` geometry.
*/
"coordinates": float64[][];
}

/**
* A valid `GeoJSON LineString` geometry type. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.1.4) for details.
*/
model GeoJsonLineString extends GeoJsonGeometry {
...GeoJsonLineStringData;
/**
* Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
* types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
* GeometryCollection, Feature and FeatureCollection.
*/
"type": "LineString";
}


model GeoJsonLineStringData {
/**
* Coordinates for the `GeoJson LineString` geometry.
*/
"coordinates": float64[][];
}

/**
* A valid `GeoJSON MultiLineString` geometry type. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.1.5) for details.
*/
model GeoJsonMultiLineString extends GeoJsonGeometry {
...GeoJsonMultiLineStringData;
/**
* Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
* types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
* GeometryCollection, Feature and FeatureCollection.
*/
"type": "MultiLineString";
}


model GeoJsonMultiLineStringData {
/**
* Coordinates for the `GeoJson MultiLineString` geometry.
*/
"coordinates": float64[][][];
}

/**
* A valid `GeoJSON Polygon` geometry type. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.1.6) for details.
*/
model GeoJsonPolygon extends GeoJsonGeometry {
...GeoJsonPolygonData;
/**
* Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
* types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
* GeometryCollection, Feature and FeatureCollection.
*/
"type": "Polygon";
}


model GeoJsonPolygonData {
/**
* Coordinates for the `GeoJson Polygon` geometry type.
*/
"coordinates": float64[][][];
}

/**
* A valid `GeoJSON MultiPolygon` object type. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.1.7) for details.
*/
model GeoJsonMultiPolygon extends GeoJsonGeometry {
...GeoJsonMultiPolygonData;
/**
* Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
* types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
* GeometryCollection, Feature and FeatureCollection.
*/
"type": "MultiPolygon";
}


model GeoJsonMultiPolygonData {
/**
* Contains a list of valid `GeoJSON Polygon` objects. **Note** that coordinates
* in GeoJSON are in x, y order (longitude, latitude).
*/
"coordinates": float64[][][][];
}

/**
* A valid `GeoJSON Feature` object type. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.2) for details.
*/
model GeoJsonFeature extends GeoJsonObject {
...GeoJsonFeatureData;
/**
* Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
* types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
* GeometryCollection, Feature and FeatureCollection.
*/
"type": "Feature";
}


model GeoJsonFeatureData {
/**
* A valid `GeoJSON` geometry object. The type must be one of the seven valid
* GeoJSON geometry types - Point, MultiPoint, LineString, MultiLineString,
* Polygon, MultiPolygon and GeometryCollection. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.1) for details.
*/
"geometry": GeoJsonGeometry;
/**
* Properties can contain any additional metadata about the `Feature`. Value can
* be any JSON object or a JSON null value
*/
"properties"?: unknown;
/**
* Identifier for the feature.
*/
"id"?: string;
/**
* The type of the feature. The value depends on the data model the current
* feature is part of. Some data models may have an empty value.
*/
"featureType"?: string;
}

/**
* A valid `GeoJSON FeatureCollection` object type. Please refer to [RFC
* 7946](https://tools.ietf.org/html/rfc7946#section-3.3) for details.
*/
model GeoJsonFeatureCollection extends GeoJsonObject {
...GeoJsonFeatureCollectionData;
/**
* Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
* types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
* GeometryCollection, Feature and FeatureCollection.
*/
"type": "FeatureCollection";
}


model GeoJsonFeatureCollectionData {
/**
* Contains a list of valid `GeoJSON Feature` objects.
*/
"features": GeoJsonFeature[];
}