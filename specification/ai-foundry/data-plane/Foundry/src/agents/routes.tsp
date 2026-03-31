import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

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
    AgentDefinitionOptInKeys | FoundryFeaturesOptInKeys.agent_endpoint_v1_preview,
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
    AgentDefinitionOptInKeys | FoundryFeaturesOptInKeys.agent_endpoint_v1_preview,
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

  /**
   * Updates an agent endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @patch(#{ implicitOptionality: true })
  @route("/agents/{agent_name}/endpoint")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[FoundryFeaturesOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @removed(Versions.v1)
  updateAgentEndpointObject is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent to retrieve. */
      @path agent_name: string;

      @header("Content-Type") contentType: "application/merge-patch+json";
      ...UpdateAgentEndpointRequest;
    },
    AgentObject
  >;

  // ── Session Lifecycle Operations ────────────────────────

  /**
   * Creates a new session for an agent. The session is backed by the agent version
   * specified in the version_indicator. Session creation is a long-running operation —
   * the response includes an `x-ms-session-operation-id` header for tracking progress
   * via the Get Operation endpoint.
   */
  @post
  @route("/agents/{agent_name}/endpoint/sessions")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[FoundryFeaturesOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @removed(Versions.v1)
  createSession is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent to create a session for. */
      @path agent_name: string;

      /** Isolation key for session ownership validation. Required for all session-mutating operations. */
      @header("x-session-isolation-key")
      isolation_key: string;

      ...CreateAgentSessionRequest;
    },
    CreatedAgentSessionResponse
  >;

  /**
   * Retrieves a session by ID.
   */
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[FoundryFeaturesOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @removed(Versions.v1)
  getSession is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The session identifier. */
      @path session_id: string;
    },
    AgentSessionResource
  >;

  /**
   * Deletes a session. This is a long-running operation — the session transitions through
   * `deleting` to `deleted` as sandbox and volume cleanup are performed asynchronously.
   * The response includes an `x-ms-session-operation-id` header for tracking progress.
   * Returns 204 No Content if the session does not exist (idempotent).
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" ""
  @delete
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[FoundryFeaturesOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @removed(Versions.v1)
  deleteSession is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The session identifier. */
      @path session_id: string;

      /** Isolation key for session ownership validation. Required for all session-mutating operations. */
      @header("x-session-isolation-key")
      isolation_key: string;
    },
    AcceptedAgentSessionDeleteResponse | NoContentResponse
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
      required_previews: #[FoundryFeaturesOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @removed(Versions.v1)
  listSessions is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      ...PageLimitQueryParameter;

      /** Opaque continuation token from a previous list response. */
      @query pagination_token?: string;
    },
    SessionListResult
  >;

  /**
   * Gets the status of a session operation (create, update, or delete LRO).
   * The response includes the operation status and the current state of the associated session.
   */
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/operations/{operation_id}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[FoundryFeaturesOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @removed(Versions.v1)
  getSessionOperation is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The session identifier. */
      @path session_id: string;

      /** The operation identifier returned in the x-ms-session-operation-id response header. */
      @path operation_id: string;
    },
    AgentSessionOperationObject
  >;
}
