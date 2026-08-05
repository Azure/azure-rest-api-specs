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

  @@clientName(AgentObject, "ProjectsAgentRecord");
  @@clientName(AgentEndpointProtocol, "ProjectsAgentProtocol");
  @@clientName(AgentEndpointProtocol.activity, "ActivityProtocol");
  @@clientName(AgentKind, "ProjectsAgentKind");
  @@clientName(AgentSessionResource, "ProjectAgentSession");
  @@clientName(SessionLogEventType, "SessionLogEventKind");
  @@access(AgentSessionResource, Access.public);

  @@clientName(JobStatus, "AgentsJobStatus");

  @@clientName(
    ContainerAppAgentDefinition,
    "ContainerApplicationAgentDefinition",
    "!autorest"
  );
  //  @@clientName(CreatedBy, "AgentResponseItemSource", "!autorest");
  
  @@clientName(OpenApiTool, "OpenAPITool", "!autorest");
  @@clientName(OpenApiTool.openapi, "FunctionDefinition", "csharp");

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
  @@clientName(ToolArgumentBinding, "StructuredInputToolArgumentBinding");
  @@clientName(FabricIQPreviewTool.server_url, "ServerUri");
  @@clientName(FabricIQPreviewToolboxTool.server_url, "ServerUri");
  //@@clientName(WebIQPreviewTool.server_url, "ServerUri");
  //@@clientName(WebIQPreviewToolboxTool.server_url, "ServerUri");

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

  @@clientName(HostedAgentDefinition.protocol_versions, "versions", "csharp");

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
  @@clientName(
    CreateAgentVersionFromCodeMetadata,
    "AgentVersionFromCodeMetadata"
  );

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

  @@alternateType(
    Azure.AI.Projects.A2APreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.A2APreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
@@alternateType(
    Azure.AI.Projects.AzureAISearchTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureAISearchTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.AISearchIndexResource,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureAISearchToolIndex",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.AzureAISearchToolResource,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureAISearchToolOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.AzureFunctionBinding,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureFunctionBinding",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.AzureFunctionDefinition,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureFunctionDefinition",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
//  @@alternateType(
//    Azure.AI.Projects.AzureFunctionDefinitionFunction,
//    {
//      identity: "Azure.AI.Extensions.OpenAI.AzureFunctionDefinitionFunction",
//      package: "Azure.AI.Extensions.OpenAI",
//      minVersion: "3.0.0-alpha.20260805.1",
//    },
//    "csharp"
//  );
  @@alternateType(
    Azure.AI.Projects.AzureFunctionStorageQueue,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureFunctionStorageQueue",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.AzureFunctionTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureFunctionTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.BingCustomSearchPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingCustomSearchPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.BingGroundingTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingGroundingTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.BingCustomSearchConfiguration,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingCustomSearchConfiguration",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
@@alternateType(
    Azure.AI.Projects.BingCustomSearchToolParameters,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingCustomSearchToolOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
@@alternateType(
    Azure.AI.Projects.BingGroundingSearchConfiguration,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingGroundingSearchConfiguration",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
@@alternateType(
    Azure.AI.Projects.BingGroundingSearchToolParameters,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingGroundingSearchToolOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
@@alternateType(
    Azure.AI.Projects.BrowserAutomationPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.BrowserAutomationPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.BrowserAutomationToolConnectionParameters,
    {
      identity: "Azure.AI.Extensions.OpenAI.BrowserAutomationToolConnectionParameters",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.BrowserAutomationToolParameters,
    {
      identity: "Azure.AI.Extensions.OpenAI.BrowserAutomationToolOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.CaptureStructuredOutputsTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.CaptureStructuredOutputsTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.FabricIQPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.FabricIQPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.FabricDataAgentToolParameters,
    {
      identity: "Azure.AI.Extensions.OpenAI.FabricDataAgentToolOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.MemorySearchPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.MemorySearchPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.MemorySearchOptions,
    {
      identity: "Azure.AI.Extensions.OpenAI.MemorySearchOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.MicrosoftFabricPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.MicrosoftFabricPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.OpenApiAnonymousAuthDetails,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenAPIAnonymousAuthenticationDetails",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.OpenApiAuthDetails,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenApiAuthenticationDetails",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.OpenApiTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenAPITool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.SharepointPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.SharepointPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260805.1",
    },
    "csharp"
  );

  // Move all the OpenAI TYpes out:
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
  @@alternateType(
    OpenAI.MCPToolRequireApproval,
    {
      identity: "OpenAI.Responses.McpToolCallApprovalPolicy",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
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


}
