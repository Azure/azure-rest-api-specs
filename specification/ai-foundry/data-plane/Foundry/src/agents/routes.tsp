import "@typespec/http";
import "@typespec/openapi";
import "@typespec/streams";
import "@azure-tools/typespec-azure-core";

import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Streams;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Agents")
interface Agents {
  /**
   * Retrieves the agent.
   */
  @get
  @route("/agents/{agent_name}")
  getAgent is FoundryDataPlaneOperation<
    {
      /** The name of the agent to retrieve. */
      @path agent_name: string;
    },
    AgentObject
  >;

  /**
   * Creates the agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @post
  @route("/agents")
  @extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
  createAgent is FoundryDataPlanePreviewOperation<
    FoundryPreviewOptInKeys.container_agents_v1 | FoundryPreviewOptInKeys.hosted_agents_v1 | FoundryPreviewOptInKeys.workflow_agents_v1,
    CreateAgentRequest,
    AgentObject
  >;

  /**
   * Updates the agent by adding a new version if there are any changes to the agent definition.
   * If no changes, returns the existing agent version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @post
  @route("/agents/{agent_name}")
  updateAgent is FoundryDataPlaneOperation<
    {
      /** The name of the agent to retrieve. */
      @path agent_name: string;

      ...UpdateAgentRequest;
    },
    AgentObject
  >;

  /**
   * Creates an agent from a manifest.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @post
  @route("/agents:import")
  createAgentFromManifest is FoundryDataPlanePreviewOperation<
    FoundryPreviewOptInKeys.container_agents_v1 | FoundryPreviewOptInKeys.hosted_agents_v1,
    CreateAgentFromManifestRequest,
    AgentObject
  >;

  /**
   * Updates the agent from a manifest by adding a new version if there are any changes to the agent definition.
   * If no changes, returns the existing agent version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @post
  @route("/agents/{agent_name}/import")
  updateAgentFromManifest is FoundryDataPlaneOperation<
    {
      /** The name of the agent to update. */
      @path agent_name: string;

      ...UpdateAgentFromManifestRequest;
    },
    AgentObject
  >;

  /**
   * Deletes an agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @delete
  @route("/agents/{agent_name}")
  deleteAgent is FoundryDataPlanePreviewOperation<
    FoundryPreviewOptInKeys.container_agents_v1 | FoundryPreviewOptInKeys.hosted_agents_v1,
    {
      /** The name of the agent to delete. */
      @path agent_name: string;
    },
    DeleteAgentResponse
  >;

  /**
   * Returns the list of all agents.
   */
  @route("/agents")
  listAgents is FoundryDataPlaneOperation<
    {
      ...ListAgentQueryParameters;
    },
    AgentsPagedResult<AgentObject>
  >;

  /**
   * Create a new agent version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @post
  @route("/agents/{agent_name}/versions")
  @extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
  createAgentVersion is FoundryDataPlanePreviewOperation<
    FoundryPreviewOptInKeys.container_agents_v1 | FoundryPreviewOptInKeys.hosted_agents_v1 | FoundryPreviewOptInKeys.workflow_agents_v1,
    {
      /**
       * The unique name that identifies the agent. Name can be used to retrieve/update/delete the agent.
       * - Must start and end with alphanumeric characters,
       * - Can contain hyphens in the middle
       * - Must not exceed 63 characters.
       */
      @maxLength(63)
      @path
      agent_name: string;

      ...CreateAgentVersionRequest;
    },
    AgentVersionObject
  >;

  /**
   * Create a new agent version from a manifest.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @post
  @route("/agents/{agent_name}/versions:import")
  createAgentVersionFromManifest is FoundryDataPlaneOperation<
    {
      /**
       * The unique name that identifies the agent. Name can be used to retrieve/update/delete the agent.
       * - Must start and end with alphanumeric characters,
       * - Can contain hyphens in the middle
       * - Must not exceed 63 characters.
       */
      @maxLength(63)
      @path
      agent_name: string;

      ...CreateAgentVersionFromManifestRequest;
    },
    AgentVersionObject
  >;

  /**
   * Retrieves a specific version of an agent.
   */
  @get
  @route("/agents/{agent_name}/versions/{agent_version}")
  getAgentVersion is FoundryDataPlaneOperation<
    {
      /** The name of the agent to retrieve. */
      @path agent_name: string;

      /** The version of the agent to retrieve. */
      @path agent_version: string;
    },
    AgentVersionObject
  >;

  /**
   * Deletes a specific version of an agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @delete
  @route("/agents/{agent_name}/versions/{agent_version}")
  deleteAgentVersion is FoundryDataPlanePreviewOperation<
    FoundryPreviewOptInKeys.container_agents_v1 | FoundryPreviewOptInKeys.hosted_agents_v1,
    {
      /** The name of the agent to delete. */
      @path agent_name: string;

      /** The version of the agent to delete */
      @path agent_version: string;
    },
    DeleteAgentVersionResponse
  >;

  /**
   * Returns the list of versions of an agent.
   */
  @get
  @route("/agents/{agent_name}/versions")
  @list
  listAgentVersions is FoundryDataPlaneOperation<
    {
      /** The name of the agent to retrieve versions for. */
      @path agent_name: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<AgentVersionObject>
  >;

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
    #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
  )
  startAgentContainer is FoundryDataPlanePreviewOperation<
    FoundryPreviewOptInKeys.container_agents_v1,
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
    #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
  )
  updateAgentContainer is FoundryDataPlanePreviewOperation<
    FoundryPreviewOptInKeys.container_agents_v1,
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
    #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
  )
  stopAgentContainer is FoundryDataPlanePreviewOperation<
    FoundryPreviewOptInKeys.container_agents_v1,
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
    #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
  )
  deleteAgentContainer is FoundryDataPlanePreviewOperation<
    FoundryPreviewOptInKeys.container_agents_v1,
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
    #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
  )
  getAgentContainer is FoundryDataPlanePreviewOperation<
    FoundryPreviewOptInKeys.container_agents_v1,
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
    #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
  )
  streamAgentContainerLogs is FoundryDataPlanePreviewOperation<
    FoundryPreviewOptInKeys.container_agents_v1,
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
    #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
  )
  getAgentContainerOperation is FoundryDataPlanePreviewOperation<
    FoundryPreviewOptInKeys.container_agents_v1,
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
    #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
  )
  listAgentContainerOperations is FoundryDataPlanePreviewOperation<
    FoundryPreviewOptInKeys.container_agents_v1,
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
    #{ required_previews: #[FoundryPreviewOptInKeys.container_agents_v1] }
  )
  listAgentVersionContainerOperations is FoundryDataPlanePreviewOperation<
    FoundryPreviewOptInKeys.container_agents_v1,
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
