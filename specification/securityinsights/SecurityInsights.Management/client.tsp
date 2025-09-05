import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.SecurityInsights;
using Azure.ClientGenerator.Core;

@@clientName(Azure.ResourceManager.CommonTypes.ActionType, "OperationActionType", "java");