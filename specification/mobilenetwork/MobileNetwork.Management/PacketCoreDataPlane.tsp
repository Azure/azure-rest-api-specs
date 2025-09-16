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
 * Packet core data plane resource. Must be created in the same location as its parent packet core control plane.
 */
@parentResource(PacketCoreControlPlane)
model PacketCoreDataPlane
  is Azure.ResourceManager.TrackedResource<
    PacketCoreDataPlanePropertiesFormat,
    false
  > {
  ...ResourceNameParameter<
    Resource = PacketCoreDataPlane,
    KeyName = "packetCoreDataPlaneName",
    SegmentName = "packetCoreDataPlanes",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
}

@armResourceOperations
interface PacketCoreDataPlanes {
  /**
   * Gets information about the specified packet core data plane.
   */
  get is ArmResourceRead<PacketCoreDataPlane>;

  /**
   * Creates or updates a packet core data plane. Must be created in the same location as its parent packet core control plane.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PacketCoreDataPlane>;

  /**
   * Updates packet core data planes tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    PacketCoreDataPlane,
    PatchModel = TagsObject
  >;

  /**
   * Deletes the specified packet core data plane.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    PacketCoreDataPlane,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the packet core data planes associated with a packet core control plane.
   */
  listByPacketCoreControlPlane is ArmResourceListByParent<PacketCoreDataPlane>;
}

@@maxLength(PacketCoreDataPlane.name, 64);
@@doc(PacketCoreDataPlane.name, "The name of the packet core data plane.");
@@doc(PacketCoreDataPlane.properties, "Packet core data plane Properties.");
@@doc(PacketCoreDataPlanes.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update packet core data plane operation."
);
@@doc(PacketCoreDataPlanes.updateTags::parameters.properties,
  "Parameters supplied to update packet core data plane tags."
);
