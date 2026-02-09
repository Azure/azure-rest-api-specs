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
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @post
  @route("/agents")
  @extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
  createAgent is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.container_agents_v1_preview | FoundryFeaturesOptInKeys.hosted_agents_v1_preview | FoundryFeaturesOptInKeys.workflow_agents_v1_preview,
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
  updateAgent is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.container_agents_v1_preview | FoundryFeaturesOptInKeys.hosted_agents_v1_preview | FoundryFeaturesOptInKeys.workflow_agents_v1_preview,
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
  createAgentFromManifest is FoundryDataPlaneOperation<
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
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @post
  @route("/agents/{agent_name}/versions")
  @extension("x-ms-foundry-meta", AllConditionalAgentDefinitionPreviews)
  createAgentVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.container_agents_v1_preview | FoundryFeaturesOptInKeys.hosted_agents_v1_preview | FoundryFeaturesOptInKeys.workflow_agents_v1_preview,
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
}
