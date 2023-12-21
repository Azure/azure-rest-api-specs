import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Role.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataBoxEdge;
// FIXME: Addon has no properties property
@doc("Role Addon")
@parentResource(Role)
model Addon is ProxyResource<{}> {
  @doc("The addon name.")
  @path
  @key("addonName")
  @segment("addons")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Addons {
  @doc("Gets a specific addon by name.")
  get is ArmResourceRead<Addon>;
  @doc("Create or update a addon.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Addon>;
  @doc("Deletes the addon on the device.")
  delete is ArmResourceDeleteAsync<Addon>;
  @doc("Lists all the addons configured in the role.")
  listByRole is ArmResourceListByParent<Addon>;
}
