import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IotCentralApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.IotCentral;
@doc("A private link resource.")
@parentResource(IotCentralApp)
model IotCentralPrivateLinkResource
  is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The private link resource name.")
  @path
  @key("groupId")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface IotCentralPrivateLinkResources {
  @doc("Get a private link resource of a IoT Central Application.")
  get is ArmResourceRead<IotCentralPrivateLinkResource>;
  @doc("Get all private link resources of a IoT Central Application.")
  list is ArmResourceListByParent<IotCentralPrivateLinkResource>;
}
