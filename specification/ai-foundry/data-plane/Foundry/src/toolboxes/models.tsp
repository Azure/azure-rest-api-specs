import "../common/service.tsp";
import "../tools/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const ToolboxesRequiredPreviews = #{
  conditional_previews: #[FoundryFeaturesOptInKeys.toolbox_v1_preview],
};

union ToolboxObjectType {
  toolbox: "toolbox",
  toolboxDeleted: "toolbox.deleted",
}

@doc("A toolbox that stores reusable tool definitions for agents.")
model ToolboxObject {
  @doc("The object type, which is always 'toolbox'.")
  object: ToolboxObjectType.toolbox;

  @doc("The unique identifier of the toolbox.")
  id: string;

  @doc("The version number of this toolbox. Increments with each update.")
  @minValue(1)
  version: int32;

  @doc("The Unix timestamp (seconds) when the toolbox was created.")
  @encode("unixTimestamp", int32)
  created_at: utcDateTime;

  @doc("The Unix timestamp (seconds) when this version was created.")
  @encode("unixTimestamp", int32)
  updated_at: utcDateTime;

  @doc("The name of the toolbox.")
  @maxLength(256)
  name: string;

  @doc("A human-readable description of the toolbox.")
  @maxLength(512)
  description?: string;

  @doc("Arbitrary key-value metadata to associate with the toolbox.")
  metadata?: Record<string>;

  @doc("The list of tools contained in this toolbox.")
  tools: OpenAI.Tool[];
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
};

alias UpdateToolboxRequest = {
  @doc("The name of the toolbox to update.")
  @path
  toolbox_name: string;

  @doc("A human-readable description of the toolbox.")
  @maxLength(512)
  description?: string;

  @doc("Arbitrary key-value metadata to associate with the toolbox.")
  metadata?: Record<string>;

  @doc("The list of tools to include in the toolbox.")
  tools: OpenAI.Tool[];
};

alias GetToolboxRequest = {
  @doc("The name of the toolbox to retrieve.")
  @path
  toolbox_name: string;

  @doc("The specific version to retrieve. If not specified, returns the latest version.")
  @query
  version?: int32;
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

  @doc("The specific version to delete. If not specified, deletes all versions.")
  @query
  version?: int32;
};
