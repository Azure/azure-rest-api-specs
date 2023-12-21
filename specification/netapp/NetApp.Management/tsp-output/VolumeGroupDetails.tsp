import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetApp;
@doc("Volume group resource for create")
@parentResource(NetAppAccount)
model VolumeGroupDetails is ProxyResource<VolumeGroupProperties> {
  @doc("The name of the volumeGroup")
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$")
  @path
  @key("volumeGroupName")
  @segment("volumeGroups")
  name: string;
}

@armResourceOperations
interface VolumeGroups {
  @doc("Get details of the specified volume group")
  get is ArmResourceRead<VolumeGroupDetails>;
  @doc("Create a volume group along with specified volumes")
  create is ArmResourceCreateOrUpdateAsync<VolumeGroupDetails>;
  @doc("Delete the specified volume group only if there are no volumes under volume group.")
  delete is ArmResourceDeleteAsync<VolumeGroupDetails>;
}
