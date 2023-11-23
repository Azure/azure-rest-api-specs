import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkFabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
@doc("The Network To Network Interconnect resource definition.")
@parentResource(NetworkFabric)
model NetworkToNetworkInterconnect
  is ProxyResource<NetworkToNetworkInterconnectProperties> {
  @doc("Name of the Network to Network Interconnect.")
  @path
  @key("networkToNetworkInterconnectName")
  @segment("networkToNetworkInterconnects")
  name: string;
}

@armResourceOperations
interface NetworkToNetworkInterconnects {
  @doc("Implements NetworkToNetworkInterconnects GET method.")
  get is ArmResourceRead<NetworkToNetworkInterconnect>;
  @doc("Configuration used to setup CE-PE connectivity PUT Method.")
  create is ArmResourceCreateOrUpdateAsync<NetworkToNetworkInterconnect>;
  @doc("Update certain properties of the Network To NetworkInterconnects resource.")
  update is ArmResourcePatchAsync<
    NetworkToNetworkInterconnect,
    NetworkToNetworkInterconnectProperties
  >;
  @doc("Implements NetworkToNetworkInterconnects DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkToNetworkInterconnect>;
  @doc("Implements Network To Network Interconnects list by Network Fabric GET method.")
  listByNetworkFabric is ArmResourceListByParent<NetworkToNetworkInterconnect>;
  @doc("Updates the NPB Static Route BFD Administrative State.")
  updateNpbStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Updates the Admin State.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
}
