import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@alternateType(HeatMapType, string, "go");
