import "../common/service.tsp";
import "../tools/models.tsp";
import "../agents/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

@doc("Policy configuration for a toolbox, including content safety and other governance settings.")
model ToolboxPolicies {
  @doc("Responsible AI content filtering configuration.")
  rai_config?: RaiConfig;
}

@doc("An example scenario that a toolbox skill can perform.")
@maxLength(1024)
scalar ToolboxSkillExample extends string;

@doc("A keyword describing a class of capabilities for a toolbox skill.")
@maxLength(32)
scalar ToolboxSkillTag extends string;

@doc("A skill contained in a toolbox version.")
model ToolboxSkill {
  @doc("A unique identifier for the skill.")
  @maxLength(64)
  @minLength(1)
  id: string;

  @doc("The name of the skill.")
  @maxLength(128)
  @minLength(1)
  name: string;

  @doc("A description of the skill.")
  @maxLength(2048)
  description?: string;

  @doc("The keywords describing classes of capabilities for the skill.")
  @maxItems(5)
  tags?: ToolboxSkillTag[];

  @doc("A list of example scenarios that the skill can perform.")
  @maxItems(5)
  examples?: ToolboxSkillExample[];
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

  @doc("The list of tools contained in this toolbox version. At least one of tools or skills is present.")
  @minItems(1)
  tools?: OpenAI.Tool[];

  @doc("The list of skills contained in this toolbox version. At least one of tools or skills is present.")
  @maxItems(16)
  @minItems(1)
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

  @doc("The list of tools to include in this version. Provide at least one tool or one skill.")
  @minItems(1)
  tools?: OpenAI.Tool[];

  @doc("The list of skills to include in this version. Provide at least one tool or one skill.")
  @maxItems(16)
  @minItems(1)
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
