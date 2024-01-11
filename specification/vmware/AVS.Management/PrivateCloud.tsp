import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AVS;
@doc("A private cloud resource")
model PrivateCloud is TrackedResource<PrivateCloudProperties> {
  @doc("Name of the private cloud")
  @pattern("^[-\\w\\._]+$")
  @path
  @key("privateCloudName")
  @segment("privateClouds")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface PrivateClouds {
  @doc("Get a private cloud")
  get is ArmResourceRead<PrivateCloud>;
  @doc("Create or update a private cloud")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PrivateCloud>;
  @doc("Update a private cloud")
  update is ArmResourcePatchAsync<PrivateCloud, PrivateCloudProperties>;
  @doc("Delete a private cloud")
  delete is ArmResourceDeleteAsync<PrivateCloud>;
  @doc("List private clouds in a resource group")
  list is ArmResourceListByParent<PrivateCloud>;
  @doc("List private clouds in a subscription")
  listInSubscription is ArmListBySubscription<PrivateCloud>;
  @doc("Rotate the vCenter password")
  rotateVcenterPassword is ArmResourceActionNoResponseContentAsync<
    PrivateCloud,
    {}
  >;
  @doc("Rotate the NSX-T Manager password")
  rotateNsxtPassword is ArmResourceActionNoResponseContentAsync<
    PrivateCloud,
    {}
  >;
  @doc("List the admin credentials for the private cloud")
  listAdminCredentials is ArmResourceActionSync<
    PrivateCloud,
    {},
    AdminCredentials
  >;
}
