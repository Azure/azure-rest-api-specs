import "../sdk-common/error.default.tsp";
import "../agents/routes.tsp";
import "../voice-agents/routes.tsp";
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

  // The Realtime message base now owns the `message` discriminator in the
  // OpenAI hierarchy. Do not regenerate duplicate leaf properties in C#.
  @@scope(OpenAI.RealtimeConversationItemMessageSystem.type, "!csharp");
  @@scope(OpenAI.RealtimeConversationItemMessageUser.type, "!csharp");
  @@scope(OpenAI.RealtimeConversationItemMessageAssistant.type, "!csharp");

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
  @@clientName(RaiConfig, "ContentFilterConfiguration", "!autorest");
  
  // The renamings denoted here are attributed to ToolBox tool,
  // because its class is not reusing tool, defined in OpenAI or Azure.AI.Projects.OpenAI
  @@clientName(OpenApiTool.openapi, "FunctionDefinition", "csharp");
  @@clientName(FabricIQPreviewTool.server_url, "ServerUri");
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
  // --------------------------------------------------------------------------------
  // Renames and visibility changes for targeted suppressions
  // --------------------------------------------------------------------------------
  @@access(OpenAI.ApplyPatchToolParam, Access.internal);
  @@clientName(
    OpenAI.ApplyPatchToolParam,
    "InternalApplyPatchToolParam",
    "!autorest"
  );

  @@access(AgentObjectType, Access.internal);
  @@clientName(AgentObjectType, "InternalAgentObjectType", "!autorest");
  @@clientName(HostedAgentDefinition.protocol_versions, "versions", "csharp");

  // The renamings denoted here are attributed to ToolBox tool,
  // because its class is not reusing tool, defined in OpenAI or Azure.AI.Projects.OpenAI
  
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

  // WebSocket protocol upgrades are not representable by the C# HTTP client generator.
  @@scope(VoiceAgentWebSocket.connectVoiceAgent, "!csharp");

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

  // --------------------------------------------------------------------------------
  // Externalization of classes, defined in Azure.AI.Extensions.OpenAI and OpenAI.
  // --------------------------------------------------------------------------------
  @@alternateType(
    Azure.AI.Projects.A2APreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.A2APreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.AzureAISearchTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureAISearchTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.AISearchIndexResource,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureAISearchToolIndex",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.AzureAISearchToolResource,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureAISearchToolOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.AzureFunctionBinding,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureFunctionBinding",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.AzureFunctionDefinition,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureFunctionDefinition",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.AzureFunctionStorageQueue,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureFunctionStorageQueue",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.AzureFunctionTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.AzureFunctionTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.BingCustomSearchPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingCustomSearchPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.BingGroundingTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingGroundingTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.BingCustomSearchConfiguration,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingCustomSearchOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.BingCustomSearchToolParameters,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingCustomSearchToolOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.BingGroundingSearchConfiguration,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingGroundingSearchOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.BingGroundingSearchToolParameters,
    {
      identity: "Azure.AI.Extensions.OpenAI.BingGroundingSearchToolOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.BrowserAutomationPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.BrowserAutomationPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.BrowserAutomationToolConnectionParameters,
    {
      identity: "Azure.AI.Extensions.OpenAI.BrowserAutomationToolConnectionOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.BrowserAutomationToolParameters,
    {
      identity: "Azure.AI.Extensions.OpenAI.BrowserAutomationToolOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.CaptureStructuredOutputsTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.CaptureStructuredOutputsTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.FabricIQPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.FabricIQPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.FabricDataAgentToolParameters,
    {
      identity: "Azure.AI.Extensions.OpenAI.FabricDataAgentToolOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.MemorySearchPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.MemorySearchPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.MemorySearchOptions,
    {
      identity: "Azure.AI.Extensions.OpenAI.MemorySearchOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.MicrosoftFabricPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.MicrosoftFabricPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.OpenApiAnonymousAuthDetails,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenAPIAnonymousAuthenticationDetails",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.OpenApiAuthDetails,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenApiAuthenticationDetails",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.OpenApiTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenApiTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.OpenApiFunctionDefinition,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenApiFunctionDefinition",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.OpenApiFunctionDefinition.functions,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenApiFunctionDefinitionFunction"[],
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.OpenApiManagedAuthDetails,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenApiManagedAuthenticationDetails",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.OpenApiManagedSecurityScheme,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenApiManagedSecurityScheme",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.OpenApiProjectConnectionAuthDetails,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenApiProjectConnectionAuthenticationDetails",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.OpenApiProjectConnectionSecurityScheme,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenApiProjectConnectionSecurityScheme",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.SharepointGroundingToolParameters,
    {
      identity: "Azure.AI.Extensions.OpenAI.SharePointGroundingToolOptions",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.SharepointPreviewTool,
    {
      identity: "Azure.AI.Extensions.OpenAI.SharePointPreviewTool",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.StructuredOutputDefinition,
    {
      identity: "Azure.AI.Extensions.OpenAI.StructuredOutputDefinition",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.WebSearchConfiguration,
    {
      identity: "Azure.AI.Extensions.OpenAI.WebSearchConfiguration",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.ToolProjectConnection,
    {
      identity: "Azure.AI.Extensions.OpenAI.ToolProjectConnection",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );
  @@alternateType(
    Azure.AI.Projects.ToolConfig,
    {
      identity: "Azure.AI.Extensions.OpenAI.ToolConfig",
      package: "Azure.AI.Extensions.OpenAI",
      minVersion: "3.0.0-alpha.20260819.1",
    },
    "csharp"
  );

  @@alternateType(
    Azure.AI.Projects.OpenApiProjectConnectionAuthDetails,
    {
      identity: "Azure.AI.Extensions.OpenAI.OpenApiProjectConnectionAuthenticationDetails",
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
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  @@alternateType(
    OpenAI.ImageGenTool.background,
    {
      identity: "OpenAI.ImageGenerationToolBackground",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  @@alternateType(
    OpenAI.ImageGenTool.input_image_mask,
    {
      identity: "OpenAI.ImageGenToolInputImageMask",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  @@alternateType(
    OpenAI.ImageGenTool.moderation,
    {
      identity: "OpenAI.ImageGenToolModeration",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  @@alternateType(
    OpenAI.ImageGenTool.quality,
    {
      identity: "OpenAI.ImageGenToolQuality",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

  @@alternateType(
    OpenAI.ImageGenTool.size,
    {
      identity: "OpenAI.ImageGenToolSize",
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
  @@alternateType(
    OpenAI.ComputerCallSafetyCheckParam,
    {
      identity: "OpenAI.Responses.ComputerCallSafetyCheck",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );

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
  @@alternateType(
    OpenAI.WebSearchTool.search_context_size,
    {
      identity: "OpenAI.Responses.WebSearchToolContextSize",
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
    OpenAI.WebSearchApproximateLocation,
    {
      identity: "OpenAI.Responses.WebSearchToolApproximateLocation",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.WebSearchToolFilters,
    {
      identity: "OpenAI.Responses.WebSearchToolFilters",
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
    OpenAI.WebSearchApproximateLocation,
    {
      identity: "OpenAI.Responses.WebSearchToolApproximateLocation",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.WebSearchToolFilters,
    {
      identity: "OpenAI.Responses.WebSearchToolFilters",
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
  @@alternateType(
    OpenAI.FunctionToolParam,
    {
      identity: "OpenAI.FunctionToolParam",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.ToolChoiceParam,
    {
      identity: "OpenAI.Responses.ToolChoice",
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

  @@clientName(
    AgentOptimizationDatasetItem.desired_num_turns,
    "DesiredTurnCount"
  );

  // --------------------------------------------------------------------------------
  // Realtime classes replacements
  // --------------------------------------------------------------------------------
  @@alternateType(
    OpenAI.RealtimeAudioFormats,
    {
      identity: "OpenAI.Realtime.RealtimeAudioFormat",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.RealtimeConversationItem,
    {
      identity: "OpenAI.Realtime.RealtimeItem",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.RealtimeResponseUsage,
    {
      identity: "OpenAI.Realtime.RealtimeResponseUsage",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.RealtimeMCPListTools,
    {
      identity: "OpenAI.Realtime.RealtimeMcpToolDefinitionListItem",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
  @@alternateType(
    OpenAI.RealtimeResponseStatusDetails,
    {
      identity: "OpenAI.Realtime.RealtimeResponseStatusDetails",
      package: "OpenAI",
      minVersion: "2.12.0",
    },
    "csharp"
  );
}
