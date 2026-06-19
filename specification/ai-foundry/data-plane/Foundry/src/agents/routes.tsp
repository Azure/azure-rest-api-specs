import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
interface Agents {
  /**
   * Retrieves an agent definition by its unique name.
   */
  @summary("Get an agent")
  @get
  @route("/agents/{agent_name}")
  @tag("Agents")
  getAgent is FoundryDataPlaneOperation<
    {
      /** The name of the agent to retrieve. */
      @path agent_name: string;
    },
    AgentObject
  >;

  /**
   * Creates a new agent or a new version of an existing agent.
   */
  @summary("Create an agent")
  @post
  @route("/agents")
  @sharedRoute
  @extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
  @tag("Agents")
  @extension("x-ms-summary-override", "Create an agent")
  @extension(
    "x-ms-description-override",
    "Creates a new agent or a new version of an existing agent."
  )
  createAgent is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys,
    CreateAgentRequest,
    AgentObject
  >;

  /**
   * Creates a new code-based agent. Uploads the code zip and creates the agent in a single call.
   * The agent name is provided in the `x-ms-agent-name` header since POST /agents has no name in the URL path.
   * The SHA-256 hex digest of the zip is provided in the `x-ms-code-zip-sha256` header for integrity and dedup.
   * The request body is multipart/form-data with a JSON metadata part and a binary code part (part order is irrelevant).
   * Maximum upload size is 250 MB.
   */
  #suppress "@azure-tools/typespec-azure-core/byos" "Code is uploaded as part of agent creation, not BYOS."
  @summary("Create a new code-based agent")
  @post
  @route("/agents")
  @sharedRoute
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[AgentDefinitionOptInKeys.code_agents_v1_preview] }
  )
  @tag("Agents")
  createAgentFromCode is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys,
    {
      @header contentType: "multipart/form-data";

      /** The unique name that identifies the agent. Max 63 chars, must start and end with alphanumeric, hyphens allowed in the middle. */
      @header("x-ms-agent-name")
      @maxLength(63)
      agentName: string;

      /** SHA-256 hex digest of the uploaded code zip. Used for change detection (dedup) and integrity verification. */
      @header("x-ms-code-zip-sha256")
      codeZipSha256: string;

      @multipartBody content: CreateAgentFromCodeContent;
    },
    AgentObject
  >;

  /**
   * Updates the agent by adding a new version if there are any changes to the agent definition.
   * If no changes, returns the existing agent version.
   */
  @summary("Update an agent")
  @post
  @route("/agents/{agent_name}")
  @sharedRoute
  @tag("Agents")
  @extension("x-ms-summary-override", "Update an agent")
  @extension(
    "x-ms-description-override",
    "Updates the agent by adding a new version if there are any changes to the agent definition. If no changes, returns the existing agent version."
  )
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
   * Updates a code-based agent by uploading new code and creating a new version.
   * If the code and definition are unchanged (matched by x-ms-code-zip-sha256 header), returns the existing version.
   * The request body is multipart/form-data with a JSON metadata part and a binary code part (part order is irrelevant).
   * Maximum upload size is 250 MB.
   */
  #suppress "@azure-tools/typespec-azure-core/byos" "Code is uploaded as part of agent update, not BYOS."
  @summary("Update a code-based agent")
  @post
  @route("/agents/{agent_name}")
  @sharedRoute
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[AgentDefinitionOptInKeys.code_agents_v1_preview] }
  )
  @tag("Agents")
  updateAgentFromCode is FoundryDataPlanePreviewOperation<
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

      @header contentType: "multipart/form-data";

      /** SHA-256 hex digest of the uploaded code zip. Used for change detection (dedup) and integrity verification. */
      @header("x-ms-code-zip-sha256")
      codeZipSha256: string;

      @multipartBody content: CreateAgentVersionFromCodeContent;
    },
    AgentObject
  >;

  /**
   * Imports the provided manifest to create an agent and returns the created resource.
   */
  @summary("Create an agent from a manifest")
  @post
  @route("/agents:import")
  @tag("Agents")
  createAgentFromManifest is FoundryDataPlaneOperation<
    CreateAgentFromManifestRequest,
    AgentObject
  >;

  /**
   * Updates the agent from a manifest by adding a new version if there are any changes to the agent definition.
   * If no changes, returns the existing agent version.
   */
  @summary("Update an agent from a manifest")
  @post
  @route("/agents/{agent_name}/import")
  @tag("Agents")
  updateAgentFromManifest is FoundryDataPlaneOperation<
    {
      /** The name of the agent to update. */
      @path agent_name: string;

      ...UpdateAgentFromManifestRequest;
    },
    AgentObject
  >;

  /**
   * Deletes an agent. For hosted agents, if any version has active sessions, the request
   * is rejected with HTTP 409 unless `force` is set to true. When force is true, all
   * associated sessions are cascade-deleted along with the agent and its versions.
   */
  @summary("Delete an agent")
  @delete
  @route("/agents/{agent_name}")
  @tag("Agents")
  deleteAgent is FoundryDataPlaneOperation<
    {
      /** The name of the agent to delete. */
      @path agent_name: string;

      /** For Hosted Agents, if `true`, force-deletes the agent even if its versions have active sessions, cascading deletion to all associated sessions. The service defaults to `false` if a value is not specified by the caller. This value is not relevant for other Agent types. */
      @query force?: boolean = false;
    },
    DeleteAgentResponse
  >;

  /**
   * Returns a paged collection of agent resources.
   */
  @summary("List agents")
  @route("/agents")
  @list
  @tag("Agents")
  listAgents is FoundryDataPlaneOperation<
    {
      ...ListAgentQueryParameters;
    },
    AgentsPagedResult<AgentObject>
  >;

  /**
   * Creates a new version for the specified agent and returns the created version resource.
   */
  @summary("Create an agent version")
  @post
  @route("/agents/{agent_name}/versions")
  @sharedRoute
  @extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
  @tag("Agent Versions")
  @extension("x-ms-summary-override", "Create an agent version")
  @extension(
    "x-ms-description-override",
    "Creates a new version for the specified agent and returns the created version resource."
  )
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
   * Imports the provided manifest to create a new version for the specified agent.
   */
  @summary("Create an agent version from manifest")
  @post
  @route("/agents/{agent_name}/versions:import")
  @tag("Agent Versions")
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
   * Retrieves the specified version of an agent by its agent name and version identifier.
   */
  @summary("Get an agent version")
  @get
  @route("/agents/{agent_name}/versions/{agent_version}")
  @tag("Agent Versions")
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
   * Deletes a specific version of an agent. For hosted agents, if the version has active
   * sessions, the request is rejected with HTTP 409 unless `force` is set to true. When
   * force is true, all sessions associated with this version are cascade-deleted.
   */
  @summary("Delete an agent version")
  @delete
  @route("/agents/{agent_name}/versions/{agent_version}")
  @tag("Agent Versions")
  deleteAgentVersion is FoundryDataPlaneOperation<
    {
      /** The name of the agent to delete. */
      @path agent_name: string;

      /** The version of the agent to delete */
      @path agent_version: string;

      /** For Hosted Agents, if `true`, force-deletes the version even if it has active sessions, cascading deletion to all associated sessions. The service defaults to `false` if a value is not specified by the caller. This value is not relevant for other Agent types. */
      @query force?: boolean = false;
    },
    DeleteAgentVersionResponse
  >;

  /**
   * Returns a paged collection of versions for the specified agent.
   */
  @summary("List agent versions")
  @get
  @route("/agents/{agent_name}/versions")
  @list
  @tag("Agent Versions")
  listAgentVersions is FoundryDataPlaneOperation<
    {
      /** The name of the agent to retrieve versions for. */
      @path agent_name: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<AgentVersionObject>
  >;

  /**
   * Applies a merge-patch update to the specified agent endpoint configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @summary("Update an agent endpoint")
  @patch(#{ implicitOptionality: true })
  @route("/agents/{agent_name}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @tag("Agents")
  patchAgentObject is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent to retrieve. */
      @summary("The name of the agent to retrieve")
      @path
      agent_name: string;

      @header("Content-Type") contentType: "application/merge-patch+json";
      ...PatchAgentRequest;
    },
    AgentObject
  >;

  /**
   * Creates a new agent version from code. Uploads the code zip and creates a new version
   * for an existing agent. The SHA-256 hex digest of the zip is provided in the
   * `x-ms-code-zip-sha256` header for integrity and dedup.
   * The request body is multipart/form-data with a JSON metadata part and a binary code part (part order is irrelevant).
   * Maximum upload size is 250 MB.
   */
  #suppress "@azure-tools/typespec-azure-core/byos" "Code is uploaded as part of agent creation, not BYOS."
  @summary("Create an agent version from code")
  @post
  @route("/agents/{agent_name}/versions")
  @sharedRoute
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[AgentDefinitionOptInKeys.code_agents_v1_preview] }
  )
  @tag("Agent Versions")
  createAgentVersionFromCode is FoundryDataPlanePreviewOperation<
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

      @header contentType: "multipart/form-data";

      /** SHA-256 hex digest of the uploaded code zip. Used for change detection (dedup) and integrity verification. */
      @header("x-ms-code-zip-sha256")
      codeZipSha256: string;

      @multipartBody content: CreateAgentVersionFromCodeContent;
    },
    AgentVersionObject
  >;

  /**
   * Downloads the code zip for a code-based hosted agent.
   * Returns the previously-uploaded zip (`application/zip`).
   *
   * If `agent_version` is supplied, returns that version's code zip; otherwise
   * returns the latest version's code zip.
   *
   * The SHA-256 digest of the returned bytes matches the `content_hash` on the
   * resolved version's `code_configuration`.
   */
  @summary("Download agent code")
  @get
  @route("/agents/{agent_name}/code:download")
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[AgentDefinitionOptInKeys.code_agents_v1_preview] }
  )
  @tag("Agents")
  downloadAgentCode is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.code_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /**
       * The version of the agent whose code zip should be downloaded.
       * If omitted, the latest version's code zip is returned.
       */
      @query agent_version?: string;
    },
    DownloadAgentCodeResponse
  >;

  // ── Session Lifecycle Operations ────────────────────────

  /**
   * Creates a new session for an agent endpoint.
   * The endpoint resolves the backing agent version from `version_indicator` and
   * enforces session ownership using the provided isolation key for session-mutating operations.
   */
  @summary("Create a session")
  @post
  @route("/agents/{agent_name}/endpoint/sessions")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @tag("Agent Sessions")
  createSession is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent to create a session for. */
      @path agent_name: string;

      ...CreateAgentSessionRequest;
    },
    ResourceCreatedResponse<AgentSessionResource>
  >;

  /**
   * Retrieves the details of a hosted agent session by agent name and session identifier.
   */
  @summary("Get a session")
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @tag("Agent Sessions")
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
  @summary("Delete a session")
  @delete
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @tag("Agent Sessions")
  deleteSession is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The session identifier. */
      @path session_id: string;
    },
    NoContentResponse
  >;

  /**
   * Terminates the specified hosted agent session and returns 204 No Content when the request succeeds.
   */
  @summary("Stop a session")
  @post
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}:stop")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @tag("Agent Sessions")
  stopSession is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The session identifier. */
      @path session_id: string;
    },
    NoContentResponse
  >;

  /**
   * Returns a paged collection of sessions associated with the specified agent endpoint.
   */
  @summary("List sessions for an agent")
  @get
  @route("/agents/{agent_name}/endpoint/sessions")
  @list
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @tag("Agent Sessions")
  listSessions is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<AgentSessionResource>
  >;

  /**
   * Streams console logs (stdout / stderr) for a specific hosted agent session
   * as a Server-Sent Events (SSE) stream.
   *
   * Each SSE frame contains:
   * - `event`: always `"log"`
   * - `data`: a plain-text log line (currently JSON-formatted, but the schema
   *   is not contractual and may include additional keys or change format
   *   over time — clients should treat it as an opaque string)
   *
   * Example SSE frames:
   * ```
   * event: log
   * data: {"timestamp":"2026-03-10T09:33:17.121Z","stream":"stdout","message":"Starting FoundryCBAgent server on port 8088"}
   *
   * event: log
   * data: {"timestamp":"2026-03-10T09:33:17.130Z","stream":"stderr","message":"INFO: Application startup complete."}
   *
   * event: log
   * data: {"timestamp":"2026-03-10T09:34:52.714Z","stream":"status","message":"Successfully connected to container"}
   *
   * event: log
   * data: {"timestamp":"2026-03-10T09:35:52.714Z","stream":"status","message":"No logs since last 60 seconds"}
   * ```
   *
   * The stream remains open until the client disconnects or the server
   * terminates the connection. Clients should handle reconnection as needed.
   */
  @summary("Stream console logs for a hosted agent session")
  @get
  @route("/agents/{agent_name}/versions/{agent_version}/sessions/{session_id}:logstream")
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[AgentDefinitionOptInKeys.hosted_agents_v1_preview] }
  )
  @tag("Agent Sessions")
  getSessionLogStream is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.hosted_agents_v1_preview,
    {
      /** The name of the hosted agent. */
      @path agent_name: string;

      /** The version of the agent. */
      @path agent_version: string;

      /** The session ID (maps to an ADC sandbox). */
      @path session_id: string;
    },
    SseResponseOf<SessionLogEvent>
  >;
}
