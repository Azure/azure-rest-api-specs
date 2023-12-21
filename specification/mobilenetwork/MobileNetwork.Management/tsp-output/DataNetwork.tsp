import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.MobileNetwork;
@doc("Data network resource. Must be created in the same location as its parent mobile network.")
@parentResource(MobileNetwork)
model DataNetwork is TrackedResource<DataNetworkPropertiesFormat> {
  @doc("The name of the data network.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])*(\\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])*)*$")
  @path
  @key("dataNetworkName")
  @segment("dataNetworks")
  name: string;
}

@armResourceOperations
interface DataNetworks {
  @doc("Gets information about the specified data network.")
  get is ArmResourceRead<DataNetwork>;
  @doc("Creates or updates a data network. Must be created in the same location as its parent mobile network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataNetwork>;
  @doc("Updates data network tags.")
  updateTags is ArmTagsPatchSync<DataNetwork>;
  @doc("Deletes the specified data network.")
  delete is ArmResourceDeleteAsync<DataNetwork>;
  @doc("Lists all data networks in the mobile network.")
  listByMobileNetwork is ArmResourceListByParent<DataNetwork>;
}
