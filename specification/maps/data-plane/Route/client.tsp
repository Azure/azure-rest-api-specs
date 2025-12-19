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
