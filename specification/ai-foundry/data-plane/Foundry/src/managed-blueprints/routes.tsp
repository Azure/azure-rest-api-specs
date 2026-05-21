import "../common/models.tsp";
import "./models.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@removed(Versions.v1)
interface ManagedAgentIdentityBlueprints {
  @put
  @route("/managedAgentIdentityBlueprints/{blueprint_name}")
  createOrUpdateManagedAgentIdentityBlueprint is FoundryDataPlaneOperation<
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
  getManagedAgentIdentityBlueprint is FoundryDataPlaneOperation<
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
  deleteManagedAgentIdentityBlueprint is FoundryDataPlaneOperation<
    {
      /** The name of the managed agent identity blueprint to delete. */
      @path blueprint_name: string;
    },
    Http.NoContentResponse
  >;

  @get
  @route("/managedAgentIdentityBlueprints")
  listManagedAgentIdentityBlueprints is FoundryDataPlaneOperation<
    {
      ...PageOrderQueryParameter;
      ...PageLimitQueryParameter;
    },
    Foundations.CustomPage<ManagedAgentIdentityBlueprint>
  >;
}
