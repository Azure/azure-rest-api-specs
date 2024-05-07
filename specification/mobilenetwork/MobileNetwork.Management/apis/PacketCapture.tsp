import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/PacketCaptureModels.tsp";
import "./PacketCoreControlPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Packet capture session resource.")
@resource("packetCaptures")
@parentResource(PacketCoreControlPlane)
model PacketCapture is ProxyResource<PacketCapturePropertiesFormat> {
  @doc("The name of the packet capture session.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("packetCaptureName")
  @segment("packetCaptures")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface PacketCaptures {
  @doc("Gets information about the specified packet capture session.")
  get is ArmResourceRead<PacketCapture>;

  @doc("Creates or updates a packet capture.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PacketCapture>;

  @doc("Deletes the specified packet capture.")
  delete is ArmResourceDeleteWithoutOkAsync<PacketCapture>;

  @doc("Lists all the packet capture sessions under a packet core control plane.")
  listByPacketCoreControlPlane is ArmResourceListByParent<PacketCapture>;

  @doc("Stop a packet capture session.")
  stop is ArmResourceActionAsync<PacketCapture, void, AsyncOperationStatus>;
}

@@doc(PacketCaptures.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update packet capture operation."
);
