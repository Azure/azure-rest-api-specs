import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
import "./endpoints/client.tsp";
import "./agents/client.tsp";
import "./evaluations/client.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Azure.AI.Client, "AzureAIClient"); // This is the name of the generated client class.
