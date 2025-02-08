import "@azure-tools/typespec-client-generator-core";
import "./projects.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Azure.AI.Projects, "AIProjectClient");
