import "../common/models.tsp";
import "../agents/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

@doc("Status of the container operation for a specific version of an agent.")
@extension(
  "x-ms-foundry-meta",
  #{
    required_previews: #[FoundryFeaturesOptInKeys.container_agents_v1_preview],
  }
)
union AgentContainerOperationStatus {
  @doc("The container operation is not started.")
  NotStarted: "NotStarted",

  @doc("The container operation is in progress.")
  InProgress: "InProgress",

  @doc("The container operation has succeeded.")
  Succeeded: "Succeeded",

  @doc("The container operation has failed.")
  Failed: "Failed",
}

@doc("Status of the container of a specific version of an agent.")
@extension(
  "x-ms-foundry-meta",
  #{
    required_previews: #[FoundryFeaturesOptInKeys.container_agents_v1_preview],
  }
)
union AgentContainerStatus {
  @doc("The container is starting.")
  Starting: "Starting",

  @doc("The container is running.")
  Running: "Running",

  @doc("The container is stopping.")
  Stopping: "Stopping",

  @doc("The container is stopped.")
  Stopped: "Stopped",

  @doc("The container has failed.")
  Failed: "Failed",

  @doc("The container is deleting.")
  Deleting: "Deleting",

  @doc("The container is deleted.")
  Deleted: "Deleted",

  @doc("The container is updating.")
  Updating: "Updating",
}


@doc("The error details of the container operation, if any.")
@extension(
  "x-ms-foundry-meta",
  #{
    required_previews: #[FoundryFeaturesOptInKeys.container_agents_v1_preview],
  }
)
model AgentContainerOperationError {
  @doc("The error code of the container operation, if any.")
  code: string;

  @doc("The error type of the container operation, if any.")
  type: string;

  @doc("The error message of the container operation, if any.")
  message: string;
}

@doc("The container operation for a specific version of an agent.")
@extension(
  "x-ms-foundry-meta",
  #{
    required_previews: #[FoundryFeaturesOptInKeys.container_agents_v1_preview],
  }
)
model AgentContainerOperationObject {
  @doc("The ID of the container operation. This id is unique identifier across the system.")
  id: string;

  @doc("The ID of the agent.")
  agent_id: string;

  @doc("The ID of the agent version.")
  agent_version_id: string;

  @doc("The status of the container operation.")
  status: AgentContainerOperationStatus;

  @doc("The error of the container operation, if any.")
  error?: AgentContainerOperationError;

  @doc("The container of the specific version of an agent.")
  container?: AgentContainerObject;
}

@doc("The details of the container of a specific version of an agent.")
@extension(
  "x-ms-foundry-meta",
  #{
    required_previews: #[FoundryFeaturesOptInKeys.container_agents_v1_preview],
  }
)
model AgentContainerObject {
  @doc("The object type, which is always 'agent.container'.")
  @visibility(Lifecycle.Read)
  object: AgentObjectType.agentContainer;

  @doc("The identifier of the container.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The status of the container of a specific version of an agent.")
  @visibility(Lifecycle.Read)
  status: AgentContainerStatus;

  @doc("The maximum number of replicas for the container. Default is 1.")
  @example(10)
  max_replicas?: int32;

  @doc("The minimum number of replicas for the container. Default is 1.")
  @example(1)
  min_replicas?: int32;

  @doc("The error message if the container failed to operate, if any.")
  @visibility(Lifecycle.Read)
  error_message?: string;

  @doc("The creation time of the container.")
  @visibility(Lifecycle.Read)
  created_at: utcDateTime;

  @doc("The last update time of the container.")
  @visibility(Lifecycle.Read)
  updated_at: utcDateTime;

  @doc("The detailed container information.")
  @visibility(Lifecycle.Read)
  container?: ContainerDetails;
}

@doc("Information about a container replica.")
@extension(
  "x-ms-foundry-meta",
  #{
    required_previews: #[FoundryFeaturesOptInKeys.container_agents_v1_preview],
  }
)
model ContainerReplica {
  @doc("The name of the replica.")
  name: string;

  @doc("The state of the replica.")
  state: string;

  @doc("The container state of the replica.")
  container_state: string;
}

@doc("Detailed information about the container.")
@extension(
  "x-ms-foundry-meta",
  #{
    required_previews: #[FoundryFeaturesOptInKeys.container_agents_v1_preview],
  }
)
model ContainerDetails {
  @doc("The provisioning state of the container.")
  provisioning_state: string;

  @doc("The provisioning error of the container, if any.")
  provisioning_error?: string;

  @doc("The state of the container.")
  state: string;

  @doc("The health state of the container.")
  health_state: string;

  @doc("The list of replicas in the container.")
  replicas: ContainerReplica[];

  @doc("The last update time of the container.")
  updated_on: utcDateTime;
}

@extension(
  "x-ms-foundry-meta",
  #{
    required_previews: #[FoundryFeaturesOptInKeys.container_agents_v1_preview],
  }
)
model AcceptedAgentContainerOperation {
  @statusCode
  code: 202;

  @header("Operation-Location")
  location: url;

  @body
  body: AgentContainerOperationObject;
}


