import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Network;

// @@alternateType(HeatMapModelsOps.HeatMapType, string, "go");
@@alternateType(HeatMapType, string, "go");
