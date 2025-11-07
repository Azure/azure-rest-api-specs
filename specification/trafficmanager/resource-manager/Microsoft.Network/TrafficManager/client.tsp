import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Network;
@@alternateType(HeatMapModels.get::parameters.heatMapType, "default", "go");
