import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core/experimental";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core.Experimental;

using Azure.AI.Projects;

// --------------------------------------------------------------------------------
// Renames
// --------------------------------------------------------------------------------

@@clientNamespace(Azure.AI.Projects, "com.azure.ai.agents", "java");
@@clientName(Azure.AI.Projects, "AgentsClient");

@@clientName(OpenAI.OutputTextContent.logprobs, "logProbs");
@@clientName(OpenAI.LocalShellExecAction.timeout_ms, "Duration");
@@clientName(OpenAI.LogProb.logprob, "logProb");
@@clientName(MicrosoftFabricPreviewTool.fabric_dataagent_preview,
  "FabricDataAgentPreview"
);

@@clientName(AgentObject, "AgentDetails");
@@clientName(AgentVersionObject, "AgentVersionDetails");
@@clientName(AgentContainerObject, "AgentContainerDetails");
@@clientName(AgentContainerOperationObject, "AgentContainerOperationDetails");

@@clientName(MemoryStoreObject, "MemoryStoreDetails");

@@clientName(Agents.getAgentVersion, "getAgentVersionDetails");

@@clientName(AzureAISearchTool.azure_ai_search, "AzureAISearch");

@@clientName(OpenAI.FileSearchTool.max_num_results, "maxResults");
@@clientName(OpenAI.MCPApprovalResponse.approve, "approved");

// ------------------------------------------------------------------------------------------------
// Operation scope customizations - don't generate agent container operations
// ------------------------------------------------------------------------------------------------
@@scope(Agents.startAgentContainer, "!java");
@@scope(Agents.stopAgentContainer, "!java");
@@scope(Agents.updateAgentContainer, "!java");
@@scope(Agents.deleteAgentContainer, "!java");
@@scope(Agents.getAgentContainer, "!java");
@@scope(Agents.getAgentContainerOperation, "!java");
@@scope(Agents.listAgentContainerOperations, "!java");
@@scope(Agents.listAgentVersionContainerOperations, "!java");
@@scope(Agents.getAgentContainerOperation, "!java");

// --------------------------------------------------------------------------------
// Usage / Public accessibility overrides
// --------------------------------------------------------------------------------

// The original type is string | OpenAI.ToolChoiceParam . Making this just string
// Prevents the emission of the full ToolChoiceParam class tree in Java, which
// is already exposed by the Stainless library. Currently there aren't any azure-isms.
@@changePropertyType(PromptAgentDefinition.tool_choice, string);

@@usage(OpenAI.IncludeEnum, Usage.input);
@@access(OpenAI.IncludeEnum, Access.public);

@@usage(OpenAI.ItemResource, Usage.json);
@@usage(OpenAI.CreateResponseStreamingResponse, Usage.json);

@@usage(AgentId, Usage.output);
@@access(AgentId, Access.public);

@@usage(AgentReference, Usage.input);
@@access(AgentReference, Access.public);

@@usage(ApiError, Usage.output);
@@access(ApiError, Access.public);

@@usage(MemoryStoreUpdateResponse, Usage.output);
@@access(MemoryStoreUpdateResponse, Access.public);
