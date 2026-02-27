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

@@clientName(MemoryStoreObject, "MemoryStoreDetails");

@@clientName(Agents.getAgentVersion, "getAgentVersionDetails");

@@clientName(AzureAISearchTool.azure_ai_search, "AzureAISearch");

@@clientName(OpenAI.FileSearchTool.max_num_results, "maxResults");
@@clientName(OpenAI.MCPApprovalResponse.approve, "approved");

@@clientName(CreateAgentRequest.name, "agentName");
@@clientName(CreateAgentFromManifestRequest.name, "agentName");

// Rename request models to avoid collision with synthetic body types generated
// by the Java codegen. The codegen names synthetic bodies as {OperationName}Request,
// which clashes with the identically-named TypeSpec models, causing a "1" suffix.
@@clientName(CreateAgentRequest, "CreateAgentInput");
@@clientName(UpdateAgentRequest, "UpdateAgentInput");
@@clientName(CreateAgentVersionRequest, "CreateAgentVersionInput");
@@clientName(CreateAgentFromManifestRequest, "CreateAgentFromManifestInput");
@@clientName(UpdateAgentFromManifestRequest, "UpdateAgentFromManifestInput");
@@clientName(CreateAgentVersionFromManifestRequest,
  "CreateAgentVersionFromManifestInput"
);

@@clientName(OpenAI.ContainerMemoryLimit.`1g`, "MEMORY_1GB");
@@clientName(OpenAI.ContainerMemoryLimit.`4g`, "MEMORY_4GB");
@@clientName(OpenAI.ContainerMemoryLimit.`16g`, "MEMORY_16GB");
@@clientName(OpenAI.ContainerMemoryLimit.`64g`, "MEMORY_64GB");

@@clientName(DeleteMemoryStoreResponse, "DeleteMemoryStoreResult");

@@clientName(OpenAI.DetailEnum, "ImageDetailLevel");

@@clientName(ApiError, "OpenAIError");

@@clientName(OpenAI.MCPListToolsToolAnnotations, "McpListToolsToolAnnotations");
@@clientName(OpenAI.MCPListToolsTool, "McpListToolsTool");
@@clientName(OpenAI.MCPTool, "McpTool");
@@clientName(OpenAI.MCPListToolsToolInputSchema, "McpListToolsToolInputSchema");
@@clientName(OpenAI.MCPToolCallStatus, "McpToolCallStatus");
@@clientName(OpenAI.MCPTool.connector_id, "connectorType");
@@clientName(OpenAI.MCPToolFilter, "McpToolFilter");
@@clientName(OpenAI.MCPToolRequireApproval, "McpToolRequireApproval");

@@clientName(MemorySearchPreviewTool.update_delay, "updateDelaySeconds");

@@clientName(OpenAI.ResponseFormatJsonSchemaSchema,
  "ResponseFormatJsonSchemaInner"
);
@@clientName(OpenAI.ResponseUsageInputTokensDetails.cached_tokens,
  "cachedTokensCount"
);

// --------------------------------------------------------------------------------
// Usage / Public accessibility overrides
// --------------------------------------------------------------------------------

@@access(Agents.createAgent, Access.internal);
@@access(Agents.updateAgent, Access.internal);
@@access(Agents.createAgentFromManifest, Access.internal);
@@access(Agents.updateAgentFromManifest, Access.internal);

// The original type is string | OpenAI.ToolChoiceParam . Making this just string
// Prevents the emission of the full ToolChoiceParam class tree in Java, which
// is already exposed by the Stainless library. Currently there aren't any azure-isms.
@@changePropertyType(PromptAgentDefinition.tool_choice, string);

@@access(FoundryFeaturesOptInKeys, Access.public);
@@access(AgentDefinitionOptInKeys, Access.public);

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
