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

@@clientLocation(Route.postRouteDirections, "Route");
@@clientName(Route.postRouteDirections, "PostRouteDirections");
@@clientLocation(Route.postRouteDirectionsBatch, "Route");
@@clientName(Route.postRouteDirectionsBatch, "PostRouteDirectionsBatch");
@@clientLocation(Route.postSnapToRoads, "Route");
@@clientName(Route.postSnapToRoads, "PostSnapToRoads");
@@clientLocation(Route.postSnapToRoadsBatch, "Route");
@@clientName(Route.postSnapToRoadsBatch, "PostSnapToRoadsBatch");
@@clientLocation(Route.postRouteRange, "Route");
@@clientName(Route.postRouteRange, "PostRouteRange");
@@clientLocation(Route.postRouteRangeBatch, "Route");
@@clientName(Route.postRouteRangeBatch, "PostRouteRangeBatch");
@@clientLocation(Route.postRouteMatrix, "Route");
@@clientName(Route.postRouteMatrix, "PostRouteMatrix");
@@clientLocation(Route.postRouteMatrixAsync, "Route");
@@clientName(Route.postRouteMatrixAsync, "PostRouteMatrixAsync");
@@clientLocation(Route.getRouteOperationsStatus, "Route");
@@clientLocation(Route.getOperationResult, "Route");
@@clientName(Route.getOperationResult, "GetRouteOperationsResult");
