import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
import "./connections/client.tsp";
import "./agents/client.tsp";
import "./evaluations/client.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Azure.AI.Client, "AzureAIClient");
