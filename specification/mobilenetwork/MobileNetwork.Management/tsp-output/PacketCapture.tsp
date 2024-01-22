import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PacketCoreControlPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Packet capture session resource.
 */
@parentResource(PacketCoreControlPlane)
model PacketCapture is ProxyResource<PacketCapturePropertiesFormat> {
  /**
   * The name of the packet capture session.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("packetCaptureName")
  @segment("packetCaptures")
  name: string;
}

@armResourceOperations
interface PacketCaptures {
  /**
   * Gets information about the specified packet capture session.
   */
  get is ArmResourceRead<PacketCapture>;

  /**
   * Creates or updates a packet capture.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PacketCapture,
    BaseParameters<PacketCapture>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes the specified packet capture.
   */
  delete is ArmResourceDeleteAsync<
    PacketCapture,
    BaseParameters<PacketCapture>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all the packet capture sessions under a packet core control plane.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PacketCaptures_ListByPacketCoreControlPlane")
  listByPacketCoreControlPlane is ArmResourceListByParent<PacketCapture>;

  /**
   * Stop a packet capture session.
   */
  stop is ArmResourceActionAsync<
    PacketCapture,
    void,
    AsyncOperationStatus,
    BaseParameters<PacketCapture>,
    ArmLroLocationHeader
  >;
}

@@projectedName(PacketCaptures.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(PacketCaptures.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(PacketCaptures.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update packet capture operation."
);
