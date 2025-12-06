import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.AI.Projects;

namespace Customizations;

@@clientNamespace(Azure.AI.Projects, "Azure.AI.Agents", "csharp");
@@clientNamespace(Azure.AI.Projects, "com.azure.ai.agents", "java");

// ------------------------------------------------------------------------------------------------
// Operation scope customizations - don't generate Responses. We will use OpenAI client for those
// ------------------------------------------------------------------------------------------------
@@scope(Responses.createResponse, "!(csharp, python, java, javascript)");
@@scope(Responses.createResponseStream, "!(csharp, python, java, javascript)");
@@scope(Responses.getResponseStream, "!(csharp, python, java, javascript)");
@@scope(Responses.getResponse, "!(csharp, python, java, javascript)");
@@scope(Responses.deleteResponse, "!(csharp, python, java, javascript)");
@@scope(Responses.cancelResponse, "!(csharp, python, java, javascript)");
@@scope(Responses.listInputItems, "!(csharp, python, java, javascript)");
@@scope(Responses.listResponses, "!(csharp, python, java, javascript)");

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
@@clientName(Agents, "AgentsClient", "csharp, python, java");

// --------------------------------------------------------------------------------
// Usage / Public accessibility overrides
// --------------------------------------------------------------------------------

@@usage(OpenAI.ItemResource, Usage.json);
@@usage(OpenAI.ResponseStreamEvent, Usage.json);

@@usage(AgentId, Usage.output);
@@access(AgentId, Access.public);

@@usage(AgentReference, Usage.input);
@@access(AgentReference, Access.public);

@@usage(ApiError, Usage.output);
@@access(ApiError, Access.public);

@@usage(MemoryStoreUpdateResponse, Usage.output);
@@access(MemoryStoreUpdateResponse, Access.public);
