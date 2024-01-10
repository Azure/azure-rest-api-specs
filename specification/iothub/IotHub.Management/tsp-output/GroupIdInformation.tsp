import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IotHubDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Devices;
@doc("The group information for creating a private endpoint on an IotHub")
@parentResource(IotHubDescription)
model GroupIdInformation is ProxyResource<GroupIdInformationProperties> {
  @doc("The name of the private link resource")
  @key("groupId")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
@projectedName("client", "PrivateLinkResources")
interface GroupIdInformations_PrivateLinkResources {
  @doc("Get the specified private link resource for the given IotHub")
  get is ArmResourceRead<GroupIdInformation>;

  @doc("List private link resources for the given IotHub")
  list is ArmResourceListByParent<GroupIdInformation>;
}
