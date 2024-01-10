import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ContainerService;
@doc("The Fleet resource.")
model Fleet is TrackedResource<FleetProperties> {
  @doc("The name of the Fleet resource.")
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @key("fleetName")
  @segment("fleets")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.EntityTag;
}

@armResourceOperations
interface Fleets {
  @doc("Gets a Fleet.")
  get is ArmResourceRead<Fleet>;

  @doc("Creates or updates a Fleet.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Fleet,
    {
      ...BaseParameters<Fleet>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;

      @doc("The request should only proceed if no entity matches this string.")
      @header
      ifNoneMatch?: string;
    }
  >;

  @doc("Update a Fleet")
  update is ArmCustomPatchAsync<
    Fleet,
    FleetPatch,
    {
      ...BaseParameters<Fleet>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;
    }
  >;

  @doc("Delete a Fleet")
  delete is ArmResourceDeleteAsync<
    Fleet,
    {
      ...BaseParameters<Fleet>;

      @doc("The request should only proceed if an entity matches this string.")
      @header
      ifMatch?: string;
    }
  >;

  @doc("Lists fleets in the specified subscription and resource group.")
  listByResourceGroup is ArmResourceListByParent<Fleet>;

  @doc("Lists fleets in the specified subscription.")
  listBySubscription is ArmListBySubscription<Fleet>;

  @doc("Lists the user credentials of a Fleet.")
  listCredentials is ArmResourceActionSync<Fleet, void, FleetCredentialResults>;
}
