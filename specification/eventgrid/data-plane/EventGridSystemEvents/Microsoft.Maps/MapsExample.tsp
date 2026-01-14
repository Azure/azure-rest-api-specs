import "./Maps.tsp";
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftMapsGeofenceEnteredExample: MapsGeofenceEnteredEventData = #{
  geometries: #[
    #{
      deviceId: "device_1",
      udId: "1a13b444-4acf-32ab-ce4e-9ca4af20b169",
      geometryId: "2",
      distance: -999.0,
      nearestLat: 47.618786,
      nearestLon: -122.132151,
    }
  ],
  isEventPublished: true,
  expiredGeofenceGeometryId: #[],
  invalidPeriodGeofenceGeometryId: #[],
};

const MicrosoftMapsGeofenceResultExample: MapsGeofenceResultEventData = #{
  geometries: #[
    #{
      deviceId: "device_1",
      udId: "1a13b444-4acf-32ab-ce4e-9ca4af20b169",
      geometryId: "1",
      distance: 999.0,
      nearestLat: 47.609833,
      nearestLon: -122.148274,
    },
    #{
      deviceId: "device_1",
      udId: "1a13b444-4acf-32ab-ce4e-9ca4af20b169",
      geometryId: "2",
      distance: 999.0,
      nearestLat: 47.621954,
      nearestLon: -122.131841,
    }
  ],
  isEventPublished: true,
  expiredGeofenceGeometryId: #[],
  invalidPeriodGeofenceGeometryId: #[],
};
