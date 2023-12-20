import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataBoxEdge;
// FIXME: DataBoxEdgeRole has no properties property
@doc("Compute role.")
@parentResource(DataBoxEdgeDevice)
model DataBoxEdgeRole is ProxyResource<{}> {
  @doc("The role name.")
  @path
  @key("name")
  @segment("roles")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataBoxEdgeRoles {
  @doc("Gets a specific role by name.")
  get is ArmResourceRead<DataBoxEdgeRole>;
  @doc("Create or update a role.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataBoxEdgeRole>;
  @doc("Deletes the role on the device.")
  delete is ArmResourceDeleteAsync<DataBoxEdgeRole>;
  @doc("Lists all the roles configured in a Data Box Edge/Data Box Gateway device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<DataBoxEdgeRole>;
}
