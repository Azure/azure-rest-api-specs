import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core.Experimental;

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@clientNamespace("Azure.AI.Projects.Agents")
namespace Azure.AI.Projects {
  @@usage(CreateAgentVersionFromManifestRequest, Usage.input);
  @@access(CreateAgentVersionFromManifestRequest, Access.public);

  @@usage(CreateAgentVersionRequest, Usage.input);
  @@access(CreateAgentVersionRequest, Access.public);

  @@access(OpenAI.Metadata, Access.internal);
  @@clientName(OpenAI.Metadata, "InternalMetadataContainer");

  @@usage(ApiError, Usage.output);
  @@access(ApiError, Access.public);

  // --------------------------------------------------------------------------------
  // Fix the xref.
  // --------------------------------------------------------------------------------
  //@@clientNamespace(OpenAI, "Azure.AI.Projects.Agents", "csharp");

  // --------------------------------------------------------------------------------
  // Root client
  // --------------------------------------------------------------------------------
  @@clientName(Agents, "AgentAdministrationClient", "csharp");
  @@clientInitialization(Azure.AI.Projects.Agents,
    {
      initializedBy: InitializedBy.parent | InitializedBy.individually,
    }
  );

  @@clientName(AgentObject, "AgentRecord");

  @@clientName(BingGroundingSearchToolParameters,
    "BingGroundingSearchToolOptions"
  );
  @@clientName(ContainerAppAgentDefinition,
    "ContainerApplicationAgentDefinition"
  );
  //  @@clientName(CreatedBy, "AgentResponseItemSource");
  @@clientName(FabricDataAgentToolParameters, "FabricDataAgentToolOptions");

  @@clientName(MemorySearchOptions, "MemorySearchToolOptions");

  @@clientName(OpenApiTool, "OpenAPITool");
  @@clientName(OpenApiTool.openapi, "FunctionDefinition", "csharp");
  @@clientName(OpenApiAnonymousAuthDetails,
    "OpenAPIAnonymousAuthenticationDetails"
  );
  @@clientName(OpenApiAuthDetails, "OpenApiAuthenticationDetails");
  @@clientName(OpenApiManagedAuthDetails,
    "OpenAPIManagedAuthenticationDetails"
  );
  @@clientName(OpenApiProjectConnectionAuthDetails,
    "OpenApiProjectConnectionAuthenticationDetails"
  );
  @@clientName(OpenApiProjectConnectionSecurityScheme,
    "OpenApiProjectConnectionSecurityScheme"
  );
  @@clientName(OpenApiManagedSecurityScheme, "OpenAPIManagedSecurityScheme");

  @@clientName(OpenApiFunctionDefinition.auth,
    "AuthenticationDetails",
    "csharp"
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

  @@access(OpenAI.ApplyPatchToolParam, Access.internal);
  @@clientName(OpenAI.ApplyPatchToolParam, "InternalApplyPatchToolParam");

  @@access(OpenAI.CustomToolParam, Access.internal);
  @@clientName(OpenAI.CustomToolParam, "InternalCustomToolParam");

  @@access(OpenAI.FunctionShellToolParam, Access.internal);
  @@clientName(OpenAI.FunctionShellToolParam, "InternalFunctionShellToolParam");

  @@access(OpenAI.AutoCodeInterpreterToolParam, Access.internal);
  @@clientName(OpenAI.AutoCodeInterpreterToolParam,
    "InternalAutoCodeInterpreterToolParam"
  );

  @@access(OpenAI.MCPToolFilter, Access.internal);
  @@clientName(OpenAI.MCPToolFilter, "InternalMCPToolFilter");

  @@access(OpenAI.MCPToolRequireApproval, Access.internal);
  @@clientName(OpenAI.MCPToolRequireApproval, "InternalMCPToolRequireApproval");

  @@access(OpenAI.WebSearchActionFind, Access.internal);
  @@clientName(OpenAI.WebSearchActionFind, "InternalWebSearchActionFind");

  @@access(OpenAI.CodeInterpreterTool, Access.internal);
  @@clientName(OpenAI.CodeInterpreterTool, "InternalCodeInterpreterTool");

  @@access(OpenAI.ComparisonFilter, Access.internal);
  @@clientName(OpenAI.ComparisonFilter, "InternalComparisonFilter");

  @@access(OpenAI.CompoundFilter, Access.internal);
  @@clientName(OpenAI.CompoundFilter, "InternalCompoundFilter");

  @@access(OpenAI.ComputerUsePreviewTool, Access.internal);
  @@clientName(OpenAI.ComputerUsePreviewTool, "InternalComputerUsePreviewTool");
  @@access(OpenAI.FileSearchTool, Access.internal);
  @@clientName(OpenAI.FileSearchTool, "InternalFileSearchTool");

  @@access(OpenAI.FunctionTool, Access.internal);
  @@clientName(OpenAI.FunctionTool, "InternalFunctionTool");

  @@access(OpenAI.ImageGenTool, Access.internal);
  @@clientName(OpenAI.ImageGenTool, "InternalImageGenTool");

  @@access(OpenAI.MCPTool, Access.internal);
  @@clientName(OpenAI.MCPTool, "InternalMCPTool");

  @@access(AgentObjectType, Access.internal);
  @@clientName(AgentObjectType, "InternalAgentObjectType");

  @@access(OpenAI.ToolChoiceParam, Access.internal);
  @@clientName(OpenAI.ToolChoiceParam, "InternalToolChoiceParam");

  @@access(OpenAI.WebSearchPreviewTool, Access.internal);
  @@clientName(OpenAI.WebSearchPreviewTool, "InternalWebSearchPreviewTool");

  @@access(OpenAI.WebSearchTool, Access.internal);
  @@clientName(OpenAI.WebSearchTool, "InternalWebSearchTool");

  @@clientName(HostedAgentDefinition.container_protocol_versions,
    "versions",
    "csharp"
  );

  @@clientName(BingCustomSearchToolParameters,
    "BingCustomSearchToolOptions",
    "csharp"
  );
  @@clientName(BrowserAutomationToolParameters,
    "BrowserAutomationToolOptions",
    "csharp"
  );
  @@clientName(BingGroundingSearchConfiguration.set_lang,
    "BingUserInterfaceLanguage",
    "csharp"
  );
  @@clientName(BingGroundingTool.bing_grounding, "SearchToolOptions", "csharp");
  @@clientName(BrowserAutomationPreviewTool.browser_automation_preview,
    "ToolParameters",
    "csharp"
  );
  @@clientName(BrowserAutomationToolParameters.connection,
    "ToolConnectionParameters",
    "csharp"
  );
  @@clientName(CaptureStructuredOutputsTool.outputs,
    "OutputDefinition",
    "csharp"
  );
  @@clientName(MemorySearchPreviewTool.update_delay,
    "UpdateDelayInSecs",
    "csharp"
  );
  @@clientName(MicrosoftFabricPreviewTool.fabric_dataagent_preview,
    "ToolOptions",
    "csharp"
  );
  @@clientName(SharepointPreviewTool.sharepoint_grounding_preview,
    "ToolOptions",
    "csharp"
  );
  // --------------------------------------------------------------------------------
  // Usage / Public accessibility overrides
  // --------------------------------------------------------------------------------

  @@usage(AgentDefinition, Usage.input | Usage.output);
  @@access(AgentDefinition, Access.public);

  @@usage(PromptAgentDefinition, Usage.input | Usage.output);
  @@access(PromptAgentDefinition, Access.public);
  @@clientName(PromptAgentDefinition, "DeclarativeAgentDefinition");

  @@usage(AgentObject, Usage.output);
  @@access(AgentObject, Access.public);
  @@clientName(AgentObject, "AgentRecord");

  @@usage(AgentVersionObject, Usage.output);
  @@access(AgentVersionObject, Access.public);
  @@clientName(AgentVersionObject, "AgentVersion");
}
