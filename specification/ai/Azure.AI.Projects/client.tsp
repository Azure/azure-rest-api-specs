import "@azure-tools/typespec-client-generator-core";
import "./projects.tsp";

using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

@@clientName(Azure.AI.Projects, "AIProjectClient");
