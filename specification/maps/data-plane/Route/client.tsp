import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MapsRoute;

@@clientName(VehicleSpec.length, "lengthInMeters", "!autorest");
@@clientName(VehicleSpec.width, "widthInMeters", "!autorest");
@@clientName(VehicleSpec.height, "heightInMeters", "!autorest");
@@clientName(VehicleSpec.weight, "weightInKilograms", "!autorest");
@@clientName(VehicleSpec.maxSpeed, "maxSpeedInKilometersPerHour", "!autorest");
@@clientName(VehicleSpec.axleWeight, "axleWeightInKilograms", "!autorest");
