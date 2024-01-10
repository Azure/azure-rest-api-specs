import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisioningServiceDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Devices;
@doc("The group information for creating a private endpoint on a provisioning service")
@parentResource(ProvisioningServiceDescription)
model GroupIdInformation is ProxyResource<GroupIdInformationProperties> {
  @doc("The name of the private link resource")
  @key("groupId")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
@projectedName("client", "IotDpsResource")
interface GroupIdInformations_IotDpsResource {
  @doc("Get the specified private link resource for the given provisioning service")
  getPrivateLinkResources is ArmResourceRead<GroupIdInformation>;

  @doc("List private link resources for the given provisioning service")
  listPrivateLinkResources is ArmResourceListByParent<GroupIdInformation>;
}
