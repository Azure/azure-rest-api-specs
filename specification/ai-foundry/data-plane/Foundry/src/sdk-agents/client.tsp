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

//rename object types to avoid confusion with Java objects
@@clientName(AgentObject.object, "objectType");
@@clientName(AgentVersionObject.object, "objectType");
@@clientName(DeleteMemoryStoreResponse.object, "objectType");
@@clientName(MemoryStoreObject.object, "objectType");
@@clientName(MemoryStoreDeleteScopeResponse.object, "objectType");

// Rename OpenAI.Error to avoid conflict with Azure.Core.Foundations.Error.
// OpenAI.Error is the object type of the `error` properties in `ApiErrorResponse`
// and `MemoryStoreUpdateResponse`.
@@clientName(OpenAI.Error, "ApiError");
@@clientName(OpenApiFunctionDefinition.default_params, "defaultParameters");

@@clientName(OpenAI.ApplyPatchToolParam, "ApplyPatchToolParameter", "java");
@@clientName(OpenAI.CustomToolParam, "CustomToolParameter", "java");
@@clientName(OpenAI.FunctionShellToolParam,
  "FunctionShellToolParameter",
  "java"
);
@@clientName(OpenAI.LocalShellToolParam, "LocalShellToolParameter", "java");
@@clientName(OpenAI.CustomGrammarFormatParam,
  "CustomGrammarFormatParameter",
  "java"
);
@@clientName(OpenAI.AutoCodeInterpreterToolParam,
  "AutoCodeInterpreterToolParameter",
  "java"
);
@@clientName(OpenAI.ContainerAutoParam, "ContainerAutoParameter", "java");
@@clientName(OpenAI.ContainerNetworkPolicyParam,
  "ContainerNetworkPolicyParameter",
  "java"
);
@@clientName(OpenAI.ContainerNetworkPolicyAllowlistParam,
  "ContainerNetworkPolicyAllowlistParameter",
  "java"
);
@@clientName(OpenAI.ContainerNetworkPolicyDisabledParam,
  "ContainerNetworkPolicyDisabledParameter",
  "java"
);
@@clientName(OpenAI.ContainerNetworkPolicyDomainSecretParam,
  "ContainerNetworkPolicyDomainSecretParameter",
  "java"
);
@@clientName(OpenAI.CustomTextFormatParam, "CustomTextFormatParameter", "java");
@@clientName(OpenAI.FunctionShellToolParamEnvironmentContainerReferenceParam,
  "FunctionShellToolParameterEnvironmentContainerReferenceParameter",
  "java"
);
@@clientName(OpenAI.FunctionShellToolParamEnvironmentLocalEnvironmentParam,
  "FunctionShellToolParameterEnvironmentLocalEnvironmentParameter",
  "java"
);
@@clientName(OpenAI.InlineSkillParam, "InlineSkillParameter", "java");
@@clientName(OpenAI.InlineSkillSourceParam,
  "InlineSkillSourceParameter",
  "java"
);
@@clientName(OpenAI.LocalSkillParam, "LocalSkillParameter", "java");
@@clientName(OpenAI.SkillReferenceParam, "SkillReferenceParameter", "java");

// --------------------------------------------------------------------------------
// Usage / Public accessibility overrides
// --------------------------------------------------------------------------------

@@access(Agents.createAgent, Access.internal);
@@access(Agents.updateAgent, Access.internal);
@@access(Agents.createAgentFromManifest, Access.internal);
@@access(Agents.updateAgentFromManifest, Access.internal);

// making methods private to add a public shim using the OpenAI types.
@@access(MemoryStores.searchMemories, Access.internal);
@@access(MemoryStores.updateMemories, Access.internal);
@@clientName(MemoryStores.updateMemories, "internalUpdateMemories");
@@clientName(MemoryStores.searchMemories, "internalSearchMemories");

// Disabled convenient API generation to provide a custom shim returning `void` in the client
@@convenientAPI(Agents.deleteAgent, false, "java");
@@convenientAPI(Agents.deleteAgentVersion, false, "java");
@@convenientAPI(MemoryStores.deleteMemoryStore, false, "java");
@@convenientAPI(MemoryStores.deleteScope, false, "java");

@@access(MemoryStoreSearchResponse, Access.public);
@@usage(MemoryStoreSearchResponse, Usage.output);

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

@@usage(MemoryStoreUpdateResponse, Usage.output);
@@access(MemoryStoreUpdateResponse, Access.public);

@@usage(AzureCreateResponseOptions, Usage.input);
@@access(AzureCreateResponseOptions, Access.public);

@@usage(AzureCreateResponseDetails, Usage.output);
@@access(AzureCreateResponseDetails, Access.public);

// --------------------------------------------------------------------------------
// Type overrides
// --------------------------------------------------------------------------------

// The original type is string | OpenAI.ToolChoiceParam . Making this just string
// Prevents the emission of the full ToolChoiceParam class tree in Java, which
// is already exposed by the Stainless library. Currently there aren't any azure-isms.
@@changePropertyType(PromptAgentDefinition.tool_choice, string);

// AI Tooling: openai-java de-dup
// Suppress emission of standalone models that are exact duplicates of openai-java classes.
// Map them to their openai-java equivalents so the codegen does not emit its own versions.
//   ComparisonFilter + ComparisonFilterType  → com.openai.models.ComparisonFilter
//   CompoundFilter + CompoundFilterType      → com.openai.models.CompoundFilter
//   Reasoning + ReasoningSummary/GenerateSummary/Effort → com.openai.models.Reasoning
@@alternateType(OpenAI.ComparisonFilter,
  {
    identity: "com.openai.models.ComparisonFilter",
  },
  "java"
);
@@alternateType(OpenAI.CompoundFilter,
  {
    identity: "com.openai.models.CompoundFilter",
  },
  "java"
);
@@alternateType(OpenAI.Reasoning,
  {
    identity: "com.openai.models.Reasoning",
  },
  "java"
);
//   ConversationResource → com.openai.models.conversations.Conversation
@@alternateType(OpenAI.ConversationResource,
  {
    identity: "com.openai.models.conversations.Conversation",
  },
  "java"
);

// TimeZone property override via model indirection
@alternateType(
  {
    identity: "java.util.TimeZone",
  },
  "java"
)
model TimeZoneType {}

@@alternateType(OpenAI.ApproximateLocation.timezone, TimeZoneType, "java");
@@alternateType(OpenAI.WebSearchApproximateLocation.timezone,
  TimeZoneType,
  "java"
);

// --------------------------------------------------------------------------------
// Conversations: only expose listConversations (Foundry-specific), suppress the rest
// --------------------------------------------------------------------------------

@@scope(Conversations.createConversation, "!(java)");
@@scope(Conversations.updateConversation, "!(java)");
@@scope(Conversations.getConversation, "!(java)");
@@scope(Conversations.deleteConversation, "!(java)");
@@scope(Conversations.createConversationItems, "!(java)");
@@scope(Conversations.getConversationItem, "!(java)");
@@scope(Conversations.deleteConversationItem, "!(java)");
@@scope(Conversations.listConversationItems, "!(java)");

// Rename and moving listAgentConversations to Agents subclient, so we prevent having a Conversation subclient
// of our own, to prevent confusion.
@@clientName(Conversations.listConversations, "listAgentConversations", "java");
@@clientLocation(Conversations.listConversations, Agents);
