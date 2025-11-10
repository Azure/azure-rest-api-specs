import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@override(HeatMapModels.get, HeatMapModels.getReplace, "go"); 
@@alternateType(HeatMapModels.getReplace::parameters.heatMapType, "default", "go");
