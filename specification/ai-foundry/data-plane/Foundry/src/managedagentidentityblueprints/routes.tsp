import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
interface ManagedAgentIdentityBlueprints {
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" ""
  @put
  @route("/managedAgentIdentityBlueprints/{name}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[FoundryFeaturesOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @removed(Versions.v1)
  createOrUpdateManagedAgentIdentityBlueprint is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the managed agent identity blueprint to create. */
      @path managed_agent_identity_blueprint_name: string;

      ...CreateOrUpdateManagedAgentIdentityBlueprintRequest;
    },
    ManagedAgentIdentityBlueprint
  >;

  /**
   * Retrieves a managed agent identity blueprint by name.
   */
  @get
  @route("/managedAgentIdentityBlueprints/{managed_agent_identity_blueprint_name}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[FoundryFeaturesOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @removed(Versions.v1)
  getManagedAgentIdentityBlueprint is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the managed agent identity blueprint to retrieve. */
      @path managed_agent_identity_blueprint_name: string;
    },
    ManagedAgentIdentityBlueprint
  >;

  /**
   * Deletes a managed agent identity blueprint by name.
   */
  @delete
  @route("/managedAgentIdentityBlueprints/{managed_agent_identity_blueprint_name}")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[FoundryFeaturesOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @removed(Versions.v1)
  deleteManagedAgentIdentityBlueprint is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.agent_endpoint_v1_preview,
    {
      /** The name of the managed agent identity blueprint to delete. */
      @path managed_agent_identity_blueprint_name: string;
    },
    Http.NoContentResponse
  >;

  @get
  @route("/managedAgentIdentityBlueprints")
  @extension(
    "x-ms-foundry-meta",
    #{
      required_previews: #[FoundryFeaturesOptInKeys.agent_endpoint_v1_preview],
    }
  )
  @removed(Versions.v1)
  listManagedAgentIdentityBlueprints is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.agent_endpoint_v1_preview,
    {
      ...PageOrderQueryParameter;
      ...PageLimitQueryParameter;
      @query @continuationToken token?: string;
    },
    ManagedAgentIdentityBlueprintPagedResponse
  >;
}
