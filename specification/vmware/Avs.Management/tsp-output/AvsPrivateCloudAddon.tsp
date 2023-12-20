import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AvsPrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Avs;
@doc("An addon resource")
@parentResource(AvsPrivateCloud)
model AvsPrivateCloudAddon is ProxyResource<AddonProperties> {
  @doc("Name of the addon for the private cloud")
  @path
  @key("addonName")
  @segment("addons")
  name: string;
}

@armResourceOperations
interface AvsPrivateCloudAddons {
  @doc("Get an addon by name in a private cloud")
  get is ArmResourceRead<AvsPrivateCloudAddon>;
  @doc("Create or update a addon in a private cloud")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AvsPrivateCloudAddon>;
  @doc("Delete a addon in a private cloud")
  delete is ArmResourceDeleteAsync<AvsPrivateCloudAddon>;
  @doc("List addons in a private cloud")
  list is ArmResourceListByParent<AvsPrivateCloudAddon>;
}
