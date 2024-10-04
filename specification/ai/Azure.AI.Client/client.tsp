import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
import "./endpoints/client.tsp";
import "./agents/client.tsp";
import "./evaluations/client.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Azure.AI, "AzureAIClient");
@@clientName(Dataset.type, ""); /* Temp fix should be removed after service side fix */
@@clientName(Dataset.id, "uri"); /*  Temp fix should be removed after service side fix */