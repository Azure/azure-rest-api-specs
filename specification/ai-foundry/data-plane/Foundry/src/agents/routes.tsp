import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  @sharedRoute
  @extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
  createAgent is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys,
    CreateAgentRequest,
    AgentObject
  >;

  /**
   * Creates a new code-based agent. Uploads the code zip and creates the agent in a single call.
   * The request is multipart/form-data with a JSON metadata part (including agent name) and a binary code part.
   * Maximum upload size is 250 MB.
   */
  #suppress "@azure-tools/typespec-azure-core/byos" "Code is uploaded as part of agent creation, not BYOS."
  @post
  @route("/agents")
  @sharedRoute
  @extension("x-ms-foundry-meta", #{ required_previews: #[AgentDefinitionOptInKeys.code_agents_v1_preview] })
  createAgentFromCode is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys,
    {
      @header contentType: "multipart/form-data";
      @multipartBody body: CreateAgentFromCodeContent;
    },
    AgentObject
  >;

  /**
   * Updates the agent by adding a new version if there are any changes to the agent definition.
   * If no changes, returns the existing agent version.
   */
  @post
  @route("/agents/{agent_name}")
  @sharedRoute
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
   * If the code and definition are unchanged (matched by content_hash), returns the existing version.
   * The request is multipart/form-data with a JSON metadata part and a binary code part.
   * Maximum upload size is 250 MB.
   */
  #suppress "@azure-tools/typespec-azure-core/byos" "Code is uploaded as part of agent update, not BYOS."
  @post
  @route("/agents/{agent_name}")
  @sharedRoute
  @extension("x-ms-foundry-meta", #{ required_previews: #[AgentDefinitionOptInKeys.code_agents_v1_preview] })
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
      @multipartBody body: CreateAgentVersionFromCodeContent;
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
  @sharedRoute
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

  /**
   * Create a new agent version from code. Uploads the code zip and creates or updates
   * the agent in a single call. If an agent with the given name already exists, a new
   * version is added. If not, the agent is created with its first version.
   * The request is multipart/form-data with a JSON metadata part and a binary code part.
   * Maximum upload size is 250 MB.
   */
  #suppress "@azure-tools/typespec-azure-core/byos" "Code is uploaded as part of agent creation, not BYOS."
  @post
  @route("/agents/{agent_name}/versions")
  @sharedRoute
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[AgentDefinitionOptInKeys.code_agents_v1_preview] }
  )
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
      @multipartBody body: CreateAgentVersionFromCodeContent;
    },
    AgentVersionObject
  >;
}
