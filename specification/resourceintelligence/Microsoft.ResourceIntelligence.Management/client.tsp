import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ResourceIntelligence;

// SDK client configuration for Agent Builder resources
@@clientName(Agents, "AgentsClient", "csharp");
@@clientName(Threads, "ThreadsClient", "csharp");
@@clientName(ThreadRuns, "ThreadRunsClient", "csharp");
@@clientName(Messages, "MessagesClient", "csharp");
