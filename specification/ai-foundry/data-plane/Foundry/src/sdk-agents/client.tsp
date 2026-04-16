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

@@clientName(OpenApiTool.openapi, "openApi");

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

// Disabled convenient API generation and make private to provide a custom shim returning `void` in the client
@@convenientAPI(Agents.deleteAgent, false, "java");
@@convenientAPI(Agents.deleteAgentVersion, false, "java");
@@convenientAPI(MemoryStores.deleteMemoryStore, false, "java");
@@convenientAPI(MemoryStores.deleteScope, false, "java");

//making delete methods internal to add public shims that return void
@@access(Agents.deleteAgentVersion, Access.internal);
@@access(Agents.deleteAgent, Access.internal);
@@access(MemoryStores.deleteMemoryStore, Access.internal);
@@access(MemoryStores.deleteScope, Access.internal);
@@clientName(Agents.deleteAgentVersion, "internalDeleteAgentVersion");
@@clientName(Agents.deleteAgent, "internalDeleteAgent");
@@clientName(MemoryStores.deleteMemoryStore, "internalDeleteMemoryStore");
@@clientName(MemoryStores.deleteScope, "internalDeleteScope");

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

// Ensure SessionLogEvent and SessionLogEventType are emitted
@@usage(SessionLogEvent, Usage.output);
@@access(SessionLogEvent, Access.public);
@@usage(SessionLogEventType, Usage.output);
@@access(SessionLogEventType, Access.public);

//Disabled convenient API generation for getSessionLogStream to handle deserialization manually
@@convenientAPI(Agents.getSessionLogStream, false, "java");

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

// ---- Expandable enum overrides ------------------------------------------------
// Convert fixed OpenAI enums / inline literal unions to expandable string enums
// by defining open unions (with `string` base) and mapping via @@alternateType.

// ComputerEnvironment
union ComputerEnvironmentExpandable {
  string,
  windows: "windows",
  mac: "mac",
  linux: "linux",
  ubuntu: "ubuntu",
  browser: "browser",
}

@@clientName(ComputerEnvironmentExpandable, "ComputerEnvironment", "java");
@@alternateType(OpenAI.ComputerEnvironment,
  ComputerEnvironmentExpandable,
  "java"
);

// ContainerMemoryLimit
union ContainerMemoryLimitExpandable {
  string,
  memory_1g: "1g",
  memory_4g: "4g",
  memory_16g: "16g",
  memory_64g: "64g",
}

@@clientName(ContainerMemoryLimitExpandable, "ContainerMemoryLimit", "java");
@@clientName(ContainerMemoryLimitExpandable.memory_1g, "MEMORY_1GB", "java");
@@clientName(ContainerMemoryLimitExpandable.memory_4g, "MEMORY_4GB", "java");
@@clientName(ContainerMemoryLimitExpandable.memory_16g, "MEMORY_16GB", "java");
@@clientName(ContainerMemoryLimitExpandable.memory_64g, "MEMORY_64GB", "java");
@@alternateType(OpenAI.ContainerMemoryLimit,
  ContainerMemoryLimitExpandable,
  "java"
);

// GrammarSyntax (TSP name: GrammarSyntax1)
union GrammarSyntaxExpandable {
  string,
  lark: "lark",
  regex: "regex",
}

@@clientName(GrammarSyntaxExpandable, "GrammarSyntax", "java");
@@alternateType(OpenAI.GrammarSyntax1, GrammarSyntaxExpandable, "java");

// ImageGenActionEnum
union ImageGenActionEnumExpandable {
  string,
  generate: "generate",
  edit: "edit",
  auto: "auto",
}

@@clientName(ImageGenActionEnumExpandable, "ImageGenActionEnum", "java");
@@alternateType(OpenAI.ImageGenActionEnum,
  ImageGenActionEnumExpandable,
  "java"
);

// ImageGenToolBackground (inline union on ImageGenTool.background)
union ImageGenToolBackgroundExpandable {
  string,
  transparent: "transparent",
  opaque: "opaque",
  auto: "auto",
}

@@clientName(ImageGenToolBackgroundExpandable,
  "ImageGenToolBackground",
  "java"
);
@@alternateType(OpenAI.ImageGenTool.background,
  ImageGenToolBackgroundExpandable,
  "java"
);

// ImageGenToolModeration (inline union on ImageGenTool.moderation)
union ImageGenToolModerationExpandable {
  string,
  auto: "auto",
  low: "low",
}

@@clientName(ImageGenToolModerationExpandable,
  "ImageGenToolModeration",
  "java"
);
@@alternateType(OpenAI.ImageGenTool.moderation,
  ImageGenToolModerationExpandable,
  "java"
);

// ImageGenToolOutputFormat (inline union on ImageGenTool.output_format)
union ImageGenToolOutputFormatExpandable {
  string,
  png: "png",
  webp: "webp",
  jpeg: "jpeg",
}

@@clientName(ImageGenToolOutputFormatExpandable,
  "ImageGenToolOutputFormat",
  "java"
);
@@alternateType(OpenAI.ImageGenTool.output_format,
  ImageGenToolOutputFormatExpandable,
  "java"
);

// ImageGenToolQuality (inline union on ImageGenTool.quality)
union ImageGenToolQualityExpandable {
  string,
  low: "low",
  medium: "medium",
  high: "high",
  auto: "auto",
}

@@clientName(ImageGenToolQualityExpandable, "ImageGenToolQuality", "java");
@@alternateType(OpenAI.ImageGenTool.quality,
  ImageGenToolQualityExpandable,
  "java"
);

// ImageGenToolSize (inline union on ImageGenTool.size)
union ImageGenToolSizeExpandable {
  string,
  size_1024x1024: "1024x1024",
  size_1024x1536: "1024x1536",
  size_1536x1024: "1536x1024",
  auto: "auto",
}

@@clientName(ImageGenToolSizeExpandable, "ImageGenToolSize", "java");
@@clientName(ImageGenToolSizeExpandable.size_1024x1024,
  "RESOLUTION_1024_X_1024",
  "java"
);
@@clientName(ImageGenToolSizeExpandable.size_1024x1536,
  "RESOLUTION_1024_X_1536",
  "java"
);
@@clientName(ImageGenToolSizeExpandable.size_1536x1024,
  "RESOLUTION_1536_X_1024",
  "java"
);
@@alternateType(OpenAI.ImageGenTool.size, ImageGenToolSizeExpandable, "java");

// InputFidelity
union InputFidelityExpandable {
  string,
  high: "high",
  low: "low",
}

@@clientName(InputFidelityExpandable, "InputFidelity", "java");
@@alternateType(OpenAI.InputFidelity, InputFidelityExpandable, "java");

// McpToolConnectorId (inline union on MCPTool.connector_id)
union McpToolConnectorIdExpandable {
  string,
  connector_dropbox: "connector_dropbox",
  connector_gmail: "connector_gmail",
  connector_googlecalendar: "connector_googlecalendar",
  connector_googledrive: "connector_googledrive",
  connector_microsoftteams: "connector_microsoftteams",
  connector_outlookcalendar: "connector_outlookcalendar",
  connector_outlookemail: "connector_outlookemail",
  connector_sharepoint: "connector_sharepoint",
}

@@clientName(McpToolConnectorIdExpandable, "McpToolConnectorId", "java");
@@alternateType(OpenAI.MCPTool.connector_id,
  McpToolConnectorIdExpandable,
  "java"
);

// RankerVersionType
union RankerVersionTypeExpandable {
  string,
  auto: "auto",
  default_2024_11_15: "default-2024-11-15",
}

@@clientName(RankerVersionTypeExpandable, "RankerVersionType", "java");
@@clientName(RankerVersionTypeExpandable.default_2024_11_15,
  "DEFAULT_2024_11_15",
  "java"
);
@@alternateType(OpenAI.RankerVersionType, RankerVersionTypeExpandable, "java");

// SearchContextSize
union SearchContextSizeExpandable {
  string,
  low: "low",
  medium: "medium",
  high: "high",
}

@@clientName(SearchContextSizeExpandable, "SearchContextSize", "java");
@@alternateType(OpenAI.SearchContextSize, SearchContextSizeExpandable, "java");

// WebSearchToolSearchContextSize (inline union on WebSearchTool.search_context_size)
union WebSearchToolSearchContextSizeExpandable {
  string,
  low: "low",
  medium: "medium",
  high: "high",
}

@@clientName(WebSearchToolSearchContextSizeExpandable,
  "WebSearchToolSearchContextSize",
  "java"
);
@@alternateType(OpenAI.WebSearchTool.search_context_size,
  WebSearchToolSearchContextSizeExpandable,
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
