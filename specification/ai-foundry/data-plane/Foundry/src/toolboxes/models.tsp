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

  @doc("Policy configuration for the toolbox version.")
  policies?: ToolboxPolicies;
}

alias CreateToolboxVersionRequest = {
  @doc("The name of the toolbox. If the toolbox does not exist, it will be created.")
  @path
  @maxLength(256)
  toolbox_name: string;

  @doc("A human-readable description of the toolbox.")
  @maxLength(512)
  description?: string;

  @doc("Arbitrary key-value metadata to associate with the toolbox.")
  metadata?: Record<string>;

  @doc("The list of tools to include in this version.")
  tools: OpenAI.Tool[];

  @doc("Policy configuration for this toolbox version.")
  policies?: ToolboxPolicies;
};

alias GetToolboxRequest = {
  @doc("The name of the toolbox to retrieve.")
  @path
  toolbox_name: string;
};

alias GetToolboxVersionRequest = {
  @doc("The name of the toolbox.")
  @path
  toolbox_name: string;

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
  toolbox_name: string;

  ...CommonPageQueryParameters;
};

alias DeleteToolboxRequest = {
  @doc("The name of the toolbox to delete.")
  @path
  toolbox_name: string;
};

alias UpdateToolboxRequest = {
  @doc("The name of the toolbox to update.")
  @path
  toolbox_name: string;

  @doc("The version identifier that the toolbox should point to. When set, the toolbox's default version will resolve to this version instead of the latest.")
  default_version: string;
};

alias DeleteToolboxVersionRequest = {
  @doc("The name of the toolbox.")
  @path
  toolbox_name: string;

  @doc("The version identifier to delete.")
  @path
  version: string;
};
