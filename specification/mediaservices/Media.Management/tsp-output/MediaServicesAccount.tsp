import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Media;
@doc("A Media Services account.")
model MediaServicesAccount is TrackedResource<MediaServiceProperties> {
  @doc("The Media Services account name.")
  @path
  @key("accountName")
  @segment("mediaservices")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface MediaServicesAccounts {
  @doc("Get the details of a Media Services account")
  get is ArmResourceRead<MediaServicesAccount>;
  @doc("Creates or updates a Media Services account")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MediaServicesAccount>;
  @doc("Updates an existing Media Services account")
  update is ArmResourcePatchAsync<MediaServicesAccount, MediaServiceProperties>;
  @doc("Deletes a Media Services account")
  delete is ArmResourceDeleteSync<MediaServicesAccount>;
  @doc("List Media Services accounts in the resource group")
  list is ArmResourceListByParent<MediaServicesAccount>;
  @doc("List Media Services accounts in the subscription.")
  listBySubscription is ArmListBySubscription<MediaServicesAccount>;
  @doc("Synchronizes storage account keys for a storage account associated with the Media Service account.")
  syncStorageKeys is ArmResourceActionSync<
    MediaServicesAccount,
    SyncStorageKeysInput,
    void
  >;
  @doc("List all the media edge policies associated with the Media Services account.")
  listEdgePolicies is ArmResourceActionSync<
    MediaServicesAccount,
    ListEdgePoliciesInput,
    EdgePolicies
  >;
}
