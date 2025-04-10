import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
import "./evaluations/client.tsp";
import "./evaluations-results/client.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Azure.AI.Projects, "AIProjectClient");
