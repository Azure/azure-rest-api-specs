import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Versioning;

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
  @post
  @route("/agents")
  @extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
  createAgent is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys,
    CreateAgentRequest,
    AgentObject
  >;

  /**
   * Updates the agent by adding a new version if there are any changes to the agent definition.
   * If no changes, returns the existing agent version.
   */
  @post
  @route("/agents/{agent_name}")
  updateAgent is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys,
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
  @post
  @route("/agents:import")
  createAgentFromManifest is FoundryDataPlaneOperation<
    CreateAgentFromManifestRequest,
    AgentObject
  >;

  /**
   * Updates the agent from a manifest by adding a new version if there are any changes to the agent definition.
   * If no changes, returns the existing agent version.
   */
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
  @delete
  @route("/agents/{agent_name}")
  deleteAgent is FoundryDataPlaneOperation<
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
  @list
  listAgents is FoundryDataPlaneOperation<
    {
      ...ListAgentQueryParameters;
    },
    AgentsPagedResult<AgentObject>
  >;

  /**
   * Create a new agent version.
   */
  @post
  @route("/agents/{agent_name}/versions")
  @extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
  createAgentVersion is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys,
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
  @delete
  @route("/agents/{agent_name}/versions/{agent_version}")
  deleteAgentVersion is FoundryDataPlaneOperation<
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

  // ── Session Lifecycle Operations ────────────────────────

  /**
   * Creates a new session for an agent endpoint.
   * The endpoint resolves the backing agent version from `version_indicator` and
   * enforces session ownership using the provided isolation key for session-mutating operations.
   */
  @post
  @route("/agents/{agent_name}/endpoint/sessions")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @removed(Versions.v1)
  createSession is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent to create a session for. */
      @path agent_name: string;

      /** Isolation key used by the agent endpoint to enforce session ownership for session-mutating operations. */
      @header("x-session-isolation-key")
      isolation_key: string;

      ...CreateAgentSessionRequest;
    },
    OkResponse<AgentSessionResource>
  >;

  /**
   * Retrieves a session by ID.
   */
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @removed(Versions.v1)
  getSession is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The session identifier. */
      @path session_id: string;
    },
    AgentSessionResource
  >;

  /**
   * Deletes a session synchronously.
   * Returns 204 No Content when the session is deleted or does not exist.
   */
  @delete
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @removed(Versions.v1)
  deleteSession is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The session identifier. */
      @path session_id: string;

      /** Isolation key used by the agent endpoint to enforce session ownership for session-mutating operations. */
      @header("x-session-isolation-key")
      isolation_key: string;
    },
    NoContentResponse
  >;

  /**
   * Returns a list of sessions for the specified agent.
   */
  @get
  @route("/agents/{agent_name}/endpoint/sessions")
  @list
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @removed(Versions.v1)
  listSessions is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      ...PageLimitQueryParameter;

      /** Opaque continuation token from a previous list response. */
      @query pagination_token?: string;
    },
    SessionListResult
  >;
}
