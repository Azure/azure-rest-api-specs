//
// This file is used for emitting a Python client for the sole
// purpose of emitting Evaluation classes that gets converted into TypeDicts for 
// type hinting. These classes are not part of azure-ai-projects, since Evaluation operations
// is done using OpenAI client.
//
import "./src/common/service.tsp";
import "./src/openai-evaluations/routes.tsp";

using Azure.ClientGenerator.Core;
using Azure.AI.Projects;

@@clientName(Azure.AI.Projects, "AIProjectClient");


// To fix circular dependency in Python, remaining OpenAI types are emitted as Azure.AI.Projects
@@clientNamespace(OpenAI, "azure.ai.projects", "python");
