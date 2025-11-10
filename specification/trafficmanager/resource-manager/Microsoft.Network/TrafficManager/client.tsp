import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Network;

// @@alternateType(HeatMapModelsOps.HeatMapType, string, "go");

// Removed invalid @@override decorator as it can only be applied to operations.
// @@alternateType(HeatMapModels.get::parameters.heatMapType, "default", "go");
@@alternateType(HeatMapType, "default", "go");
@@alternateType(HeatMapType, string, "go");
// @@override(HeatMapModels.get::parameters.ApiVersionParameter, "default", "go");
