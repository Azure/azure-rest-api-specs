import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MapsRoute;

@@clientName(VehicleSpec.length, "lengthInMeters");
@@clientName(VehicleSpec.width, "widthInMeters");
@@clientName(VehicleSpec.height, "heightInMeters");
@@clientName(VehicleSpec.weight, "weightInKilograms");
@@clientName(VehicleSpec.maxSpeed, "maxSpeedInKilometersPerHour");
@@clientName(VehicleSpec.axleWeight, "axleWeightInKilograms");

@@clientLocation(RouteOperationGroup.route_PostRouteDirections, "Route");
@@clientName(RouteOperationGroup.route_PostRouteDirections,
  "PostRouteDirections"
);
@@clientLocation(RouteOperationGroup.route_PostRouteDirectionsBatch, "Route");
@@clientName(RouteOperationGroup.route_PostRouteDirectionsBatch,
  "PostRouteDirectionsBatch"
);
@@clientLocation(RouteOperationGroup.route_PostSnapToRoads, "Route");
@@clientName(RouteOperationGroup.route_PostSnapToRoads, "PostSnapToRoads");
@@clientLocation(RouteOperationGroup.route_PostSnapToRoadsBatch, "Route");
@@clientName(RouteOperationGroup.route_PostSnapToRoadsBatch,
  "PostSnapToRoadsBatch"
);
@@clientLocation(RouteOperationGroup.route_PostRouteRange, "Route");
@@clientName(RouteOperationGroup.route_PostRouteRange, "PostRouteRange");
@@clientLocation(RouteOperationGroup.route_PostRouteRangeBatch, "Route");
@@clientName(RouteOperationGroup.route_PostRouteRangeBatch,
  "PostRouteRangeBatch"
);
@@clientLocation(RouteOperationGroup.route_PostRouteMatrix, "Route");
@@clientName(RouteOperationGroup.route_PostRouteMatrix, "PostRouteMatrix");
@@clientLocation(RouteOperationGroup.route_PostRouteMatrixAsync, "Route");
@@clientName(RouteOperationGroup.route_PostRouteMatrixAsync,
  "PostRouteMatrixAsync"
);
@@clientLocation(RouteOperationGroup.getRouteOperationsStatus, "Route");
@@clientLocation(RouteOperationGroup.route_GetOperationResult, "Route");
@@clientName(RouteOperationGroup.route_GetOperationResult,
  "GetRouteOperationsResult"
);
