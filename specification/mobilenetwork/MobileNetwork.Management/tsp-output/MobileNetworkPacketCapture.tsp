import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PacketCoreControlPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.MobileNetwork;
@doc("Packet capture session resource.")
@parentResource(PacketCoreControlPlane)
model MobileNetworkPacketCapture
  is ProxyResource<PacketCapturePropertiesFormat> {
  @doc("The name of the packet capture session.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("packetCaptureName")
  @segment("packetCaptures")
  name: string;
}

@armResourceOperations
interface MobileNetworkPacketCaptures {
  @doc("Gets information about the specified packet capture session.")
  get is ArmResourceRead<MobileNetworkPacketCapture>;
  @doc("Creates or updates a packet capture.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MobileNetworkPacketCapture>;
  @doc("Deletes the specified packet capture.")
  delete is ArmResourceDeleteAsync<MobileNetworkPacketCapture>;
  @doc("Lists all the packet capture sessions under a packet core control plane.")
  listByPacketCoreControlPlane is ArmResourceListByParent<MobileNetworkPacketCapture>;
  @doc("Stop a packet capture session.")
  stop is ArmResourceActionAsync<
    MobileNetworkPacketCapture,
    {},
    AsyncOperationStatus
  >;
}
