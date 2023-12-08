import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetwork;
@doc("The Managed Network resource")
model ManagedNetwork is TrackedResource<ManagedNetworkProperties> {
  @doc("The name of the Managed Network.")
  @path
  @key("managedNetworkName")
  @segment("managedNetworks")
  name: string;
}

@armResourceOperations
interface ManagedNetworks {
  @doc("The Get ManagedNetworks operation gets a Managed Network Resource, specified by the resource group and Managed Network name")
  get is ArmResourceRead<ManagedNetwork>;
  @doc("The Put ManagedNetworks operation creates/updates a Managed Network Resource, specified by resource group and Managed Network name")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedNetwork>;
  @doc("Updates the specified Managed Network resource tags.")
  update is ArmTagsPatchAsync<ManagedNetwork>;
  @doc("The Delete ManagedNetworks operation deletes a Managed Network Resource, specified by the  resource group and Managed Network name")
  delete is ArmResourceDeleteAsync<ManagedNetwork>;
  @doc("The ListByResourceGroup ManagedNetwork operation retrieves all the Managed Network resources in a resource group in a paginated format.")
  listByResourceGroup is ArmResourceListByParent<
    ManagedNetwork,
    {
      ...BaseParameters<ManagedNetwork>;

      @doc("May be used to limit the number of results in a page for list queries.")
      @query("$top")
      $top?: int32;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
  @doc("The ListBySubscription  ManagedNetwork operation retrieves all the Managed Network Resources in the current subscription in a paginated format.")
  listBySubscription is ArmListBySubscription<ManagedNetwork>;
}
