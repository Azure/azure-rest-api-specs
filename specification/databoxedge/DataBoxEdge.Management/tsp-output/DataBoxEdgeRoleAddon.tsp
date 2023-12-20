import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeRole.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataBoxEdge;
// FIXME: DataBoxEdgeRoleAddon has no properties property
@doc("Role Addon")
@parentResource(DataBoxEdgeRole)
model DataBoxEdgeRoleAddon is ProxyResource<{}> {
  @doc("The addon name.")
  @path
  @key("addonName")
  @segment("addons")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataBoxEdgeRoleAddons {
  @doc("Gets a specific addon by name.")
  get is ArmResourceRead<DataBoxEdgeRoleAddon>;
  @doc("Create or update a addon.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataBoxEdgeRoleAddon>;
  @doc("Deletes the addon on the device.")
  delete is ArmResourceDeleteAsync<DataBoxEdgeRoleAddon>;
  @doc("Lists all the addons configured in the role.")
  listByRole is ArmResourceListByParent<DataBoxEdgeRoleAddon>;
}
