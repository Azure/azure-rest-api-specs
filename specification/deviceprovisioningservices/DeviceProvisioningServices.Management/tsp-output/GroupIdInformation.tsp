import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisioningServiceDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
@doc("The group information for creating a private endpoint on a provisioning service")
@parentResource(ProvisioningServiceDescription)
model GroupIdInformation is ProxyResource<GroupIdInformationProperties> {
  @doc("The name of the private link resource")
  @path
  @key("groupId")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface GroupIdInformations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the specified private link resource for the given provisioning service")
  @operationId("IotDpsResource_GetPrivateLinkResources")
  getPrivateLinkResources is ArmResourceRead<GroupIdInformation>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List private link resources for the given provisioning service")
  @operationId("IotDpsResource_ListPrivateLinkResources")
  listPrivateLinkResources is ArmResourceListByParent<GroupIdInformation>;
}
