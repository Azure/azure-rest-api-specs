import "../common/service.tsp";
import "../common/custom-types.tsp";
import "../sdk-common/error.default.tsp";
import "../sdk-common/ops-relocation-agents.tsp";

import "../agents/routes.tsp";
import "../voice-agents/routes.tsp";
import "../memory-stores/routes.tsp";
import "../toolboxes/routes.tsp";
import "../agents-session-files/routes.tsp";
import "../agents-microsoft365/routes.tsp";
import "../agents-optimization/routes.tsp";
// We don't need the operations for these subclients, just the models
// so we can customize visibility where necessary.
import "../openai/responses/models.tsp";
import "../openai/conversations/routes.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core.Experimental;
using TypeSpec.OpenAPI;

using Azure.AI.Projects;

// Java promotes the shared Foundry-Features header with @@clientLocation, not @@scope/@@clientInitialization.
// @@scope(..., "!java") removes the header from Java entirely, including REST-interface @HeaderParam wiring.
// @@clientInitialization requires exact singleton opt-in properties (e.g. agents_optimization_v1_preview) per key.
// Moving the shared aliases keeps generated wire plumbing and automatically covers new operations using this pattern.
@@scope(WithConditionalFoundryPreviewHeader.foundry_features, "!java");
@@scope(WithRequiredFoundryPreviewHeader.foundry_features, "!java");

// --------------------------------------------------------------------------------
// Renames
// --------------------------------------------------------------------------------

@@clientNamespace(Azure.AI.Projects, "com.azure.ai.agents", "java");
@@clientName(Azure.AI.Projects, "AgentsClient");

@@clientName(OpenAI.OutputTextContent.logprobs, "logProbs");
@@clientName(OpenAI.LocalShellExecAction.timeout_ms, "Duration");
@@clientName(OpenAI.LogProb.logprob, "logProb");
@@clientName(
  MicrosoftFabricPreviewTool.fabric_dataagent_preview,
  "FabricDataAgentPreview"
);

@@clientName(AgentObject, "AgentDetails");
@@clientName(AgentVersionObject, "AgentVersionDetails");
@@clientName(Agents.patchAgentObject, "updateAgentDetails");

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
@@clientName(
  CreateAgentVersionFromManifestRequest,
  "CreateAgentVersionFromManifestInput"
);
@@clientName(UpdateToolboxRequest, "UpdateToolboxInput");

@@clientName(OpenAI.ContainerMemoryLimit.`1g`, "MEMORY_1GB");
@@clientName(OpenAI.ContainerMemoryLimit.`4g`, "MEMORY_4GB");
@@clientName(OpenAI.ContainerMemoryLimit.`16g`, "MEMORY_16GB");
@@clientName(OpenAI.ContainerMemoryLimit.`64g`, "MEMORY_64GB");

@@clientName(DeleteMemoryStoreResponse, "DeleteMemoryStoreResult");

@@clientName(OpenAI.DetailEnum, "ImageDetailLevel");

@@clientName(
  _PreviewAgentToolType.fabric_dataagent_preview,
  "FABRIC_DATA_AGENT_PREVIEW"
);

@@clientName(OpenAI.MCPListToolsToolAnnotations, "McpListToolsToolAnnotations");
@@clientName(OpenAI.MCPListToolsTool, "McpListToolsTool");
@@clientName(OpenAI.MCPTool, "McpTool");
@@clientName(OpenAI.MCPListToolsToolInputSchema, "McpListToolsToolInputSchema");
@@clientName(OpenAI.MCPToolCallStatus, "McpToolCallStatus");
@@clientName(OpenAI.MCPTool.connector_id, "connectorType");
@@clientName(OpenAI.MCPToolFilter, "McpToolFilter");
@@clientName(OpenAI.MCPToolRequireApproval, "McpToolRequireApproval");
@@clientName(MCPToolboxTool, "McpToolboxTool");

@@clientName(MemorySearchPreviewTool.update_delay, "updateDelaySeconds");

@@clientName(AgentObject.blueprint, "blueprintIdentity");

@@clientName(CodeConfiguration.content_hash, "contentSha256");

@@clientName(AgentOptimizationCandidate.avg_score, "averageScore");
@@clientName(AgentOptimizationCandidate.avg_tokens, "averageTokens");
@@clientName(AgentOptimizationCandidate.eval_id, "evaluationId");
@@clientName(AgentOptimizationCandidate.eval_run_id, "evaluationRunId");
@@clientName(
  AgentOptimizationDatasetItem.desired_num_turns,
  "desiredNumberTurns"
);
@@clientName(
  AgentOptimizationEvaluatorRef,
  "AgentOptimizationEvaluatorReference"
);
@@clientName(AgentOptimizationJobProgress.elapsed_seconds, "elapsed");

@@clientName(SessionFileWriteResponse, "SessionFileWriteResult");

@@clientName(
  OpenAI.ResponseFormatJsonSchemaSchema,
  "ResponseFormatJsonSchemaInner"
);
@@clientName(
  OpenAI.ResponseUsageInputTokensDetails.cached_tokens,
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
@@clientName(OpenAI.NamespaceToolParam, "NamespaceTool", "java");
@@clientName(OpenAI.ToolSearchToolParam, "ToolSearchTool", "java");
@@clientName(
  OpenAI.FunctionShellToolParam,
  "FunctionShellToolParameter",
  "java"
);
@@clientName(OpenAI.LocalShellToolParam, "LocalShellToolParameter", "java");
@@clientName(
  OpenAI.CustomGrammarFormatParam,
  "CustomGrammarFormatParameter",
  "java"
);
@@clientName(
  OpenAI.AutoCodeInterpreterToolParam,
  "AutoCodeInterpreterToolParameter",
  "java"
);
@@clientName(OpenAI.ContainerAutoParam, "ContainerAutoParameter", "java");
@@clientName(
  OpenAI.ContainerNetworkPolicyParam,
  "ContainerNetworkPolicyParameter",
  "java"
);
@@clientName(
  OpenAI.ContainerNetworkPolicyAllowlistParam,
  "ContainerNetworkPolicyAllowlistParameter",
  "java"
);
@@clientName(
  OpenAI.ContainerNetworkPolicyDisabledParam,
  "ContainerNetworkPolicyDisabledParameter",
  "java"
);
@@clientName(
  OpenAI.ContainerNetworkPolicyDomainSecretParam,
  "ContainerNetworkPolicyDomainSecretParameter",
  "java"
);
@@clientName(OpenAI.CustomTextFormatParam, "CustomTextFormatParameter", "java");
@@clientName(
  OpenAI.FunctionShellToolParamEnvironmentContainerReferenceParam,
  "FunctionShellToolParameterEnvironmentContainerReferenceParameter",
  "java"
);
@@clientName(
  OpenAI.FunctionShellToolParamEnvironmentLocalEnvironmentParam,
  "FunctionShellToolParameterEnvironmentLocalEnvironmentParameter",
  "java"
);
@@clientName(OpenAI.InlineSkillParam, "InlineSkillParameter", "java");
@@clientName(
  OpenAI.InlineSkillSourceParam,
  "InlineSkillSourceParameter",
  "java"
);
@@clientName(OpenAI.LocalSkillParam, "LocalSkillParameter", "java");
@@clientName(OpenAI.SkillReferenceParam, "SkillReferenceParameter", "java");
@@clientName(
  OpenAI.ProgrammaticToolCallingParam,
  "ProgrammaticToolCallingParameter",
  "java"
);

@@clientName(ToolboxVersionObject, "ToolboxVersionDetails", "java");
@@clientName(ToolboxObject, "ToolboxDetails", "java");

@@clientName(WorkIQPreviewTool, "WorkIqPreviewTool", "java");
@@clientName(FabricIQPreviewTool, "FabricIqPreviewTool", "java");
@@clientName(WebIQPreviewTool, "WebIqPreviewTool", "java");
@@clientName(WorkIQPreviewToolboxTool, "WorkIqPreviewToolboxTool", "java");
@@clientName(FabricIQPreviewToolboxTool, "FabricIqPreviewToolboxTool", "java");
@@clientName(WebIQPreviewToolboxTool, "WebIqPreviewToolboxTool", "java");

@@clientName(AgentOptimizationJobs.create, "createOptimizationJob", "java");
@@clientName(AgentOptimizationJobs.get, "getOptimizationJob", "java");
@@clientName(AgentOptimizationJobs.list, "listOptimizationJobs", "java");
@@clientName(AgentOptimizationJobs.cancel, "cancelOptimizationJob", "java");
@@clientName(AgentOptimizationJobs.delete, "deleteOptimizationJob", "java");

@@clientName(UploadSessionFileParams.agent_session_id, "sessionId", "java");
@@clientName(DownloadSessionFileParams.agent_session_id, "sessionId", "java");
@@clientName(ListSessionFilesParams.agent_session_id, "sessionId", "java");
@@clientName(DeleteSessionFileParams.agent_session_id, "sessionId", "java");

// --------------------------------------------------------------------------------
// Usage / Public accessibility overrides
// --------------------------------------------------------------------------------

// Java's HTTP pipeline cannot expose the upgraded WebSocket connection or exchange frames.
// Exclude this operation until the Java SDK has a supported WebSocket transport implementation.
@@scope(Azure.AI.Projects.VoiceAgentWebSocket.connectVoiceAgent, "!java");

@@access(Agents.createAgent, Access.internal);
@@access(Agents.updateAgent, Access.internal);
@@access(Agents.createAgentFromManifest, Access.internal);
@@access(Agents.updateAgentFromManifest, Access.internal);
@@access(Agents.createAgentFromCode, Access.internal);

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
@@convenientAPI(MemoryStores.deleteMemory, false, "java");

//making delete methods internal to add public shims that return void
@@access(Agents.deleteAgentVersion, Access.internal);
@@access(Agents.deleteAgent, Access.internal);
@@access(MemoryStores.deleteMemoryStore, Access.internal);
@@access(MemoryStores.deleteScope, Access.internal);
@@access(MemoryStores.deleteMemory, Access.internal);
@@clientName(Agents.deleteAgentVersion, "internalDeleteAgentVersion");
@@clientName(Agents.deleteAgent, "internalDeleteAgent");
@@clientName(MemoryStores.deleteMemoryStore, "internalDeleteMemoryStore");
@@clientName(MemoryStores.deleteScope, "internalDeleteScope");
@@clientName(MemoryStores.deleteMemory, "internalDeleteMemory");

@@access(MemoryStoreSearchResponse, Access.public);
@@usage(MemoryStoreSearchResponse, Usage.output);

// Emit Azure-specific OutputItem subtypes as public Java classes
@@access(BingGroundingToolCall, Access.public);
@@usage(BingGroundingToolCall, Usage.input);

@@access(BingGroundingToolCallOutput, Access.public);
@@usage(BingGroundingToolCallOutput, Usage.input);

@@access(SharepointGroundingToolCall, Access.public);
@@usage(SharepointGroundingToolCall, Usage.input);

@@access(SharepointGroundingToolCallOutput, Access.public);
@@usage(SharepointGroundingToolCallOutput, Usage.input);

@@access(AzureAISearchToolCall, Access.public);
@@usage(AzureAISearchToolCall, Usage.input);

@@access(AzureAISearchToolCallOutput, Access.public);
@@usage(AzureAISearchToolCallOutput, Usage.input);

@@access(BingCustomSearchToolCall, Access.public);
@@usage(BingCustomSearchToolCall, Usage.input);

@@access(BingCustomSearchToolCallOutput, Access.public);
@@usage(BingCustomSearchToolCallOutput, Usage.input);

@@access(OpenApiToolCall, Access.public);
@@usage(OpenApiToolCall, Usage.input);

@@access(OpenApiToolCallOutput, Access.public);
@@usage(OpenApiToolCallOutput, Usage.input);

@@access(BrowserAutomationToolCall, Access.public);
@@usage(BrowserAutomationToolCall, Usage.input);

@@access(BrowserAutomationToolCallOutput, Access.public);
@@usage(BrowserAutomationToolCallOutput, Usage.input);

@@access(FabricDataAgentToolCall, Access.public);
@@usage(FabricDataAgentToolCall, Usage.input);

@@access(FabricDataAgentToolCallOutput, Access.public);
@@usage(FabricDataAgentToolCallOutput, Usage.input);

@@access(AzureFunctionToolCall, Access.public);
@@usage(AzureFunctionToolCall, Usage.input);

@@access(AzureFunctionToolCallOutput, Access.public);
@@usage(AzureFunctionToolCallOutput, Usage.input);

@@access(A2AToolCall, Access.public);
@@usage(A2AToolCall, Usage.input);

@@access(A2AToolCallOutput, Access.public);
@@usage(A2AToolCallOutput, Usage.input);

@@access(MemorySearchToolCall, Access.public);
@@usage(MemorySearchToolCall, Usage.input);

@@access(MemoryCommandToolCall, Access.public);
@@usage(MemoryCommandToolCall, Usage.input);

@@access(MemoryCommandToolCallOutput, Access.public);
@@usage(MemoryCommandToolCallOutput, Usage.input);

@@access(ToolCallStatus, Access.public);
@@usage(ToolCallStatus, Usage.input);

@@usage(FoundryFeaturesOptInKeys, Usage.input);
@@access(FoundryFeaturesOptInKeys, Access.internal, "java");
@@usage(AgentDefinitionOptInKeys, Usage.input);
@@access(AgentDefinitionOptInKeys, Access.internal, "java");

@@clientName(OpenAI.RealtimeMCPHTTPError, "RealtimeMcpHttpError", "java");

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

@@usage(CreateAgentVersionRequest, Usage.input);
@@access(CreateAgentVersionRequest, Access.public);

// Ensure SessionLogEvent and SessionLogEventType are emitted
@@usage(SessionLogEvent, Usage.output);
@@access(SessionLogEvent, Access.public);
@@usage(SessionLogEventType, Usage.output);
@@access(SessionLogEventType, Access.public);

//Disabled convenient API generation for getSessionLogStream to handle deserialization manually
@@convenientAPI(Agents.getSessionLogStream, false, "java");

@@access(UpdateToolboxRequest, Access.internal, "java");

// RealtimeConversationItemMessage forms a doubly discriminated hierarchy: the base item dispatches on `type`, then
// the message branch dispatches on `role`. Each concrete message leaf redundantly redeclares its inherited
// `type: "message"` property. The Java emitter does not de-duplicate that property across this three-level hierarchy,
// so it otherwise generates duplicate `type` fields and accessors. Suppress only the redundant Java leaf properties;
// the inherited `type` discriminator remains serialized and continues to select the message branch.
@@scope(OpenAI.RealtimeConversationItemMessageSystem.type, "!java");
@@scope(OpenAI.RealtimeConversationItemMessageUser.type, "!java");
@@scope(OpenAI.RealtimeConversationItemMessageAssistant.type, "!java");

// --------------------------------------------------------------------------------
// Type overrides
// --------------------------------------------------------------------------------

// The original type is string | OpenAI.ToolChoiceParam . Making this just string
// Prevents the emission of the full ToolChoiceParam class tree in Java, which
// is already exposed by the Stainless library. Currently there aren't any azure-isms.
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@changePropertyType(PromptAgentDefinition.tool_choice, string);

// AI Tooling: openai-java de-dup
// Suppress emission of standalone models that are exact duplicates of openai-java classes.
// Map them to their openai-java equivalents so the codegen does not emit its own versions.
//   ComparisonFilter + ComparisonFilterType  → com.openai.models.ComparisonFilter
//   CompoundFilter + CompoundFilterType      → com.openai.models.CompoundFilter
@@alternateType(
  OpenAI.ComparisonFilter,
  {
    identity: "com.openai.models.ComparisonFilter",
  },
  "java"
);
@@alternateType(
  OpenAI.CompoundFilter,
  {
    identity: "com.openai.models.CompoundFilter",
  },
  "java"
);

@@alternateType(
  OpenAI.Reasoning,
  {
    identity: "com.openai.models.Reasoning",
  },
  "java"
);
// Do NOT map OpenAI.ToolChoiceFunction / OpenAI.ToolChoiceMCP to their openai-java equivalents
// (com.openai.models.responses.ToolChoiceFunction / ToolChoiceMcp). Although both are field-for-field
// duplicates, they are discriminated subtypes of `ToolChoiceParam` (@discriminator("type")). Substituting a
// subtype with an external identity type strips the discriminator the Java emitter needs, and generation
// fails with:
//   IllegalArgumentException: discriminator not found in type ToolChoiceFunction and its parents
// This matches the general rule that members of a discriminator hierarchy are structural equivalents, not
// actionable duplicates. Verified empirically against tsp-client update; do not re-attempt without emitter
// support for external types in discriminated hierarchies.
//   ConversationResource → com.openai.models.conversations.Conversation
@@alternateType(
  OpenAI.ConversationResource,
  {
    identity: "com.openai.models.conversations.Conversation",
  },
  "java"
);

@@alternateType(OpenAI.OutputItem, unknown, "java");
@@alternateType(OpenAI.InputItem, unknown, "java");

// Erase strongly-typed payloads on the namespace / tool_search Tool variants.
@@alternateType(OpenAI.NamespaceToolParam.tools, unknown, "java");
@@alternateType(OpenAI.ToolSearchToolParam.parameters, unknown, "java");

// `RealtimeFunctionTool.parameters` is documented as "Parameters of the function in JSON Schema" but is typed as
// `model RealtimeFunctionToolParameters {}` - an empty model with no properties and no additional properties.
// Java therefore generates a class whose `toJson` always writes `{}` and whose `fromJson` calls `skipChildren()`,
// silently discarding the caller's schema on the wire in both directions. The equivalent non-realtime
// `FunctionTool.parameters` is declared `Record<unknown> | null` upstream, confirming the payload is arbitrary JSON.
// Project it as `unknown` (BinaryData) for Java so the schema round-trips.
@@alternateType(OpenAI.RealtimeFunctionTool.parameters, unknown, "java");

// TimeZone property override via model indirection
@alternateType(
  {
    identity: "java.util.TimeZone",
  },
  "java"
)
model TimeZoneType {}

@@alternateType(OpenAI.ApproximateLocation.timezone, TimeZoneType, "java");
@@alternateType(
  OpenAI.WebSearchApproximateLocation.timezone,
  TimeZoneType,
  "java"
);

// Java-only helper scalar so `elapsed_seconds` (wire = fractional seconds as float64)
// is exposed to callers as java.time.Duration while keeping the wire format unchanged.
@encode(DurationKnownEncoding.seconds, float64)
scalar DurationInFloatSeconds extends duration;

@@alternateType(
  AgentOptimizationJobProgress.elapsed_seconds,
  DurationInFloatSeconds,
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
@@alternateType(
  OpenAI.ComputerEnvironment,
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
@@alternateType(
  OpenAI.ContainerMemoryLimit,
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
@@alternateType(
  OpenAI.ImageGenActionEnum,
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

@@clientName(
  ImageGenToolBackgroundExpandable,
  "ImageGenToolBackground",
  "java"
);
@@alternateType(
  OpenAI.ImageGenTool.background,
  ImageGenToolBackgroundExpandable,
  "java"
);

// ImageGenToolModeration (inline union on ImageGenTool.moderation)
union ImageGenToolModerationExpandable {
  string,
  auto: "auto",
  low: "low",
}

@@clientName(
  ImageGenToolModerationExpandable,
  "ImageGenToolModeration",
  "java"
);
@@alternateType(
  OpenAI.ImageGenTool.moderation,
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

@@clientName(
  ImageGenToolOutputFormatExpandable,
  "ImageGenToolOutputFormat",
  "java"
);
@@alternateType(
  OpenAI.ImageGenTool.output_format,
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
@@alternateType(
  OpenAI.ImageGenTool.quality,
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
@@clientName(
  ImageGenToolSizeExpandable.size_1024x1024,
  "RESOLUTION_1024_X_1024",
  "java"
);
@@clientName(
  ImageGenToolSizeExpandable.size_1024x1536,
  "RESOLUTION_1024_X_1536",
  "java"
);
@@clientName(
  ImageGenToolSizeExpandable.size_1536x1024,
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
@@alternateType(
  OpenAI.MCPTool.connector_id,
  McpToolConnectorIdExpandable,
  "java"
);

// Reuse one expandable type for the repeated `object: "realtime.item"` literal.
union RealtimeConversationItemObject {
  string,
  realtime_item: "realtime.item",
}

@@alternateType(
  OpenAI.RealtimeConversationItemMessageSystem.object,
  RealtimeConversationItemObject,
  "java"
);
@@alternateType(
  OpenAI.RealtimeConversationItemMessageUser.object,
  RealtimeConversationItemObject,
  "java"
);
@@alternateType(
  OpenAI.RealtimeConversationItemMessageAssistant.object,
  RealtimeConversationItemObject,
  "java"
);
@@alternateType(
  OpenAI.RealtimeConversationItemFunctionCall.object,
  RealtimeConversationItemObject,
  "java"
);
@@alternateType(
  OpenAI.RealtimeConversationItemFunctionCallOutput.object,
  RealtimeConversationItemObject,
  "java"
);

// RankerVersionType
union RankerVersionTypeExpandable {
  string,
  auto: "auto",
  default_2024_11_15: "default-2024-11-15",
}

@@clientName(RankerVersionTypeExpandable, "RankerVersionType", "java");
@@clientName(
  RankerVersionTypeExpandable.default_2024_11_15,
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

@@clientName(
  WebSearchToolSearchContextSizeExpandable,
  "WebSearchToolSearchContextSize",
  "java"
);
@@alternateType(
  OpenAI.WebSearchTool.search_context_size,
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
