import "@typespec/rest";
import "@typespec/http";
import "./common/common.tsp";

namespace MapsTraffic;

/**
 * Specifies the type of traffic incident. This can be used to request and
 * differentiate between various types of incidents.
 */
union IncidentType {
  string,

  /**
   * Accident
   */
  Accident: "Accident",

  /**
   * Congestion
   */
  Congestion: "Congestion",

  /**
   * DisabledVehicle
   */
  DisabledVehicle: "DisabledVehicle",

  /**
   * Miscellaneous
   */
  Miscellaneous: "Miscellaneous",

  /**
   * RoadHazard
   */
  RoadHazard: "RoadHazard",

  /**
   * Construction
   */
  Construction: "Construction",

  /**
   * Weather
   */
  Weather: "Weather",
}

/**
 * Specifies the `GeoJSON` type. The only supported object type is
 * `FeatureCollection`. For more information, see [RFC
 * 7946](https://www.rfc-editor.org/rfc/rfc7946).
 */
union FeatureTypeEnum {
  string,

  /**
   * Specifies the `GeoJSON` `FeatureCollection` object type.
   */
  FeatureCollection: "FeatureCollection",
}

/**
 * Specifies the `GeoJSON` type. The only supported object type is Feature. For
 * more information, see [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
 */
union FeaturesItemTypeEnum {
  string,

  /**
   * Specifies the `GeoJSON` Feature object type.
   */
  Feature: "Feature",
}

/**
 * A GeoJSON feature collection object that contains a list of traffic incidents
 * features.
 */
model TrafficIncidentResponse {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is
   * `FeatureCollection`. For more information, see [RFC
   * 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type?: FeatureTypeEnum;

  /**
   * `GeoJSON` feature object that contains Geometry object and additional
   * properties. Refer to [RFC 7946, Section
   * 3.2](https://www.rfc-editor.org/rfc/rfc7946#section-3.2) for details.
   */
  features?: TrafficIncidentFeaturesItem[];
}

/**
 * GeoJSON feature object that contains Geometry object and additional properties
 * of traffic incidents.
 */
model TrafficIncidentFeaturesItem {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is Feature. For
   * more information, see [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type?: FeaturesItemTypeEnum;

  /**
   * A unique ID for the incident.
   */
  id?: int64;

  /**
   * A valid `GeoJSON Point` geometry type. Please refer to [RFC
   * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.2) for details.
   */
  geometry?: GeoJsonPoint;

  /**
   * Specifies detailed information about the traffic incidents.
   */
  properties?: TrafficIncidentFeatureProperties;
}

/**
 * Specifies detailed information about the traffic incidents.
 */
model TrafficIncidentFeatureProperties {
  /**
   * A description of the incident that includes the road name and the event
   * impacting the traffic flow.
   *
   *  Examples:
   *
   * • W 95th St between Switzer Rd and Bluejacket Dr - construction
   *
   * • WB Johnson Dr at I-435 - bridge repair
   */
  description?: string;

  /**
   * The date and time in UTC when the incident occurred, formatted as a dateTime
   * value as defined in [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
   */
  startTime?: string;

  /**
   * The date and time in UTC when the traffic incident will end, formatted as a
   * dateTime value as defined in [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
   */
  endTime?: string;

  /**
   * The date and time in UTC when the incident information was last updated,
   * formatted as a dateTime value as defined in [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
   */
  lastModifiedTime?: string;

  /**
   * A value of `true` indicates that there is a road closure.
   */
  isRoadClosed?: boolean;

  /**
   * Specifies the level of importance of the incident.
   *
   *  - 0: Unknown
   *
   *  - 1: Minor
   *
   *  - 2: Moderate
   *
   *  - 3: Major
   *
   * - 4: Undefined (used for road closures and other indefinite delays)
   */
  severity?: int32;

  /**
   * Specifies the type of traffic incident. This can be used to request and
   * differentiate between various types of incidents.
   */
  incidentType?: IncidentType;

  /**
   * Specifies the road names and direction of affected roads.
   */
  title?: string;

  /**
   * The delay caused by the incident in seconds. If no delay or not applicable, it
   * returns zero.
   */
  delay?: float64;

  /**
   * A GeoJson Point object that specified the end location of a traffic incident
   * such as end of a construction zone.
   *
   *  This location is part of the incident properties object and by default, cannot
   * be interpreted by parsers for display on the map.
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API contract."
  endPoint?: Record<unknown>;

  /**
   * A value of `true` indicates that the area of road covered by this incident is
   * experiencing abnormal traffic conditions resulting in non-typical delays.
   */
  isTrafficJam?: boolean;
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
