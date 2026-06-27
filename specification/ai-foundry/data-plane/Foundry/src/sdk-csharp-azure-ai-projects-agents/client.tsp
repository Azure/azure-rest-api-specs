import "../sdk-common/error.default.tsp";
import "../agents/routes.tsp";
import "../toolboxes/routes.tsp";
import "../skills/routes.tsp";
import "../agents-session-files/routes.tsp";
import "../managed-blueprints/routes.tsp";
import "../agents-optimization/routes.tsp";

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
  @@clientInitialization(
    Azure.AI.Projects.Agents,
    {
      initializedBy: InitializedBy.parent | InitializedBy.individually,
    }
  );

  @@clientName(AgentObject, "ProjectsAgentRecord");
  @@clientName(AgentEndpointProtocol, "ProjectsAgentProtocol");
  @@clientName(AgentEndpointProtocol.activity, "ActivityProtocol");
  @@clientName(AgentKind, "ProjectsAgentKind");
  @@clientName(AgentSessionResource, "ProjectAgentSession");
  @@clientName(SessionLogEventType, "SessionLogEventKind");
  @@access(AgentSessionResource, Access.public);
  
  @@clientName(JobStatus, "AgentsJobStatus");

  @@clientName(
    BingGroundingSearchToolParameters,
    "BingGroundingSearchToolOptions"
  );
  @@clientName(
    ContainerAppAgentDefinition,
    "ContainerApplicationAgentDefinition"
  );
  //  @@clientName(CreatedBy, "AgentResponseItemSource");
  @@clientName(FabricDataAgentToolParameters, "FabricDataAgentToolOptions");

  @@clientName(MemorySearchOptions, "MemorySearchToolOptions");

  @@clientName(OpenApiTool, "OpenAPITool");
  @@clientName(OpenApiTool.openapi, "FunctionDefinition", "csharp");
  @@clientName(
    OpenApiAnonymousAuthDetails,
    "OpenAPIAnonymousAuthenticationDetails"
  );
  @@clientName(OpenApiAuthDetails, "OpenApiAuthenticationDetails");
  @@clientName(
    OpenApiManagedAuthDetails,
    "OpenAPIManagedAuthenticationDetails"
  );
  @@clientName(
    OpenApiProjectConnectionAuthDetails,
    "OpenApiProjectConnectionAuthenticationDetails"
  );
  @@clientName(
    OpenApiProjectConnectionSecurityScheme,
    "OpenApiProjectConnectionSecurityScheme"
  );
  @@clientName(OpenApiManagedSecurityScheme, "OpenAPIManagedSecurityScheme");

  @@clientName(
    OpenApiFunctionDefinition.auth,
    "AuthenticationDetails",
    "csharp"
  );
  @@clientName(RaiConfig, "ContentFilterConfiguration");
  @@clientName(
    SharepointGroundingToolParameters,
    "SharePointGroundingToolOptions"
  );
  @@clientName(ToolArgumentBinding, "StructuredInputToolArgumentBinding");
  @@clientName(FabricIQPreviewTool.server_url, "ServerUri");
  @@clientName(FabricIQPreviewToolboxTool.server_url, "ServerUri");
  
  @@clientName(DeprecatedToolConfigExtension.tool_configs, "ToolConfigInternal");
  @@access(DeprecatedToolConfigExtension, Access.internal);

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
  @@clientName(
    OpenAI.AutoCodeInterpreterToolParam,
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

  @@clientName(HostedAgentDefinition.protocol_versions, "versions", "csharp");

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
  @@clientName(AgentEndpointConfig, "AgentEndpointConfiguration");
  @@clientName(TelemetryEndpointAuth, "TelemetryEndpointAuthentication");
  @@clientName(TelemetryEndpoint.auth, "Authentication");
  @@clientName(TelemetryEndpoint.data, "ExportedDataTypes");
  @@clientName(
    TelemetryEndpointAuthType,
    "TelemetryEndpointAuthenticationKind"
  );
  @@clientName(TelemetryDataKind, "ExportedDataTypes");
  @@clientName(EvaluationLevel, "AgentsEvaluationLevel");
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
  @@clientName(AgentVersionObject, "ProjectsAgentVersion");

  @@usage(PatchAgentRequest, Usage.input | Usage.output);
  @@access(PatchAgentRequest, Access.public);
  @@clientName(PatchAgentRequest, "PatchAgentOptions");
  @@access(Agents.patchAgentObject, Access.internal);
  @@clientName(Agents.patchAgentObject, "PatchAgent");
  @@access(Agents.getSessionLogStream, Access.internal);

  @@usage(CreateAgentFromCodeContent, Usage.input);
  @@access(CreateAgentFromCodeContent, Access.public);
  @@clientName(CreateAgentFromCodeContent, "AgentFromCodeOptions");
  @@clientName(CreateAgentVersionFromCodeMetadata, "AgentVersionFromCodeMetadata");
  
  @@clientName(AgentCardSkill.tags, "Labels");

  // --------------------------------------------------------------------------------
  // Hide Agent administration operations, containing the foundry features
  // --------------------------------------------------------------------------------
  @@access(Agents.createAgentVersionFromCode, Access.internal);
  @@access(Agents.downloadAgentCode, Access.internal);

  // --------------------------------------------------------------------------------
  // Hide session operations, containing the foundry features
  // --------------------------------------------------------------------------------

  // Hide the protocol methods and methods using feature headers
  @@access(Agents.createSession, Access.internal);
  @@access(Agents.getSession, Access.internal);
  @@access(Agents.getSession, Access.internal);
  @@access(Agents.deleteSession, Access.internal);
  @@access(Agents.stopSession, Access.internal);

  // --------------------------------------------------------------------------------
  // Toolboxes sub‐client
  // --------------------------------------------------------------------------------

  @@clientName(ToolboxObject, "ToolboxRecord");
  @@clientName(ToolboxVersionObject, "ToolboxVersion");
  
  @@clientName(Toolboxes.createToolboxVersion, "CreateVersion");
  @@clientName(Toolboxes.getToolbox, "Get");
  @@clientName(Toolboxes.getToolboxVersion, "GetVersion");
  @@clientName(Toolboxes.updateToolbox, "UpdateDefaultVersion");
  @@clientName(Toolboxes.deleteToolboxVersion, "DeleteVersion");
  @@clientName(Toolboxes.deleteToolbox, "Delete");
  @@clientName(Toolboxes.listToolboxes, "GetAll");
  @@clientName(Toolboxes.listToolboxVersions, "GetVersions");
  @@clientName(ToolConfig.pin, "IsPinned");

  // --------------------------------------------------------------------------------
  // AgentSessionFiles sub‐client
  // --------------------------------------------------------------------------------

  // Hide the protocol methods and methods using feature headers
  @@access(AgentSessionFiles.uploadSessionFile, Access.internal);
  @@clientName(AgentSessionFiles.uploadSessionFile, "Upload");
  @@access(AgentSessionFiles.downloadSessionFile, Access.internal);
  @@clientName(AgentSessionFiles.downloadSessionFile, "Download");
  @@access(AgentSessionFiles.listSessionFiles, Access.internal);
  @@access(AgentSessionFiles.deleteSessionFile, Access.internal);
  @@clientName(AgentSessionFiles.deleteSessionFile, "Delete");
  
  @@clientName(SessionDirectoryEntry.modified_time, "ModifiedAt");
  @@clientName(SessionDirectoryEntry.size, "SizeInBytes");

  // --------------------------------------------------------------------------------
  // Skills sub‐client
  // --------------------------------------------------------------------------------
  @@clientName(Skill, "AgentsSkill");
  @@clientName(Skills.updateSkill, "UpdateDefaultVersion");
  @@clientName(DeleteSkillResponse, "SkillDeletionResult");
  @@clientName(DeleteSkillVersionResponse, "SkillVersionDeletionResult");
  
  @@clientName(CreateSkillVersionRequest.default, "isDefault");

  // --------------------------------------------------------------------------------
  // AgentOptimizationJobs sub‐client
  // --------------------------------------------------------------------------------
  @@access(AgentOptimizationJobs.create, Access.internal);
  @@access(AgentOptimizationJobs.get, Access.internal);
  @@access(AgentOptimizationJobs.cancel, Access.internal);
  @@access(AgentOptimizationJobs.delete, Access.internal);
  
  @@clientName(OptimizationDatasetItem.desired_num_turns, "DesiredTurnCount");
}
