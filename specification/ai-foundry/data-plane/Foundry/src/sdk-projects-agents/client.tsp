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
  @@clientName(OpenAI.Metadata, "InternalMetadataContainer", "!autorest");

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
  @@clientInitialization(
    Azure.AI.Projects.Agents,
    {
      initializedBy: InitializedBy.parent | InitializedBy.individually,
    }
  );

  @@clientName(AgentObject, "AgentRecord", "!autorest");

  @@clientName(
    BingGroundingSearchToolParameters,
    "BingGroundingSearchToolOptions",
    "!autorest"
  );
  @@clientName(
    ContainerAppAgentDefinition,
    "ContainerApplicationAgentDefinition",
    "!autorest"
  );
  //  @@clientName(CreatedBy, "AgentResponseItemSource", "!autorest");
  @@clientName(
    FabricDataAgentToolParameters,
    "FabricDataAgentToolOptions",
    "!autorest"
  );

  @@clientName(MemorySearchOptions, "MemorySearchToolOptions", "!autorest");

  @@clientName(OpenApiTool, "OpenAPITool", "!autorest");
  @@clientName(OpenApiTool.openapi, "FunctionDefinition", "csharp");
  @@clientName(
    OpenApiAnonymousAuthDetails,
    "OpenAPIAnonymousAuthenticationDetails",
    "!autorest"
  );
  @@clientName(OpenApiAuthDetails, "OpenApiAuthenticationDetails", "!autorest");
  @@clientName(
    OpenApiManagedAuthDetails,
    "OpenAPIManagedAuthenticationDetails",
    "!autorest"
  );
  @@clientName(
    OpenApiProjectConnectionAuthDetails,
    "OpenApiProjectConnectionAuthenticationDetails",
    "!autorest"
  );
  @@clientName(
    OpenApiProjectConnectionSecurityScheme,
    "OpenApiProjectConnectionSecurityScheme",
    "!autorest"
  );
  @@clientName(
    OpenApiManagedSecurityScheme,
    "OpenAPIManagedSecurityScheme",
    "!autorest"
  );

  @@clientName(
    OpenApiFunctionDefinition.auth,
    "AuthenticationDetails",
    "csharp"
  );
  @@clientName(RaiConfig, "ContentFilterConfiguration", "!autorest");
  @@clientName(
    SharepointGroundingToolParameters,
    "SharePointGroundingToolOptions",
    "!autorest"
  );
  @@clientName(
    ToolArgumentBinding,
    "StructuredInputToolArgumentBinding",
    "!autorest"
  );

  // --------------------------------------------------------------------------------
  // Renames and visibility changes for targeted suppressions
  // --------------------------------------------------------------------------------

  @@access(OpenAI.LocalShellToolParam, Access.internal);
  @@clientName(
    OpenAI.LocalShellToolParam,
    "InternalLocalShellTool",
    "!autorest"
  );

  @@access(OpenAI.ApplyPatchToolParam, Access.internal);
  @@clientName(
    OpenAI.ApplyPatchToolParam,
    "InternalApplyPatchToolParam",
    "!autorest"
  );

  @@access(OpenAI.CustomToolParam, Access.internal);
  @@clientName(OpenAI.CustomToolParam, "InternalCustomToolParam", "!autorest");

  @@access(OpenAI.FunctionShellToolParam, Access.internal);
  @@clientName(
    OpenAI.FunctionShellToolParam,
    "InternalFunctionShellToolParam",
    "!autorest"
  );

  @@access(OpenAI.AutoCodeInterpreterToolParam, Access.internal);
  @@clientName(
    OpenAI.AutoCodeInterpreterToolParam,
    "InternalAutoCodeInterpreterToolParam",
    "!autorest"
  );

  @@access(OpenAI.MCPToolFilter, Access.internal);
  @@clientName(OpenAI.MCPToolFilter, "InternalMCPToolFilter", "!autorest");

  @@access(OpenAI.MCPToolRequireApproval, Access.internal);
  @@clientName(
    OpenAI.MCPToolRequireApproval,
    "InternalMCPToolRequireApproval",
    "!autorest"
  );

  @@access(OpenAI.WebSearchActionFind, Access.internal);
  @@clientName(
    OpenAI.WebSearchActionFind,
    "InternalWebSearchActionFind",
    "!autorest"
  );

  @@access(OpenAI.CodeInterpreterTool, Access.internal);
  @@clientName(
    OpenAI.CodeInterpreterTool,
    "InternalCodeInterpreterTool",
    "!autorest"
  );

  @@access(OpenAI.ComparisonFilter, Access.internal);
  @@clientName(
    OpenAI.ComparisonFilter,
    "InternalComparisonFilter",
    "!autorest"
  );

  @@access(OpenAI.CompoundFilter, Access.internal);
  @@clientName(OpenAI.CompoundFilter, "InternalCompoundFilter", "!autorest");

  @@access(OpenAI.ComputerUsePreviewTool, Access.internal);
  @@clientName(
    OpenAI.ComputerUsePreviewTool,
    "InternalComputerUsePreviewTool",
    "!autorest"
  );
  @@access(OpenAI.FileSearchTool, Access.internal);
  @@clientName(OpenAI.FileSearchTool, "InternalFileSearchTool", "!autorest");

  @@access(OpenAI.FunctionTool, Access.internal);
  @@clientName(OpenAI.FunctionTool, "InternalFunctionTool", "!autorest");

  @@access(OpenAI.ImageGenTool, Access.internal);
  @@clientName(OpenAI.ImageGenTool, "InternalImageGenTool", "!autorest");

  @@access(OpenAI.MCPTool, Access.internal);
  @@clientName(OpenAI.MCPTool, "InternalMCPTool", "!autorest");

  @@access(AgentObjectType, Access.internal);
  @@clientName(AgentObjectType, "InternalAgentObjectType", "!autorest");

  @@access(OpenAI.ToolChoiceParam, Access.internal);
  @@clientName(OpenAI.ToolChoiceParam, "InternalToolChoiceParam", "!autorest");

  @@access(OpenAI.WebSearchPreviewTool, Access.internal);
  @@clientName(
    OpenAI.WebSearchPreviewTool,
    "InternalWebSearchPreviewTool",
    "!autorest"
  );

  @@access(OpenAI.WebSearchTool, Access.internal);
  @@clientName(OpenAI.WebSearchTool, "InternalWebSearchTool", "!autorest");

  @@clientName(
    HostedAgentDefinition.container_protocol_versions,
    "versions",
    "csharp"
  );

  @@clientName(
    BingCustomSearchToolParameters,
    "BingCustomSearchToolOptions",
    "csharp"
  );
  @@clientName(
    BrowserAutomationToolParameters,
    "BrowserAutomationToolOptions",
    "csharp"
  );
  @@clientName(
    BingGroundingSearchConfiguration.set_lang,
    "BingUserInterfaceLanguage",
    "csharp"
  );
  @@clientName(BingGroundingTool.bing_grounding, "SearchToolOptions", "csharp");
  @@clientName(
    BrowserAutomationPreviewTool.browser_automation_preview,
    "ToolParameters",
    "csharp"
  );
  @@clientName(
    BrowserAutomationToolParameters.connection,
    "ToolConnectionParameters",
    "csharp"
  );
  @@clientName(
    CaptureStructuredOutputsTool.outputs,
    "OutputDefinition",
    "csharp"
  );
  @@clientName(
    MemorySearchPreviewTool.update_delay,
    "UpdateDelayInSecs",
    "csharp"
  );
  @@clientName(
    MicrosoftFabricPreviewTool.fabric_dataagent_preview,
    "ToolOptions",
    "csharp"
  );
  @@clientName(
    SharepointPreviewTool.sharepoint_grounding_preview,
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
  @@clientName(
    PromptAgentDefinition,
    "DeclarativeAgentDefinition",
    "!autorest"
  );

  @@usage(AgentObject, Usage.output);
  @@access(AgentObject, Access.public);
  @@clientName(AgentObject, "AgentRecord", "!autorest");

  @@usage(AgentVersionObject, Usage.output);
  @@access(AgentVersionObject, Access.public);
  @@clientName(AgentVersionObject, "AgentVersion", "!autorest");
}
