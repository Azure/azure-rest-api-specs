import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DeviceProvisioningService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DeviceProvisioningServices;
@doc("The group information for creating a private endpoint on a provisioning service")
@parentResource(DeviceProvisioningService)
model DeviceProvisioningServicesPrivateLinkResource
  is ProxyResource<GroupIdInformationProperties> {
  @doc("The name of the private link resource")
  @path
  @key("groupId")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface DeviceProvisioningServicesPrivateLinkResources {
  @doc("Get the specified private link resource for the given provisioning service")
  getPrivateLinkResources is ArmResourceRead<DeviceProvisioningServicesPrivateLinkResource>;
  @doc("List private link resources for the given provisioning service")
  listPrivateLinkResources is ArmResourceListByParent<DeviceProvisioningServicesPrivateLinkResource>;
}
