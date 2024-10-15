import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureFleet;

@@clientName(Microsoft.ContainerService, "ContainerServiceFleetMgmt", "python");
