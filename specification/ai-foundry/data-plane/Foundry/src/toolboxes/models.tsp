import "../common/service.tsp";
import "../tools/models.tsp";
import "../agents/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const ToolboxesRequiredPreviews = #{
  conditional_previews: #[FoundryFeaturesOptInKeys.toolbox_v1_preview],
};

union ToolboxObjectType {
  toolbox: "toolbox",
  toolboxVersion: "toolbox.version",
  toolboxDeleted: "toolbox.deleted",
  toolboxVersionDeleted: "toolbox.version.deleted",
}

@doc("Policy configuration for a toolbox, including content safety and other governance settings.")
model ToolboxPolicies {
  @doc("Responsible AI content filtering configuration.")
  rai_config?: RaiConfig;
}

@doc("A toolbox that stores reusable tool definitions for agents.")
model ToolboxObject {
  @doc("The object type, which is always 'toolbox'.")
  object: ToolboxObjectType.toolbox;

  @doc("The unique identifier of the toolbox.")
  id: string;

  @doc("The name of the toolbox.")
  @maxLength(256)
  name: string;

  @doc("The versions of the toolbox.")
  versions: {
    @doc("The latest version of the toolbox.")
    latest: ToolboxVersionObject;
  };
}

@doc("A specific version of a toolbox.")
model ToolboxVersionObject {
  ...MetadataPropertyForResponse;

  @doc("The object type, which is always 'toolbox.version'.")
  object: ToolboxObjectType.toolboxVersion;

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

@doc("Response returned when a toolbox is deleted.")
model DeleteToolboxResponse {
  @doc("The object type. Always 'toolbox.deleted'.")
  object: ToolboxObjectType.toolboxDeleted;

  @doc("The name of the toolbox.")
  name: string;

  @doc("Whether the toolbox was successfully deleted.")
  deleted: boolean;
}

@doc("Response returned when a toolbox version is deleted.")
model DeleteToolboxVersionResponse {
  @doc("The object type. Always 'toolbox.version.deleted'.")
  object: ToolboxObjectType.toolboxVersionDeleted;

  @doc("The name of the toolbox.")
  name: string;

  @doc("The version identifier that was deleted.")
  version: string;

  @doc("Whether the version was successfully deleted.")
  deleted: boolean;
}

alias CreateToolboxRequest = {
  @doc("The name of the toolbox.")
  @maxLength(256)
  name: string;

  @doc("A human-readable description of the toolbox.")
  @maxLength(512)
  description?: string;

  @doc("Arbitrary key-value metadata to associate with the toolbox.")
  metadata?: Record<string>;

  @doc("The list of tools to include in the toolbox.")
  tools: OpenAI.Tool[];

  @doc("Policy configuration for the toolbox.")
  policies?: ToolboxPolicies;
};

alias CreateToolboxVersionRequest = {
  @doc("The name of the toolbox to add a new version to.")
  @path
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

alias DeleteToolboxVersionRequest = {
  @doc("The name of the toolbox.")
  @path
  toolbox_name: string;

  @doc("The version identifier to delete.")
  @path
  version: string;
};
