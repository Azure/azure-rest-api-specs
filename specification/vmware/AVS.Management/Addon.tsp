import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AVS;
@doc("An addon resource")
@parentResource(PrivateCloud)
model Addon is ProxyResource<AddonProperties> {
  @doc("Name of the addon for the private cloud")
  @pattern("^[-\\w\\._]+$")
  @path
  @key("addonName")
  @segment("addons")
  name: string;
}

@armResourceOperations
interface Addons {
  @doc("Get an addon by name in a private cloud")
  get is ArmResourceRead<Addon>;
  @doc("Create or update a addon in a private cloud")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Addon>;
  @doc("Delete a addon in a private cloud")
  delete is ArmResourceDeleteAsync<Addon>;
  @doc("List addons in a private cloud")
  list is ArmResourceListByParent<Addon>;
}
