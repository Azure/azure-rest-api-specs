import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using Azure.Core;

namespace MapsRoute;

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
 * Waypoint type on the route. It can be a stop or an intermediate location that
 * the route must pass through.
 */
union InputWaypointTypeEnum {
  string,

  /**
   * A waypoint is a specific location or point along a route or trip that serves as
   * a reference or stopping point.
   */
  waypoint: "waypoint",

  /**
   * A viaWaypoint is a specific waypoint that must be passed through or visited
   * along a route or trip.
   */
  viaWaypoint: "viaWaypoint",
}

/**
 * The mode of travel for the requested route. If not defined, the default value
 * is "driving" that returns the route optimized for cars.
 *
 * `Note`: For truck travelMode, the requested truck route may not be available
 * for the entire route. Where the truck route is not available for a particular
 * section, the travelMode element of the response for that section will be
 * "other".
 *
 * Example: "travelMode":"driving"
 */
union TravelModeEnum {
  string,

  /**
   * The returned routes are optimized for cars.
   */
  driving: "driving",

  /**
   * The returned routes are optimized for large size trucks based on the vehicle
   * specification.
   */
  truck: "truck",

  /**
   * The returned routes are optimized for pedestrians, including the use of
   * sidewalks.
   */
  walking: "walking",
}

/**
 * Specifies the parameter to use to optimize the route. If not defined, the
 * default is "fastestWithoutTraffic" which returns the route to minimize the
 * travel time without using current traffic information.
 *
 * Example: "optimizeRoute":"shortest"
 */
union RouteDirectionOptimizeRouteEnum {
  string,

  /**
   * The route is calculated to balance fast travel time and short distance, rather
   * than prioritizing just one. It's optimized for both speed and efficiency.
   * Traffic information is not used.
   */
  Short: "short",

  /**
   * The route is calculated to minimize the distance. Traffic information is not
   * used.
   */
  Shortest: "shortest",

  /**
   * Finds the fastest route, without factoring in traffic information.
   */
  FastestWithoutTraffic: "fastestWithoutTraffic",

  /**
   * The route is calculated to minimize the time using current traffic information.
   * `Note`: Only supported for driving and truck travelMode.
   */
  FastestWithTraffic: "fastestWithTraffic",
}

/**
 * Specifies restrictions that the route calculation should honor when determining the route.
 * Avoid supports multiple values in a request and is only supported for the driving and truck
 * travelMode.\n\nExample: \"avoid\": [\"limitedAccessHighways\", \"tollRoads\"]
 */
union AvoidEnum {
  string,

  /**
   * Avoids the use of limited access highways in the route.
   */
  limitedAccessHighways: "limitedAccessHighways",

  /**
   * Avoids the use of toll roads in the route.
   */
  tollRoads: "tollRoads",

  /**
   * Avoids the use of ferries in the route.
   */
  ferries: "ferries",

  /**
   * Avoids the use of tunnels in the route.
   */
  tunnels: "tunnels",

  /**
   * Avoids crossing country borders in the route.
   */
  borderCrossings: "borderCrossings",

  /**
   * Avoids low-emission zones in the route.
   */
  lowEmissionZones: "lowEmissionZones",

  /**
   * Avoids unpaved roads in the route.
   */
  unpavedRoads: "unpavedRoads",
}

/** The desired route information from the response. */
union RouteOutputOptionEnum {
  string,

  /**
   * Include only travel time and distance for the route, and do not provide other
   * information.
   */
  routeSummary: "routeSummary",

  /**
   * Include a GeoJSON MultiLineString [RFC 7946, section
   * 3.1.5](https://www.rfc-editor.org/rfc/rfc7946#section-3.1.5) that describe the
   * route's path in the response.
   */
  routePath: "routePath",

  /**
   * Include detailed directions in the response. Detailed directions are provided
   * as "ManeuverPoints" and contain details such as turn-by-turn instructions.
   */
  itinerary: "itinerary",
}

/** Types of cargo that may be classified as hazardous materials and restricted from some roads. */
union VehicleLoadTypeEnum {
  string,

  /**
   * Explosives
   */
  USHazmatClass1: "USHazmatClass1",

  /**
   * Compressed gas
   */
  USHazmatClass2: "USHazmatClass2",

  /**
   * Flammable liquids
   */
  USHazmatClass3: "USHazmatClass3",

  /**
   * Flammable solids
   */
  USHazmatClass4: "USHazmatClass4",

  /**
   * Oxidizers
   */
  USHazmatClass5: "USHazmatClass5",

  /**
   * Poisons
   */
  USHazmatClass6: "USHazmatClass6",

  /**
   * Radioactive
   */
  USHazmatClass7: "USHazmatClass7",

  /**
   * Corrosives
   */
  USHazmatClass8: "USHazmatClass8",

  /**
   * Miscellaneous
   */
  USHazmatClass9: "USHazmatClass9",

  /**
   * Explosives
   */
  otherHazmatExplosive: "otherHazmatExplosive",

  /**
   * Miscellaneous
   */
  otherHazmatGeneral: "otherHazmatGeneral",

  /**
   * Harmful to water
   */
  otherHazmatHarmfulToWater: "otherHazmatHarmfulToWater",
}

/**
 * The ADR tunnel restriction code. ADR is a European agreement concerning the
 * international carriage of dangerous goods by road. The ADR tunnel restriction
 * code is used to determine whether a vehicle is allowed to pass through a tunnel
 * with restrictions on the carriage of dangerous goods.
 */
union AdrTunnelRestrictionCodeEnum {
  string,

  /**
   * Vehicles with code B are restricted from roads with ADR tunnel categories B, C,
   * D, and E.
   */
  B: "B",

  /**
   * Vehicles with code C are restricted from roads with ADR tunnel categories C, D,
   * and E
   */
  C: "C",

  /**
   * Vehicles with code D are restricted from roads with ADR tunnel categories D and
   * E.
   */
  D: "D",

  /**
   * Vehicles with code E are restricted from roads with ADR tunnel category E.
   */
  E: "E",
}

/**
 * Output type.
 */
union PropertiesTypeEnum {
  string,

  /**
   * A maneuverPoint is a specific point on a route or trip where a change in
   * direction or mode of transportation is required or recommended.
   */
  ManeuverPoint: "ManeuverPoint",

  /**
   * A waypoint is a specific location or point along a route or trip that serves as
   * a reference or stopping point.
   */
  Waypoint: "Waypoint",

  /**
   * A routePath is a line that represents the path of a route or trip.
   */
  RoutePath: "RoutePath",
}

/**
 * Specifies the routing profile for snapping the points. If unspecified, the
 * default mode is "driving", which optimizes the snapped points for driving
 * routes.
 */
union SnapToRoadsTravelModeEnum {
  string,

  /**
   * The points are snapped to the road suitable for cars.
   */
  driving: "driving",

  /**
   * The points are snapped to the road suitable for truck.
   */
  truck: "truck",
}

/**
 * Specifies the parameter to use to optimize the route. If not defined, the
 * default is "fastestWithoutTraffic" which returns the route to minimize the
 * travel time without using current traffic information.
 *
 * Example: "optimizeRoute":"shortest"
 */
union RouteRangeOptimizeRouteEnum {
  string,

  /**
   * The route is calculated to minimize the distance. Traffic information is not
   * used.
   */
  Shortest: "shortest",

  /**
   * Finds the fastest route, without factoring in traffic information.
   */
  FastestWithoutTraffic: "fastestWithoutTraffic",

  /**
   * The route is calculated to minimize the time using current traffic information.
   * `Note`: Only supported for driving and truck travelMode.
   */
  FastestWithTraffic: "fastestWithTraffic",
}

/**
 * Specifies restrictions that the route calculation should honor when determining the
 * reachable locations. Avoid supports multiple values in a request.
 * \n\nExample: \"avoid\": [\"limitedAccessHighways\", \"tollRoads\"]
 */
union RouteRangeAvoidEnum {
  string,

  /**
   * Avoids the use of limited access highways in the route.
   */
  limitedAccessHighways: "limitedAccessHighways",

  /**
   * Avoids the use of toll roads in the route.
   */
  tollRoads: "tollRoads",

  /**
   * Avoids the use of ferries in the route.
   */
  ferries: "ferries",

  /**
   * Avoids the use of tunnels in the route.
   */
  tunnels: "tunnels",

  /**
   * Avoids crossing country borders in the route.
   */
  borderCrossings: "borderCrossings",

  /**
   * Avoids low-emission zones in the route.
   */
  lowEmissionZones: "lowEmissionZones",

  /**
   * Avoids unpaved roads in the route.
   */
  unpavedRoads: "unpavedRoads",

  /**
   * Avoids routes that require use of carpool.
   */
  carpools: "carpools",

  /**
   * Avoids car trains.
   */
  carTrains: "carTrains",
}

/**
 * Specifies the travel profile to consider when calculating the range polygon. If
 * not specified, the default value is "driving".
 *
 * Example: "travelMode":"driving"
 */
union RouteRangeTravelModeEnum {
  string,

  /**
   * Routing profile suitable for cars are used for range polygon calculation.
   */
  driving: "driving",

  /**
   * Routing profile suitable for commercial vehicles like trucks are used for range
   * polygon calculation.
   */
  truck: "truck",
}

/**
 * The feature types for the feature objects returned in the response.
 */
union RouteRangeTypeEnum {
  string,

  /**
   * The center point feature type represents the point used for the range polygon
   * calculation.
   */
  center: "center",

  /**
   * The boundary feature type represents the range polygon.
   */
  boundary: "boundary",
}

/**
 * Specifies the origin MultiPoint type and destination MultiPoint type for the
 * input matrix.
 */
union RouteMatrixTypeEnum {
  string,

  /**
   * MultiPoint features that define the origin locations in the input matrix.
   */
  origins: "origins",

  /**
   * MultiPoint features that define the destination locations in the input matrix.
   */
  destinations: "destinations",
}

/**
 * Specifies the travel profile to consider when calculating the matrix. If not
 * specified, the default value is "driving".
 *
 * Example: "travelMode":"driving"
 */
union RouteMatrixTravelModeEnum {
  string,

  /**
   * Routing profile suitable for cars are used for route matrix calculation.
   */
  driving: "driving",

  /**
   * Routing profile suitable for commercial vehicles like trucks are used for route
   * matrix calculation.
   */
  truck: "truck",

  /**
   * The returned routes are optimized for pedestrians, including the use of
   * sidewalks.
   */
  walking: "walking",
}

/**
 * Specifies the parameter to use to optimize the route. If not defined, the
 * default is "fastest" which returns the route to minimize the travel time.
 *
 * Example: "optimizeRoute":"fastest "
 */
union RouteMatrixOptimizeRouteEnum {
  string,

  /**
   * Finds the fastest route to optimize route by travel time.
   *
   * Only `fastest` is supported for the Route Matrix sync API. To use the other
   * types, check the Route Matrix async API.
   */
  Fastest: "fastest",
}

/**
 * Specifies how traffic is considered for computing routes.
 *
 * Default value: `historical`
 */
union RouteMatrixTrafficEnum {
  string,

  /**
   * Route calculation considers historical travel times and long term closures.
   * Traffic jams and short-term closures during the travel time window do not
   * influence routing or travel time.
   */
  Historical: "historical",

  /**
   * In addition to historical travel times, route calculation considers traffic
   * jams and short- and long-term closures during the travel time window.
   *
   * `Note`: `traffic=live` may not be used in conjunction with `arriveAt=any` and
   * `departAt=any`
   */
  Live: "live",
}

/**
 * Specifies restrictions that the route calculation should honor when determining
 * the route. Avoid supports multiple values in a request and is only supported
 * for the driving and truck travelMode.
 */
union RouteMatrixAvoidEnum {
  string,

  /**
   * Avoids the use of toll roads in the route.
   */
  TollRoads: "tollRoads",

  /**
   * Avoids unpaved roads in the route.
   */
  UnpavedRoads: "unpavedRoads",
}

/**
 * Specifies the parameter to use to optimize the route. If not defined, the
 * default is "fastest" which returns the route to minimize the travel time.
 *
 * Example: "optimizeRoute":"shortest"
 */
union RouteMatrixAsyncOptimizeRouteEnum {
  string,

  /**
   * Finds the shortest route to optimize route by travel distance.
   */
  Shortest: "shortest",

  /**
   * Finds the fastest route to optimize route by travel time.
   */
  Fastest: "fastest",
}

/**
 * Current status of the async operation.
 */
union StatusEnum {
  string,

  /**
   * The operation has not started yet.
   */
  NotStarted: "NotStarted",

  /**
   * The operation is running.
   */
  Running: "Running",

  /**
   * The operation has completed successfully.
   */
  @lroSucceeded
  Completed: "Completed",

  /**
   * The operation has failed.
   */
  Failed: "Failed",
}

/**
 * Type of asynchronous operation
 */
union RouteOperationKindEnum {
  string,

  /**
   * Route matrix asynchronous job.
   */
  RouteMatrix: "RouteMatrix",
}

/**
 * The type of maneuver described in this detailed collection. The ManeuverType
 * provides information for a portion of the maneuver specified by the
 * corresponding instruction. For example, the maneuverType of an instruction may
 * specify TurnLeftThenTurnRight, while the associated detail items may provide
 * specifics about the TurnLeft and TurnRight maneuvers
 */
union ManeuverTypeEnum {
  string,

  /**
   * Arrive at the final destination.
   */
  ArriveFinish: "ArriveFinish",

  /**
   * Arrive at an intermediate waypoint.
   */
  ArriveIntermediate: "ArriveIntermediate",

  /**
   * Bear left.
   */
  BearLeft: "BearLeft",

  /**
   * Bear left and then bear left again.
   */
  BearLeftThenBearLeft: "BearLeftThenBearLeft",

  /**
   * Bear left and then bear right.
   */
  BearLeftThenBearRight: "BearLeftThenBearRight",

  /**
   * Bear left and then turn left.
   */
  BearLeftThenTurnLeft: "BearLeftThenTurnLeft",

  /**
   * Bear left and then turn right.
   */
  BearLeftThenTurnRight: "BearLeftThenTurnRight",

  /**
   * Bear right.
   */
  BearRight: "BearRight",

  /**
   * Bear right and then bear left.
   */
  BearRightThenBearLeft: "BearRightThenBearLeft",

  /**
   * Bear right and then bear right again.
   */
  BearRightThenBearRight: "BearRightThenBearRight",

  /**
   * Bear right and then turn left.
   */
  BearRightThenTurnLeft: "BearRightThenTurnLeft",

  /**
   * Bear right and then turn right.
   */
  BearRightThenTurnRight: "BearRightThenTurnRight",

  /**
   * Bear instruction and then a keep instruction
   */
  BearThenKeep: "BearThenKeep",

  /**
   * Leave the starting point.
   */
  DepartStart: "DepartStart",

  /**
   * Bear instruction and then a merge instruction.
   */
  BearThenMerge: "BearThenMerge",

  /**
   * Continue on the current road.
   */
  Continue: "Continue",

  /**
   * Leave an intermediate waypoint in a different direction and road than you
   * arrived on.
   */
  DepartIntermediateStop: "DepartIntermediateStop",

  /**
   * Leave an intermediate waypoint in the same direction and on the same road that
   * you arrived on.
   */
  DepartIntermediateStopReturning: "DepartIntermediateStopReturning",

  /**
   * Enter a roundabout.
   */
  EnterRoundabout: "EnterRoundabout",

  /**
   * Exit a roundabout.
   */
  ExitRoundabout: "ExitRoundabout",

  /**
   * Enter and exit a roundabout.
   */
  EnterThenExitRoundabout: "EnterThenExitRoundabout",

  /**
   * At the roundabout take the exit on the right.
   */
  ExitRoundaboutRight: "ExitRoundaboutRight",

  /**
   * At the roundabout take the exit on the left.
   */
  ExitRoundaboutLeft: "ExitRoundaboutLeft",

  /**
   * Follow.
   */
  Follow: "Follow",

  /**
   * Go around the roundabout.
   */
  GoAroundRoundabout: "GoAroundRoundabout",

  /**
   * Keep left onto a different road.
   */
  KeepLeft: "KeepLeft",

  /**
   * Keep left and continue onto ramp.
   */
  KeepOnRampLeft: "KeepOnRampLeft",

  /**
   * Keep right and continue onto ramp.
   */
  KeepOnRampRight: "KeepOnRampRight",

  /**
   * Keep straight and continue onto ramp.
   */
  KeepOnRampStraight: "KeepOnRampStraight",

  /**
   * Keep right onto a different road.
   */
  KeepRight: "KeepRight",

  /**
   * Keep straight onto a different road.
   */
  KeepStraight: "KeepStraight",

  /**
   * Keep left to stay on the same road.
   */
  KeepToStayLeft: "KeepToStayLeft",

  /**
   * Keep right to stay on the same road.
   */
  KeepToStayRight: "KeepToStayRight",

  /**
   * Keep straight to stay on the same road.
   */
  KeepToStayStraight: "KeepToStayStraight",

  /**
   * Merge onto a freeway.
   */
  MergeFreeway: "MergeFreeway",

  /**
   * Merge onto a highway.
   */
  MergeHighway: "MergeHighway",

  /**
   * Merge onto a motorway.
   */
  MergeMotorway: "MergeMotorway",

  /**
   * Take the left exit.
   */
  MotorwayExitLeft: "MotorwayExitLeft",

  /**
   * Take the right exit.
   */
  MotorwayExitRight: "MotorwayExitRight",

  /**
   * No instruction.
   */
  None: "None",

  /**
   * Take left ramp onto highway. This is part of a combined instruction.
   */
  RampThenHighwayLeft: "RampThenHighwayLeft",

  /**
   * Take right ramp onto highway. This is part of a combined instruction.
   */
  RampThenHighwayRight: "RampThenHighwayRight",

  /**
   * Stay straight to take ramp onto highway. This is part of a combined instruction.
   */
  RampThenHighwayStraight: "RampThenHighwayStraight",

  /**
   * Road name changes.
   */
  RoadNameChange: "RoadNameChange",

  /**
   * Switch to the parallel road.
   */
  SwitchToParallelRoad: "SwitchToParallelRoad",

  /**
   * Switch to the main road.
   */
  SwitchToMainRoad: "SwitchToMainRoad",

  /**
   * Take the road. This instruction is used when you are entering or exiting a
   * ferry.
   */
  Take: "Take",

  /**
   * Take the ferry.
   */
  TakeFerry: "TakeFerry",

  /**
   * Take the exit.
   */
  TakeExit: "TakeExit",

  /**
   * Take ramp.
   */
  TakeRamp: "TakeRamp",

  /**
   * Take ramp to the left.
   */
  TakeRampLeft: "TakeRampLeft",

  /**
   * Take ramp to the right.
   */
  TakeRampRight: "TakeRampRight",

  /**
   * Stay straight to take ramp.
   */
  TakeRampStraight: "TakeRampStraight",

  /**
   * Turn back sharply.
   */
  TurnBack: "TurnBack",

  /**
   * Turn left.
   */
  TurnLeft: "TurnLeft",

  /**
   * Take a sharp left turn.
   */
  TurnLeftSharp: "TurnLeftSharp",

  /**
   * Turn left and then bear left.
   */
  TurnLeftThenBearLeft: "TurnLeftThenBearLeft",

  /**
   * Turn left and then bear right.
   */
  TurnLeftThenBearRight: "TurnLeftThenBearRight",

  /**
   * Turn left and then turn left again.
   */
  TurnLeftThenTurnLeft: "TurnLeftThenTurnLeft",

  /**
   * Turn left and then turn right.
   */
  TurnLeftThenTurnRight: "TurnLeftThenTurnRight",

  /**
   * Turn right.
   */
  TurnRight: "TurnRight",

  /**
   * Take a sharp right turn.
   */
  TurnRightSharp: "TurnRightSharp",

  /**
   * Turn right and then bear left.
   */
  TurnRightThenBearLeft: "TurnRightThenBearLeft",

  /**
   * Turn right and then bear right.
   */
  TurnRightThenBearRight: "TurnRightThenBearRight",

  /**
   * Turn right and then turn left.
   */
  TurnRightThenTurnLeft: "TurnRightThenTurnLeft",

  /**
   * Turn right and then turn right again
   */
  TurnRightThenTurnRight: "TurnRightThenTurnRight",

  /**
   * Turn instruction followed by a merge instruction.
   */
  TurnThenMerge: "TurnThenMerge",

  /**
   * Turn left to stay on the same road.
   */
  TurnToStayLeft: "TurnToStayLeft",

  /**
   * Turn right to stay on the same road.
   */
  TurnToStayRight: "TurnToStayRight",

  /**
   * The instruction is unknown.
   */
  Unknown: "Unknown",

  /**
   * Make a u-turn to go in the opposite direction.
   */
  UTurn: "UTurn",

  /**
   * Wait
   */
  Wait: "Wait",

  /**
   * Walk
   */
  Walk: "Walk",
}

/**
 * Indicates left-hand vs. right-hand side driving at the point of the maneuver.
 */
union DrivingSideEnum {
  string,

  /**
   * Left-hand side driving.
   */
  Left: "Left",

  /**
   * Right-hand side driving.
   */
  Right: "Right",
}

/**
 * The side of the street where the destination is found based on the arrival
 * direction. This field applies to the last maneuverPoint only.
 */
union SideOfStreetEnum {
  string,

  /**
   * Left.
   */
  Left: "Left",

  /**
   * Right.
   */
  Right: "Right",

  /**
   * Unknown.
   */
  Unknown: "Unknown",
}

/**
 * The mode of travel for the route path in the response.
 */
union RoutePathTravelModeEnum {
  string,

  /**
   * Routes optimized for cars.
   */
  driving: "driving",

  /**
   * Routes optimized for large size trucks based on the vehicle specification.
   */
  truck: "truck",

  /**
   * Routes optimized for pedestrians.
   */
  walking: "walking",

  /**
   * RouteTravelMode is returned as "other" for the truck travelMode when the truck
   * route is not available for a particular section of a route.
   */
  other: "other",
}

/**
 * The level of traffic congestion along the route. `Note`: Only supported for
 * driving travelMode
 */
union TrafficCongestionEnum {
  string,

  /**
   * Unknown.
   */
  Unknown: "Unknown",

  /**
   * None.
   */
  None: "None",

  /**
   * Mild.
   */
  Mild: "Mild",

  /**
   * Medium.
   */
  Medium: "Medium",

  /**
   * Heavy.
   */
  Heavy: "Heavy",
}

/**
 * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
 * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
 * GeometryCollection, Feature and FeatureCollection.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API contract"
enum GeoJsonObjectType {
  /**
   * `GeoJSON Point` geometry.
   */
  GeoJsonPoint: "Point",

  /**
   * `GeoJSON MultiPoint` geometry.
   */
  GeoJsonMultiPoint: "MultiPoint",

  /**
   * `GeoJSON LineString` geometry.
   */
  GeoJsonLineString: "LineString",

  /**
   * `GeoJSON MultiLineString` geometry.
   */
  GeoJsonMultiLineString: "MultiLineString",

  /**
   * `GeoJSON Polygon` geometry.
   */
  GeoJsonPolygon: "Polygon",

  /**
   * `GeoJSON MultiPolygon` geometry.
   */
  GeoJsonMultiPolygon: "MultiPolygon",

  /**
   * `GeoJSON GeometryCollection` geometry.
   */
  GeoJsonGeometryCollection: "GeometryCollection",

  /**
   * `GeoJSON Feature` object.
   */
  GeoJsonFeature: "Feature",

  /**
   * `GeoJSON FeatureCollection` object.
   */
  GeoJsonFeatureCollection: "FeatureCollection",
}

/**
 * This object is the request body.
 */
model DirectionsRequest {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is
   * `FeatureCollection`. For more information, see [RFC
   * 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type: FeatureTypeEnum;

  /**
   * Driving, walking, and truck routes are defined by a set of waypoints(stops) and
   * viaWaypoints (intermediate locations that the route must pass through). You can
   * have a maximum of 150 waypoints, and a maximum of 10 viaWaypoints between each
   * set of waypoints.
   *
   * A route must have a minimum of 2 waypoints and the start and end points of the
   * route cannot be viaWaypoints.
   *
   * Both waypoint and viaWaypoint locations must be specified as a valid GeoJSON
   * Point feature object along with pointIndex that specifies the order of the
   * locations. For more information on the GeoJSON format, see [RFC
   * 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  @minItems(2)
  features: InputWaypointFeaturesItem[];

  /**
   * The mode of travel for the requested route. If not defined, the default value
   * is "driving" that returns the route optimized for cars.
   *
   * `Note`: For truck travelMode, the requested truck route may not be available
   * for the entire route. Where the truck route is not available for a particular
   * section, the travelMode element of the response for that section will be
   * "other".
   *
   * Example: "travelMode":"driving"
   */
  travelMode?: TravelModeEnum = TravelModeEnum.driving;

  /**
   * The date and time of departure from the origin point formatted as a `dateTime`
   * value defined by [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6). When a time zone
   * offset is not specified, UTC will be assumed.
   *
   * If the `departAt` is not set, the default value is the current time.
   *
   * Example:
   *
   * "departAt": "2023-06-01T09:30:00.000-07:00"
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  departAt?: utcDateTime;

  /**
   * The date and time of arrival at the destination point formatted as a `dateTime`
   * value defined by [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6). When a time zone
   * offset is not specified, UTC will be assumed.
   *
   * The `arriveAt` parameter cannot be used in conjunction with `departAt`.
   *
   * Example: "arriveAt": "2023-06-01T09:30:00.000-07:00"
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  arriveAt?: utcDateTime;

  /**
   * Specifies the parameter to use to optimize the route. If not defined, the
   * default is "fastestWithoutTraffic" which returns the route to minimize the
   * travel time without using current traffic information.
   *
   * Example: "optimizeRoute":"shortest"
   */
  optimizeRoute?: RouteDirectionOptimizeRouteEnum = RouteDirectionOptimizeRouteEnum.FastestWithoutTraffic;

  /**
   * Re-order the route waypoints using a fast heuristic algorithm to reduce the
   * route cost specified with the optimize parameter. The origin and destination
   * are excluded from the optimized waypoint and their position is considered
   * fixed. Acceptable values are true or false.
   */
  optimizeWaypointOrder?: boolean = false;

  /**
   * Specifies restrictions that the route calculation should honor when determining
   * the route. Avoid supports multiple values in a request and is only supported
   * for the driving and truck travelMode.
   *
   * Example: "avoid": ["limitedAccessHighways", "tollRoads"]
   */
  avoid?: AvoidEnum[];

  /**
   * Include the desired route information from the response. By default, the
   * itinerary is included in the response.
   *
   * Supports multiple values such as "routeOutputOptions": ["routePath",
   * "itinerary"]
   */
  routeOutputOptions?: RouteOutputOptionEnum[] = #[
    RouteOutputOptionEnum.itinerary
  ];

  /**
   * The maximum number of routes to return. Available for the driving and truck
   * travel modes.
   *
   * Default: "maxRouteCount":1
   */
  @maxValue(6)
  @minValue(1)
  maxRouteCount?: int64;

  /**
   * The initial directional heading of the vehicle in degrees starting at true
   * North and continuing in clockwise direction. North is 0 degrees, east is 90
   * degrees, south is 180 degrees, west is 270 degrees.
   */
  @minValue(0)
  @maxValue(359)
  heading?: int64;

  /**
   * Specifies the vehicle attributes such as size, weight, max speed, type of
   * cargo, etc. for truck routing only. This helps avoid low bridge clearances,
   * road restrictions, difficult right turns to provide the optimized truck route
   * based on the vehicle specifications.
   *
   * `Note`: Only supported for truck travelMode
   */
  vehicleSpec?: RouteDirectionVehicleSpec;
}

/**
 * Specifies the input waypoint and viaWaypoint `GeoJSON` feature object and
 * additional properties. For more information, see [RFC
 * 7946](https://www.rfc-editor.org/rfc/rfc7946).
 */
model InputWaypointFeaturesItem {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is Feature. For
   * more information, see [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type: FeaturesItemTypeEnum;

  /**
   * A valid `GeoJSON Point` geometry type. Please refer to [RFC
   * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.2) for details.
   */
  geometry: GeoJsonPoint;

  /**
   * Specifies the properties of a waypoint which is a specific location or point
   * along a route or trip that serves as a reference or stopping point.
   */
  properties: InputWaypointProperties;
}

/**
 * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
 * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
 * GeometryCollection, Feature and FeatureCollection.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API contract"
enum GeoJsonGeometryObjectType {
  /**
   * `GeoJSON Point` geometry.
   */
  GeoJsonPoint: "Point",

  /**
   * `GeoJSON MultiPoint` geometry.
   */
  GeoJsonMultiPoint: "MultiPoint",

  /**
   * `GeoJSON LineString` geometry.
   */
  GeoJsonLineString: "LineString",

  /**
   * `GeoJSON MultiLineString` geometry.
   */
  GeoJsonMultiLineString: "MultiLineString",

  /**
   * `GeoJSON Polygon` geometry.
   */
  GeoJsonPolygon: "Polygon",

  /**
   * `GeoJSON MultiPolygon` geometry.
   */
  GeoJsonMultiPolygon: "MultiPolygon",

  /**
   * `GeoJSON GeometryCollection` geometry.
   */
  GeoJsonGeometryCollection: "GeometryCollection",
}

/**
 * A valid `GeoJSON` geometry object. The type must be one of the seven valid
 * GeoJSON geometry types - Point, MultiPoint, LineString, MultiLineString,
 * Polygon, MultiPolygon and GeometryCollection. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3.1) for details.
 */
model GeoJsonGeometry is GeoJsonObject;

/**
 * A valid `GeoJSON` object. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3) for details.
 */
// FIXME The warning for type looks like a bug
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing API contract"
@discriminator("type")
model GeoJsonObject {
  /**
   * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
   * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
   * GeometryCollection, Feature and FeatureCollection.
   */
  type: GeoJsonObjectType;
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
  coordinates: float64[];
}

/**
 * Specifies the properties of a waypoint which is a specific location or point
 * along a route or trip that serves as a reference or stopping point.
 */
model InputWaypointProperties {
  /**
   * Identify and order the sequence of waypoints in the route. The default value is
   * the `index value` of a features array.
   */
  pointIndex?: int64;

  /**
   * Waypoint type on the route. It can be a stop or an intermediate location that
   * the route must pass through.
   */
  pointType?: InputWaypointTypeEnum = InputWaypointTypeEnum.waypoint;
}

/**
 * Specifies the vehicle attributes such as size, weight, max speed, type of
 * cargo, etc. for truck routing only. This helps avoid low bridge clearances,
 * road restrictions, difficult right turns to provide the optimized truck route
 * based on the vehicle specifications.
 *
 * IS`Note`: Only supported for truck travelMode.
 */
model RouteDirectionVehicleSpec {
  ...VehicleSpec;
  ...AxleCount;
}

/**
 * Specifies the vehicle attributes such as size, weight, max speed, type of
 * cargo, etc. for truck routing only. This helps avoid low bridge clearances,
 * road restrictions, difficult right turns to provide the optimized truck route
 * based on the vehicle specifications.
 *
 * `Note`: Only supported for truck travelMode.
 */
model VehicleSpec {
  /**
   * Whether the vehicle is used for commercial purposes. Commercial vehicles may
   * not be allowed to drive on some roads.
   */
  isVehicleCommercial?: boolean = false;

  /**
   * Length of the vehicle in meters. A value of 0 means that length restrictions
   * are not considered.
   */
  @minValue(0)
  @maxValue(1000000)
  length?: float64 = 0;

  /**
   * Width of the vehicle in meters. A value of 0 means that width restrictions are
   * not considered.
   */
  @minValue(0)
  @maxValue(1000000)
  width?: float64 = 0;

  /**
   * Height of the vehicle in meters. A value of 0 means that height restrictions
   * are not considered.
   */
  @minValue(0)
  @maxValue(1000000)
  height?: float64 = 0;

  /**
   * Weight of the vehicle in kilograms. A value of 0 means that weight restrictions
   * are not considered.
   */
  @minValue(0)
  @maxValue(1000000)
  weight?: int64 = 0;

  /**
   * Maximum speed of the vehicle in km/hour. The max speed in the vehicle profile
   * is used to check whether a vehicle is allowed on motorways.
   *
   * A value of 0 means that an appropriate value for the vehicle will be determined
   * and applied during route planning.
   *
   * A non-zero value may be overridden during route planning. For example, the
   * current traffic flow is 60 km/hour. If the vehicle maximum speed is set to 50
   * km/hour, the routing engine will consider 60 km/hour as this is the current
   * situation. If the maximum speed of the vehicle is provided as 80 km/hour but
   * the current traffic flow is 60 km/hour, then routing engine will again use 60
   * km/hour.
   */
  @minValue(0)
  @maxValue(250)
  maxSpeed?: int64 = 0;

  /**
   * Weight per axle of the vehicle in kg. A value of 0 means that weight
   * restrictions per axle are not considered.
   */
  @minValue(0)
  @maxValue(1000000)
  axleWeight?: int64 = 0;

  /**
   * Types of cargo that may be classified as hazardous materials and restricted
   * from some roads. Available vehicleLoadType values are US Hazmat classes 1
   * through 9, plus generic classifications for use in other countries. Values
   * beginning with USHazmat are for US routing while otherHazmat should be used for
   * all other countries. vehicleLoadType supports multiple values in a request.
   */
  loadType?: VehicleLoadTypeEnum[];

  /**
   * The ADR tunnel restriction code. ADR is a European agreement concerning the
   * international carriage of dangerous goods by road. The ADR tunnel restriction
   * code is used to determine whether a vehicle is allowed to pass through a tunnel
   * with restrictions on the carriage of dangerous goods.
   */
  adrTunnelRestrictionCode?: AdrTunnelRestrictionCodeEnum;
}

/**
 * The number of axles on the vehicle.
 */
alias AxleCount = {
  /**
   * The number of axles on the vehicle.
   */
  axleCount?: int64;
};

/**
 * Alternative route.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RouteDirectionsResponse extends FeatureCollection {
  /**
   * Alternative route.
   */
  alternativeRoutes?: FeatureCollection[];
}

/**
 * `GeoJSON` `FeatureCollection` object that contains a list of Features. For more
 * information, see [RFC 7946, section
 * 3.3](https://www.rfc-editor.org/rfc/rfc7946#section-3.3).
 */
model FeatureCollection {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is
   * `FeatureCollection`. For more information, see [RFC
   * 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type?: FeatureTypeEnum;

  /**
   * `GeoJSON` feature object that contains Geometry object and additional
   * properties. For more information, see [RFC 7946, Section
   * 3.2](https://www.rfc-editor.org/rfc/rfc7946#section-3.2).
   */
  features?: FeaturesItem[];
}

/**
 * GeoJSON feature object that contains Geometry object and additional properties
 * of the route.
 */
model FeaturesItem {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is Feature. For
   * more information, see [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type?: FeaturesItemTypeEnum;

  /**
   * A valid `GeoJSON` Geometry object. For more information, see [RFC
   * 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  geometry?: RouteDirectionsGeometry;

  /**
   * Specifies the feature properties of the route like itinerary, route Legs and
   * geometry, travel summary.
   */
  properties?: FeatureProperties;

  /**
   * A rectangular area on the earth defined as a bounding box object. The sides of
   * the rectangles are defined by latitude and longitude values. For more
   * information, see [RFC 7946, Section
   * 5](https://www.rfc-editor.org/rfc/rfc7946#section-5).
   *
   * Example: "bbox": [-10.0, -10.0, 10.0, 10.0]
   */
  bbox?: float64[];
}

/**
 * A valid `GeoJSON` Geometry object. For more information, see [RFC
 * 7946](https://www.rfc-editor.org/rfc/rfc7946).
 */
// FIXME: The warning for type looks like a bug
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing API contract"
@discriminator("type")
model RouteDirectionsGeometry {
  /**
   * Specifies the geometry type for the `GeoJSON` Geometry object. For more
   * information, see [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type: GeoJsonObjectType;
}

/**
 * Specifies the feature properties of the route like itinerary, route Legs and
 * geometry, travel summary.
 */
@discriminator("type")
model FeatureProperties {
  /**
   * Output type.
   */
  type: PropertiesTypeEnum;
}

/**
 * Common error response for Azure Maps APIs to return error details for failed
 * operations.
 */
@error
model MapsErrorResponse {
  /**
   * The error detail.
   */
  @visibility(Lifecycle.Read)
  error: MapsErrorDetail;
}

/**
 * The error detail.
 */
model MapsErrorDetail {
  /**
   * One of a server-defined set of error codes.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * A human-readable representation of the error.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The target of the error.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * An array of details about specific errors that led to this reported error.
   */
  @visibility(Lifecycle.Read)
  details?: MapsErrorDetail[];

  /**
   * An object containing more specific information than the current object about
   * the error.
   */
  @visibility(Lifecycle.Read)
  innererror?: MapsInnerError;
}

/**
 * An object containing more specific information than the current object about
 * the error.
 */
model MapsInnerError {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * An object containing more specific information than the current object about
   * the error.
   */
  @visibility(Lifecycle.Read)
  innererror?: MapsInnerError;
}

/**
 * The list of directions queries/requests to process. The list can contain a max
 * of 100 queries and must contain at least 1 query.
 */
model DirectionsBatchRequestBody {
  /**
   * The list of queries to process.
   */
  batchItems?: DirectionsBatchRequestItem[];
}

/**
 * Batch Query object
 */
model DirectionsBatchRequestItem {
  ...OptionalId;
  ...DirectionsRequest;
}

/**
 * optional Id
 */
alias OptionalId = {
  /**
   * Id of the request which would show in corresponding batchItem.
   */
  optionalId?: string;
};

/**
 * This object is returned from a successful Directions Batch service call.
 */
model DirectionsBatchResponse {
  /**
   * Summary for the batch request
   */
  summary?: DirectionsBatchResponseSummary;

  /**
   * Array containing the batch results.
   */
  batchItems?: DirectionsBatchResponseItem[];
}

/**
 * Summary for the batch request
 */
model DirectionsBatchResponseSummary {
  /**
   * Number of successful requests in the batch
   */
  successfulRequests?: int32;

  /**
   * Total number of requests in the batch
   */
  totalRequests?: int32;
}

/**
 * error details
 */
model DirectionsBatchResponseItem {
  ...OptionalId;
  ...RouteDirectionsResponse;

  /**
   * The error detail.
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

/**
 * The resource management error additional info.
 */
model ErrorAdditionalInfo {
  /**
   * The additional info type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The additional info.
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API contract"
  @visibility(Lifecycle.Read)
  info?: Record<unknown>;
}

/**
 * This object is the request body.
 */
model SnapToRoadsRequest {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is
   * `FeatureCollection`. For more information, see [RFC
   * 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type: FeatureTypeEnum;

  /**
   * A set of points to snap to road network. You can have a minimum of 2 points and
   * maximum of 5000 points and the two consecutive points must be within 6
   * kilometer of each other and a total road distance of up to 100 kilometers.
   * Refer to [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946) for details on the
   * GeoJSON format.
   *
   * `Note`: The API will not return a point object in the response for the GPS
   * point that cannot be snapped to a road network.
   */
  @minItems(2)
  @maxItems(100)
  features: InputSnapToRoadsFeaturesItem[];

  /**
   * Specifies whether to return additional points between the snapped points to
   * complete the full route path that smoothly follows the road geometry.
   *
   * The interpolated points will have `isInterpolate:true` in the response which
   * can be used to identify the snapped points from interpolated points.
   */
  interpolate?: boolean = false;

  /**
   * Specifies whether to include speed limit information for the snapped points in
   * the response. The unit is in kilometers per hour.
   */
  includeSpeedLimit?: boolean = false;

  /**
   * Specifies the routing profile for snapping the points. If unspecified, the
   * default mode is "driving", which optimizes the snapped points for driving
   * routes.
   */
  travelMode?: SnapToRoadsTravelModeEnum = SnapToRoadsTravelModeEnum.driving;
}

/**
 * Specifies the input snap to roads points. `GeoJSON` feature object and
 * additional properties. Refer to [RFC
 * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details.
 */
model InputSnapToRoadsFeaturesItem {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is Feature. For
   * more information, see [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type: FeaturesItemTypeEnum;

  /**
   * A valid `GeoJSON Point` geometry type. Please refer to [RFC
   * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.2) for details.
   */
  geometry: GeoJsonPoint;

  /**
   * The properties object is required in a valid GeoJSON but it can be empty since
   * the metadata is not used for snapping to road.
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API contract"
  properties: Record<unknown>;
}

/**
 * This object is returned from a successful call.
 */
model SnapToRoadsResponse {
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
  features?: SnapToRoadFeaturesItem[];
}

/**
 * GeoJSON feature object that contains Geometry object and additional properties
 * of the route.
 */
model SnapToRoadFeaturesItem {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is Feature. For
   * more information, see [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type?: FeaturesItemTypeEnum;

  /**
   * A valid `GeoJSON Point` geometry type. Please refer to [RFC
   * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.2) for details.
   */
  geometry?: GeoJsonPoint;

  /**
   * A rectangular area on the earth defined as a bounding box object. The sides of
   * the rectangles are defined by latitude and longitude values. For more
   * information, see [RFC 7946, Section
   * 5](https://www.rfc-editor.org/rfc/rfc7946#section-5).
   *
   * Example: "bbox": [-10.0, -10.0, 10.0, 10.0]
   */
  bbox?: float64[];

  /**
   * Snap to Roads properties.
   */
  properties?: SnapToRoadsFeatureProperties;
}

/**
 * Snap to Roads properties.
 */
model SnapToRoadsFeatureProperties {
  /**
   * Identify the corresponding index in the original list of points for each
   * snapped point. Only the snapped points will return indices and can be used to
   * distinguish them from the interpolated points.
   */
  inputIndex?: int64;

  /**
   * Identify whether this is the interpolated point.
   */
  isInterpolated?: boolean;

  /**
   * Name of the road the point is snapped to.
   */
  name?: string;

  /**
   * Speed limit in kilometers per hour.
   */
  speedLimitInKilometersPerHour?: float64;
}

/**
 * The list of snap to roads queries/requests to process. The list can contain a
 * max of 100 queries and must contain at least 1 query.
 */
model SnapToRoadsBatchRequestBody {
  /**
   * The list of queries to process.
   */
  batchItems?: SnapToRoadsBatchRequestItem[];
}

/**
 * Batch Query object
 */
model SnapToRoadsBatchRequestItem {
  ...OptionalId;
  ...SnapToRoadsRequest;
}

/**
 * This object is returned from a successful Snap To Roads Batch service call.
 */
model SnapToRoadsBatchResponse {
  /**
   * Summary for the batch request
   */
  summary?: SnapToRoadsBatchResponseSummary;

  /**
   * Array containing the batch results.
   */
  batchItems?: SnapToRoadsBatchResponseItem[];
}

/**
 * Summary for the batch request
 */
model SnapToRoadsBatchResponseSummary {
  /**
   * Number of successful requests in the batch
   */
  successfulRequests?: int32;

  /**
   * Total number of requests in the batch
   */
  totalRequests?: int32;
}

/**
 * error details
 */
model SnapToRoadsBatchResponseItem {
  ...OptionalId;
  ...SnapToRoadsResponse;

  /**
   * The error detail.
   */
  error?: ErrorDetail;
}

/**
 * Specifies the starting point for range calculation. `GeoJSON` feature object
 * and additional properties. Refer to [RFC
 * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details.
 */
model RouteRangeRequest {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is Feature. For
   * more information, see [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type: FeaturesItemTypeEnum;

  /**
   * Specifies the `GeoJSON` Point Geometry object. Refer to [RFC
   * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details.
   */
  geometry: RouteRangePointGeometry;

  /**
   * Specifies the parameters to use for the calculation of isochrone polygon.
   */
  properties: InputRouteRangeProperties;
}

/**
 * Specifies the `GeoJSON` Point Geometry object. Refer to [RFC
 * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details.
 */
model RouteRangePointGeometry extends RouteRangeGeometry {
  ...GeoJsonPointData;

  /**
   * Specifies the geometry type for the `GeoJSON` Geometry object. Refer to [RFC
   * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details.
   */
  type: GeoJsonObjectType.GeoJsonPoint;
}

/**
 * A valid `GeoJSON` Geometry object. Please refer to [RFC
 * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details.
 */
// FIXME is the warning for type a bug?
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing API contract"
@discriminator("type")
model RouteRangeGeometry {
  /**
   * Specifies the geometry type for the `GeoJSON` Geometry object. Refer to [RFC
   * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details.
   */
  type: GeoJsonObjectType;
}

/**
 * Specifies the parameters to use for the calculation of isochrone polygon.
 */
model InputRouteRangeProperties {
  /**
   * The date and time of departure from the origin point formatted as a dateTime
   * value defined by [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6). When a time zone
   * offset is not specified, UTC will be assumed.
   *
   * If the `departAt` is not set, the default value is the current time.
   *
   * Example:
   *
   * "departAt": "2023-06-01T09:30:00.000-07:00"
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  departAt?: utcDateTime;

  /**
   * Use this to specify if you need simplified polygons that reduces the number of
   * polygon vertices while preserving the shape. The API returns low definition
   * polygon by default.
   */
  isSimplifiedPolygon?: boolean = true;

  /**
   * Specifies the parameter to use to optimize the route. If not defined, the
   * default is "fastestWithoutTraffic" which returns the route to minimize the
   * travel time without using current traffic information.
   *
   * Example: "optimizeRoute":"shortest"
   */
  optimizeRoute?: RouteRangeOptimizeRouteEnum = RouteRangeOptimizeRouteEnum.FastestWithoutTraffic;

  /**
   * Specifies restrictions that the route calculation should honor when determining
   * the reachable locations. Avoid supports multiple values in a request.
   *
   * Example: "avoid": ["limitedAccessHighways", "tollRoads"]
   */
  avoid?: RouteRangeAvoidEnum[];

  /**
   * Specifies the vehicle attributes such as vehicle height, weight, max speed,
   * type of cargo, etc. to consider when calculating the reachable locations. This
   * helps avoid low bridge clearances, road restrictions, difficult right turns to
   * provide the optimized truck route based on the vehicle specifications. Vehicle
   * attributes are specified within the vehicleSpec property.
   */
  vehicleSpec?: RouteRangeVehicleSpec;

  /**
   * The distance budget specifies the maximum range in meters which can be traveled
   * from the origin waypoint. It cannot be set when `timeBudgetInSec` is specified.
   *
   * When `isSimplifiedPolygon` is false, the maximum distance supported is 90000
   * meters; otherwise, it is 500,000 meters.
   *
   * Example: "distanceBudgetInMeters":5000
   */
  @maxValue(500000)
  distanceBudgetInMeters?: float32;

  /**
   * The time budget specifies the maximum time in seconds available for travel,
   * defining how far one can go within this time constraint from the origin
   * waypoint. It cannot be set when `distanceBudgetInMeters` is specified.
   *
   * When `isSimplifiedPolygon` is false, the maximum time supported is 3600
   * seconds; otherwise, it is 21,600 seconds.
   *
   * Example: "timeBudgetInSec":3600
   */
  @maxValue(21600)
  timeBudgetInSec?: float32;

  /**
   * Specifies the travel profile to consider when calculating the range polygon. If
   * not specified, the default value is "driving".
   *
   * Example: "travelMode":"driving"
   */
  travelMode?: RouteRangeTravelModeEnum = RouteRangeTravelModeEnum.driving;
}

/**
 * Specifies the vehicle attributes such as vehicle height, weight, max speed,
 * type of cargo, etc. to consider when calculating the reachable locations. This
 * helps avoid low bridge clearances, road restrictions, difficult right turns to
 * provide the optimized truck route based on the vehicle specifications. Vehicle
 * attributes are specified within the vehicleSpec property.
 */
model RouteRangeVehicleSpec {
  ...VehicleSpec;
  ...AxleCount;
}

/**
 * This object is returned from a successful call.
 */
model RouteRangeResponse {
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
  features?: RouteRangeFeaturesItem[];
}

/**
 * GeoJSON feature object that contains Geometry object and additional properties
 * of the route.
 */
model RouteRangeFeaturesItem {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is Feature. For
   * more information, see [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type?: FeaturesItemTypeEnum;

  /**
   * A valid `GeoJSON` Geometry object. Please refer to [RFC
   * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details.
   */
  geometry?: RouteRangeGeometry;

  /**
   * A rectangular area on the earth defined as a bounding box object. The sides of
   * the rectangles are defined by latitude and longitude values. For more
   * information, see [RFC 7946, Section
   * 5](https://www.rfc-editor.org/rfc/rfc7946#section-5).
   *
   * Example: "bbox": [-10.0, -10.0, 10.0, 10.0]
   */
  bbox?: float64[];

  /**
   * Route Ranges properties.
   */
  properties?: RouteRangeFeatureProperties;
}

/**
 * Route Ranges properties.
 */
model RouteRangeFeatureProperties {
  /**
   * The feature types for the feature objects returned in the response.
   */
  type?: RouteRangeTypeEnum;
}

/**
 * The list of route range queries/requests to process. The list can contain a max
 * of 100 queries and must contain at least 1 query.
 */
model RouteRangeBatchRequestBody {
  /**
   * The list of queries to process.
   */
  batchItems?: RouteRangeBatchRequestItem[];
}

/**
 * Batch Query object
 */
model RouteRangeBatchRequestItem {
  ...OptionalId;
  ...RouteRangeRequest;
}

/**
 * This object is returned from a successful Route Range Batch service call.
 */
model RouteRangeBatchResponse {
  /**
   * Summary for the batch request
   */
  summary?: RouteRangeBatchResponseSummary;

  /**
   * Array containing the batch results.
   */
  batchItems?: RouteRangeBatchResponseItem[];
}

/**
 * Summary for the batch request
 */
model RouteRangeBatchResponseSummary {
  /**
   * Number of successful requests in the batch
   */
  successfulRequests?: int32;

  /**
   * Total number of requests in the batch
   */
  totalRequests?: int32;
}

/**
 * error details
 */
model RouteRangeBatchResponseItem {
  ...OptionalId;
  ...RouteRangeResponse;

  /**
   * The error detail.
   */
  error?: ErrorDetail;
}

/**
 * Use to get a route matrix showing the travel time and distance for all possible
 * pairs in a list of origins and destination. `GeoJSON` feature object and
 * additional properties. Refer to [RFC
 * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details.
 */
model RouteMatrixRequest {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is
   * `FeatureCollection`. For more information, see [RFC
   * 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type: FeatureTypeEnum;

  /**
   * A set of origin and destination points passed as GeoJSON MultiPoint features
   * for the input matrix. Refer to [RFC
   * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details on the GeoJSON
   * format.
   */
  @minItems(2)
  @maxItems(2)
  features: InputRouteMatrixFeaturesItem[];

  /**
   * The date and time of departure from the origin point formatted as a `dateTime`
   * value defined by [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6). When a time zone
   * offset is not specified, UTC will be assumed.
   *
   * The `departAt` parameter cannot be used in conjunction with `arriveAt`.
   *
   * The `departAt` also supports:
   *
   *  `any` value tailored to the use case where the time context is irrelevant. The
   * `traffic=live` parameter value cannot be used together with `any`.
   *
   * `now` value to set the departure time to the processing time of each individual
   * cell. Processing time may be any time between submission and its completion.
   * This mode is best used together with traffic=live.
   *
   * Default value: `any` if `departAt` is not specified.
   *
   * Example:
   *
   * "departAt": "2024-12-01T09:30:00.000-07:00"
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  departAt?: utcDateTime;

  /**
   * The date and time of arrival at the destination point formatted as a `dateTime`
   * value defined by [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6). When a time zone
   * offset is not specified, UTC will be assumed.
   *
   * The `arriveAt` parameter cannot be used in conjunction with `departAt`.
   *
   * The `arriveAt` also supports `any` value which is tailored to the use case
   * where the time context is irrelevant. The `traffic=live` parameter value cannot
   * be used together with `any`.
   *
   * Default value: `any` if `arriveAt` is not specified.
   *
   * Example: "arriveAt": "2024-12-01T09:30:00.000-07:00"
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  arriveAt?: utcDateTime;

  /**
   * Specifies the travel profile to consider when calculating the matrix. If not
   * specified, the default value is "driving".
   *
   * Example: "travelMode":"driving"
   */
  travelMode?: RouteMatrixTravelModeEnum = RouteMatrixTravelModeEnum.driving;

  /**
   * Specifies the parameter to use to optimize the route. If not defined, the
   * default is "fastest" which returns the route to minimize the travel time.
   *
   * Example: "optimizeRoute":"fastest "
   */
  optimizeRoute?: RouteMatrixOptimizeRouteEnum = RouteMatrixOptimizeRouteEnum.Fastest;

  /**
   * Specifies how traffic is considered for computing routes.
   *
   * Default value: `historical`
   */
  traffic?: RouteMatrixTrafficEnum = RouteMatrixTrafficEnum.Historical;

  /**
   * Specifies restrictions that the route calculation should honor when determining
   * the route. Avoid supports multiple values in a request and is only supported
   * for the driving and truck travelMode.
   */
  avoid?: RouteMatrixAvoidEnum[];

  /**
   * Specifies the vehicle attributes such as vehicle height, weight, max speed,
   * type of cargo, etc. to consider when calculating the route matrix. This helps
   * avoid low bridge clearances, road restrictions, difficult right turns to
   * provide the optimized route based on the vehicle specifications. Vehicle
   * attributes are specified within the vehicleSpec property.
   */
  vehicleSpec?: RouteMatrixVehicleSpec;
}

/**
 * Specifies the input origin and destination points and additional properties for
 * the `GeoJSON` MultiPoint feature object. Refer to [RFC
 * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details.
 */
model InputRouteMatrixFeaturesItem {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is Feature. For
   * more information, see [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type: FeaturesItemTypeEnum;

  /**
   * A valid `GeoJSON MultiPoint` geometry type. Please refer to [RFC
   * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.3) for details.
   */
  geometry: GeoJsonMultiPoint;

  /**
   * MultiPoint feature properties object which specifies the origin features and
   * destination features for the input matrix.
   */
  properties: InputRouteMatrixProperties;
}

/**
 * A valid `GeoJSON MultiPoint` geometry type. Please refer to [RFC
 * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.3) for details.
 */
// FIXME: the discriminator is deeply nested, probably incorrectly reported warning
model GeoJsonMultiPoint extends GeoJsonGeometry {
  ...GeoJsonMultiPointData;

  /**
   * Specifies the `GeoJSON` type. Must be one of the nine valid GeoJSON object
   * types - Point, MultiPoint, LineString, MultiLineString, Polygon, MultiPolygon,
   * GeometryCollection, Feature and FeatureCollection.
   */
  type: GeoJsonObjectType.GeoJsonMultiPoint;
}

/**
 * Data contained by a `GeoJson MultiPoint`.
 */
model GeoJsonMultiPointData {
  /**
   * Coordinates for the `GeoJson MultiPoint` geometry.
   */
  coordinates: float64[][];
}

/**
 * Specifies the properties object for the input matrix.
 */
model InputRouteMatrixProperties {
  /**
   * Specifies the origin MultiPoint type and destination MultiPoint type for the
   * input matrix.
   */
  pointType?: RouteMatrixTypeEnum;
}

/**
 * Specifies the vehicle attributes such as vehicle height, weight, max speed,
 * type of cargo, etc. to consider when calculating the route matrix. This helps
 * avoid low bridge clearances, road restrictions, difficult right turns to
 * provide the optimized route based on the vehicle specifications. Vehicle
 * attributes are specified within the vehicleSpec property.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RouteMatrixVehicleSpec extends VehicleSpec {}

/**
 * This object is returned from a successful call.
 */
model RouteMatrixResponse {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is Feature. For
   * more information, see [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type: FeaturesItemTypeEnum;

  /**
   * The geometry object is null
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API contract"
  // FIXME: should this be specified as optional?
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract"
  geometry: Record<unknown> | null;

  /**
   * Route Matrix properties.
   */
  properties: RouteMatrixFeatureProperties;
}

/**
 * Route Matrix properties.
 */
model RouteMatrixFeatureProperties {
  /**
   * Summary for the route matrix request
   */
  summary?: RouteMatrixSummary;

  /**
   * The matrix of route results.
   */
  matrix?: RouteMatrixItemResult[];
}

/**
 * Summary for the route matrix request
 */
model RouteMatrixSummary {
  /**
   * Number of successful routes within this matrix.
   */
  successfulCount?: int32;

  /**
   * Total number of routes within this matrix.
   */
  totalCount?: int32;
}

/**
 * Route Matrix item result
 */
model RouteMatrixItemResult {
  /**
   * The HTTP status code of the current cell.
   */
  statusCode?: int32;

  /**
   * Index of the origin point
   */
  originIndex?: int32;

  /**
   * Index of the destination point
   */
  destinationIndex?: int32;

  /**
   * The estimated departure time, which takes into account the traffic conditions,
   * is formatted as a `dateTime` value defined by [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6). It will reference the
   * timezone offset by either `departAt` or `arrivalAt`. If not, then the UTC time
   * will be used. If departAt or arriveAt is `any`, then departureAt is absent.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  departureAt?: utcDateTime;

  /**
   * The estimated arrival time, which takes into account the traffic conditions, is
   * formatted as a `dateTime` value defined by [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6). It will reference the
   * timezone offset by either `departAt` or `arrivalAt`. If not, then the UTC time
   * will be used. If departAt or arriveAt is any, then departureAt is absent.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  arrivalAt?: utcDateTime;

  /**
   * Length In Meters property
   */
  distanceInMeters?: float64;

  /**
   * Estimated travel time in seconds that does not include delays on the route due
   * to traffic conditions.
   */
  durationInSeconds?: int64;

  /**
   * The time that it takes, in seconds, to travel a corresponding `TravelDistance`
   * with current traffic conditions. This value is provided if `optimizeRoute`
   * includes traffic considerations.
   */
  durationTrafficInSeconds?: int64;

  /**
   * The error detail.
   */
  error?: ErrorDetail;
}

/**
 * Use to get a route matrix showing the travel time and distance for all possible
 * pairs in a list of origins and destination. `GeoJSON` feature object and
 * additional properties. Refer to [RFC
 * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details.
 */
model RouteMatrixAsyncRequest {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is
   * `FeatureCollection`. For more information, see [RFC
   * 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type: FeatureTypeEnum;

  /**
   * A set of origin and destination points passed as GeoJSON MultiPoint features
   * for the input matrix. Refer to [RFC
   * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details on the GeoJSON
   * format.
   */
  @minItems(2)
  @maxItems(2)
  features: InputRouteMatrixFeaturesItem[];

  /**
   * The date and time of departure from the origin point formatted as a `dateTime`
   * value defined by [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6). When a time zone
   * offset is not specified, UTC will be assumed.
   *
   * The `departAt` parameter cannot be used in conjunction with `arriveAt`.
   *
   * The `departAt` also supports:
   *
   *  `any` value tailored to the use case where the time context is irrelevant. The
   * `traffic=live` parameter value cannot be used together with `any`.
   *
   * `now` value to set the departure time to the processing time of each individual
   * cell. Processing time may be any time between submission and its completion.
   * This mode is best used together with traffic=live.
   *
   * Default value: `any` if `departAt` is not specified.
   *
   * Example:
   *
   * "departAt": "2024-12-01T09:30:00.000-07:00"
   */
  departAt?: string;

  /**
   * The date and time of arrival at the destination point formatted as a `dateTime`
   * value defined by [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6). When a time zone
   * offset is not specified, UTC will be assumed.
   *
   * The `arriveAt` parameter cannot be used in conjunction with `departAt`.
   *
   * The `arriveAt` also supports `any` value which is tailored to the use case
   * where the time context is irrelevant. The `traffic=live` parameter value cannot
   * be used together with `any`.
   *
   * Default value: `any` if `arriveAt` is not specified.
   *
   * Example: "arriveAt": "2024-12-01T09:30:00.000-07:00"
   */
  arriveAt?: string;

  /**
   * Specifies the travel profile to consider when calculating the matrix. If not
   * specified, the default value is "driving".
   *
   * Example: "travelMode":"driving"
   */
  travelMode?: RouteMatrixTravelModeEnum = RouteMatrixTravelModeEnum.driving;

  /**
   * Specifies the parameter to use to optimize the route. If not defined, the
   * default is "fastest" which returns the route to minimize the travel time.
   *
   * Example: "optimizeRoute":"shortest"
   */
  optimizeRoute?: RouteMatrixAsyncOptimizeRouteEnum = RouteMatrixAsyncOptimizeRouteEnum.Fastest;

  /**
   * Specifies how traffic is considered for computing routes.
   *
   * Default value: `historical`
   */
  traffic?: RouteMatrixTrafficEnum = RouteMatrixTrafficEnum.Historical;

  /**
   * Specifies restrictions that the route calculation should honor when determining
   * the route. Avoid supports multiple values in a request and is only supported
   * for the driving and truck travelMode.
   */
  avoid?: RouteMatrixAvoidEnum[];

  /**
   * Specifies the vehicle attributes such as vehicle height, weight, max speed,
   * type of cargo, etc. to consider when calculating the route matrix. This helps
   * avoid low bridge clearances, road restrictions, difficult right turns to
   * provide the optimized route based on the vehicle specifications. Vehicle
   * attributes are specified within the vehicleSpec property.
   */
  vehicleSpec?: RouteMatrixVehicleSpec;
}

/**
 * This object is returned from a successful Get Operation request.
 */
model RouteOperation {
  /**
   * Unique identifier for the asynchronous operation.
   */
  id?: string;

  /**
   * Current status of the async operation.
   */
  @lroStatus
  status?: StatusEnum;

  /**
   * Type of asynchronous operation
   */
  kind?: RouteOperationKindEnum;

  /**
   * The result of async operation
   */
  result?: RouteOperationResult;

  /**
   * Timestamp when the operation was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Timestamp when the operation status was updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActionAt?: utcDateTime;

  /**
   * The error detail.
   */
  error?: ErrorDetail;
}

/**
 * The result of async operation
 */
model RouteOperationResult {
  /**
   * URL to the get the result of async operation
   */
  resultUrl?: url;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error
 * details for failed operations. (This also follows the OData error response
 * format.).
 */
@error
model ErrorResponse {
  /**
   * Error code of the error that occurred.
   */
  @header("x-ms-error-code")
  errorCode?: string;

  /**
   * The error object.
   */
  error?: ErrorDetail;
}

/**
 * This object represents the result of a successful route operation.
 */
@discriminator("kind")
model RouteOperationResponse {
  /**
   * Type of asynchronous operation
   */
  kind: RouteOperationKindEnum;
}

/**
 * Specifies the driving instructions and additional properties for each maneuver
 * point in the route Leg.
 */
model RouteMatrixAsyncResponse extends RouteOperationResponse {
  ...RouteMatrixResponse;

  /**
   * Type of asynchronous operation
   */
  kind: "RouteMatrix";
}

/**
 * The origin point passed as a valid `GeoJSON` Geometry object, from which the
 * range polygon should be calculated. Please refer to [RFC
 * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details.
 *
 * `Note`: The API will snap the requested origin point to the nearest road
 * network and will use that for range calculation. It will be returned as a
 * `center` point in the response.
 */
model PointGeometry extends RouteDirectionsGeometry {
  ...GeoJsonPoint;
}

/**
 * Specifies the `GeoJSON` MultiLineString Geometry object. For more information,
 * see [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
 */
model MultiLineStringGeometry extends RouteDirectionsGeometry {
  ...GeoJsonMultiLineString;
}

/** GeoJson MultiLineString data */
model GeoJsonMultiLineStringData {
  /**
   * Coordinates for the `GeoJson MultiLineString` geometry.
   */
  coordinates: float64[][][];
}

/**
 * Specifies the `GeoJSON` Polygon Geometry object. Refer to [RFC
 * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details.
 */
model RouteRangePolygonGeometry extends RouteRangeGeometry {
  ...GeoJsonPolygon;
}

/** GeoJson Polygon data */
model GeoJsonPolygonData {
  /**
   * Coordinates for the `GeoJson Polygon` geometry type.
   */
  coordinates: float64[][][];
}

/**
 * Specifies the properties of a waypoint which is a specific location or point
 * along a route or trip that serves as a reference or stopping point.
 */
model WaypointProperties extends FeatureProperties {
  ...NavigationPointProperties;

  /**
   * Output type.
   */
  type: "Waypoint";
}

/**
 * Waypoint and ManeuverPoint properties.
 */
model NavigationPointProperties {
  /**
   * Refers to the index of a point within a specific Leg of a route.
   */
  routePathPoint?: RoutePathPoint;

  /**
   * Sequence for visiting waypoints.
   */
  order?: Order;

  /**
   * Steps between two consecutive maneuver points.
   */
  steps?: RouteStep[];

  /**
   * A description of a maneuver in a set of directions.
   */
  instruction?: Instruction;

  /**
   * The administrative district and country region for the waypoints and maneuver
   * points on the route.
   */
  address?: NavigationPointPropertiesAddress;

  /**
   * The side of the street where the destination is found based on the arrival
   * direction. This field applies to the last maneuverPoint only.
   */
  sideOfStreet?: SideOfStreetEnum;

  /**
   * Signage text for the route. There may be more than one sign value.
   */
  signs?: string[];

  /**
   * The name of the street that the route goes towards in the first `ManeuverPoint`.
   */
  towardsRoadName?: string;

  /**
   * The name or number of the exit associated with this route step.
   */
  exitIdentifier?: string;

  /**
   * The physical distance in meters covered by this route step.
   */
  distanceInMeters?: float32;

  /**
   * The time that it takes, in seconds, to travel a corresponding `TravelDistance`.
   */
  durationInSeconds?: int64;

  /**
   * The mode of travel for the route path in the response.
   */
  travelMode?: RoutePathTravelModeEnum = RoutePathTravelModeEnum.driving;
}

/**
 * Refers to the index of a point within a specific Leg of a route.
 */
model RoutePathPoint {
  /**
   * The route Leg index is a sequential number assigned to each Leg of the route to
   * help identify and distinguish between different segments of the route.
   */
  legIndex?: int64;

  /**
   * Index of a point within a specific Leg.
   */
  pointIndex?: int64;
}

/**
 * Sequence for visiting waypoints.
 */
model Order {
  /**
   * User-provided index for waypoint
   */
  inputIndex?: int64;

  /**
   * System-optimized waypoint
   */
  optimizedIndex?: int64;
}

/**
 * A route Leg contain turn-by-turn instructions. A step refers to a range of a
 * route between two consecutive maneuverPoint.
 */
model RouteStep {
  /**
   * The type of maneuver described in this detailed collection. The ManeuverType
   * provides information for a portion of the maneuver specified by the
   * corresponding instruction. For example, the maneuverType of an instruction may
   * specify TurnLeftThenTurnRight, while the associated detail items may provide
   * specifics about the TurnLeft and TurnRight maneuvers
   */
  maneuverType?: ManeuverTypeEnum;

  /**
   * A street, highway or intersection where the maneuver occurs. If the maneuver is
   * complex, there may be more than one name field in the details collection. The
   * name field may also have no value. This can occur if the name is not known or
   * if a street, highway or intersection does not have a name.
   */
  names?: string[];

  /**
   * Refers to the range covered by a specific Leg of a route or path.
   */
  routePathRange?: RoutePathRange;
}

/**
 * Refers to the range covered by a specific Leg of a route or path.
 */
model RoutePathRange {
  /**
   * Refers to the range covered by a specific Leg of a route or path.
   */
  range?: int64[];

  /**
   * The route Leg index is a sequential number assigned to each Leg of the route to
   * help identify and distinguish between different segments of the route.
   */
  legIndex?: int64;
}

/**
 * A description of a maneuver in a set of directions.
 */
model Instruction {
  /**
   * The type of maneuver described in this detailed collection. The ManeuverType
   * provides information for a portion of the maneuver specified by the
   * corresponding instruction. For example, the maneuverType of an instruction may
   * specify TurnLeftThenTurnRight, while the associated detail items may provide
   * specifics about the TurnLeft and TurnRight maneuvers
   */
  maneuverType?: ManeuverTypeEnum;

  /**
   * The plain text description of the instruction.
   */
  text?: string;

  /**
   * The formatted text description of the instruction.
   */
  formattedText?: string;

  /**
   * Indicates left-hand vs. right-hand side driving at the point of the maneuver.
   */
  drivingSide?: DrivingSideEnum;
}

/**
 * The administrative district and country region for the waypoints and maneuver
 * points on the route.
 */
model NavigationPointPropertiesAddress {
  /**
   * Represents a country or region, containing related details.
   */
  countryRegion?: CountryRegion;

  /**
   * The subdivision name in the country or region for an address. This element is
   * typically treated as the first order administrative subdivision, but in some
   * cases it also contains the second, third, or fourth order subdivision in a
   * country, dependency, or region.
   */
  adminDistricts?: AdminDistrict[];
}

/**
 * Represents a country or region, containing related details.
 */
model CountryRegion {
  /**
   * name of country/region
   */
  name?: string;

  /**
   * ISO of country/region represents an [ISO 3166-1 Alpha-2 region/country
   * code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
  ISO?: string;
}

/**
 * The subdivision name in the country or region for an address. This element is
 * typically treated as the first order administrative subdivision, but in some
 * cases it also contains the second, third, or fourth order subdivision in a
 * country, dependency, or region.
 */
model AdminDistrict {
  /**
   * The short name for the corresponding adminDistrict field,
   * For adminDistrict[0], this could be short name of state such as WA. This is
   * only available for the US, Canada, and Mexico.
   */
  shortName?: string;
}

/**
 * Specifies the driving instructions and additional properties for each maneuver
 * point in the route Leg.
 */
model ManeuverPointProperties extends FeatureProperties {
  ...NavigationPointProperties;

  /**
   * Output type.
   */
  type: "ManeuverPoint";
}

/**
 * Specifies the properties that describe the route's path in the response.
 */
model RoutePathProperties extends FeatureProperties {
  /**
   * The physical distance in meters covered by the entire route.
   */
  distanceInMeters?: float32;

  /**
   * Estimated travel time in seconds that does not include delays on the route due
   * to traffic conditions.
   */
  durationInSeconds?: int64;

  /**
   * The time that it takes, in seconds, to travel a corresponding `TravelDistance`
   * with current traffic conditions. This value is provided if `optimizeRoute`
   * includes traffic considerations.
   */
  durationTrafficInSeconds?: int64;

  /**
   * The estimated departure time for the leg, which takes into account the traffic
   * conditions, is formatted as a `dateTime` value defined by [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6). It will reference the
   * timezone offset by either `departAt` or `arrivalAt`. If not, then the UTC time
   * will be used.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  departureAt?: utcDateTime;

  /**
   * The estimated arrival time for the leg, which takes into account the traffic
   * conditions, is formatted as a `dateTime` value defined by [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6). It will reference the
   * timezone offset by either `departAt` or `arrivalAt`. If not, then the UTC time
   * will be used.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  arrivalAt?: utcDateTime;

  /**
   * The level of traffic congestion along the route. `Note`: Only supported for
   * driving travelMode
   */
  trafficCongestion?: TrafficCongestionEnum;

  /**
   * An array of route Legs. Check route Leg object description for more information.
   */
  legs?: RouteLeg[];

  /**
   * Optimized sequence of waypoints. It shows the index from the user provided
   * waypoint sequence for the original and optimized lists.
   */
  optimizedWaypoints?: OptimizedWaypoint[];

  /**
   * Output type.
   */
  type: "RoutePath";
}

/**
 * Information about a section of a route between two waypoints. More information
 * about the fields contained in a route Leg:
 */
model RouteLeg {
  /**
   * Refers to the range covered by a specific Leg of a route or path.
   */
  routePathRange?: RoutePathRange;

  /**
   * The physical distance in meters covered by a route Leg.
   */
  distanceInMeters?: float32;

  /**
   * Estimated travel time in seconds that does not include delays on the route due
   * to traffic conditions.
   */
  durationInSeconds?: int64;

  /**
   * The time that it takes, in seconds, to travel a corresponding `TravelDistance`
   * with current traffic conditions. This value is provided if `optimizeRoute`
   * includes traffic considerations.
   */
  durationTrafficInSeconds?: int64;

  /**
   * The estimated departure time for the leg, which takes into account the traffic
   * conditions, is formatted as a dateTime value defined by [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6). It will reference the
   * timezone offset by either `departAt` or `arrivalAt`. If not, then the UTC time
   * will be used.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  departureAt?: utcDateTime;

  /**
   * The estimated arrival time for the leg, which takes into account the traffic
   * conditions, is formatted as a dateTime value defined by [RFC 3339, section
   * 5.6](https://www.rfc-editor.org/rfc/rfc3339#section-5.6). It will reference the
   * timezone offset by either `departAt` or `arrivalAt`. If not, then the UTC time
   * will be used.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  arrivalAt?: utcDateTime;
}

/**
 * Optimized way point object.
 */
model OptimizedWaypoint {
  /**
   * Way point index provided by the user.
   */
  inputIndex?: int64;

  /**
   * Optimized way point index from the system.
   */
  optimizedIndex?: int64;
}

/**
 * Specifies the starting point for range calculation. `GeoJSON` feature object
 * and additional properties. Refer to [RFC
 * 7946](https://www.rfc-editor.org/rfc/rfc7946) for details.
 */
model InputRouteRangeFeaturesItem {
  /**
   * Specifies the `GeoJSON` type. The only supported object type is Feature. For
   * more information, see [RFC 7946](https://www.rfc-editor.org/rfc/rfc7946).
   */
  type: FeaturesItemTypeEnum;

  /**
   * A valid `GeoJSON Point` geometry type. Please refer to [RFC
   * 7946](https://tools.ietf.org/html/rfc7946#section-3.1.2) for details.
   */
  geometry: GeoJsonPoint;

  /**
   * Route Ranges properties.
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Existing API contract"
  properties: Record<unknown>;
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
  type: GeoJsonObjectType.GeoJsonPoint;
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
  type: GeoJsonObjectType.GeoJsonLineString;
}

/** GeoJson LineString data */
model GeoJsonLineStringData {
  /**
   * Coordinates for the `GeoJson LineString` geometry.
   */
  coordinates: float64[][];
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
  type: GeoJsonObjectType.GeoJsonMultiLineString;
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
  type: GeoJsonObjectType.GeoJsonPolygon;
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
  type: GeoJsonObjectType.GeoJsonMultiPolygon;
}

/** GeoJson MultiPolygon data */
model GeoJsonMultiPolygonData {
  /**
   * Contains a list of valid `GeoJSON Polygon` objects. **Note** that coordinates
   * in GeoJSON are in x, y order (longitude, latitude).
   */
  coordinates: float64[][][][];
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
  type: GeoJsonObjectType.GeoJsonGeometryCollection;
}

/**
 * GeoJson GeometryCollection data.
 */
model GeoJsonGeometryCollectionData {
  /**
   * Contains a list of valid `GeoJSON` geometry objects. **Note** that coordinates
   * in GeoJSON are in x, y order (longitude, latitude).
   */
  geometries: GeoJsonGeometry[];
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
  type: GeoJsonObjectType.GeoJsonFeature;
}

/**
 * GeoJson Feature data.
 */
model GeoJsonFeatureData {
  /**
   * A valid `GeoJSON` geometry object. The type must be one of the seven valid
   * GeoJSON geometry types - Point, MultiPoint, LineString, MultiLineString,
   * Polygon, MultiPolygon and GeometryCollection. Please refer to [RFC
   * 7946](https://tools.ietf.org/html/rfc7946#section-3.1) for details.
   */
  geometry: GeoJsonGeometry;

  /**
   * Properties can contain any additional metadata about the `Feature`. Value can
   * be any JSON object or a JSON null value
   */
  // FIXME: should this be specified as optional?
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Existing API contract"
  properties?: Record<unknown> | null;

  /**
   * Identifier for the feature.
   */
  id?: string;

  /**
   * The type of the feature. The value depends on the data model the current
   * feature is part of. Some data models may have an empty value.
   */
  featureType?: string;
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
  type: GeoJsonObjectType.GeoJsonFeatureCollection;
}

/**
 * GeoJson FeatureCollection data.
 */
model GeoJsonFeatureCollectionData {
  /**
   * Contains a list of valid `GeoJSON Feature` objects.
   */
  features: GeoJsonFeature[];
}

alias AcceptLanguageHeader = {
  /**
   * Language in which routing results should be returned.
   *
   * For more information, see [Localization support in Azure
   * Maps](https://learn.microsoft.com/azure/azure-maps/supported-languages#routing-v2-services-preview-supported-languages).
   */
  @header("Accept-Language")
  acceptLanguage?: string;
};

alias OperationIdPathParameter = {
  /**
   * System generated unique identifier for the asynchronous operation after it has
   * been submitted.
   */
  @maxLength(36)
  @minLength(36)
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  @path
  id: string;
};

alias ClientIdHeader = {
  /**
   * Indicates the account intended for use with the Microsoft Entra ID security
   * model. This unique ID for the Azure Maps account can be obtained from the
   * [Azure Maps management plane Account API](/rest/api/maps-management/accounts).
   * For more information on using Microsoft Entra ID security in Azure Maps, see
   * [Manage authentication in Azure
   * Maps](/azure/azure-maps/how-to-manage-authentication).
   */
  @header("x-ms-client-id")
  clientId?: string;
};
