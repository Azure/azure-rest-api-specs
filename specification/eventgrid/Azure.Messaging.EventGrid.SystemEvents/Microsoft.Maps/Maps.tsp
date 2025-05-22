/** Describes the schema of the Azure Maps events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

/** Schema of the Data property of an EventGridEvent for a Microsoft.Maps.GeofenceEntered event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model MapsGeofenceEnteredEventData extends MapsGeofenceEventProperties {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Maps.GeofenceExited event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model MapsGeofenceExitedEventData extends MapsGeofenceEventProperties {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Maps.GeofenceResult event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model MapsGeofenceResultEventData extends MapsGeofenceEventProperties {}

/** Schema of the Data property of an EventGridEvent for a Geofence event (GeofenceEntered, GeofenceExited, GeofenceResult). */
model MapsGeofenceEventProperties {
  /** Lists of the geometry ID of the geofence which is expired relative to the user time in the request. */
  expiredGeofenceGeometryId?: string[];

  /** Lists the fence geometries that either fully contain the coordinate position or have an overlap with the searchBuffer around the fence. */
  geometries: MapsGeofenceGeometry[];

  /** Lists of the geometry ID of the geofence which is in invalid period relative to the user time in the request. */
  invalidPeriodGeofenceGeometryId?: string[];

  /** True if at least one event is published to the Azure Maps event subscriber, false if no event is published to the Azure Maps event subscriber. */
  isEventPublished?: boolean;
}

/** The geofence geometry. */
model MapsGeofenceGeometry {
  /** ID of the device. */
  deviceId?: string;

  /** Distance from the coordinate to the closest border of the geofence. Positive means the coordinate is outside of the geofence. If the coordinate is outside of the geofence, but more than the value of searchBuffer away from the closest geofence border, then the value is 999. Negative means the coordinate is inside of the geofence. If the coordinate is inside the polygon, but more than the value of searchBuffer away from the closest geofencing border,then the value is -999. A value of 999 means that there is great confidence the coordinate is well outside the geofence. A value of -999 means that there is great confidence the coordinate is well within the geofence. */
  distance?: float32;

  /** The unique ID for the geofence geometry. */
  geometryId?: string;

  /** Latitude of the nearest point of the geometry. */
  nearestLat?: float32;

  /** Longitude of the nearest point of the geometry. */
  nearestLon?: float32;

  /** The unique id returned from user upload service when uploading a geofence. Will not be included in geofencing post API. */
  udId?: string;
}
