import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core/experimental";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core.Experimental;

@clientNamespace("Azure.AI.Projects.OpenAI")
namespace Azure.AI.Projects;

// ------------------------------------------------------------------------------------------------
// Operation scope customizations - don't generate OpenAI operations that we'll use the OpenAI client for
// ------------------------------------------------------------------------------------------------
@@scope(Responses.createResponse, "!csharp");
@@scope(Responses.createResponseStream, "!csharp");
@@scope(Responses.getResponseStream, "!csharp");
@@scope(Responses.getResponse, "!csharp");
@@scope(Responses.deleteResponse, "!csharp");
@@scope(Responses.cancelResponse, "!csharp");
@@scope(Responses.listInputItems, "!csharp");
@@scope(Responses.listResponses, "!csharp");

// These operations are temporarily preserved to root request/response models for
// interim convenience layer support; to be removed once available in
// https://github.com/openai/openai-dotnet
// @@scope(Conversations.createConversation, "!csharp");
// @@scope(Conversations.updateConversation, "!csharp");

@@scope(Conversations.listConversations, "!csharp");
@@scope(Conversations.getConversation, "!csharp");
@@scope(Conversations.deleteConversation, "!csharp");
@@scope(Conversations.createConversationItems, "!csharp");
@@scope(Conversations.listConversationItems, "!csharp");
@@scope(Conversations.getConversationItem, "!csharp");
@@scope(Conversations.deleteConversationItem, "!csharp");

@@usage(OpenAI.Conversation, Usage.output);
@@access(OpenAI.Conversation, Access.public);
@@clientName(OpenAI.Conversation, "ProjectConversation");
@@usage(OpenAI.CreateConversationBody, Usage.input);
@@access(OpenAI.CreateConversationBody, Access.public);
@@usage(OpenAI.UpdateConversationBody, Usage.input);
@@access(OpenAI.UpdateConversationBody, Access.public);

@@access(OpenAI.Metadata, Access.internal);
@@clientName(OpenAI.Metadata, "InternalMetadataContainer");

// --------------------------------------------------------------------------------
// Fix the xref.
// --------------------------------------------------------------------------------
@@clientNamespace(OpenAI, "Azure.AI.Projects.OpenAI", "csharp");

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
@@clientName(OpenAI, "ProjectOpenAIClient");

@@clientName(AgentId, "AgentInfo");
@@clientName(AgentObject, "AgentRecord");
@@clientName(AgentProtocol, "AgentCommunicationMethod");

@@clientName(BingGroundingSearchToolParameters,
  "BingGroundingSearchToolOptions"
);
@@clientName(ContainerAppAgentDefinition,
  "ContainerApplicationAgentDefinition"
);
@@clientName(CreatedBy, "AgentResponseItemSource");
@@clientName(FabricDataAgentToolParameters, "FabricDataAgentToolOptions");

@@clientName(MemorySearchOptions, "MemorySearchToolOptions");
@@clientName(MemorySearchToolCallItemResource,
  "MemorySearchToolCallResponseItem"
);
@@clientName(OAuthConsentRequestItemResource,
  "OAuthConsentRequestResponseItem"
);
@@clientName(OpenAI.ItemResourceType, "AgentResponseItemKind");
@@clientName(OpenApiTool, "OpenAPITool");
@@clientName(OpenApiAnonymousAuthDetails,
  "OpenAPIAnonymousAuthenticationDetails"
);
@@clientName(OpenApiAuthDetails, "OpenAPIAuthenticationDetails");
@@clientName(OpenApiFunctionDefinition, "OpenAPIFunctionDefinition");
@@clientName(OpenApiManagedAuthDetails, "OpenAPIManagedAuthenticationDetails");
@@clientName(OpenApiProjectConnectionAuthDetails,
  "OpenAPIProjectConnectionAuthenticationDetails"
);
@@clientName(OpenApiProjectConnectionSecurityScheme,
  "OpenAPIProjectConnectionSecurityScheme"
);
@@clientName(RaiConfig, "ContentFilterConfiguration");
@@clientName(SharepointGroundingToolParameters,
  "SharePointGroundingToolOptions"
);
@@clientName(ToolArgumentBinding, "StructuredInputToolArgumentBinding");

// --------------------------------------------------------------------------------
// Renames and visibility changes for targeted suppressions
// --------------------------------------------------------------------------------

@@access(OpenAI.LocalShellToolParam, Access.internal);
@@clientName(OpenAI.LocalShellToolParam, "InternalLocalShellTool");

@@access(OpenAI.ItemLocalShellToolCall, Access.internal);
@@clientName(OpenAI.ItemLocalShellToolCall, "InternalLocalShellToolCallItem");
@@access(OpenAI.ItemLocalShellToolCallOutput, Access.internal);
@@clientName(OpenAI.ItemLocalShellToolCallOutput,
  "InternalLocalShellToolCallOutputItem"
);

@@access(OpenAI.ApplyPatchToolParam, Access.internal);
@@clientName(OpenAI.ApplyPatchToolParam, "InternalApplyPatchToolParam");

@@access(OpenAI.ApplyPatchToolCallItemParam, Access.internal);
@@clientName(OpenAI.ApplyPatchToolCallItemParam,
  "InternalApplyPatchToolCallItemParam"
);

@@access(OpenAI.ApplyPatchToolCall, Access.internal);
@@clientName(OpenAI.ApplyPatchToolCall, "InternalApplyPatchToolCall");

@@access(OpenAI.OutputItemApplyPatchToolCall, Access.internal);
@@clientName(OpenAI.OutputItemApplyPatchToolCall,
  "InternalOutputItemApplyPatchToolCall"
);

@@access(OpenAI.OutputItemApplyPatchToolCall, Access.internal);
@@clientName(OpenAI.OutputItemApplyPatchToolCall,
  "InternalOutputItemApplyPatchToolCall"
);

@@access(OpenAI.ItemResourceApplyPatchToolCall, Access.internal);
@@clientName(OpenAI.ItemResourceApplyPatchToolCall,
  "InternalItemResourceApplyPatchToolCall"
);

@@access(OpenAI.ItemResourceApplyPatchToolCallOutput, Access.internal);
@@clientName(OpenAI.ItemResourceApplyPatchToolCallOutput,
  "InternalItemResourceApplyPatchToolCallOutput"
);

@@access(OpenAI.ApplyPatchFileOperation, Access.internal);
@@clientName(OpenAI.ApplyPatchFileOperation, "InternalApplyPatchFileOperation");

@@access(OpenAI.ApplyPatchCreateFileOperationParam, Access.internal);
@@clientName(OpenAI.ApplyPatchCreateFileOperationParam,
  "InternalApplyPatchCreateFileOperationParam"
);

@@access(OpenAI.FileSearchToolCall, Access.internal);
@@clientName(OpenAI.FileSearchToolCall, "InternalFileSearchToolCall");

@@access(OpenAI.ItemResourceFileSearchToolCall, Access.internal);
@@clientName(OpenAI.ItemResourceFileSearchToolCall,
  "InternalItemResourceFileSearchToolCall"
);

@@access(OpenAI.ItemResourceOutputMessage, Access.internal);
@@clientName(OpenAI.ItemResourceOutputMessage,
  "InternalItemResourceOutputMessage"
);

@@access(OpenAI.ItemResourceMcpListTools, Access.internal);
@@clientName(OpenAI.ItemResourceMcpListTools,
  "InternalItemResourceMcpListTools"
);

@@access(OpenAI.ItemResourceComputerToolCall, Access.internal);
@@clientName(OpenAI.ItemResourceComputerToolCall,
  "InternalItemResourceComputerToolCall"
);

@@access(OpenAI.ItemResourceCodeInterpreterToolCall, Access.internal);
@@clientName(OpenAI.ItemResourceCodeInterpreterToolCall,
  "InternalItemResourceCodeInterpreterToolCall"
);

@@access(OpenAI.InputMessageResource, Access.internal);
@@clientName(OpenAI.InputMessageResource, "InternalInputMessageResource");

@@access(OpenAI.FunctionAndCustomToolCallOutput, Access.internal);
@@clientName(OpenAI.FunctionAndCustomToolCallOutput,
  "InternalFunctionAndCustomToolCallOutput"
);

@@access(OpenAI.ItemResourceMcpToolCall, Access.internal);
@@clientName(OpenAI.ItemResourceMcpToolCall, "InternalItemResourceMcpToolCall");

@@access(OpenAI.ItemResourceMcpApprovalResponseResource, Access.internal);
@@clientName(OpenAI.ItemResourceMcpApprovalResponseResource,
  "InternalItemResourceMcpApprovalResponseResource"
);

@@access(OpenAI.ItemResourceMcpApprovalRequest, Access.internal);
@@clientName(OpenAI.ItemResourceMcpApprovalRequest,
  "InternalItemResourceMcpApprovalRequest"
);

@@access(OpenAI.ItemResourceFunctionShellCallOutput, Access.internal);
@@clientName(OpenAI.ItemResourceFunctionShellCallOutput,
  "InternalItemResourceFunctionShellCallOutput"
);

@@access(OpenAI.ItemResourceFunctionShellCall, Access.internal);
@@clientName(OpenAI.ItemResourceFunctionShellCall,
  "InternalItemResourceFunctionShellCall"
);

@@access(OpenAI.ItemResourceLocalShellToolCallOutput, Access.internal);
@@clientName(OpenAI.ItemResourceLocalShellToolCallOutput,
  "InternalItemResourceLocalShellToolCallOutput"
);

@@access(OpenAI.ItemResourceLocalShellToolCall, Access.internal);
@@clientName(OpenAI.ItemResourceLocalShellToolCall,
  "InternalItemResourceLocalShellToolCall"
);

@@access(OpenAI.ItemResourceImageGenToolCall, Access.internal);
@@clientName(OpenAI.ItemResourceImageGenToolCall,
  "InternalItemResourceImageGenToolCall"
);

@@access(OpenAI.ItemResourceFunctionToolCallOutputResource, Access.internal);
@@clientName(OpenAI.ItemResourceFunctionToolCallOutputResource,
  "InternalItemResourceFunctionToolCallOutputResource"
);

@@access(OpenAI.ItemResourceFunctionToolCallResource, Access.internal);
@@clientName(OpenAI.ItemResourceFunctionToolCallResource,
  "InternalItemResourceFunctionToolCallResource"
);

@@access(OpenAI.ItemResourceWebSearchToolCall, Access.internal);
@@clientName(OpenAI.ItemResourceWebSearchToolCall,
  "InternalItemResourceWebSearchToolCall"
);

@@access(OpenAI.ItemResourceComputerToolCallOutputResource, Access.internal);
@@clientName(OpenAI.ItemResourceComputerToolCallOutputResource,
  "InternalItemResourceComputerToolCallOutputResource"
);

@@access(OpenAI.CustomToolParam, Access.internal);
@@clientName(OpenAI.CustomToolParam, "InternalCustomToolParam");

@@access(OpenAI.FunctionShellToolParam, Access.internal);
@@clientName(OpenAI.FunctionShellToolParam, "InternalFunctionShellToolParam");

@@access(OpenAI.CodeInterpreterContainerAuto, Access.internal);
@@clientName(OpenAI.CodeInterpreterContainerAuto,
  "InternalCodeInterpreterContainerAuto"
);

@@access(OpenAI.MCPToolFilter, Access.internal);
@@clientName(OpenAI.MCPToolFilter, "InternalMCPToolFilter");

@@access(OpenAI.MCPToolRequireApproval, Access.internal);
@@clientName(OpenAI.MCPToolRequireApproval, "InternalMCPToolRequireApproval");

@@access(OpenAI.WebSearchTool, Access.internal);
@@clientName(OpenAI.WebSearchTool, "InternalWebSearchTool");

@@access(CreatedBy, Access.public);
@@usage(CreatedBy, Usage.output);
@@clientName(CreatedBy, "AgentItemSource");

// --------------------------------------------------------------------------------
// Usage / Public accessibility overrides
// --------------------------------------------------------------------------------

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@changePropertyType(OpenAI.InputMessage.role, OpenAI.MessageRole);

@@copyProperties(OpenAI.ItemResource,
  {
    id?: string,
  }
);

@@usage(OpenAI.ItemResource, Usage.json);
@@access(OpenAI.ItemResource, Access.public);
@@clientName(OpenAI.ItemResource, "AgentResponseItem");

@@usage(OpenAI.CreateResponseStreamingResponse, Usage.json);

@@usage(AgentId, Usage.output);
@@access(AgentId, Access.public);

@@usage(AgentReference, Usage.input);
@@access(AgentReference, Access.public);

@@usage(ApiError, Usage.output);
@@access(ApiError, Access.public);

@@usage(AgentDefinition, Usage.input | Usage.output);
@@access(AgentDefinition, Access.public);

@@usage(PromptAgentDefinition, Usage.input | Usage.output);
@@access(PromptAgentDefinition, Access.public);

@@usage(AgentObject, Usage.output);
@@access(AgentObject, Access.public);
@@clientName(AgentObject, "AgentRecord");

@@usage(AgentVersionObject, Usage.output);
@@access(AgentVersionObject, Access.public);
@@clientName(AgentVersionObject, "AgentVersion");
