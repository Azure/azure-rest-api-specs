import "../common/service.tsp";
import "../tools/models.tsp";
import "../agents/models.tsp";
import "../skills/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

/**
 * Per-tool configuration that controls tool visibility and search behavior.
 */
model ToolConfig {
  /**
   * When true, the tool is always included in agent context and visible in `tools/list`.
   * When false (default), the tool is hidden from `tools/list` and only discoverable via `tool_search`.
   */
  pin?: boolean;

  /**
   * Additional text indexed for tool_search. Supplements the native tool description
   * to improve discoverability. Does not alter `tools/list` output.
   */
  @maxLength(1000)
  additional_search_text?: string;
}

/**
 * Optional tool configuration extension for controlling tool visibility and search behavior.
 */
alias ToolConfigExtension = {
  /**
   * Per-tool configuration map. Keys are tool names or `*` (catch-all default).
   * Resolution order: exact tool name match takes priority over `*`.
   * Unknown tool names are silently ignored at runtime.
   */
  tool_configs?: Record<ToolConfig>;
};

/**
 * Optional name and description fields for tool definitions and nested tool configurations.
 */
alias ToolNameAndDescriptionExtension = {
  /**
   * Optional user-defined name for this tool or configuration.
   */
  name?: string;

  /**
   * Optional user-defined description for this tool or configuration.
   */
  description?: string;
};

/**
 * Spreads `Source`, changing the selected properties to optional.
 */
model WithFieldsOptional<Source, Keys extends string> {
  ...OmitProperties<Source, Keys>;
  ...PickProperties<OptionalProperties<Source>, Keys>;
}

/**
 * Spreads tool-specific fields from `Source`, excluding fields owned by `ToolboxTool`.
 */
alias ToolFields<Source> = {
  ...OmitProperties<Source, "name" | "description" | "type" | "tool_configs">;
};

alias ToolboxCodeInterpreterToolType = "code_interpreter";
alias ToolboxFileSearchToolType = "file_search";
alias ToolboxWebSearchToolType = "web_search";
alias ToolboxMCPToolType = "mcp";
alias ToolboxAzureAISearchToolType = "azure_ai_search";
alias ToolboxOpenApiToolType = "openapi";
alias ToolboxA2APreviewToolType = "a2a_preview";
alias ToolboxBrowserAutomationPreviewToolType = "browser_automation_preview";
alias ToolboxReminderPreviewToolType = "reminder_preview";
alias ToolboxWorkIQPreviewToolType = "work_iq_preview";
alias ToolboxFabricIQPreviewToolType = "fabric_iq_preview";
alias ToolboxSearchPreviewToolType = "toolbox_search_preview";

/**
 * Supported tool types for tools stored in a toolbox.
 */
union ToolboxToolType {
  code_interpreter: ToolboxCodeInterpreterToolType,
  file_search: ToolboxFileSearchToolType,
  web_search: ToolboxWebSearchToolType,
  mcp: ToolboxMCPToolType,
  azure_ai_search: ToolboxAzureAISearchToolType,
  openapi: ToolboxOpenApiToolType,
  a2a_preview: ToolboxA2APreviewToolType,
  browser_automation_preview: ToolboxBrowserAutomationPreviewToolType,
  reminder_preview: ToolboxReminderPreviewToolType,
  work_iq_preview: ToolboxWorkIQPreviewToolType,
  fabric_iq_preview: ToolboxFabricIQPreviewToolType,
  toolbox_search_preview: ToolboxSearchPreviewToolType,
}

/**
 * An abstract representation of a tool stored in a toolbox.
 */
@discriminator("type")
model ToolboxTool {
  /**
   * The type of tool.
   */
  type: ToolboxToolType;

  ...ToolNameAndDescriptionExtension;
  ...ToolConfigExtension;
}

/**
 * A code interpreter tool stored in a toolbox.
 */
model CodeInterpreterToolboxTool extends ToolboxTool {
  type: ToolboxCodeInterpreterToolType;

  ...ToolFields<OpenAI.CodeInterpreterTool>;
}

/**
 * A file search tool stored in a toolbox.
 */
model FileSearchToolboxTool extends ToolboxTool {
  type: ToolboxFileSearchToolType;

  ...WithFieldsOptional<
    ToolFields<OpenAI.FileSearchTool>,
    "vector_store_ids"
  >;
}

/**
 * A web search tool stored in a toolbox.
 */
model WebSearchToolboxTool extends ToolboxTool {
  type: ToolboxWebSearchToolType;

  ...ToolFields<OpenAI.WebSearchTool>;
}

/**
 * An MCP tool stored in a toolbox.
 */
model MCPToolboxTool extends ToolboxTool {
  type: ToolboxMCPToolType;

  ...ToolFields<OpenAI.MCPTool>;
}

/**
 * An Azure AI Search tool stored in a toolbox.
 */
model AzureAISearchToolboxTool extends ToolboxTool {
  type: ToolboxAzureAISearchToolType;

  ...ToolFields<AzureAISearchTool>;
}

/**
 * An OpenAPI tool stored in a toolbox.
 */
model OpenApiToolboxTool extends ToolboxTool {
  type: ToolboxOpenApiToolType;

  ...ToolFields<OpenApiTool>;
}

/**
 * An A2A tool stored in a toolbox.
 */
@extension("x-ms-foundry-meta", PreviewTool)
model A2APreviewToolboxTool extends ToolboxTool {
  type: ToolboxA2APreviewToolType;

  ...ToolFields<A2APreviewTool>;
}

/**
 * A browser automation tool stored in a toolbox.
 */
@extension("x-ms-foundry-meta", PreviewTool)
model BrowserAutomationPreviewToolboxTool extends ToolboxTool {
  type: ToolboxBrowserAutomationPreviewToolType;

  ...ToolFields<BrowserAutomationPreviewTool>;
}

/**
 * A reminder tool stored in a toolbox.
 */
@extension("x-ms-foundry-meta", PreviewTool)
model ReminderPreviewToolboxTool extends ToolboxTool {
  type: ToolboxReminderPreviewToolType;
}

/**
 * A WorkIQ tool stored in a toolbox.
 */
@extension("x-ms-foundry-meta", PreviewTool)
model WorkIQPreviewToolboxTool extends ToolboxTool {
  type: ToolboxWorkIQPreviewToolType;

  ...ToolFields<WorkIQPreviewTool>;
}

/**
 * A FabricIQ tool stored in a toolbox.
 */
@extension("x-ms-foundry-meta", PreviewTool)
model FabricIQPreviewToolboxTool extends ToolboxTool {
  type: ToolboxFabricIQPreviewToolType;

  ...ToolFields<FabricIQPreviewTool>;
}

/**
 * A toolbox search tool stored in a toolbox.
 */
@extension("x-ms-foundry-meta", PreviewTool)
model ToolboxSearchPreviewToolboxTool extends ToolboxTool {
  /**
   * The type of the tool. Always `toolbox_search_preview`.
   */
  type: ToolboxSearchPreviewToolType;
}
@doc("Policy configuration for a toolbox, including content safety and other governance settings.")
model ToolboxPolicies {
  @doc("Responsible AI content filtering configuration.")
  rai_config?: RaiConfig;
}

@doc("A skill source included in a toolbox.")
@discriminator("type")
model ToolboxSkill {
  @doc("The type of skill source.")
  type: string;
}

@doc("A reference to an existing skill to include in a toolbox.")
model ToolboxSkillReference extends ToolboxSkill {
  @doc("The type of skill source.")
  type: "skill_reference";

  @doc("The name of the skill.")
  name: SkillName;

  @doc("The version of the skill. If not specified, the skill's default version is used. When a version is specified, the reference is pinned to that immutable version.")
  version?: string;
}

@doc("A toolbox that stores reusable tool definitions for agents.")
model ToolboxObject {
  @doc("The unique identifier of the toolbox.")
  id: string;

  @doc("The name of the toolbox.")
  @maxLength(256)
  name: string;

  @doc("The version identifier that the toolbox currently points to. Defaults to the latest version. Can be changed via updateToolbox.")
  default_version: string;
}

@doc("A specific version of a toolbox.")
model ToolboxVersionObject {
  ...MetadataPropertyForResponse;

  @doc("The unique identifier of the toolbox version.")
  id: string;

  @doc("The name of the toolbox.")
  @maxLength(256)
  name: string;

  @doc("The version identifier of the toolbox. Toolbox versions are immutable and every update creates a new version.")
  version: string;

  @doc("A human-readable description of the toolbox.")
  @maxLength(512)
  description?: string;

  @doc("The Unix timestamp (seconds) when the toolbox version was created.")
  @encode("unixTimestamp", int32)
  created_at: utcDateTime;

  @doc("The list of tools contained in this toolbox version.")
  tools: ToolboxTool[];

  @doc("The list of skill sources included in this toolbox version.")
  skills?: ToolboxSkill[];

  @doc("Policy configuration for the toolbox version.")
  policies?: ToolboxPolicies;
}

alias CreateToolboxVersionRequest = {
  @doc("The name of the toolbox. If the toolbox does not exist, it will be created.")
  @path
  @maxLength(256)
  name: string;

  @doc("A human-readable description of the toolbox.")
  @maxLength(512)
  description?: string;

  @doc("Arbitrary key-value metadata to associate with the toolbox.")
  metadata?: Record<string>;

  @doc("The list of tools to include in this version.")
  tools: ToolboxTool[];

  @doc("The list of skill sources to include in this version. A skill reference specifies a skill name and optionally a version. If version is omitted, the skill's default version is used.")
  skills?: ToolboxSkill[];

  @doc("Policy configuration for this toolbox version.")
  policies?: ToolboxPolicies;
};

alias GetToolboxRequest = {
  @doc("The name of the toolbox to retrieve.")
  @path
  name: string;
};

alias GetToolboxVersionRequest = {
  @doc("The name of the toolbox.")
  @path
  name: string;

  @doc("The version identifier to retrieve.")
  @path
  version: string;
};

alias ListToolboxesRequest = {
  ...CommonPageQueryParameters;
};

alias ListToolboxVersionsRequest = {
  @doc("The name of the toolbox to list versions for.")
  @path
  name: string;

  ...CommonPageQueryParameters;
};

alias DeleteToolboxRequest = {
  @doc("The name of the toolbox to delete.")
  @path
  name: string;
};

model UpdateToolboxRequest {
  @doc("The name of the toolbox to update.")
  @path
  name: string;

  @doc("The version identifier that the toolbox should point to. When set, the toolbox's default version will resolve to this version instead of the latest.")
  default_version: string;
}

alias DeleteToolboxVersionRequest = {
  @doc("The name of the toolbox.")
  @path
  name: string;

  @doc("The version identifier to delete.")
  @path
  version: string;
};
