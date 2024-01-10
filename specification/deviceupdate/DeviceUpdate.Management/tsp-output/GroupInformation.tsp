import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DeviceUpdate;
@doc("The group information for creating a private endpoint on an Account")
@parentResource(Account)
model GroupInformation is ProxyResource<GroupInformationProperties> {
  @doc("The group ID of the private link resource.")
  @key("groupId")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
@projectedName("client", "PrivateLinkResources")
interface GroupInformations_PrivateLinkResources {
  @doc("Get the specified private link resource associated with the device update account.")
  get is ArmResourceRead<GroupInformation>;

  @doc("List all private link resources in a device update account.")
  listByAccount is ArmResourceListByParent<GroupInformation>;
}
