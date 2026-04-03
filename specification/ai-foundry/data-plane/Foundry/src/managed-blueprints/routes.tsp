import "../common/models.tsp";
import "./models.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
interface ManagedAgentIdentityBlueprints {
  @put
  @route("/managedAgentIdentityBlueprints/{blueprint_name}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  createOrUpdateManagedAgentIdentityBlueprint is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the managed agent identity blueprint to create. */
      @path blueprint_name: string;

      ...CreateOrUpdateManagedAgentIdentityBlueprintRequest;
    },
    ManagedAgentIdentityBlueprint
  >;

  /**
   * Retrieves a managed agent identity blueprint by name.
   */
  @get
  @route("/managedAgentIdentityBlueprints/{blueprint_name}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  getManagedAgentIdentityBlueprint is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the managed agent identity blueprint to retrieve. */
      @path blueprint_name: string;
    },
    ManagedAgentIdentityBlueprint
  >;

  /**
   * Deletes a managed agent identity blueprint by name.
   */
  @delete
  @route("/managedAgentIdentityBlueprints/{blueprint_name}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  deleteManagedAgentIdentityBlueprint is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the managed agent identity blueprint to delete. */
      @path blueprint_name: string;
    },
    Http.NoContentResponse
  >;

  @get
  @route("/managedAgentIdentityBlueprints")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[AgentDefinitionOptInKeys.agent_endpoint_v1_preview],
    }
  )
  listManagedAgentIdentityBlueprints is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.agent_endpoint_v1_preview,
    {
      ...PageOrderQueryParameter;
      ...PageLimitQueryParameter;
    },
    Foundations.CustomPage<ManagedAgentIdentityBlueprint>
  >;
}
