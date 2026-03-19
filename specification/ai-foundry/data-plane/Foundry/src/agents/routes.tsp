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

  /**
   * Upload a code zip file for code-based hosted agent deployment.
   * The zip is stored internally and an opaque code_reference_id is returned.
   * This ID is then passed into code_configuration.code_reference_id when creating an agent version.
   * Maximum upload size is 250 MB.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  #suppress "@azure-tools/typespec-azure-core/byos" "Code upload is stored internally by the service, not BYOS."
  @post
  @route("/code:upload")
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[AgentDefinitionOptInKeys.code_agents_v1_preview] }
  )
  uploadCode is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys,
    {
      @header contentType: "application/zip" | "application/octet-stream";

      @doc("The code zip file to upload.")
      @body
      body: bytes;
    },
    CodeUploadResponse
  >;
}
