import "../common/service.tsp";
import "../tools/models.tsp";
import "../agents/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const ToolboxesRequiredPreviews = #{
  conditional_previews: #[FoundryFeaturesOptInKeys.toolboxes_v1_preview],
};

@doc("Policy configuration for a toolbox, including content safety and other governance settings.")
model ToolboxPolicies {
  @doc("Responsible AI content filtering configuration.")
  rai_config?: RaiConfig;
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

/**
 * The load mode for a tool when tool search is enabled.
 * Controls how the tool appears in `tools/list` responses.
 */
union ToolLoadMode {
  /** Tool appears in `tools/list` with its full schema (name, description, inputSchema). */
  always: "always",

  /** Tool appears in `tools/list` with name and description only (no inputSchema). */
  descriptions_only: "descriptions_only",

  /** Tool is hidden from `tools/list` and only discoverable via `tool_search` queries. */
  defer: "defer",
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
  tools: OpenAI.Tool[];

  @doc("Tool load policy for the toolbox version. Maps tool names (or `*` as a catch-all) to a ToolLoadMode that controls how each tool appears in `tools/list` when tool search is enabled. Resolution order: exact tool name > catch-all (`*`). When omitted and a ToolboxSearchPreviewTool is present, defaults to `{\"*\": \"defer\"}`.")
  load?: Record<ToolLoadMode>;

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
  tools: OpenAI.Tool[];

  @doc("Tool load policy for the toolbox version. Maps tool names (or `*` as a catch-all) to a ToolLoadMode that controls how each tool appears in `tools/list` when tool search is enabled. Resolution order: exact tool name > catch-all (`*`). When omitted and a ToolboxSearchPreviewTool is present, defaults to `{\"*\": \"defer\"}`.")
  load?: Record<ToolLoadMode>;

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
