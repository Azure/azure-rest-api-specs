import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Avs;
@doc("A private cloud resource")
model AvsPrivateCloud is TrackedResource<PrivateCloudProperties> {
  @doc("Name of the private cloud")
  @path
  @key("privateCloudName")
  @segment("privateClouds")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface AvsPrivateClouds {
  @doc("Get a private cloud")
  get is ArmResourceRead<AvsPrivateCloud>;
  @doc("Create or update a private cloud")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AvsPrivateCloud>;
  @doc("Update a private cloud")
  update is ArmResourcePatchAsync<AvsPrivateCloud, PrivateCloudProperties>;
  @doc("Delete a private cloud")
  delete is ArmResourceDeleteAsync<AvsPrivateCloud>;
  @doc("List private clouds in a resource group")
  list is ArmResourceListByParent<AvsPrivateCloud>;
  @doc("List private clouds in a subscription")
  listInSubscription is ArmListBySubscription<AvsPrivateCloud>;
  @doc("Rotate the vCenter password")
  rotateVcenterPassword is ArmResourceActionNoResponseContentAsync<
    AvsPrivateCloud,
    void
  >;
  @doc("Rotate the NSX-T Manager password")
  rotateNsxtPassword is ArmResourceActionNoResponseContentAsync<
    AvsPrivateCloud,
    void
  >;
  @doc("List the admin credentials for the private cloud")
  listAdminCredentials is ArmResourceActionSync<
    AvsPrivateCloud,
    void,
    AdminCredentials
  >;
}
