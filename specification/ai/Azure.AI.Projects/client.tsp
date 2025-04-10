import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
import "./evaluations/client.tsp";
import "./evaluation-results/client.tsp";
import "./red-teams/client.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Azure.AI.Projects, "AIProjectClient");
