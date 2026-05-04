import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core.Experimental;

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@clientNamespace("Azure.AI.Extensions.OpenAI")
namespace Azure.AI.Projects {
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

  @@usage(OpenAI.ConversationResource, Usage.output);
  @@access(OpenAI.ConversationResource, Access.public);
  @@clientName(OpenAI.ConversationResource, "ProjectConversation");
  @@usage(OpenAI.CreateConversationBody, Usage.input);
  @@access(OpenAI.CreateConversationBody, Access.public);
  @@usage(OpenAI.UpdateConversationBody, Usage.input);
  @@access(OpenAI.UpdateConversationBody, Access.public);

  @@access(OpenAI.Metadata, Access.internal);
  @@clientName(OpenAI.Metadata, "InternalMetadataContainer");

  // --------------------------------------------------------------------------------
  // Root client
  // --------------------------------------------------------------------------------
  @@clientName(OpenAI, "ProjectOpenAIClient");

  // --------------------------------------------------------------------------------
  // Fix the xref.
  // --------------------------------------------------------------------------------
  @@clientNamespace(OpenAI, "Azure.AI.Extensions.OpenAI", "csharp");
  @@clientNamespace(Azure.AI.Projects, "Azure.AI.Extensions.OpenAI", "csharp");

  @@clientName(CreatedBy, "AgentResponseItemSource");
  @@clientName(FabricDataAgentToolParameters, "FabricDataAgentToolOptions");

  @@clientName(MemorySearchToolCallItemResource,
    "MemorySearchToolCallResponseItem"
  );
  @@clientName(OAuthConsentRequestOutputItem,
    "OAuthConsentRequestResponseItem"
  );
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

  // Use alternateType to replace the inline union with our named union for SDK generation
  @@alternateType(OpenAI.LocalShellToolCallOutput.status,
    LocalShellToolCallOutputStatus
  );

  // Rename and include in typegraph
  @@clientName(LocalShellToolCallOutputStatus,
    "ItemLocalShellToolCallOutputStatus"
  );

  // --------------------------------------------------------------------------------
  // Renames and visibility changes for targeted suppressions
  // --------------------------------------------------------------------------------
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

  @@access(OpenAI.OutputItemApplyPatchToolCall, Access.internal);
  @@clientName(OpenAI.OutputItemApplyPatchToolCall,
    "InternalOutputItemApplyPatchToolCall"
  );

  @@access(OpenAI.OutputItemApplyPatchToolCallOutput, Access.internal);
  @@clientName(OpenAI.OutputItemApplyPatchToolCallOutput,
    "InternalOutputItemApplyPatchToolCallOutput"
  );

  @@access(OpenAI.ApplyPatchFileOperation, Access.internal);
  @@clientName(OpenAI.ApplyPatchFileOperation,
    "InternalApplyPatchFileOperation"
  );

  @@access(OpenAI.ApplyPatchCreateFileOperationParam, Access.internal);
  @@clientName(OpenAI.ApplyPatchCreateFileOperationParam,
    "InternalApplyPatchCreateFileOperationParam"
  );

  @@access(OpenAI.OutputItemOutputMessage, Access.internal);
  @@clientName(OpenAI.OutputItemOutputMessage, "InternalOutputItemMessage");

  @@access(OpenAI.ItemComputerToolCall, Access.internal);
  @@clientName(OpenAI.ItemComputerToolCall, "InternalItemComputerToolCall");

  @@access(OpenAI.FileSearchToolCall, Access.internal);
  @@clientName(OpenAI.FileSearchToolCall, "InternalFileSearchToolCall");

  @@access(OpenAI.OutputItemFileSearchToolCall, Access.internal);
  @@clientName(OpenAI.OutputItemFileSearchToolCall,
    "InternalOutputItemFileSearchToolCall"
  );

  @@access(OpenAI.ItemMcpListTools, Access.internal);
  @@clientName(OpenAI.ItemMcpListTools, "InternalItemMcpListTools");

  @@access(OpenAI.OutputItemOutputMessage, Access.internal);
  @@clientName(OpenAI.OutputItemOutputMessage,
    "InternalOutputItemOutputMessage"
  );

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
  @@clientName(OpenAI.InputImageContentParamAutoParam,
    "InternalInputImageContentParamAutoParam"
  );
  @@access(OpenAI.InputTextContent, Access.internal);
  @@clientName(OpenAI.InputTextContent, "InternalInputTextContent");

  @@access(OpenAI.InputTextContentParam, Access.internal);
  @@clientName(OpenAI.InputTextContentParam, "InternalInputTextContentParam");

  @@access(OpenAI.OutputItemMcpListTools, Access.internal);
  @@clientName(OpenAI.OutputItemMcpListTools, "InternalOutputItemMcpListTools");

  @@access(OpenAI.OutputMessageContentOutputTextContent, Access.internal);
  @@clientName(OpenAI.OutputMessageContentOutputTextContent,
    "InternalOutputMessageContentOutputTextContent"
  );

  @@access(OpenAI.OutputContentOutputTextContent, Access.internal);
  @@clientName(OpenAI.OutputContentOutputTextContent,
    "InternalOutputContentOutputTextContent"
  );

  @@access(OpenAI.ItemComputerToolCall, Access.internal);
  @@clientName(OpenAI.ItemComputerToolCall, "InternalItemComputerToolCall");
  @@access(OpenAI.OutputItemComputerToolCall, Access.internal);
  @@clientName(OpenAI.OutputItemComputerToolCall,
    "InternalOutputItemComputerToolCall"
  );

  @@access(OpenAI.OutputItemCodeInterpreterToolCall, Access.internal);
  @@clientName(OpenAI.OutputItemCodeInterpreterToolCall,
    "InternalOutputItemCodeInterpreterToolCall"
  );

  @@access(OpenAI.ItemOutputMessage, Access.internal);
  @@clientName(OpenAI.ItemOutputMessage, "InternalItemMessage");

  @@access(OpenAI.FunctionAndCustomToolCallOutput, Access.internal);
  @@clientName(OpenAI.FunctionAndCustomToolCallOutput,
    "InternalFunctionAndCustomToolCallOutput"
  );

  @@access(OpenAI.OutputItemMcpToolCall, Access.internal);
  @@clientName(OpenAI.OutputItemMcpToolCall, "InternalOutputItemMcpToolCall");

  @@access(OpenAI.ItemResourceMcpApprovalResponseResource, Access.internal);
  @@clientName(OpenAI.ItemResourceMcpApprovalResponseResource,
    "InternalOutputItemMcpApprovalResponseResource"
  );

  @@access(OpenAI.OutputItemMcpApprovalRequest, Access.internal);
  @@clientName(OpenAI.OutputItemMcpApprovalRequest,
    "InternalOutputItemMcpApprovalRequest"
  );

  @@access(OpenAI.OutputItemFunctionShellCallOutput, Access.internal);
  @@clientName(OpenAI.OutputItemFunctionShellCallOutput,
    "InternalOutputItemFunctionShellCallOutput"
  );

  @@access(OpenAI.OutputItemFunctionShellCall, Access.internal);
  @@clientName(OpenAI.OutputItemFunctionShellCall,
    "InternalOutputItemFunctionShellCall"
  );

  @@access(OpenAI.ItemLocalShellToolCallOutput, Access.internal);
  @@clientName(OpenAI.ItemLocalShellToolCallOutput,
    "InternalOutputItemLocalShellToolCallOutput"
  );

  @@access(OpenAI.OutputItemLocalShellToolCall, Access.internal);
  @@clientName(OpenAI.OutputItemLocalShellToolCall,
    "InternalOutputItemLocalShellToolCall"
  );

  @@access(OpenAI.OutputItemImageGenToolCall, Access.internal);
  @@clientName(OpenAI.OutputItemImageGenToolCall,
    "InternalOutputItemImageGenToolCall"
  );

  @@access(OpenAI.FunctionToolCallOutput, Access.internal);
  @@clientName(OpenAI.FunctionToolCallOutput,
    "InternalOutputItemFunctionToolCallOutput"
  );

  @@access(OpenAI.OutputItemFunctionToolCall, Access.internal);
  @@clientName(OpenAI.OutputItemFunctionToolCall,
    "InternalOutputItemFunctionToolCall"
  );

  @@access(OpenAI.OutputItemWebSearchToolCall, Access.internal);
  @@clientName(OpenAI.OutputItemWebSearchToolCall,
    "InternalOutputItemWebSearchToolCall"
  );

  @@access(OpenAI.ItemResourceComputerToolCallOutput, Access.internal);
  @@clientName(OpenAI.ItemResourceComputerToolCallOutput,
    "InternalOutputItemComputerToolCallOutput"
  );

  @@access(OpenAI.ItemCustomToolCallOutput, Access.internal);
  @@clientName(OpenAI.ItemCustomToolCallOutput,
    "InternalOutputItemCustomToolCallOutput"
  );

  @@access(OpenAI.OutputItemReasoningItem, Access.internal);
  @@clientName(OpenAI.OutputItemReasoningItem,
    "InternalOutputItemReasoningItem"
  );

  @@clientName(MemoryItem, "MemoryOutputItem");

  @@access(OpenAI.SummaryTextContent, Access.internal);
  @@clientName(OpenAI.SummaryTextContent, "InternalSummaryTextObject");

  @@access(OpenAI.OutputItemCompactionBody, Access.internal);
  @@clientName(OpenAI.OutputItemCompactionBody,
    "InternalOutputItemCompactionBody"
  );

  @@access(OpenAI.OutputItemCustomToolCallResource, Access.internal);
  @@clientName(OpenAI.OutputItemCustomToolCallResource,
    "InternalOutputItemCustomToolCallResource"
  );

  @@clientName(_AgentItemType.a2a_preview_call, "A2APreviewCall ");
  @@clientName(_AgentItemType.a2a_preview_call_output, "A2APreviewCallOutput");

  @@access(OpenAI.WebSearchActionFind, Access.internal);
  @@clientName(OpenAI.WebSearchActionFind, "InternalWebSearchActionFind");

  @@access(OpenAI.WebSearchActionOpenPage, Access.internal);
  @@clientName(OpenAI.WebSearchActionOpenPage,
    "InternalWebSearchActionOpenPage"
  );

  @@access(OpenAI.WebSearchActionSearch, Access.internal);
  @@clientName(OpenAI.WebSearchActionSearch, "InternalWebSearchActionSearch");

  @@access(OpenAI.CodeInterpreterOutputImage, Access.internal);
  @@clientName(OpenAI.CodeInterpreterOutputImage,
    "InternalCodeInterpreterOutputImage"
  );

  @@access(OpenAI.CodeInterpreterOutputLogs, Access.internal);
  @@clientName(OpenAI.CodeInterpreterOutputLogs,
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

  @@access(CreatedBy, Access.public);
  @@usage(CreatedBy, Usage.output);
  @@clientName(CreatedBy, "AgentItemSource");
  @@clientName(OpenAI.DetailEnum, "ImageDetailLevel");
  // --------------------------------------------------------------------------------
  // Usage / Public accessibility overrides
  // --------------------------------------------------------------------------------

  // @@changePropertyType(OpenAI.InputMessage.role, OpenAI.MessageRole);

  @@copyProperties(OpenAI.OutputItem,
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

  @@usage(AgentReference, Usage.input);
  @@access(AgentReference, Access.public);

  @@usage(ApiError, Usage.output);
  @@access(ApiError, Access.public);

  @@usage(StructuredOutputsOutputItem, Usage.input | Usage.output);

  // --------------------------------------------------------------------------------
  // Renames for tools.
  // --------------------------------------------------------------------------------
  @@clientName(OpenAI.ContainerMemoryLimit, "ResponsesContainerMemoryLimit");
  @@clientName(OpenAI.FunctionCallOutputStatusEnum,
    "ResponsesFunctionCallOutputStatusEnum"
  );
  @@clientName(OpenAI.FunctionCallStatus, "ResponsesFunctionCallStatus");
  @@clientName(OpenAI.ToolSearchExecutionType,
    "ResponsesToolSearchExecutionType"
  );
}
