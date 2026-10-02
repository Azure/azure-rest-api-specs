import "../sdk-common/error.default.tsp";
import "../common/servicepatterns.tsp";
import "../openai/conversations/routes.tsp";
import "../openai/responses/routes.tsp";
import "../toolboxes/models.tsp";
import "../agents/models.tsp";
import "../skills/models.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core.Experimental;

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@clientNamespace("Azure.AI.Extensions.OpenAI")
namespace Azure.AI.Projects {
  // ------------------------------------------------------------------------------------------------
  // Operation scope customizations - don't generate OpenAI operations that we'll use the OpenAI client for
  // ------------------------------------------------------------------------------------------------
  @@scope(Responses.createResponse, "!csharp");
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

  // --------------------------------------------------------------------------------
  // Fix the xref.
  // --------------------------------------------------------------------------------
  @@clientNamespace(OpenAI, "Azure.AI.Extensions.OpenAI", "csharp");

  // --------------------------------------------------------------------------------
  // Root client
  // --------------------------------------------------------------------------------
  @@clientName(OpenAI, "ProjectOpenAIClient");

  @@usage(OpenAI.ConversationResource, Usage.output);
  @@access(OpenAI.ConversationResource, Access.public);
  @@clientName(OpenAI.ConversationResource, "ProjectConversation");
  @@usage(
    OpenAI.CreateConversationBody,
    Usage.output | Usage.json | Usage.input
  );
  @@access(OpenAI.CreateConversationBody, Access.public);
  @@usage(OpenAI.UpdateConversationBody, Usage.input);
  @@access(OpenAI.UpdateConversationBody, Access.public);

  @@access(OpenAI.Metadata, Access.internal);
  @@clientName(OpenAI.Metadata, "InternalMetadataContainer");

  @@clientNamespace(Azure.AI.Projects, "Azure.AI.Extensions.OpenAI", "csharp");

  @@clientName(CreatedBy, "AgentResponseItemSource");

  @@access(CreatedBy, Access.public);
  @@usage(CreatedBy, Usage.output);
  @@clientName(CreatedBy, "AgentItemSource");
  @@clientName(FabricDataAgentToolParameters, "FabricDataAgentToolOptions");
  @@usage(FabricDataAgentToolParameters, Usage.input | Usage.output);

  @@clientName(
    OAuthConsentRequestOutputItem,
    "OAuthConsentRequestResponseItem"
  );
  @@usage(OAuthConsentRequestOutputItem, Usage.input | Usage.output);
  // The ResponsesOutputItem that OpenAI.OutputItem maps to in C# already has a id property...
  @@withoutOmittedProperties(OAuthConsentRequestOutputItem, "id");
  @@alternateType(OAuthConsentRequestOutputItem.consent_link, url);

  @@clientName(OpenApiFunctionDefinition.auth, "authentication");
  @@clientName(OpenApiFunctionDefinition.default_params, "DefaultParameters");
  @@clientName(
    OpenApiManagedAuthDetails,
    "OpenApiManagedAuthenticationDetails"
  );
  @@clientName(OpenApiAuthType, "OpenApiAuthenticationKind");
  @@clientName(OpenApiAuthDetails.type, "Kind");

  @@clientName(BingCustomSearchConfiguration, "BingCustomSearchOptions");
  @@clientName(BingGroundingSearchConfiguration, "BingGroundingSearchOptions");

  @@clientName(WorkflowActionOutputItem.kind, "CSDLActionKind");

  @@clientName(OpenAI.OutputItemType, "AgentResponseItemKind");
  @@usage(OpenAI.OutputItemType, Usage.output | Usage.json | Usage.input);

  // --------------------------------------------------------------------------------
  // --------------------------------------------------------------------------------
  // LocalShellToolCallOutputStatus - named union to replace inline union
  // --------------------------------------------------------------------------------

  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Matching OpenAI spec"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Matching OpenAI spec"
  union LocalShellToolCallOutputStatus {
    in_progress: "in_progress",
    completed: "completed",
    incomplete: "incomplete",
    null,
  }

  // Replace the inline union with a named type for SDK generation.
  @@alternateType(
    OpenAI.LocalShellToolCallOutput.status,
    LocalShellToolCallOutputStatus
  );

  // Rename and include in typegraph
  @@clientName(
    LocalShellToolCallOutputStatus,
    "ItemLocalShellToolCallOutputStatus"
  );

  // --------------------------------------------------------------------------------
  // Renames and visibility changes for targeted suppressions
  // --------------------------------------------------------------------------------

  @@access(OpenAI.ItemLocalShellToolCall, Access.internal);
  @@clientName(OpenAI.ItemLocalShellToolCall, "InternalLocalShellToolCallItem");
  @@access(OpenAI.ItemLocalShellToolCallOutput, Access.internal);
  @@clientName(
    OpenAI.ItemLocalShellToolCallOutput,
    "InternalLocalShellToolCallOutputItem"
  );

  @@access(OpenAI.ApplyPatchToolParam, Access.internal);
  @@clientName(OpenAI.ApplyPatchToolParam, "InternalApplyPatchToolParam");

  @@access(OpenAI.ApplyPatchToolCallItemParam, Access.internal);
  @@clientName(
    OpenAI.ApplyPatchToolCallItemParam,
    "InternalApplyPatchToolCallItemParam"
  );

  @@access(OpenAI.ApplyPatchToolCall, Access.internal);
  @@clientName(OpenAI.ApplyPatchToolCall, "InternalApplyPatchToolCall");

  @@access(OpenAI.OutputItemApplyPatchToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemApplyPatchToolCall,
    "InternalOutputItemApplyPatchToolCall"
  );

  @@access(OpenAI.OutputItemApplyPatchToolCallOutput, Access.internal);
  @@clientName(
    OpenAI.OutputItemApplyPatchToolCallOutput,
    "InternalOutputItemApplyPatchToolCallOutput"
  );

  @@access(OpenAI.ApplyPatchFileOperation, Access.internal);
  @@clientName(
    OpenAI.ApplyPatchFileOperation,
    "InternalApplyPatchFileOperation"
  );

  @@access(OpenAI.ApplyPatchCreateFileOperationParam, Access.internal);
  @@clientName(
    OpenAI.ApplyPatchCreateFileOperationParam,
    "InternalApplyPatchCreateFileOperationParam"
  );

  @@access(OpenAI.OutputItemOutputMessage, Access.internal);
  @@clientName(
    OpenAI.OutputItemOutputMessage,
    "InternalOutputItemOutputMessage"
  );

  @@access(OpenAI.ItemComputerToolCall, Access.internal);
  @@clientName(OpenAI.ItemComputerToolCall, "InternalItemComputerToolCall");

  @@access(OpenAI.FileSearchToolCall, Access.internal);
  @@clientName(OpenAI.FileSearchToolCall, "InternalFileSearchToolCall");

  @@access(OpenAI.OutputItemFileSearchToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemFileSearchToolCall,
    "InternalOutputItemFileSearchToolCall"
  );

  @@access(OpenAI.ItemMcpListTools, Access.internal);
  @@clientName(OpenAI.ItemMcpListTools, "InternalItemMcpListTools");

  @@access(OpenAI.MessageContent, Access.internal);
  @@clientName(OpenAI.MessageContent, "InternalMessageContent");

  @@access(OpenAI.OutputMessageContent, Access.internal);
  @@clientName(OpenAI.OutputMessageContent, "InternalOutputMessageContent");

  @@access(OpenAI.InputImageContent, Access.internal);
  @@clientName(OpenAI.InputImageContent, "InternalInputImageContent");

  @@access(OpenAI.InputFileContent, Access.internal);
  @@clientName(OpenAI.InputFileContent, "InternalInputFileContent");

  @@access(OpenAI.InputFileContentParam, Access.internal);
  @@clientName(OpenAI.InputFileContentParam, "InternalInputFileContentParam");

  @@access(OpenAI.InputImageContentParamAutoParam, Access.internal);
  @@clientName(
    OpenAI.InputImageContentParamAutoParam,
    "InternalInputImageContentParamAutoParam"
  );

  @@access(OpenAI.InputTextContent, Access.internal);
  @@clientName(OpenAI.InputTextContent, "InternalInputTextContent");

  @@access(OpenAI.InputTextContentParam, Access.internal);
  @@clientName(OpenAI.InputTextContentParam, "InternalInputTextContentParam");

  @@access(OpenAI.OutputItemMcpListTools, Access.internal);
  @@clientName(OpenAI.OutputItemMcpListTools, "InternalOutputItemMcpListTools");

  @@access(OpenAI.OutputMessageContentOutputTextContent, Access.internal);
  @@clientName(
    OpenAI.OutputMessageContentOutputTextContent,
    "InternalOutputMessageContentOutputTextContent"
  );

  @@access(OpenAI.OutputContentOutputTextContent, Access.internal);
  @@clientName(
    OpenAI.OutputContentOutputTextContent,
    "InternalOutputContentOutputTextContent"
  );

  @@access(OpenAI.OutputItemComputerToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemComputerToolCall,
    "InternalOutputItemComputerToolCall"
  );

  @@access(OpenAI.OutputItemCodeInterpreterToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemCodeInterpreterToolCall,
    "InternalOutputItemCodeInterpreterToolCall"
  );

  @@access(OpenAI.ItemOutputMessage, Access.internal);
  @@clientName(OpenAI.ItemOutputMessage, "InternalItemMessage");

  @@access(OpenAI.FunctionAndCustomToolCallOutput, Access.internal);
  @@clientName(
    OpenAI.FunctionAndCustomToolCallOutput,
    "InternalFunctionAndCustomToolCallOutput"
  );

  @@access(OpenAI.OutputItemMcpToolCall, Access.internal);
  @@clientName(OpenAI.OutputItemMcpToolCall, "InternalOutputItemMcpToolCall");

  @@access(OpenAI.ItemResourceMcpApprovalResponseResource, Access.internal);
  @@clientName(
    OpenAI.ItemResourceMcpApprovalResponseResource,
    "InternalOutputItemMcpApprovalResponseResource"
  );

  @@access(OpenAI.OutputItemMcpApprovalRequest, Access.internal);
  @@clientName(
    OpenAI.OutputItemMcpApprovalRequest,
    "InternalOutputItemMcpApprovalRequest"
  );

  @@access(OpenAI.OutputItemFunctionShellCallOutput, Access.internal);
  @@clientName(
    OpenAI.OutputItemFunctionShellCallOutput,
    "InternalOutputItemFunctionShellCallOutput"
  );

  @@access(OpenAI.OutputItemFunctionShellCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemFunctionShellCall,
    "InternalOutputItemFunctionShellCall"
  );

  @@access(OpenAI.ItemLocalShellToolCallOutput, Access.internal);
  @@clientName(
    OpenAI.ItemLocalShellToolCallOutput,
    "InternalOutputItemLocalShellToolCallOutput"
  );

  @@access(OpenAI.OutputItemLocalShellToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemLocalShellToolCall,
    "InternalOutputItemLocalShellToolCall"
  );

  @@access(OpenAI.OutputItemImageGenToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemImageGenToolCall,
    "InternalOutputItemImageGenToolCall"
  );

  @@access(OpenAI.FunctionToolCallOutput, Access.internal);
  @@clientName(
    OpenAI.FunctionToolCallOutput,
    "InternalOutputItemFunctionToolCallOutput"
  );

  @@access(OpenAI.OutputItemFunctionToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemFunctionToolCall,
    "InternalOutputItemFunctionToolCall"
  );

  @@access(OpenAI.OutputItemWebSearchToolCall, Access.internal);
  @@clientName(
    OpenAI.OutputItemWebSearchToolCall,
    "InternalOutputItemWebSearchToolCall"
  );

  @@access(OpenAI.ItemResourceComputerToolCallOutput, Access.internal);
  @@clientName(
    OpenAI.ItemResourceComputerToolCallOutput,
    "InternalOutputItemComputerToolCallOutput"
  );

  @@access(OpenAI.ItemCustomToolCallOutput, Access.internal);
  @@clientName(
    OpenAI.ItemCustomToolCallOutput,
    "InternalOutputItemCustomToolCallOutput"
  );

  @@access(OpenAI.OutputItemReasoningItem, Access.internal);
  @@clientName(
    OpenAI.OutputItemReasoningItem,
    "InternalOutputItemReasoningItem"
  );

  @@clientName(MemoryItem, "MemoryOutputItem");

  @@access(OpenAI.SummaryTextContent, Access.internal);
  @@clientName(OpenAI.SummaryTextContent, "InternalSummaryTextObject");

  @@access(OpenAI.OutputItemCompactionBody, Access.internal);
  @@clientName(
    OpenAI.OutputItemCompactionBody,
    "InternalOutputItemCompactionBody"
  );

  @@access(OpenAI.OutputItemCustomToolCallResource, Access.internal);
  @@clientName(
    OpenAI.OutputItemCustomToolCallResource,
    "InternalOutputItemCustomToolCallResource"
  );

  @@clientName(_AgentItemType.a2a_preview_call, "A2APreviewCall ");
  @@clientName(_AgentItemType.a2a_preview_call_output, "A2APreviewCallOutput");

  @@access(OpenAI.WebSearchActionFind, Access.internal);
  @@clientName(OpenAI.WebSearchActionFind, "InternalWebSearchActionFind");

  @@access(OpenAI.WebSearchActionOpenPage, Access.internal);
  @@clientName(
    OpenAI.WebSearchActionOpenPage,
    "InternalWebSearchActionOpenPage"
  );

  @@access(OpenAI.WebSearchActionSearch, Access.internal);
  @@clientName(OpenAI.WebSearchActionSearch, "InternalWebSearchActionSearch");

  @@access(OpenAI.CodeInterpreterOutputImage, Access.internal);
  @@clientName(
    OpenAI.CodeInterpreterOutputImage,
    "InternalCodeInterpreterOutputImage"
  );

  @@access(OpenAI.CodeInterpreterOutputLogs, Access.internal);
  @@clientName(
    OpenAI.CodeInterpreterOutputLogs,
    "InternalCodeInterpreterOutputLogs"
  );

  @@access(OpenAI.ComparisonFilter, Access.internal);
  @@clientName(OpenAI.ComparisonFilter, "InternalComparisonFilter");

  @@access(OpenAI.CompoundFilter, Access.internal);
  @@clientName(OpenAI.CompoundFilter, "InternalCompoundFilter");

  @@access(OpenAI.ComputerUsePreviewTool, Access.internal);
  @@clientName(OpenAI.ComputerUsePreviewTool, "InternalComputerUsePreviewTool");

  @@access(OpenAI.FileSearchTool, Access.internal);
  @@clientName(OpenAI.FileSearchTool, "InternalFileSearchTool");

  @@access(OpenAI.ToolChoiceParam, Access.internal);
  @@clientName(OpenAI.ToolChoiceParam, "InternalToolChoiceParam");

  // Emit Azure-specific OutputItem subtypes as public classes
  @@access(BingGroundingToolCall, Access.public);
  @@usage(BingGroundingToolCall, Usage.input | Usage.output);

  @@access(BingGroundingToolCallOutput, Access.public);
  @@usage(BingGroundingToolCallOutput, Usage.input | Usage.output);

  @@clientName(
    SharepointGroundingToolCall,
    "SharePointGroundingToolCall",
    "!autorest"
  );
  @@access(SharepointGroundingToolCall, Access.public);
  @@usage(SharepointGroundingToolCall, Usage.input | Usage.output);

  @@access(SharepointGroundingToolCallOutput, Access.public);
  @@usage(SharepointGroundingToolCallOutput, Usage.input | Usage.output);
  @@clientName(
    SharepointGroundingToolCallOutput,
    "SharePointGroundingToolCallOutput",
    "!autorest"
  );

  @@clientName(
    SharepointGroundingToolParameters,
    "SharePointGroundingToolOptions",
    "!autorest"
  );

  @@access(AzureAISearchToolCall, Access.public);
  @@usage(AzureAISearchToolCall, Usage.input | Usage.output);

  @@access(AzureAISearchToolCallOutput, Access.public);
  @@usage(AzureAISearchToolCallOutput, Usage.input | Usage.output);

  @@access(BingCustomSearchToolCall, Access.public);
  @@usage(BingCustomSearchToolCall, Usage.input | Usage.output);

  @@access(BingCustomSearchToolCallOutput, Access.public);
  @@usage(BingCustomSearchToolCallOutput, Usage.input | Usage.output);

  @@access(OpenApiToolCall, Access.public);
  @@usage(OpenApiToolCall, Usage.input | Usage.output);

  @@access(OpenApiToolCallOutput, Access.public);
  @@usage(OpenApiToolCallOutput, Usage.input | Usage.output);

  @@access(BrowserAutomationToolCall, Access.public);
  @@usage(BrowserAutomationToolCall, Usage.input | Usage.output);

  @@access(BrowserAutomationToolCallOutput, Access.public);
  @@usage(BrowserAutomationToolCallOutput, Usage.input | Usage.output);

  @@clientName(
    BrowserAutomationToolParameters,
    "BrowserAutomationToolOptions",
    "csharp"
  );
  @@usage(BrowserAutomationToolParameters, Usage.input | Usage.output);

  @@access(FabricDataAgentToolCall, Access.public);
  @@usage(FabricDataAgentToolCall, Usage.input | Usage.output);

  @@access(FabricDataAgentToolCallOutput, Access.public);
  @@usage(FabricDataAgentToolCallOutput, Usage.input | Usage.output);

  @@access(AzureFunctionToolCall, Access.public);
  @@usage(AzureFunctionToolCall, Usage.input | Usage.output);

  @@access(AzureFunctionToolCallOutput, Access.public);
  @@usage(AzureFunctionToolCallOutput, Usage.input | Usage.output);

  @@access(Azure.AI.Projects.A2AToolCall, Access.public);
  @@usage(Azure.AI.Projects.A2AToolCall, Usage.input | Usage.output);

  @@access(Azure.AI.Projects.A2AToolCallOutput, Access.public);
  @@usage(Azure.AI.Projects.A2AToolCallOutput, Usage.input | Usage.output);

  @@access(MemorySearchToolCall, Access.public);
  @@usage(MemorySearchToolCall, Usage.input | Usage.output);

  @@access(MemoryCommandToolCall, Access.public);
  @@usage(MemoryCommandToolCall, Usage.input | Usage.output);

  @@access(MemoryCommandToolCallOutput, Access.public);
  @@usage(MemoryCommandToolCallOutput, Usage.input | Usage.output);

  @@usage(WorkflowActionOutputItem, Usage.input | Usage.output);
  @@usage(AISearchIndexResource, Usage.input | Usage.output);
  @@clientName(AISearchIndexResource, "AzureAISearchToolIndex");

  @@usage(AzureAISearchQueryType, Usage.input | Usage.output);
  @@usage(AzureAISearchTool, Usage.input | Usage.output);

  @@clientName(AzureAISearchToolResource, "AzureAISearchToolOptions");
  @@usage(AzureAISearchToolResource, Usage.input | Usage.output);

  @@usage(AzureFunctionBinding, Usage.input | Usage.output);
  @@usage(AzureFunctionDefinition, Usage.input | Usage.output);

  @@usage(AzureFunctionStorageQueue, Usage.input | Usage.output);
  @@usage(AzureFunctionTool, Usage.input | Usage.output);
  @@usage(BingCustomSearchConfiguration, Usage.input | Usage.output);
  @@usage(BingCustomSearchPreviewTool, Usage.input | Usage.output);
  @@usage(BingCustomSearchToolParameters, Usage.input | Usage.output);
  @@clientName(
    BingCustomSearchToolParameters,
    "BingCustomSearchToolOptions",
    "csharp"
  );
  @@clientName(
    BingGroundingSearchToolParameters,
    "BingGroundingSearchToolOptions",
    "!autorest"
  );

  @@usage(BingGroundingSearchToolParameters, Usage.input | Usage.output);
  @@usage(BingGroundingSearchConfiguration, Usage.input | Usage.output);

  @@usage(BingGroundingTool, Usage.input | Usage.output);
  @@usage(BrowserAutomationPreviewTool, Usage.input | Usage.output);
  @@usage(BrowserAutomationTool, Usage.input | Usage.output);
  @@usage(
    BrowserAutomationToolConnectionParameters,
    Usage.input | Usage.output
  );
  @@usage(CaptureStructuredOutputsTool, Usage.input | Usage.output);
  @@usage(MemorySearchOptions, Usage.input | Usage.output);
  @@usage(MemorySearchPreviewTool, Usage.input | Usage.output);
  @@usage(MicrosoftFabricPreviewTool, Usage.input | Usage.output);
  @@clientName(
    MicrosoftFabricPreviewTool.fabric_dataagent_preview,
    "ToolOptions",
    "csharp"
  );
  @@usage(OpenApiManagedAuthDetails, Usage.input | Usage.output);
  @@clientName(OpenApiAuthDetails, "OpenApiAuthenticationDetails", "!autorest");

  @@usage(OpenApiAuthDetails, Usage.input);

  @@clientName(
    OpenApiAnonymousAuthDetails,
    "OpenApiAnonymousAuthenticationDetails",
    "!autorest"
  );

  @@usage(OpenApiManagedSecurityScheme, Usage.input | Usage.output);
  @@usage(OpenApiProjectConnectionAuthDetails, Usage.input | Usage.output);

  @@clientName(
    OpenApiProjectConnectionAuthDetails,
    "OpenApiProjectConnectionAuthenticationDetails",
    "!autorest"
  );
  @@usage(OpenApiProjectConnectionSecurityScheme, Usage.input | Usage.output);

  @@clientName(
    OpenApiProjectConnectionSecurityScheme,
    "OpenApiProjectConnectionSecurityScheme",
    "!autorest"
  );

  @@usage(SharepointPreviewTool, Usage.input | Usage.output);
  @@clientName(
    SharepointPreviewTool.sharepoint_grounding_preview,
    "ToolOptions",
    "csharp"
  );

  @@usage(WebSearchConfiguration, Usage.input | Usage.output);
  @@usage(WorkIQPreviewTool, Usage.input | Usage.output);
  @@clientName(AzureAISearchTool.azure_ai_search, "AzureAISearch");
  @@clientName(AzureFunctionBinding.type, "Kind");
  @@access(AzureFunctionBinding.type, Access.internal);
  @@clientName(BingGroundingSearchConfiguration.set_lang, "Language");
  @@clientName(OpenAI.DetailEnum, "ImageDetailLevel");
  @@clientName(OpenAI.ComputerScreenshotImage.image_url, "ImageUri");
  @@clientName(OpenAI.ComputerScreenshotImage.type, "ImageKind");
  @@clientName(OpenAI.AutoCodeInterpreterToolParam.type, "Kind");
  @@access(OpenAI.AutoCodeInterpreterToolParam.type, Access.internal);
  @@clientName(OpenAI.CustomToolParam.defer_loading, "ShouldDeferLoading");
  @@clientName(OpenAI.FunctionToolParam.defer_loading, "ShouldDeferLoading");
  @@clientName(OpenAI.FunctionToolParam.strict, "IsStrict");
  @@access(OpenAI.FunctionToolParam.type, Access.internal);
  @@access(OpenAI.InlineSkillSourceParam.type, Access.internal);
  @@clientName(OpenAI.MCPToolFilter.read_only, "IsReadOnly");

  @@clientName(MemorySearchPreviewTool.update_delay, "UpdateDelayInSeconds");
  @@clientName(MemorySearchOptions, "MemorySearchResultOptions");
  @@alternateType(Azure.AI.Projects.OpenApiFunctionDefinition.spec, unknown);
  @@clientName(OpenApiFunctionDefinition.spec, "Specification");
  @@usage(OpenApiFunctionDefinition, Usage.input | Usage.output);

  @@usage(OpenApiTool, Usage.input | Usage.output);
  @@access(OpenApiTool, Access.public);
  @@clientName(OpenApiTool.openapi, "FunctionDefinition", "csharp");
  @@clientName(OpenApiTool.openapi, "OpenApi");

  @@clientName(StructuredOutputDefinition.strict, "IsStrict");
  @@clientName(OpenAI.WebSearchApproximateLocation.type, "Kind");
  @@access(OpenAI.WebSearchApproximateLocation.type, Access.internal);
  @@clientName(
    OpenAI.OutputItemMcpApprovalResponseResource.approve,
    "IsApproved"
  );

  @@clientName(A2APreviewTool.base_url, "BaseUri");
  @@usage(A2APreviewTool, Usage.input | Usage.output);

  @@usage(FabricIQPreviewTool, Usage.input | Usage.output);
  @@clientName(FabricIQPreviewTool.server_url, "ServerUri");
  @@usage(WebIQPreviewTool, Usage.input | Usage.output);
  @@clientName(
    CaptureStructuredOutputsTool.outputs,
    "OutputDefinition",
    "csharp"
  );

  // --------------------------------------------------------------------------------
  // Usage / Public accessibility overrides
  // --------------------------------------------------------------------------------

  // @@changePropertyType(OpenAI.InputMessage.role, OpenAI.MessageRole);

  @@copyProperties(
    OpenAI.OutputItem,
    {
      id?: string,
    }
  );

  @@usage(OpenAI.OutputItem, Usage.input | Usage.output);
  @@access(OpenAI.OutputItem, Access.public);
  @@clientName(OpenAI.OutputItem, "AgentResponseItem");

  @@usage(OpenAI.CreateResponseStreamingResponse, Usage.json);

  @@usage(AgentId, Usage.output);
  @@access(AgentId, Access.public);

  @@usage(AgentReference, Usage.input | Usage.output);
  @@access(AgentReference, Access.public);

  @@usage(ApiError, Usage.output);
  @@access(ApiError, Access.public);

  @@usage(StructuredOutputsOutputItem, Usage.input | Usage.output);
}
