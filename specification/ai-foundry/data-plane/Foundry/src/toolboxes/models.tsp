import "../common/service.tsp";
import "../tools/models.tsp";
import "../agents/models.tsp";
import "../skills/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core.Experimental;

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
 * Supported tool types for tools stored in a toolbox.
 */
union ToolboxToolType {
  code_interpreter: "code_interpreter",
  file_search: "file_search",
  web_search: "web_search",
  mcp: "mcp",
  azure_ai_search: "azure_ai_search",
  openapi: "openapi",
  a2a_preview: "a2a_preview",
  work_iq_preview: "work_iq_preview",
  fabric_iq_preview: "fabric_iq_preview",
  toolbox_search_preview: "toolbox_search_preview",
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
model CodeInterpreterToolbox extends ToolboxTool {
  /**
   * The type of the tool. Always `code_interpreter`.
   */
  type: "code_interpreter";
}

/**
 * A file search tool stored in a toolbox.
 */
model FileSearchToolbox extends ToolboxTool {
  /**
   * The type of the tool. Always `file_search`.
   */
  type: "file_search";

  /**
   * The IDs of the vector stores to search.
   */
  vector_store_ids?: string[];
}

/**
 * A web search tool stored in a toolbox.
 */
model WebSearchToolbox extends ToolboxTool {
  /**
   * The type of the tool. Always `web_search`.
   */
  type: "web_search";
}

/**
 * An MCP tool stored in a toolbox.
 */
model MCPToolbox extends ToolboxTool {
  /**
   * The type of the tool. Always `mcp`.
   */
  type: "mcp";
}

/**
 * An Azure AI Search tool stored in a toolbox.
 */
model AzureAISearchToolbox extends ToolboxTool {
  /**
   * The type of the tool. Always `azure_ai_search`.
   */
  type: "azure_ai_search";
}

/**
 * An OpenAPI tool stored in a toolbox.
 */
model OpenApiToolbox extends ToolboxTool {
  /**
   * The type of the tool. Always `openapi`.
   */
  type: "openapi";
}

/**
 * An A2A tool stored in a toolbox.
 */
model A2APreviewToolbox extends ToolboxTool {
  /**
   * The type of the tool. Always `a2a_preview`.
   */
  type: "a2a_preview";
}

/**
 * A WorkIQ tool stored in a toolbox.
 */
model WorkIQPreviewToolbox extends ToolboxTool {
  /**
   * The type of the tool. Always `work_iq_preview`.
   */
  type: "work_iq_preview";
}

/**
 * A FabricIQ tool stored in a toolbox.
 */
model FabricIQPreviewToolbox extends ToolboxTool {
  /**
   * The type of the tool. Always `fabric_iq_preview`.
   */
  type: "fabric_iq_preview";
}

/**
 * A toolbox search tool stored in a toolbox.
 */
model ToolboxSearchPreviewToolbox extends ToolboxTool {
  /**
   * The type of the tool. Always `toolbox_search_preview`.
   */
  type: "toolbox_search_preview";
}

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(CodeInterpreterToolbox, OpenAI.CodeInterpreterTool);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(FileSearchToolbox, OpenAI.FileSearchTool);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(WebSearchToolbox, OpenAI.WebSearchTool);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(WebSearchToolbox,
  {
    /**
     * The project connections attached to this tool. There can be a maximum of 1 connection
     * resource attached to the tool.
     */
    custom_search_configuration?: WebSearchConfiguration,
  }
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(MCPToolbox, OpenAI.MCPTool);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(MCPToolbox,
  {
    /**
     * The connection ID in the project for the MCP server. The connection stores authentication and other connection details needed to connect to the MCP server.
     */
    project_connection_id?: string,
  }
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(AzureAISearchToolbox, AzureAISearchTool);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(OpenApiToolbox, OpenApiTool);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(A2APreviewToolbox, A2APreviewTool);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(WorkIQPreviewToolbox, WorkIQPreviewTool);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Using experimental feature"
@@copyProperties(FabricIQPreviewToolbox, FabricIQPreviewTool);

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
