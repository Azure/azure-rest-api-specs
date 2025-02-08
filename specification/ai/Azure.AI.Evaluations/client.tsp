import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
import "./client.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Azure.AI.Evaluations, "AIEvaluationsClient");
