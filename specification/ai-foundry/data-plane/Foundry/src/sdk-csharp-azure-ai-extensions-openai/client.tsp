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
  @@scope(Conversations.createConversation, "!csharp");
  @@scope(Conversations.updateConversation, "!csharp");

  @@scope(Conversations.listConversations, "!csharp");
  @@scope(Conversations.getConversation, "!csharp");
  @@scope(Conversations.deleteConversation, "!csharp");
  @@scope(Conversations.createConversationItems, "!csharp");
  @@scope(Conversations.listConversationItems, "!csharp");
  @@scope(Conversations.getConversationItem, "!csharp");
  @@scope(Conversations.deleteConversationItem, "!csharp");

  // --------------------------------------------------------------------------------
  // Fix the xref.
  // Set it to default move all of OpenAI to "Internal" to make detecting new models
  // simpler.
  // --------------------------------------------------------------------------------
  @@clientNamespace(OpenAI, "Azure.AI.Extensions.OpenAI.Internal", "csharp");

  // --------------------------------------------------------------------------------
  // Root client
  // --------------------------------------------------------------------------------
  @@clientName(OpenAI, "ProjectOpenAIClient");

  // The conversation data models (ConversationResource, CreateConversationBody,
  // UpdateConversationBody) are now emitted by the OpenAI SDK (2.12+), so they are
  // no longer generated here. The Foundry ProjectConversationsClient wrapper consumes
  // OpenAI's OpenAI.Conversations.* types directly.

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

  @@clientName(WorkflowActionOutputItem.kind, "CSDLActionKind");

  // Now take the OpenAI models, and ensure that they are emitted as consumption points from the OpenAI SDK instead of re-emitting them here.
  // This is to ensure that the OpenAI SDK is the source of truth for these models, and we don't have duplicate definitions.
  @@usage(OpenAI.OutputItemType, Usage.output | Usage.json | Usage.input);
  @@alternateType(
    OpenAI.OutputItemType,
    {
      identity: "OpenAI.Responses.ResponseItemKind",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  @@usage(OpenAI.ToolType, Usage.output | Usage.json | Usage.input);

  @@alternateType(
    OpenAI.ToolType,
    {
      identity: "OpenAI.Responses.ResponseToolKind",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.Tool,
    {
      identity: "OpenAI.Responses.ResponseTool",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ComputerTool,
    {
      identity: "OpenAI.Responses.ComputerTool",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  @@alternateType(
    OpenAI.WebSearchTool,
    {
      identity: "OpenAI.Responses.WebSearchTool",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.FunctionTool,
    {
      identity: "OpenAI.Responses.FunctionTool",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.AnnotationType,
    {
      identity: "OpenAI.Responses.ResponseMessageAnnotationKind",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ApplyPatchCallOutputStatus,
    {
      identity: "OpenAI.Responses.ApplyPatchCallOutputStatus",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ImageGenTool,
    {
      identity: "OpenAI.Responses.ImageGenerationTool",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ImageGenTool,
    {
      identity: "OpenAI.Responses.ImageGenerationTool",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  @@alternateType(
    OpenAI.CodeInterpreterOutputImage,
    {
      identity: "OpenAI.Responses.CodeInterpreterCallImageOutput",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.CodeInterpreterOutputLogs,
    {
      identity: "OpenAI.Responses.CodeInterpreterCallLogsOutput",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  // --------------------------------------------------------------------------------
  // Export OpenAI types from the OpenAI package instead of re-emitting them.
  // Each target verified public in OpenAI 2.11.0. Input/output TypeSpec twins
  // (the "...Param" variants) are mapped onto the single OpenAI package type.
  // --------------------------------------------------------------------------------

  // ApplyPatch tool: status enums (closed enum -> extensible struct in package)
  @@alternateType(
    OpenAI.ApplyPatchCallOutputStatusParam,
    {
      identity: "OpenAI.Responses.ApplyPatchCallOutputStatus",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ApplyPatchCallStatus,
    {
      identity: "OpenAI.Responses.ApplyPatchCallStatus",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ApplyPatchCallStatusParam,
    {
      identity: "OpenAI.Responses.ApplyPatchCallStatus",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  // ApplyPatch tool: file operations
  @@alternateType(
    OpenAI.ApplyPatchOperationParam,
    {
      identity: "OpenAI.Responses.ApplyPatchOperation",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ApplyPatchCreateFileOperation,
    {
      identity: "OpenAI.Responses.ApplyPatchCreateFileOperation",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ApplyPatchDeleteFileOperation,
    {
      identity: "OpenAI.Responses.ApplyPatchDeleteFileOperation",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ApplyPatchDeleteFileOperationParam,
    {
      identity: "OpenAI.Responses.ApplyPatchDeleteFileOperation",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ApplyPatchUpdateFileOperation,
    {
      identity: "OpenAI.Responses.ApplyPatchUpdateFileOperation",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ApplyPatchUpdateFileOperationParam,
    {
      identity: "OpenAI.Responses.ApplyPatchUpdateFileOperation",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  // Computer tool
  // @@alternateType(OpenAI.ComputerActionType, {  identity: "OpenAI.Responses.ComputerCallActionKind",  package: "OpenAI",  minVersion: "2.12.0"}, "csharp");
  @@alternateType(
    OpenAI.ComputerCallSafetyCheckParam,
    {
      identity: "OpenAI.Responses.ComputerCallSafetyCheck",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  // Message item
  //@@alternateType(OpenAI.MessageRole, {  identity: "OpenAI.Responses.MessageRole",  package: "OpenAI",  minVersion: "2.12.0"}, "csharp");
  //@@alternateType(OpenAI.MessageStatus, {  identity: "OpenAI.Responses.MessageStatus",  package: "OpenAI",  minVersion: "2.12.0"}, "csharp");

  // Annotations
  @@alternateType(
    OpenAI.ContainerFileCitationBody,
    {
      identity: "OpenAI.Responses.ContainerFileCitationMessageAnnotation",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  // Response-level enums / details
  @@alternateType(
    OpenAI.ResponseErrorCode,
    {
      identity: "OpenAI.Responses.ResponseErrorCode",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  // NOTE: the TypeSpec model is `union ServiceTier`; the emitter prefixes it to
  // ResponseServiceTier, so the alternateType source must be OpenAI.ServiceTier.
  @@alternateType(
    OpenAI.ServiceTier,
    {
      identity: "OpenAI.Responses.ResponseServiceTier",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  // Token usage
  @@alternateType(
    OpenAI.ResponseUsage,
    {
      identity: "OpenAI.Responses.ResponseTokenUsage",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ResponseUsageInputTokensDetails,
    {
      identity: "OpenAI.Responses.ResponseInputTokenUsageDetails",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ResponseUsageOutputTokensDetails,
    {
      identity: "OpenAI.Responses.ResponseOutputTokenUsageDetails",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  @@alternateType(
    OpenAI.Annotation,
    {
      identity: "OpenAI.Responses.ResponseMessageAnnotation",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  @@alternateType(
    OpenAI.Response,
    {
      identity: "OpenAI.Responses.ResponseResult",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  @@alternateType(
    OpenAI.DetailEnum,
    {
      identity: "OpenAI.Responses.ResponseImageDetailLevel",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ImageGenActionEnum,
    {
      identity: "OpenAI.Responses.ImageGenerationToolAction",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.InputFidelity,
    {
      identity: "OpenAI.Responses.ImageGenerationToolInputFidelity",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.TopLogProb,
    {
      identity: "OpenAI.Responses.ResponseTokenTopLogProbabilityDetails",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.LogProb,
    {
      identity: "OpenAI.Responses.ResponseTokenLogProbabilityDetails",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  @@alternateType(
    OpenAI.Reasoning,
    {
      identity: "OpenAI.Responses.ResponseReasoningOptions",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ResponseError,
    {
      identity: "OpenAI.Responses.ResponseError",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ApproximateLocation,
    {
      identity: "OpenAI.Responses.WebSearchToolApproximateLocation",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  @@alternateType(
    OpenAI.MCPTool,
    {
      identity: "OpenAI.Responses.McpTool",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.WebSearchPreviewTool,
    {
      identity: "OpenAI.Responses.WebSearchPreviewTool",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.CodeInterpreterTool,
    {
      identity: "OpenAI.Responses.CodeInterpreterToolContainer",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.MCPListToolsTool,
    {
      identity: "OpenAI.Responses.McpToolDefinition",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.WebSearchActionSearch,
    {
      identity: "OpenAI.Responses.WebSearchSearchAction",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.WebSearchActionOpenPage,
    {
      identity: "OpenAI.Responses.WebSearchOpenPageAction",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.WebSearchActionFind,
    {
      identity: "OpenAI.Responses.WebSearchFindInPageAction",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  //@@alternateType(OpenAI.MCPToolRequireApproval, {  identity: "OpenAI.Responses.McpToolCallApprovalPolicy",  package: "OpenAI",  minVersion: "2.12.0"}, "csharp");
  @@alternateType(
    OpenAI.MCPToolFilter,
    {
      identity: "OpenAI.Responses.McpToolFilter",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  // And now drop classes that aren't referenced, and aren't pruned.
  @@alternateType(
    OpenAI.InputTextContent,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.InputTextContentParam,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.InputImageContent,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ComparisonFilter,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.CompoundFilter,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.RankingOptions,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.InputImageContentParamAutoParam,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.InputFileContent,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  // GAP (FD-2): The Foundry service accepts `memory_limit` and `network_policy` on the code-interpreter
  // "auto" container config (see AutoCodeInterpreterToolParam in the compiled openapi3), but OpenAI's
  // .NET type `OpenAI.Responses.AutomaticCodeInterpreterToolContainerConfiguration` (2.12.0) models only
  // `file_ids`. This is an upstream source-of-truth lag: openai-dotnet/specification's CodeInterpreterToolAuto
  // omits these fields while openai-openapi-pr defines them, so no richer OpenAI type exists to map to.
  // Dropping to System.Object intentionally leaves the gap unfilled (file_ids and container-id selection are
  // unaffected). Revisit once the OpenAI .NET SDK models memory_limit/network_policy. See CHANGELOG 3.0.0-beta.1.
  @@alternateType(
    OpenAI.AutoCodeInterpreterToolParam,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ToolChoiceOptions,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.VectorStoreFileAttributes,
    {
      identity: "System.Object",
    },
    "csharp"
  );

  @@alternateType(
    OpenAI.ResponseFormatJsonSchemaSchema,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  // OpenAI SDK: internal partial class InternalItemContentInputFile
  @@alternateType(
    OpenAI.InputFileContentParam,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  // ToolType = "local_shell"
  @@alternateType(
    OpenAI.LocalShellToolParam,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  // ToolType = "shell"
  @@alternateType(
    OpenAI.FunctionShellToolParam,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  // ToolType = "custom"
  @@alternateType(
    OpenAI.CustomToolParam,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  // ToolType = "namespace"
  @@alternateType(
    OpenAI.NamespaceToolParam,
    {
      identity: "System.Object",
    },
    "csharp"
  );
  // ToolType = "tool_search"
  @@alternateType(
    OpenAI.ToolSearchToolParam,
    {
      identity: "System.Object",
    },
    "csharp"
  );

  //@@alternateType(OpenAI.CompactResource, { identity: "System.Object" }, "csharp");

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

  // Rename and include in typegraph
  @@clientName(
    LocalShellToolCallOutputStatus,
    "ItemLocalShellToolCallOutputStatus"
  );

  // --------------------------------------------------------------------------------
  // Renames and visibility changes for targeted suppressions
  // --------------------------------------------------------------------------------

  @@clientName(MemoryItem, "MemoryOutputItem");

  @@clientName(_AgentItemType.a2a_preview_call, "A2APreviewCall ");
  @@clientName(_AgentItemType.a2a_preview_call_output, "A2APreviewCallOutput");

  // Emit Azure-specific OutputItem subtypes as public classes
  @@access(BingGroundingToolCall, Access.public);
  @@usage(BingGroundingToolCall, Usage.input | Usage.output);

  @@access(BingGroundingToolCallOutput, Access.public);
  @@usage(BingGroundingToolCallOutput, Usage.input | Usage.output);

  @@access(SharepointGroundingToolCall, Access.public);
  @@usage(SharepointGroundingToolCall, Usage.input | Usage.output);

  @@access(SharepointGroundingToolCallOutput, Access.public);
  @@usage(SharepointGroundingToolCallOutput, Usage.input | Usage.output);

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
    "OpenAPIAnonymousAuthenticationDetails",
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

  @@clientName(MemorySearchPreviewTool.update_delay, "UpdateDelayInSeconds");
  @@clientName(OpenApiFunctionDefinition.spec, "Specification");
  @@usage(OpenApiFunctionDefinition, Usage.input | Usage.output);

  @@clientName(OpenApiTool, "OpenAPITool", "!autorest");
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
  @@clientName(WebIQPreviewTool.server_url, "ServerUri");
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

  @@alternateType(
    OpenAI.OutputItem,
    {
      identity: "OpenAI.Responses.ResponseItem",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  // Memory Stores search/update operations are the only Foundry operations that define
  // OpenAI.InputItem as inputs, which otherwise pulls in the entire OpenAI input-item
  // hierarchy (InputItem -> InputItemComputerToolCall -> ComputerAction -> ClickParam, etc.).
  // Map it to the OpenAI .NET library's ResponseItem, consistent with OutputItem above.
  @@alternateType(
    OpenAI.InputItem,
    {
      identity: "OpenAI.Responses.ResponseItem",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.InputItemType,
    {
      identity: "OpenAI.Responses.ResponseItemKind",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  // Just disappear it.
  @@alternateType(
    OpenAI.EasyInputMessage,
    {
      identity: "System.Object",
    },
    "csharp"
  );

  //@@usage(OpenAI.CreateResponseStreamingResponse, Usage.json);

  @@usage(AgentId, Usage.output);
  @@access(AgentId, Access.public);

  @@usage(AgentReference, Usage.input | Usage.output);
  @@access(AgentReference, Access.public);

  @@usage(ApiError, Usage.output);
  @@access(ApiError, Access.public);

  @@usage(StructuredOutputsOutputItem, Usage.input | Usage.output);
}
