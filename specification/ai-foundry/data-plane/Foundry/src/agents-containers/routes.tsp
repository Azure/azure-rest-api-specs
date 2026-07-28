import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Streams;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Agent Containers")
@removed(Versions.v1)
interface AgentContainers {
  /**
   * Starts the default container for the specified agent version.
   * The long-running operation provisions replicas when a container is not already running.
   */
  @summary("Start an agent container")
  @pollingOperation(AgentContainers.getAgentContainerOperation)
  @post
  @route("/agents/{agent_name}/versions/{agent_version}/containers/default:start")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        AgentDefinitionOptInKeys.container_agents_v1_preview
      ],
    }
  )
  startAgentContainer is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.container_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;

      /** The minimum number of replicas. Defaults to 1. */
      min_replicas?: int32 = 1;

      /** The maximum number of replicas. Defaults to 1. */
      max_replicas?: int32 = 1;
    },
    AcceptedAgentContainerOperation
  >;

  /**
   * Updates the replica settings for the default container of the specified agent version.
   * The long-running operation applies changes only when a container is already running.
   */
  @summary("Update an agent container")
  @pollingOperation(AgentContainers.getAgentContainerOperation)
  @post
  @route("/agents/{agent_name}/versions/{agent_version}/containers/default:update")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        AgentDefinitionOptInKeys.container_agents_v1_preview
      ],
    }
  )
  updateAgentContainer is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.container_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;

      /** The minimum number of replicas. */
      min_replicas?: int32;

      /** The maximum number of replicas. */
      max_replicas?: int32;
    },
    AcceptedAgentContainerOperation
  >;

  /**
   * Stops the default container for the specified agent version.
   * The long-running operation completes even when the container is already stopped.
   */
  @summary("Stop an agent container")
  @pollingOperation(AgentContainers.getAgentContainerOperation)
  @post
  @route("/agents/{agent_name}/versions/{agent_version}/containers/default:stop")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        AgentDefinitionOptInKeys.container_agents_v1_preview
      ],
    }
  )
  stopAgentContainer is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.container_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;
    },
    AcceptedAgentContainerOperation
  >;

  /**
   * Deletes the default container for the specified agent version.
   * The long-running operation returns an operation resource that can be polled to completion.
   */
  @summary("Delete an agent container")
  @pollingOperation(AgentContainers.getAgentContainerOperation)
  @post
  @route("/agents/{agent_name}/versions/{agent_version}/containers/default:delete")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        AgentDefinitionOptInKeys.container_agents_v1_preview
      ],
    }
  )
  deleteAgentContainer is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.container_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;
    },
    AcceptedAgentContainerOperation
  >;

  /**
   * Retrieves the default container resource for the specified agent version.
   * The response includes the current container state and configuration.
   */
  @summary("Get an agent container")
  @get
  @route("/agents/{agent_name}/versions/{agent_version}/containers/default")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        AgentDefinitionOptInKeys.container_agents_v1_preview
      ],
    }
  )
  getAgentContainer is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.container_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;
    },
    AgentContainerObject
  >;

  /**
   * Streams console or system logs from the default container for the specified agent version.
   * Clients can target a specific replica and request trailing log lines before the chunked text stream begins.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" ""
  @summary("Stream agent container logs")
  @post
  @route("/agents/{agent_name}/versions/{agent_version}/containers/default:logstream")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        AgentDefinitionOptInKeys.container_agents_v1_preview
      ],
    }
  )
  streamAgentContainerLogs is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.container_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;

      /** The type of logs to stream. */
      @doc("console returns container stdout/stderr, system returns container app event stream. defaults to console")
      @query
      kind?: ContainerLogKind;

      /** The name of the replica to stream logs from. */
      @doc("When omitted, the server chooses the first replica for console logs. Required to target a specific replica.")
      @query
      replica_name?: string;

      /** The number of lines from the end of the logs to show. */
      @doc("Number of trailing lines returned. Enforced to 1-300. Defaults to 20")
      @query
      tail?: int32;
    },
    Stream<{
      @header("content-type") contentType: "text/plain; charset=utf-8";
      @header("transfer-encoding") transferEncoding: "chunked";
      @body body: string;
    }>
  >;

  /**
   * Retrieves the status and details of the specified container operation for an agent.
   */
  @summary("Get an agent container operation")
  @get
  @route("/agents/{agent_name}/operations/{operation_id}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        AgentDefinitionOptInKeys.container_agents_v1_preview
      ],
    }
  )
  getAgentContainerOperation is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.container_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The operation ID. */
      @path operation_id: string;
    },
    AgentContainerOperationObject
  >;

  /**
   * Returns container operations recorded for the specified agent across its container lifecycle.
   */
  @summary("List agent container operations")
  @get
  @route("/agents/{agent_name}/operations")
  @list
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        AgentDefinitionOptInKeys.container_agents_v1_preview
      ],
    }
  )
  listAgentContainerOperations is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.container_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<AgentContainerOperationObject>
  >;

  /**
   * Returns container operations for the default container of the specified agent version.
   */
  @summary("List agent version container operations")
  @get
  @route("/agents/{agent_name}/versions/{agent_version}/containers/default/operations")
  @list
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        AgentDefinitionOptInKeys.container_agents_v1_preview
      ],
    }
  )
  listAgentVersionContainerOperations is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.container_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<AgentContainerOperationObject>
  >;
}
