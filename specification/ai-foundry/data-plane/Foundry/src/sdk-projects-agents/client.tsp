import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core.Experimental;

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@clientNamespace("Azure.AI.Projects.Agents")
namespace Azure.AI.Projects {

  @@usage(CreateAgentRequest, Usage.input);
  @@access(CreateAgentRequest, Access.internal);

  @@usage(CreateAgentVersionFromManifestRequest, Usage.input);
  @@access(CreateAgentVersionFromManifestRequest, Access.public);

  @@usage(UpdateAgentRequest, Usage.input);
  @@access(UpdateAgentRequest, Access.internal);

  @@usage(CreateAgentVersionRequest, Usage.input);
  @@access(CreateAgentVersionRequest, Access.public);
  @@clientName(CreateAgentVersionRequest, "AgentVersionCreationOptions");

  @@access(OpenAI.Metadata, Access.internal);
  @@clientName(OpenAI.Metadata, "InternalMetadataContainer");

  // --------------------------------------------------------------------------------
  // Fix the xref.
  // --------------------------------------------------------------------------------
  @@clientNamespace(OpenAI, "Azure.AI.Projects.Agents", "csharp");

  // --------------------------------------------------------------------------------
  // Root client
  // --------------------------------------------------------------------------------
  @@clientName(Agents,
    "AgentsClient",
    "csharp"
  );
  @@clientName(AgentObject, "AgentRecord");
  @@clientName(AgentProtocol, "AgentCommunicationMethod");

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
  @@clientName(OpenApiAnonymousAuthDetails,
    "OpenAPIAnonymousAuthenticationDetails"
  );
  @@clientName(OpenApiAuthDetails, "OpenAPIAuthenticationDetails");
  @@clientName(OpenApiFunctionDefinition, "OpenAPIFunctionDefinition");
  @@clientName(OpenApiManagedAuthDetails,
    "OpenAPIManagedAuthenticationDetails"
  );
  @@clientName(OpenApiProjectConnectionAuthDetails,
    "OpenAPIProjectConnectionAuthenticationDetails"
  );
  @@clientName(OpenApiProjectConnectionSecurityScheme,
    "OpenAPIProjectConnectionSecurityScheme"
  );
  @@clientName(OpenApiManagedSecurityScheme, "OpenAPIManagedSecurityScheme");
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
  
  // --------------------------------------------------------------------------------
  // Usage / Public accessibility overrides
  // --------------------------------------------------------------------------------
  
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
}
