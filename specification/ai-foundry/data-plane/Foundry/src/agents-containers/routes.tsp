import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Streams;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Agent Containers")
@removed(Versions.v1)
interface AgentContainers {
  /**
   * Start a container for a specific version of an agent. If the container is already running, the operation will be no-op.
   * The operation is a long-running operation. Following the design guidelines for long-running operations in Azure REST APIs.
   * https://github.com/microsoft/api-guidelines/blob/vNext/azure/ConsiderationsForServiceDesign.md#action-operations
   */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" ""
  @post
  @route("/agents/{agent_name}/versions/{agent_version}/containers/default:start")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        FoundryFeaturesOptInKeys.container_agents_v1_preview
      ],
    }
  )
  startAgentContainer is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.container_agents_v1_preview,
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
   * Update a container for a specific version of an agent. If the container is not running, the operation will be no-op.
   * The operation is a long-running operation. Following the design guidelines for long-running operations in Azure REST APIs.
   * https://github.com/microsoft/api-guidelines/blob/vNext/azure/ConsiderationsForServiceDesign.md#action-operations
   */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" ""
  @post
  @route("/agents/{agent_name}/versions/{agent_version}/containers/default:update")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        FoundryFeaturesOptInKeys.container_agents_v1_preview
      ],
    }
  )
  updateAgentContainer is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.container_agents_v1_preview,
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
   * Stop a container for a specific version of an agent. If the container is not running, or already stopped, the operation will be no-op.
   * The operation is a long-running operation. Following the design guidelines for long-running operations in Azure REST APIs.
   * https://github.com/microsoft/api-guidelines/blob/vNext/azure/ConsiderationsForServiceDesign.md#action-operations
   */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" ""
  @post
  @route("/agents/{agent_name}/versions/{agent_version}/containers/default:stop")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        FoundryFeaturesOptInKeys.container_agents_v1_preview
      ],
    }
  )
  stopAgentContainer is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.container_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;
    },
    AcceptedAgentContainerOperation
  >;

  /**
   * Delete a container for a specific version of an agent. If the container doesn't exist, the operation will be no-op.
   * The operation is a long-running operation. Following the design guidelines for long-running operations in Azure REST APIs.
   * https://github.com/microsoft/api-guidelines/blob/vNext/azure/ConsiderationsForServiceDesign.md#action-operations
   */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" ""
  @post
  @route("/agents/{agent_name}/versions/{agent_version}/containers/default:delete")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        FoundryFeaturesOptInKeys.container_agents_v1_preview
      ],
    }
  )
  deleteAgentContainer is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.container_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;
    },
    AcceptedAgentContainerOperation
  >;

  /**
   * Get a container for a specific version of an agent.
   */
  @get
  @route("/agents/{agent_name}/versions/{agent_version}/containers/default")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        FoundryFeaturesOptInKeys.container_agents_v1_preview
      ],
    }
  )
  getAgentContainer is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.container_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;
    },
    AgentContainerObject
  >;

  /**
   * Stream logs from a container for a specific version of an agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" ""
  @post
  @route("/agents/{agent_name}/versions/{agent_version}/containers/default:logstream")
  @doc("""
    Container log entry streamed from the container as text chunks.
    Each chunk is a UTF-8 string that may be either a plain text log line
    or a JSON-formatted log entry, depending on the type of container log being streamed.
    Clients should treat each chunk as opaque text and, if needed, attempt
    to parse it as JSON based on their logging requirements.
    
    For system logs, the format is JSON with the following structure:
    {"TimeStamp":"2025-12-15T16:51:33Z","Type":"Normal","ContainerAppName":null,"RevisionName":null,"ReplicaName":null,"Msg":"Connecting to the events collector...","Reason":"StartingGettingEvents","EventSource":"ContainerAppController","Count":1}
    {"TimeStamp":"2025-12-15T16:51:34Z","Type":"Normal","ContainerAppName":null,"RevisionName":null,"ReplicaName":null,"Msg":"Successfully connected to events server","Reason":"ConnectedToEventsServer","EventSource":"ContainerAppController","Count":1}
    
    For console logs, the format is plain text as emitted by the container's stdout/stderr.
    2025-12-15T08:43:48.72656  Connecting to the container 'agent-container'...
    2025-12-15T08:43:48.75451  Successfully Connected to container: 'agent-container' [Revision: 'je90fe655aa742ef9a188b9fd14d6764--7tca06b', Replica: 'je90fe655aa742ef9a188b9fd14d6764--7tca06b-6898b9c89f-mpkjc']
    2025-12-15T08:33:59.0671054Z stdout F INFO:     127.0.0.1:42588 - "GET /readiness HTTP/1.1" 200 OK
    2025-12-15T08:34:29.0649033Z stdout F INFO:     127.0.0.1:60246 - "GET /readiness HTTP/1.1" 200 OK
    2025-12-15T08:34:59.0644467Z stdout F INFO:     127.0.0.1:43994 - "GET /readiness HTTP/1.1" 200 OK
    """)
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        FoundryFeaturesOptInKeys.container_agents_v1_preview
      ],
    }
  )
  streamAgentContainerLogs is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.container_agents_v1_preview,
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
   * Get the status of a container operation for an agent.
   */
  @get
  @route("/agents/{agent_name}/operations/{operation_id}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        FoundryFeaturesOptInKeys.container_agents_v1_preview
      ],
    }
  )
  getAgentContainerOperation is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.container_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The operation ID. */
      @path operation_id: string;
    },
    AgentContainerOperationObject
  >;

  /**
   * List container operations for an agent.
   */
  @get
  @route("/agents/{agent_name}/operations")
  @list
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        FoundryFeaturesOptInKeys.container_agents_v1_preview
      ],
    }
  )
  listAgentContainerOperations is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.container_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<AgentContainerOperationObject>
  >;

  /**
   * List container operations for a specific version of an agent.
   */
  @get
  @route("/agents/{agent_name}/versions/{agent_version}/containers/default/operations")
  @list
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[
        FoundryFeaturesOptInKeys.container_agents_v1_preview
      ],
    }
  )
  listAgentVersionContainerOperations is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.container_agents_v1_preview,
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
