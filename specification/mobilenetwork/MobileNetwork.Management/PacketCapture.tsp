import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PacketCoreControlPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Packet capture session resource.
 */
@parentResource(PacketCoreControlPlane)
model PacketCapture
  is Azure.ResourceManager.ProxyResource<PacketCapturePropertiesFormat, false> {
  ...ResourceNameParameter<
    Resource = PacketCapture,
    KeyName = "packetCaptureName",
    SegmentName = "packetCaptures",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PacketCapture>;

  /**
   * Deletes the specified packet capture.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    PacketCapture,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the packet capture sessions under a packet core control plane.
   */
  listByPacketCoreControlPlane is ArmResourceListByParent<PacketCapture>;

  /**
   * Stop a packet capture session.
   */
  stop is ArmResourceActionAsync<
    PacketCapture,
    void,
    ArmResponse<AsyncOperationStatus>
  >;
}

@@maxLength(PacketCapture.name, 64);
@@doc(PacketCapture.name, "The name of the packet capture session.");
@@doc(PacketCapture.properties,
  "Packet capture session properties. Packet capture file(s) derived from the name of this session will be uploaded to the Storage Account Container URL in the packet core control plane properties"
);
@@doc(PacketCaptures.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update packet capture operation."
);
